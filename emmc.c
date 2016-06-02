#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "base.h"
#include "mailbox.h"
#include "uart.h"
#include "mmu.h"
#include "time.h"
#include "emmc.h"

// EMMC Clock Frequencies (in Hz)
#define EMMC_CLOCK_ID         400000
#define EMMC_CLOCK_NORMAL     25000000
#define EMMC_CLOCK_HIGH       50000000
#define EMMC_CLOCK_100        100000000
#define EMMC_CLOCK_208        208000000


typedef struct{
     volatile uint32_t ARG2;          // ACMD23 Argument                        0-4
     volatile uint32_t BLKSIZECNT;    // Block size and count                   4-8
     volatile uint32_t ARG1;          // Argument                               8-c
     volatile uint32_t CMDTM;         // Command and transfer mode              c-10
     volatile uint32_t RESP0;         // Response bits 31 : 0                   10-14
     volatile uint32_t RESP1;         // Response bits 63 : 32                  14-18
     volatile uint32_t RESP2;         // Response bits 95 : 64                  18-1c
     volatile uint32_t RESP3;         // Response bits 127 : 96                 1c-20
     volatile uint32_t DATA;          // Data                                   20-24
     volatile uint32_t STATUS;        // Status                                 24-28
     volatile uint32_t CONTROL0;      // Host configuration bits                28-2c
     volatile uint32_t CONTROL1;      // Host configuration bits                2c-30
     volatile uint32_t INTERRUPT;     // Interrupt flags                        30-34
     volatile uint32_t IRPT_MASK;     // Interrupt flag enable                  34-38
     volatile uint32_t IRPT_EN;       // Interrupt generation enable            38-3c
     volatile uint32_t CONTROL2;      // host configuration bits                3c-40
     volatile uint32_t padding1[4];                                          // 40-50 
     volatile uint32_t FORCE_IRPT;     // Force interrupt event                  50-54
     volatile uint32_t padding2[7];                                         //  54-6c
     volatile uint32_t BOOT_TIMEOUT;  // Timeout in boot mode                   70-74
     volatile uint32_t DBG_SEL;       // Debug bus configuration                74-78
     volatile uint32_t padding3[2];                                            //  78-80
     volatile uint32_t EXRDFIFO_CFG;  // Extension fifo configuration           80-84
     volatile uint32_t EXRDFIFO_EN;   // Extension FIFO enable              //  84-88
     volatile uint32_t TUNE_STEP;     // Delay per card clock tuning step   //  88-8c
     volatile uint32_t TUNE_STEP_STD; // Card clock tuning steps for EMMCR        8c-90
     volatile uint32_t TUNE_STEP_DDR; // Card clock tuning steps for DDR        90-94
     volatile uint32_t padding4[23]; //94-9c                                    94-ec
     volatile uint32_t SPI_INT_SPT;   // SPI interrupt support                  f0-f4
     volatile uint32_t padding6[2]; //f4-fc                                        f4-fc
     volatile uint32_t SLOTISR_VER;   // Slot interrupt status and version      fc 100
} emmc_controller_t;

#define EMMC_CONTROLLER_BASE        (PERIPHERAL_BASE + 0x300000)

static emmc_controller_t *EMMCController = 
        (emmc_controller_t*)EMMC_CONTROLLER_BASE;

emmc_controller_t *emmc_get(void){
    return EMMCController;
}

static int timeout_wait(volatile uint32_t *reg, uint32_t mask, int value, uint32_t msec){
    time_unit_t time1 = time_get();
    time_add_microseconds(&time1 ,msec);
    do{
        if ( (*reg & mask) ? value : !value){ return 0;}
    } while( time_compare(time1, time_get()) == 1);
    return -1;
}

static uint32_t sd_version = 0;

struct emmc_scr{
    uint32_t    scr[2];
    uint32_t    sd_bus_widths;
    int         sd_version;
};

struct emmc_dev{
	uint32_t card_supports_sdhc;
	uint32_t card_supports_18v;
	uint32_t card_ocr;
	uint32_t card_rca;
	uint32_t last_interrupt;
	uint32_t last_error;
    
	struct emmc_scr *scr;

	int failed_voltage_switch;

    uint32_t last_cmd_reg;
    uint32_t last_cmd;
	uint32_t last_cmd_success;
	uint32_t last_r0;
	uint32_t last_r1;
	uint32_t last_r2;
	uint32_t last_r3;

	void *buf;
	int blocks_to_transfer;
	size_t block_size;
	int card_removal;
	uint32_t base_clock;
};

// BLKSIZECNT
#define BLOCKCNT(a)                     (a << 16)
#define BLKSIZE(a)                    (a << 0)


// control0 bit offsets
#define ALT_BOOT_EN                     (1 << 22)
#define BOOT_EN                         (1 << 21)
#define SPI_MODE                        (1 << 20)
#define GAP_IEN                         (1 << 19)
#define READWAIT_EN                     (1 << 18)
#define GAP_RESTART                     (1 << 17)
#define GAP_STOP                        (1 << 16)
#define ENABLE_1_8V                     (1 << 8)
#define HCTL_8BIT                       (1 << 5)
#define HCTL_HS_EN                      (1 << 2)
#define HCTL_DWIDTH                     (1 << 1)

// control1 bit offsets
#define SRST_DATA                       (1 << 26)
#define SRST_CMD                        (1 << 25)
#define SRST_HC                         (1 << 24)
#define DATA_TOUNIT(a)                  (a << 16)
#define CLK_FREQ8(a)                    (a << 8)
#define CLK_FREQ_MS2(a)                 (a << 6)
#define CLK_GENSEL                      (1 << 5)
#define CLK_EN                          (1 << 2)
#define CLK_STABLE                      (1 << 1)
#define CLK_INTLEN                      (1 << 0)

// INTERRUPTS bit offsets
#define ACMD_ERR                        (1 << 24)
#define DEND_ERR                        (1 << 22)
#define DCRC_ERR                        (1 << 21)
#define DTO_ERR                         (1 << 20)
#define CBAD_ERR                        (1 << 19)
#define CEND_ERR                        (1 << 18)
#define CCRC_ERR                        (1 << 17)
#define CTO_ERR                         (1 << 16)
#define ERR                             (1 << 15)
#define ENDBOOT                         (1 << 14)
#define BOOTACK                         (1 << 13)
#define RETUNE                          (1 << 12)
#define CARD                            (1 << 8)
#define READ_RDY                        (1 << 5)
#define WRITE_RDY                       (1 << 4)
#define BLOCK_GAP                       (1 << 2)
#define DATA_DONE                       (1 << 1)
#define CMD_DONE                        (1 << 0)
#define ERROR_MASK                      (0xffff0000)

// STATUS bit offsets
#define CMD_LEVEL                       (1 << 24)
#define VALID_CARD                      (1 << 16)
#define READ_TRANSFER                   (1 << 9)
#define WRITE_TRANSFER                  (1 << 8)
#define DAT_ACTIVE                      (1 << 2)
#define DAT_INHIBIT                     (1 << 1)
#define CMD_INHIBIT                     (1 << 0)

#define EMMC_CMD_INDEX(a)		        ((a) << 24)
#define EMMC_CMD_TYPE_NORMAL	        (0 << 0)
#define EMMC_CMD_TYPE_SUSPEND	        (1 << 22)
#define EMMC_CMD_TYPE_RESUME	        (2 << 22)
#define EMMC_CMD_TYPE_ABORT	            (3 << 22)
#define EMMC_CMD_TYPE_MASK              (3 << 22)
#define EMMC_CMD_WITH_DATA		        (1 << 21)
#define EMMC_CMD_IXCHK_EN		        (1 << 20)
#define EMMC_CMD_CRCCHK_EN	            (1 << 19)
#define EMMC_CMD_RSPNS_TYPE_NONE	    (0 << 0)    // For no response
#define EMMC_CMD_RSPNS_TYPE_136	        (1 << 16)	// For response R2 (with CRC), R3,4 (no CRC)
#define EMMC_CMD_RSPNS_TYPE_48	        (2 << 16)	// For responses R1, R5, R6, R7 (with CRC)
#define EMMC_CMD_RSPNS_TYPE_48B	        (3 << 16)	// For responses R1b, R5b (with CRC)
#define EMMC_CMD_RSPNS_TYPE_MASK        (3 << 16)
#define EMMC_CMD_MULTI_BLOCK	        (1 << 5)
#define EMMC_CMD_DAT_DIR_HC	            (0 << 0)
#define EMMC_CMD_DAT_DIR_CH	            (1 << 4)
#define EMMC_CMD_AUTO_CMD_EN_NONE	    (0 << 0)
#define EMMC_CMD_AUTO_CMD_EN_CMD12	    (1 << 2)
#define EMMC_CMD_AUTO_CMD_EN_CMD23	    (2 << 2)
#define EMMC_CMD_BLKCNT_EN		        (1 << 1)
#define EMMC_CMD_DMA                    (1 << 0)

#define EMMC_RESP_NONE        EMMC_CMD_RSPNS_TYPE_NONE
#define EMMC_RESP_R1          (EMMC_CMD_RSPNS_TYPE_48 | EMMC_CMD_CRCCHK_EN)
#define EMMC_RESP_R1b         (EMMC_CMD_RSPNS_TYPE_48B | EMMC_CMD_CRCCHK_EN)
#define EMMC_RESP_R2          (EMMC_CMD_RSPNS_TYPE_136 | EMMC_CMD_CRCCHK_EN)
#define EMMC_RESP_R3          EMMC_CMD_RSPNS_TYPE_48
#define EMMC_RESP_R4          EMMC_CMD_RSPNS_TYPE_136
#define EMMC_RESP_R5          (EMMC_CMD_RSPNS_TYPE_48 | EMMC_CMD_CRCCHK_EN)
#define EMMC_RESP_R5b         (EMMC_CMD_RSPNS_TYPE_48B | EMMC_CMD_CRCCHK_EN)
#define EMMC_RESP_R6          (EMMC_CMD_RSPNS_TYPE_48 | EMMC_CMD_CRCCHK_EN)
#define EMMC_RESP_R7          (EMMC_CMD_RSPNS_TYPE_48 | EMMC_CMD_CRCCHK_EN)

#define EMMC_DATA_READ        (EMMC_CMD_WITH_DATA | EMMC_CMD_DAT_DIR_CH)
#define EMMC_DATA_WRITE       (EMMC_CMD_WITH_DATA | EMMC_CMD_DAT_DIR_HC)

#define EMMC_CMD_RESERVED(a)  0xffffffff

#define SUCCESS(a)          (a->last_cmd_success)
#define FAIL(a)             (a->last_cmd_success == 0)
#define TIMEOUT(a)          (FAIL(a) && (a->last_error == 0))
#define CMD_TIMEOUT(a)      (FAIL(a) && (a->last_error & (1 << 16)))
#define CMD_CRC(a)          (FAIL(a) && (a->last_error & (1 << 17)))
#define CMD_END_BIT(a)      (FAIL(a) && (a->last_error & (1 << 18)))
#define CMD_INDEX(a)        (FAIL(a) && (a->last_error & (1 << 19)))
#define DATA_TIMEOUT(a)     (FAIL(a) && (a->last_error & (1 << 20)))
#define DATA_CRC(a)         (FAIL(a) && (a->last_error & (1 << 21)))
#define DATA_END_BIT(a)     (FAIL(a) && (a->last_error & (1 << 22)))
#define CURRENT_LIMIT(a)    (FAIL(a) && (a->last_error & (1 << 23)))
#define ACMD12_ERROR(a)     (FAIL(a) && (a->last_error & (1 << 24)))
#define ADMA_ERROR(a)       (FAIL(a) && (a->last_error & (1 << 25)))
#define TUNING_ERROR(a)     (FAIL(a) && (a->last_error & (1 << 26)))

#define EMMC_VER_UNKNOWN      0
#define EMMC_VER_1            1
#define EMMC_VER_1_1          2
#define EMMC_VER_2            3
#define EMMC_VER_3            4
#define EMMC_VER_4            5

static uint32_t emmc_commands[] = {
    EMMC_CMD_INDEX(0),
    EMMC_CMD_RESERVED(1),
    EMMC_CMD_INDEX(2) | EMMC_RESP_R2,
    EMMC_CMD_INDEX(3) | EMMC_RESP_R6,
    EMMC_CMD_INDEX(4),
    EMMC_CMD_INDEX(5) | EMMC_RESP_R4,
    EMMC_CMD_INDEX(6) | EMMC_RESP_R1,
    EMMC_CMD_INDEX(7) | EMMC_RESP_R1b,
    EMMC_CMD_INDEX(8) | EMMC_RESP_R7,
    EMMC_CMD_INDEX(9) | EMMC_RESP_R2,
    EMMC_CMD_INDEX(10) | EMMC_RESP_R2,
    EMMC_CMD_INDEX(11) | EMMC_RESP_R1,
    EMMC_CMD_INDEX(12) | EMMC_RESP_R1b | EMMC_CMD_TYPE_ABORT,
    EMMC_CMD_INDEX(13) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(14),
    EMMC_CMD_INDEX(15),
    EMMC_CMD_INDEX(16) | EMMC_RESP_R1,
    EMMC_CMD_INDEX(17) | EMMC_RESP_R1 | EMMC_DATA_READ,
    EMMC_CMD_INDEX(18) | EMMC_RESP_R1 | EMMC_DATA_READ | EMMC_CMD_MULTI_BLOCK | EMMC_CMD_BLKCNT_EN,
    EMMC_CMD_INDEX(19) | EMMC_RESP_R1 | EMMC_DATA_READ,
    EMMC_CMD_INDEX(20) | EMMC_RESP_R1b,
    EMMC_CMD_RESERVED(21),
    EMMC_CMD_RESERVED(22),
    EMMC_CMD_INDEX(23) | EMMC_RESP_R1,
    EMMC_CMD_INDEX(24) | EMMC_RESP_R1 | EMMC_DATA_WRITE,
    EMMC_CMD_INDEX(25) | EMMC_RESP_R1 | EMMC_DATA_WRITE | EMMC_CMD_MULTI_BLOCK | EMMC_CMD_BLKCNT_EN,
    EMMC_CMD_RESERVED(26),
    EMMC_CMD_INDEX(27) | EMMC_RESP_R1 | EMMC_DATA_WRITE,
    EMMC_CMD_INDEX(28) | EMMC_RESP_R1b,
    EMMC_CMD_INDEX(29) | EMMC_RESP_R1b,
    EMMC_CMD_INDEX(30) | EMMC_RESP_R1 | EMMC_DATA_READ,
    EMMC_CMD_RESERVED(31),
    EMMC_CMD_INDEX(32) | EMMC_RESP_R1,
    EMMC_CMD_INDEX(33) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(34),
    EMMC_CMD_RESERVED(35),
    EMMC_CMD_RESERVED(36),
    EMMC_CMD_RESERVED(37),
    EMMC_CMD_INDEX(38) | EMMC_RESP_R1b,
    EMMC_CMD_RESERVED(39),
    EMMC_CMD_RESERVED(40),
    EMMC_CMD_RESERVED(41),
    EMMC_CMD_RESERVED(42) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(43),
    EMMC_CMD_RESERVED(44),
    EMMC_CMD_RESERVED(45),
    EMMC_CMD_RESERVED(46),
    EMMC_CMD_RESERVED(47),
    EMMC_CMD_RESERVED(48),
    EMMC_CMD_RESERVED(49),
    EMMC_CMD_RESERVED(50),
    EMMC_CMD_RESERVED(51),
    EMMC_CMD_RESERVED(52),
    EMMC_CMD_RESERVED(53),
    EMMC_CMD_RESERVED(54),
    EMMC_CMD_INDEX(55) | EMMC_RESP_R1,
    EMMC_CMD_INDEX(56) | EMMC_RESP_R1 | EMMC_CMD_WITH_DATA,
    EMMC_CMD_RESERVED(57),
    EMMC_CMD_RESERVED(58),
    EMMC_CMD_RESERVED(59),
    EMMC_CMD_RESERVED(60),
    EMMC_CMD_RESERVED(61),
    EMMC_CMD_RESERVED(62),
    EMMC_CMD_RESERVED(63)
};

static uint32_t emmc_acommands[] = {
    EMMC_CMD_RESERVED(0),
    EMMC_CMD_RESERVED(1),
    EMMC_CMD_RESERVED(2),
    EMMC_CMD_RESERVED(3),
    EMMC_CMD_RESERVED(4),
    EMMC_CMD_RESERVED(5),
    EMMC_CMD_INDEX(6) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(7),
    EMMC_CMD_RESERVED(8),
    EMMC_CMD_RESERVED(9),
    EMMC_CMD_RESERVED(10),
    EMMC_CMD_RESERVED(11),
    EMMC_CMD_RESERVED(12),
    EMMC_CMD_INDEX(13) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(14),
    EMMC_CMD_RESERVED(15),
    EMMC_CMD_RESERVED(16),
    EMMC_CMD_RESERVED(17),
    EMMC_CMD_RESERVED(18),
    EMMC_CMD_RESERVED(19),
    EMMC_CMD_RESERVED(20),
    EMMC_CMD_RESERVED(21),
    EMMC_CMD_INDEX(22) | EMMC_RESP_R1 | EMMC_DATA_READ,
    EMMC_CMD_INDEX(23) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(24),
    EMMC_CMD_RESERVED(25),
    EMMC_CMD_RESERVED(26),
    EMMC_CMD_RESERVED(27),
    EMMC_CMD_RESERVED(28),
    EMMC_CMD_RESERVED(29),
    EMMC_CMD_RESERVED(30),
    EMMC_CMD_RESERVED(31),
    EMMC_CMD_RESERVED(32),
    EMMC_CMD_RESERVED(33),
    EMMC_CMD_RESERVED(34),
    EMMC_CMD_RESERVED(35),
    EMMC_CMD_RESERVED(36),
    EMMC_CMD_RESERVED(37),
    EMMC_CMD_RESERVED(38),
    EMMC_CMD_RESERVED(39),
    EMMC_CMD_RESERVED(40),
    EMMC_CMD_INDEX(41) | EMMC_RESP_R3,
    EMMC_CMD_INDEX(42) | EMMC_RESP_R1,
    EMMC_CMD_RESERVED(43),
    EMMC_CMD_RESERVED(44),
    EMMC_CMD_RESERVED(45),
    EMMC_CMD_RESERVED(46),
    EMMC_CMD_RESERVED(47),
    EMMC_CMD_RESERVED(48),
    EMMC_CMD_RESERVED(49),
    EMMC_CMD_RESERVED(50),
    EMMC_CMD_INDEX(51) | EMMC_RESP_R1 | EMMC_DATA_READ,
    EMMC_CMD_RESERVED(52),
    EMMC_CMD_RESERVED(53),
    EMMC_CMD_RESERVED(54),
    EMMC_CMD_RESERVED(55),
    EMMC_CMD_RESERVED(56),
    EMMC_CMD_RESERVED(57),
    EMMC_CMD_RESERVED(58),
    EMMC_CMD_RESERVED(59),
    EMMC_CMD_RESERVED(60),
    EMMC_CMD_RESERVED(61),
    EMMC_CMD_RESERVED(62),
    EMMC_CMD_RESERVED(63)
};

// The commands
#define GO_IDLE_STATE           0
#define ALL_SEND_CID            2
#define SEND_RELATIVE_ADDR      3
#define SET_DSR                 4
#define IO_SET_OP_COND          5
#define SWITCH_FUNC             6
#define SELECT_CARD             7
#define DESELECT_CARD           7
#define SELECT_DESELECT_CARD    7
#define SEND_IF_COND            8
#define SEND_CEMMC              9
#define SEND_CID                10
#define VOLTAGE_SWITCH          11
#define STOP_TRANSMISSION       12
#define SEND_STATUS             13
#define GO_INACTIVE_STATE       15
#define SET_BLOCKLEN            16
#define READ_SINGLE_BLOCK       17
#define READ_MULTIPLE_BLOCK     18
#define SEND_TUNING_BLOCK       19
#define SPEED_CLASS_CONTROL     20
#define SET_BLOCK_COUNT         23
#define WRITE_BLOCK             24
#define WRITE_MULTIPLE_BLOCK    25
#define PROGRAM_CEMMC           27
#define SET_WRITE_PROT          28
#define CLR_WRITE_PROT          29
#define SEND_WRITE_PROT         30
#define ERASE_WR_BLK_START      32
#define ERASE_WR_BLK_END        33
#define ERASE                   38
#define LOCK_UNLOCK             42
#define APP_CMD                 55
#define GEN_CMD                 56

#define IS_APP_CMD              0x80000000
#define ACMD(a)                 (a | IS_APP_CMD)
#define SET_BUS_WIDTH           (6 | IS_APP_CMD)
#define EMMC_STATUS             (13 | IS_APP_CMD)
#define SEND_NUM_WR_BLOCKS      (22 | IS_APP_CMD)
#define SET_WR_BLK_ERASE_COUNT  (23 | IS_APP_CMD)
#define EMMC_SEND_OP_COND       (41 | IS_APP_CMD)
#define SET_CLR_CARD_DETECT     (42 | IS_APP_CMD)
#define SEND_SCR                (51 | IS_APP_CMD)

#define EMMC_RESET_ALL            (1 << 24)

#define EMMC_GET_CLOCK_DIVIDER_FAIL	0xffffffff

// CARD status register
#define AKE_SEQ_ERROR           (1 << 3)
#define CARD_APP_CMD            (1 << 5)
#define READY_FOR_DATA          (1 << 8)
#define CURRENT_STATE(a)        ((a >> 9) & 0xf)
#define ERASE_RESET             (1 << 13)
#define CARD_ECC_DISABLED       (1 << 14)
#define WP_ERASE_SKIP           (1 << 15)
#define CSD_OVERWRITE           (1 << 16)
#define CARD_ERROR              (1 << 19)
#define CC_ERROR                (1 << 20)
#define CARD_ECC_FAILED         (1 << 21)
#define ILLEGAL_COMMAND         (1 << 22)
#define COM_CRC_ERROR           (1 << 23)
#define LOCK_UNLOCK_FAILED      (1 << 24)
#define CARD_IS_LOCKED          (1 << 25)
#define WP_VIOLATION            (1 << 26)
#define ERASE_PARAM             (1 << 27)
#define ERASE_SEQ_ERROR         (1 << 28)
#define BLOCK_LEN_ERROR         (1 << 29)
#define ADDRESS_ERROR           (1 << 30)
#define OUT_OF_RANGE            (1 << 31) 

// CARD states
#define CARD_IDLE           0
#define CARD_READY          1
#define CARD_IDENT          2
#define CARD_STBY           3
#define CARD_TRAN           4
#define CARD_DATA           5
#define CARD_RCB            6
#define CARD_PRG            7
#define CARD_DIS            8
#define CARD_IO             15

// convert little endianess
static uint32_t byte_swap(unsigned int in){
    return            ((in & 0xFF) << 24) 
                    | (((in >> 8) & 0xFF) << 16)
                    | (((in >> 16) & 0xFF) << 8)
                    | ((in >> 24) & 0xFF);
}

static void write_word(uint32_t val, uint8_t* buf, int offset){
    buf[offset + 0] = val & 0xff;
    buf[offset + 1] = (val >> 8) & 0xff;
    buf[offset + 2] = (val >> 16) & 0xff;
    buf[offset + 3] = (val >> 24) & 0xff;
}

static uint32_t read_word(uint8_t* buf, int offset){
    uint32_t b0 = buf[offset + 0] & 0xff;
    uint32_t b1 = buf[offset + 1] & 0xff;
    uint32_t b2 = buf[offset + 2] & 0xff;
    uint32_t b3 = buf[offset + 3] & 0xff;
    return b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
}

static void emmc_power_off(void){
    /* Power off the EMMC card */
    uint32_t control0 = emmc_get()->CONTROL0;
    control0 &= ~(1 << 8);    // Set EMMC Bus Power bit off in Power Control Register
    emmc_get()->CONTROL0, control0;
}

static uint32_t emmc_get_base_clock(void){
    //      mailbox needs to be 0x100 aligned
    volatile __attribute__((aligned(0x100))) uint32_t mailbuffer[8];  // response needs 8 bits
    // use mailbox to get clock
    mailbuffer[0] = sizeof(mailbuffer);         // length of buffer
    mailbuffer[1] = MAILBOX_REQUEST;            // length
    mailbuffer[2] = MAILBOX_GET_CLOCK_RATE;
    mailbuffer[3] = 0x8;                        // value buffer size
    mailbuffer[4] = 4;                        // value length size
    mailbuffer[5] = MAILBOX_CLOCK_EMMC;                          // clock id and space to return clock id
    mailbuffer[6] = 0;                          // space for clock rate
    mailbuffer[7] = MAILBOX_PROPERTY_END;
    //  invalidate the location of mailbuffer in cache. it has not been written to main memory yet.
    mmu_cache_invalidate((uint32_t)mailbuffer);
    //  send and receive
    mailbox_write_read(mailbuffer, MAILBOX_ARM_TO_VC);
    //  interprit the msg
    if(mailbuffer[1] != MAILBOX_REQUEST_SUCCESSFUL){ 
        uart_puts("error: emmc get base clock: Mailbox request not successfull:\r\n");
        return 0;
    }
    if(mailbuffer[5] != 0x1) {
        uart_puts("error: emmc get base clock: mailbuffer[5] != 1\r\n");
        return 0;
    }
    return mailbuffer[6];       // return clock rate
}

static int bcm_power_off(void){
    volatile __attribute__((aligned(0x100))) uint32_t mailbuffer[8];
    mailbuffer[0] = sizeof(mailbuffer);
    mailbuffer[1] = MAILBOX_REQUEST;
    mailbuffer[2] = MAILBOX_SET_POWER_STATE;
    mailbuffer[3] = 8;  // size of value buffer
    mailbuffer[4] = 8;  // a request and value length is 8
    mailbuffer[5] = MAILBOX_SD_CARD;
    mailbuffer[6] =      (0 << 1) // wait
                        |(0 << 0); // power off
    mailbuffer[7] = MAILBOX_PROPERTY_END;
    //  invalidate the location of mailbuffer in cache. it has not been written to main memory yet.
    mmu_cache_invalidate((uint32_t)mailbuffer);
    //  write to VC
    mailbox_write_read(mailbuffer, MAILBOX_ARM_TO_VC);

    if(mailbuffer[1] != MAILBOX_REQUEST_SUCCESSFUL){
        uart_puts("EMMC power off: request not successfull:\r\n");
        return -1;
    }
    if(mailbuffer[5] != MAILBOX_SD_CARD) {
        uart_puts("EMMC power off: Wrong device ID returned!\r\n");
        return -1;
    }
    if(mailbuffer[6] & (1 << 0)){
        uart_puts("EMMC power off: power still on!   ");
        uart_put_uint32_t(mailbuffer[6], 16);
        uart_puts("\r\n");
        return -1;
    }
    if(mailbuffer[6] & (1 << 1)){
        uart_puts("EMMC power off: device does not exist!\r\n");
        return -1;
    } return 0;
}

static int bcm_power_on(void){
    volatile __attribute__((aligned(0x100))) uint32_t mailbuffer[8];
    mailbuffer[0] = sizeof(mailbuffer);
    mailbuffer[1] = MAILBOX_REQUEST;
    mailbuffer[2] = MAILBOX_SET_POWER_STATE;
    mailbuffer[3] = 8;  // size of value buffer
    mailbuffer[4] = 8;  // a request and value length is 8
    mailbuffer[5] = MAILBOX_SD_CARD;
    mailbuffer[6] =      (1 << 1) // wait
                        |(1 << 0); // power om
    mailbuffer[7] = MAILBOX_PROPERTY_END;
    //  invalidate the location of mailbuffer in cache. it has not been written to main memory yet.
    mmu_cache_invalidate((uint32_t)mailbuffer);
    //  write to VC
    mailbox_write_read(mailbuffer, MAILBOX_ARM_TO_VC);

    if(mailbuffer[1] != MAILBOX_REQUEST_SUCCESSFUL){
        uart_puts("EMMC power on: request not successfull:\r\n");
        return -1;
    }
    if(mailbuffer[5] != MAILBOX_SD_CARD) {
        uart_puts("EMMC power on: Wrong device ID returned!\r\n");
        return -1;
    }
    if(mailbuffer[6] & (1 << 1)){
        uart_puts("EMMC power on: device does not exist!\r\n");
        return -1;
    }
    if(!(mailbuffer[6] & (1 << 0))){
        uart_puts("EMMC power on: device still off!\r\n");
        return -1;
    }
    return 0;
}



static int bcm_emmc_power_cycle(void){
    if(bcm_power_off() < 0){
        return -1;
    }
    time_delay_microseconds(5);
    return bcm_power_on();
}

static uint32_t emmc_get_clock_divider(uint32_t base_clock, uint32_t target_rate){
    uint32_t target_div = 0;
    if(target_rate > base_clock){
        target_div = 1;
    }else{
        target_div = base_clock / target_rate;
        uint32_t mod = base_clock % target_rate;
        if(mod){
            target_div--;
        }
    }

    if(sd_version >= 2){
        // version 3 or greater supports 10-bit divided clock mode

        // Find the first bit set
        int div = -1;
        int first_bit;
        for(first_bit = 31; first_bit >= 0; first_bit--)
        {
            uint32_t bit_test = (1 << first_bit);
            if(target_div & bit_test)
            {
                div = first_bit;
                target_div &= ~bit_test;
                if(target_div)
                    div++;
                break;
            }
        }
        if(div == -1){  div = 31; }
        if(div >= 32){  div = 31; }
        if(div != 0) {  div = (1 << (div - 1)); }
        if(div >= 0x400)    {div = 0x3ff;}

        uint32_t freq_select = div & 0xff;
        uint32_t upper_bits = (div >> 8) & 0x3;
        uint32_t ret = (freq_select << 8) | (upper_bits << 6) | (0 << 5);

        return ret;
    }
    else{
        return EMMC_GET_CLOCK_DIVIDER_FAIL;
    }
}

// Switch the clock rate 
static int emmc_switch_clock_rate(uint32_t base_clock, uint32_t target_rate){
    // get divider
    uint32_t div = emmc_get_clock_divider(base_clock, target_rate);
    if(div == EMMC_GET_CLOCK_DIVIDER_FAIL){
        return -1;
    }
    // wait for cmd and dat inhibit to clear
    while( emmc_get()->STATUS & (DAT_INHIBIT | CMD_INHIBIT)){
        time_delay_microseconds(1);
    }
    // Set the emmc clock off
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 &= ~CLK_EN;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    // Write the new divider
 //   control1 &= ~0xffe0;        // Clear old
    control1 &= ~( CLK_GENSEL | CLK_FREQ_MS2(3) | CLK_FREQ8(0xff));
    control1 |= div;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    // Enable the emmc clock
    control1 |= CLK_EN;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    return 0;
}


// Reset the CMD line
static int emmc_reset_cmd(void){
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SRST_CMD;
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), SRST_CMD, 0, 1000);
    if( (emmc_get()->CONTROL1 & SRST_CMD) != 0){    return -1;}
    return 0;
}

// Reset the DATA line
static int emmc_reset_dat(void){
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SRST_DATA;
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), SRST_DATA, 0, 1000);
    if(( emmc_get()->CONTROL1 & SRST_DATA) != 0)  {return -1;}
    return 0;
}

static void emmc_command_single(        struct emmc_dev *dev,
                                        uint32_t cmd_reg, uint32_t argument, 
                                        uint32_t timeout){
    dev->last_cmd_reg = cmd_reg;
    dev->last_cmd_success = 0;
    while(emmc_get()->STATUS & CMD_INHIBIT){
        time_delay_microseconds(1);
    }
    // Is the command with busy?
    if((cmd_reg & EMMC_CMD_RSPNS_TYPE_MASK) == EMMC_CMD_RSPNS_TYPE_48B){
        if((cmd_reg & EMMC_CMD_TYPE_MASK) != EMMC_CMD_TYPE_ABORT){
            // Wait for the data line to be free
            while( emmc_get()->STATUS & DAT_INHIBIT){
                time_delay_microseconds(1);
            }
        }
    }

    // Set block size and block count
    // block size = 512 bytes, block count = 1,
    if(dev->blocks_to_transfer > 0xffff){
        dev->last_cmd_success = 0;
        return;
    }
    uint32_t blksizecnt = dev->block_size | (dev->blocks_to_transfer << 16);
    emmc_get()->BLKSIZECNT = blksizecnt;

    // Set argument 1 reg
    emmc_get()->ARG1 = argument;
    
    // Set command reg
    emmc_get()->CMDTM = cmd_reg;
    time_delay_microseconds(2);

    // Wait for command complete or error
    timeout_wait( &(emmc_get()->INTERRUPT), (ERR | CMD_DONE), 1, timeout);
    uint32_t interrupts = emmc_get()->INTERRUPT;

    // Clear command complete status
    emmc_get()->INTERRUPT = 0xffff0001;

    // Test for errors
    if((interrupts & (ERROR_MASK | CMD_DONE)) != CMD_DONE){
        dev->last_error = interrupts & ERROR_MASK;
        dev->last_interrupt = interrupts;
        return;
    }

    time_delay_microseconds(2);

    // Get response data
    switch(cmd_reg & EMMC_CMD_RSPNS_TYPE_MASK){
        case EMMC_CMD_RSPNS_TYPE_48:
        case EMMC_CMD_RSPNS_TYPE_48B:
            dev->last_r0 = emmc_get()->RESP0;
            break;
        case EMMC_CMD_RSPNS_TYPE_136:
            dev->last_r0 = emmc_get()->RESP0;
            dev->last_r1 = emmc_get()->RESP1;
            dev->last_r2 = emmc_get()->RESP2;
            dev->last_r3 = emmc_get()->RESP3;
            break;
    }

    // If with data, wait for the appropriate interrupt
    if(cmd_reg & EMMC_CMD_WITH_DATA){
        uint32_t wr_irq;
        int is_write = 0;
        if(cmd_reg & EMMC_CMD_DAT_DIR_CH){
            wr_irq = READ_RDY;
        }else{
            is_write = 1;
            wr_irq = WRITE_RDY;
        }

        int cur_block = 0;
        uint32_t *cur_buf_addr = (uint32_t *)dev->buf;
        while(cur_block < dev->blocks_to_transfer){
            timeout_wait( &(emmc_get()->INTERRUPT), wr_irq | ERR, 1, timeout);
            interrupts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = ERROR_MASK | wr_irq;
            // check for error
            if((interrupts & (ERROR_MASK | wr_irq)) != wr_irq){
                dev->last_error = interrupts & ERROR_MASK;
                dev->last_interrupt = interrupts;
                return;
            }

            // Transfer the block
            size_t cur_byte_no = 0;
            while(cur_byte_no < dev->block_size){
                if(is_write){
					uint32_t data = read_word((uint8_t *)cur_buf_addr, 0);
                    emmc_get()->DATA = data;
				}else{
					uint32_t data = emmc_get()->DATA;
                    write_word(data, (uint8_t *)cur_buf_addr, 0);
				}
                cur_byte_no += 4;
                cur_buf_addr++;
            }
            cur_block++;
        }
    }
    
    // Wait for transfer complete (set if read/write transfer or with busy)
    if(((cmd_reg & EMMC_CMD_RSPNS_TYPE_MASK) == EMMC_CMD_RSPNS_TYPE_48B) ||
       (cmd_reg & EMMC_CMD_WITH_DATA)){
        // First check command inhibit (DAT) is not already 0
        if( ((emmc_get()->STATUS) & DAT_INHIBIT) == 0){
            emmc_get()->INTERRUPT = ERROR_MASK | DATA_DONE;
        }else{
            timeout_wait( &(emmc_get()->INTERRUPT), ERR | DATA_DONE, 1, timeout);
            interrupts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = ERROR_MASK | DATA_DONE;

            // Handle the case where both data timeout and transfer complete
            //  are set - transfer complete overrides data timeout: HCSS 2.2.17
            if(((interrupts & (ERROR_MASK | DATA_DONE)) != DATA_DONE) && ((interrupts & (ERROR_MASK | DATA_DONE)) != (DTO_ERR | DATA_DONE))){
                dev->last_error = interrupts & ERROR_MASK;
                dev->last_interrupt = interrupts;
                return;
            }
            emmc_get()->INTERRUPT = ERROR_MASK | DATA_DONE;
        }
    }
    // Return success
    dev->last_cmd_success = 1;
}

static void emmc_handle_card_interrupt(struct emmc_dev *dev){
    // Handle a card interrupt
    if(dev->card_rca){
        emmc_command_single(dev, emmc_commands[SEND_STATUS], dev->card_rca << 16,500);
    }
}

static void emmc_handle_interrupts(struct emmc_dev *dev){
    uint32_t interrupts = emmc_get()->INTERRUPT;
    uint32_t reset_mask = 0;

    if(interrupts & CMD_DONE){
        reset_mask |= CMD_DONE;
    }
    if(interrupts & DATA_DONE){
        reset_mask |= DATA_DONE;
    }
    if(interrupts & BLOCK_GAP){
        reset_mask |= BLOCK_GAP;
    }
    if(interrupts & WRITE_RDY){
        reset_mask |= WRITE_RDY;
        emmc_reset_dat();
    }
    if(interrupts & READ_RDY){
        reset_mask |= READ_RDY;
        emmc_reset_dat();
    }
    if(interrupts & CARD){
        emmc_handle_card_interrupt(dev);
        reset_mask |= CARD;
    }
    if(interrupts & ERR){
        reset_mask |= ERROR_MASK;
    }
    emmc_get()->INTERRUPT = reset_mask;
}


static int emmc_command(        struct emmc_dev *dev,
                                uint32_t command,
                                uint32_t argument,
                                uint32_t timeout){
    // First, handle any pending interrupts
    emmc_handle_interrupts(dev);
    // Stop the command issue if it was the card remove interrupt that was
    //  handled
    if(dev->card_removal){
        dev->last_cmd_success = 0;
        return -1;
    }

    // Now run the appropriate commands by calling emmc_issue_command_int()
    // mask out IS_APP_CMD
    if(command & IS_APP_CMD){
        command &= 0xff;

        if(emmc_acommands[command] == EMMC_CMD_RESERVED(0)){
            dev->last_cmd_success = 0;
            return -1;
        }
        dev->last_cmd = APP_CMD;

        uint32_t rca = 0;
        if(dev->card_rca){
            rca = dev->card_rca << 16;
        }
        emmc_command_single(dev, emmc_commands[APP_CMD], rca, timeout);
        if(dev->last_cmd_success){
            dev->last_cmd = command | IS_APP_CMD;
            emmc_command_single(dev, emmc_acommands[command], argument, timeout);
        }
    }else{
        if(emmc_commands[command] == EMMC_CMD_RESERVED(0)){
            dev->last_cmd_success = 0;
            return -1;
        }
        dev->last_cmd = command;
        emmc_command_single(dev, emmc_commands[command], argument, timeout);
    }
    return 0;
}

static int emmc_card_init(struct emmc_dev **dev){

	// Power cycle the card to ensure its in its startup state
	if(bcm_emmc_power_cycle() != 0){
        uart_puts("EMMC init: failed power cycle\r\n");
        return -1;
	}

	// read the sd controller version
	uint32_t ver = emmc_get()->SLOTISR_VER;
    uint32_t emmcversion = (ver >> 16) & 0xff;
    sd_version = emmcversion;

	if(sd_version < 2){
        uart_puts("EMMC init: sd version not supported\r\n");
		return -1;
	}

	// Reset the controller
	uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SRST_HC;
    // Disable clock
    control1 &= ~CLK_EN;
    control1 &= ~CLK_INTLEN;
    emmc_get()->CONTROL1 = control1;
	if (timeout_wait( &(emmc_get()->CONTROL1), SRST_DATA | SRST_CMD | SRST_HC, 0, 10) < 0){
        uart_puts("EMMC init: clock disable timout wait error\r\n");
		return -1;
	}
    if((emmc_get()->CONTROL1 & (SRST_DATA | SRST_CMD | SRST_HC)) != 0){
        uart_puts("EMMC init: clock disable bits still high\r\n");
        return -1;
    }

	// Check for a valid card
    timeout_wait( &(emmc_get()->STATUS), VALID_CARD, 1, 500);
    uint32_t status_reg = emmc_get()->STATUS;
    if((status_reg & VALID_CARD) == 0){
        uart_puts("EMMC init: invalid card\r\n");
        return -1;
    }
	// Clear control2
	emmc_get()->CONTROL2 = 0;

	// Get the base clock rate
	uint32_t base_clock = emmc_get_base_clock();
    if(base_clock == 0){
        uart_puts("EMMC init: can't get emmc base clock. assuming 100 000 000\r\n");
        base_clock = 100000000;
    }
	// Set clock rate to something slow
	control1 = emmc_get()->CONTROL1;
    control1 |= CLK_INTLEN;    // enable clock

	// Set to identification frequency (400 kHz)
	uint32_t f_id = emmc_get_clock_divider(base_clock, EMMC_CLOCK_ID);
    if(f_id == EMMC_GET_CLOCK_DIVIDER_FAIL){
        uart_puts("EMMC init: get clock divider failed\r\n");
        return -1;
    }
    control1 |= f_id;

	control1 |= DATA_TOUNIT(7);		// data timeout = TMCLK * 2^10
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), CLK_STABLE, 1, 0x100);
    if((emmc_get()->CONTROL1 & CLK_STABLE) == 0){
        uart_puts("EMMC init: clock adjustment timeout wait failed\r\n");
        return -1;
    }

	// Enable the EMMC clock
	time_delay_microseconds(2);
    control1 = emmc_get()->CONTROL1;
    control1 |= CLK_EN;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

	// Mask off sending interrupts to the ARM
	emmc_get()->IRPT_EN = 0;
	// Reset interrupts
	emmc_get()->INTERRUPT = 0xffffffff;
	// Have all interrupts sent to the INTERRUPT register
	uint32_t irpt_mask = 0xffffffff & (~CARD);
    irpt_mask |= CARD;
	emmc_get()->IRPT_MASK = irpt_mask;

	time_delay_microseconds(2);

    // Prepare the device 
	struct emmc_dev *ret;
	if(*dev == NULL){
		ret = (struct emmc_dev *)malloc(sizeof(struct emmc_dev));
	}else{
		ret = *dev;
    }

	memset(ret, 0, sizeof(struct emmc_dev));
	ret->base_clock = base_clock;

	// Send CMD0 to the card (reset to idle state)
	emmc_command(ret, GO_IDLE_STATE, 0, 500);
	if(FAIL(ret)){
        uart_puts("EMMC init: GO_IDLE_STATE failed\r\n");
        return -1;
    }

	// Send CMD8 to the card
	// Voltage supplied = 0x1 = 2.7-3.6V (standard)
	// Check pattern = 10101010b (as per PLSS 4.3.13) = 0xAA
	emmc_command(ret, SEND_IF_COND, 0x1aa, 500);
	int v2 = 0;
	if(TIMEOUT(ret)){   v2 = 0; }
    else if(CMD_TIMEOUT(ret)){
        if(emmc_reset_cmd() == -1){
            uart_puts("EMMC init: SEND_IF_COND reset cmd failed\r\n");
            return -1; 
        }
        emmc_get()->INTERRUPT = CTO_ERR;
        v2 = 0;
    }
    else if(FAIL(ret)){
        uart_puts("EMMC init; SEND_IF_COND failed!\r\n");
        return -1; 
    }else{
        if((ret->last_r0 & 0xfff) != 0x1aa){
            uart_puts("EMMC: not usable card\n");
            return -1;
        }else{
            v2 = 1;
        }
    }

    // Here we are supposed to check the response to CMD5 (HCSS 3.6)
    // It only returns if the card is a EMMCIO card
    emmc_command(ret, IO_SET_OP_COND, 0, 10);
    if(!TIMEOUT(ret)){
        if(CMD_TIMEOUT(ret)){
            if(emmc_reset_cmd() == -1){ 
                uart_puts("EMMC init: Set op cond reset cmd error\r\n");
                return -1;
            }
            emmc_get()->INTERRUPT = CTO_ERR;
        }else{
            uart_puts("EMMC init: Set op cond error!\r\n");
            return -1;
        }
    }

    // Call an inquiry ACMD41 (voltage window = 0) to get the OCR
    emmc_command(ret, ACMD(41), 0, 500);
    if(FAIL(ret)){
        uart_puts("EMMC init: Get OCR failed\r\n");
        return -1;
    }

	// Call initialization ACMD41
	int card_is_busy = 1;
	while(card_is_busy){
	    uint32_t v2_flags = 0;
	    if(v2){
	        // Set EMMCHC support
	        v2_flags |= (1 << 30);

	        // Set 1.8v support
	        if(!ret->failed_voltage_switch){
                v2_flags |= (1 << 24);
            }

            // Enable EMMCXC maximum performance
            v2_flags |= (1 << 28);
	    }

	    emmc_command(ret, ACMD(41), 0x00ff8000 | v2_flags, 500);
	    if(FAIL(ret)){
	        uart_puts("EMMC: error issuing ACMD41\n");
	        return -1;
	    }

	    if((ret->last_r0 >> 31) & 0x1){
	        // Initialization is complete
	        ret->card_ocr = (ret->last_r0 >> 8) & 0xffff;
	        ret->card_supports_sdhc = (ret->last_r0 >> 30) & 0x1;

	        if(!ret->failed_voltage_switch){
                ret->card_supports_18v = (ret->last_r0 >> 24) & 0x1;
            }
	        card_is_busy = 0;
	    }else{
	        // Card is still busy
            time_delay_microseconds(5);
	    }
	}

    emmc_switch_clock_rate(base_clock, EMMC_CLOCK_NORMAL);

	// A small wait before the voltage switch
	time_delay_microseconds(5);

	// Switch to 1.8V mode if possible
	if(ret->card_supports_18v){
	    // As per HCSS 3.6.1

	    // Send VOLTAGE_SWITCH
	    emmc_command(ret, VOLTAGE_SWITCH, 0, 500);
	    if(FAIL(ret)){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
			uart_puts("EMMC: voltage switch error\r\n");
	        return emmc_card_init(&ret);
	    }

	    // Disable EMMC clock
	    control1 = emmc_get()->CONTROL1;
        control1 &= ~CLK_EN;
        emmc_get()->CONTROL1 = control1;

	    // Check DAT[3:0]
	    status_reg = emmc_get()->STATUS;
        uint32_t dat30 = (status_reg >> 20) & 0xf;
	    if(dat30 != 0){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
			uart_puts("EMMC: dat30 error\r\n");
	        return emmc_card_init(&ret);
	    }

	    // Set 1.8V signal enable to 1
	    uint32_t control0 = emmc_get()->CONTROL0;
        control0 |= ENABLE_1_8V;
        emmc_get()->CONTROL0 = control0;
	    // Wait 5 ms
	    time_delay_microseconds(5);

	    // Check the 1.8V signal enable is set
	    control0 = emmc_get()->CONTROL0;
	    if((control0 & ENABLE_1_8V) == 0){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
	        return emmc_card_init(&ret);
	    }

	    // Re-enable the EMMC clock
	    control1 = emmc_get()->CONTROL1;
        control1 |= CLK_EN;
        emmc_get()->CONTROL1 = control1;

	    // Wait 1 ms
	    time_delay_microseconds(1);

	    // Check DAT[3:0]
	    status_reg = emmc_get()->STATUS;
        dat30 = (status_reg >> 20) & 0xf;
        if(dat30 != 0xf){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
	        return emmc_card_init(&ret);
	    }
	}

	// Send CMD2 to get the cards CID
	emmc_command(ret, ALL_SEND_CID, 0, 500);
	if(FAIL(ret)){
	    uart_puts("EMMC: error sending ALL_SEND_CID\n");
	    return -1;
	}
	uint32_t card_cid_0 = ret->last_r0;
	uint32_t card_cid_1 = ret->last_r1;
	uint32_t card_cid_2 = ret->last_r2;
	uint32_t card_cid_3 = ret->last_r3;

	uint32_t *dev_id = (uint32_t *)malloc(4 * sizeof(uint32_t));
	dev_id[0] = card_cid_0;
	dev_id[1] = card_cid_1;
	dev_id[2] = card_cid_2;
	dev_id[3] = card_cid_3;

	// Send CMD3 to enter the data state
	emmc_command(ret, SEND_RELATIVE_ADDR, 0, 500000);
	if(FAIL(ret)){
        free(ret);
        uart_puts("EMMC init: enter data state error\r\n");
        return -1;
    }

	uint32_t cmd3_resp = ret->last_r0;

	ret->card_rca = (cmd3_resp >> 16) & 0xffff;
	uint32_t crc_error = (cmd3_resp >> 15) & 0x1;
	uint32_t illegal_cmd = (cmd3_resp >> 14) & 0x1;
	uint32_t error = (cmd3_resp >> 13) & 0x1;
	uint32_t status = (cmd3_resp >> 9) & 0xf;
	uint32_t ready = (cmd3_resp >> 8) & 0x1;

	if(crc_error){
		free(ret);
        uart_puts("EMMC init: CRC error\r\n");
		return -1;
	}

	if(illegal_cmd){
		free(ret);
        uart_puts("EMMC init: illegal command error\r\n");
		return -1;
	}

	if(error){
		free(ret);
        uart_puts("EMMC init: error\r\n");
		return -1;
	}

	if(!ready){
		free(ret);
        uart_puts("EMMC init: not ready! error\r\n");
		return -1;
	}


	// Now select the card (toggles it to transfer state)
	emmc_command(ret, SELECT_CARD, ret->card_rca << 16, 500);
	if(FAIL(ret)){
	    free(ret);
        uart_puts("EMMC init: Select card error\r\n");
	    return -1;
	}

	uint32_t cmd7_resp = ret->last_r0;
	status = (cmd7_resp >> 9) & 0xf;

	if((status != 3) && (status != 4)){
		free(ret);
        uart_puts("EMMC init: status error\r\n");
		return -1;
	}

	// If not an EMMCHC card, ensure BLOCKLEN is 512 bytes
	if(!ret->card_supports_sdhc){
	    emmc_command(ret, SET_BLOCKLEN, 512, 500);
	    if(FAIL(ret)){
	        uart_puts("EMMC: error sending SET_BLOCKLEN\n\r");
	        free(ret);
	        return -1;
	    }
	}
	ret->block_size = 512;
	uint32_t controller_block_size = emmc_get()->BLKSIZECNT;
    controller_block_size &= ~BLKSIZE(0xfff);
    controller_block_size |= BLKSIZE(0x200);
    emmc_get()->BLKSIZECNT = controller_block_size;

	// Get the cards SCR register
	ret->scr = (struct emmc_scr *)malloc(sizeof(struct emmc_scr));
	ret->buf = &ret->scr->scr[0];
	ret->block_size = 8;
	ret->blocks_to_transfer = 1;
	emmc_command(ret, SEND_SCR, 0, 500);
	ret->block_size = 512;
	if(FAIL(ret)){
	    uart_puts("EMMC: error sending SEND_SCR\n\r");
	    free(ret->scr);
        free(ret);
	    return -1;
	}

	// Determine card version
	// Note that the SCR is big-endian
	uint32_t scr0 = byte_swap(ret->scr->scr[0]);
	ret->scr->sd_version = EMMC_VER_UNKNOWN;
	uint32_t emmc_spec = (scr0 >> (56 - 32)) & 0xf;
	uint32_t emmc_spec3 = (scr0 >> (47 - 32)) & 0x1;
	uint32_t emmc_spec4 = (scr0 >> (42 - 32)) & 0x1;
	ret->scr->sd_bus_widths = (scr0 >> (48 - 32)) & 0xf;
	if(emmc_spec == 0)      { ret->scr->sd_version = EMMC_VER_1; }
    else if(emmc_spec == 1) { ret->scr->sd_version = EMMC_VER_1_1; }
    else if(emmc_spec == 2) {
        if(emmc_spec3 == 0) {ret->scr->sd_version = EMMC_VER_2; }
        else if(emmc_spec3 == 1){
            if(emmc_spec4 == 0){
                ret->scr->sd_version = EMMC_VER_3;
            }else if(emmc_spec4 == 1){
                ret->scr->sd_version = EMMC_VER_4;
            }
        }
    }

    if(ret->scr->sd_bus_widths & 0x4){
        // Set 4-bit transfer mode (ACMD6)
        // See HCSS 3.4 for the algorithm

        // Disable card interrupt in host
        uint32_t old_irpt_mask = emmc_get()->IRPT_MASK;
        uint32_t new_iprt_mask = old_irpt_mask & ~CARD;
        emmc_get()->IRPT_MASK = new_iprt_mask;

        // Send ACMD6 to change the card's bit mode
        emmc_command(ret, SET_BUS_WIDTH, 0x2, 500);
        if(FAIL(ret)){
            uart_puts("EMMC init: switch to 4-bit data mode failed\n\r");
        }else{
            // Change bit mode for Host
            uint32_t control0 = emmc_get()->CONTROL0;
            control0 |= HCTL_DWIDTH;
            emmc_get()->CONTROL0 = control0;

            // Re-enable card interrupt in host
            emmc_get()->IRPT_MASK = old_irpt_mask;
        }
    }

	// Reset interrupt register
	emmc_get()->INTERRUPT = 0xffffffff;

	*dev = ret;
	return 0;
}

static int emmc_data_mode(struct emmc_dev *edev){
	if(edev->card_rca == 0){
		// Try again to initialise the card
		int ret = emmc_card_init(&edev);
		if(ret != 0){   return ret;}
	}

    emmc_command(edev, SEND_STATUS, edev->card_rca << 16, 500);
    if(FAIL(edev)){
        uart_puts("EMMC: ensure_data_mode() error sending CMD13\n\r");
        edev->card_rca = 0;
        return -1;
    }

	uint32_t status = edev->last_r0;
	uint32_t cur_state = CURRENT_STATE(status);
	if(cur_state == CARD_IDENT){
		// Currently in the stand-by state - select it
		emmc_command(edev, SELECT_CARD, edev->card_rca << 16, 500);
		if(FAIL(edev)){
			uart_puts("EMMC: ensure_data_mode() no response from CMD17\r\n");
			edev->card_rca = 0;
			return -1;
		}
	}else if(cur_state == CARD_DATA){
		// In the data transfer state - cancel the transmission
		emmc_command(edev, STOP_TRANSMISSION, 0, 500);
		if(FAIL(edev)){
			edev->card_rca = 0;
			return -1;
		}

		// Reset the data circuit
		emmc_reset_dat();
		
	}else if(cur_state != CARD_TRAN){
		// Not in the transfer state - re-initialise
		int ret = emmc_card_init(&edev);
		if(ret != 0){   return ret; }
	}

	// Check again that we're now in the correct mode
	if(cur_state != CARD_TRAN){
        emmc_command(edev, SEND_STATUS, edev->card_rca << 16, 500000);
        if(FAIL(edev)){
			edev->card_rca = 0;
			return -1;
		}
		status = edev->last_r0;
		cur_state = (status >> 9) & 0xf;

		if(cur_state != CARD_TRAN){
			edev->card_rca = 0;
			return -1;
		}
	}
	return 0;
}

static int emmc_data_command(        struct emmc_dev *edev,
                                        int is_write, uint8_t *buf,
                                        size_t buf_size,
                                        uint32_t block_no){
	// PLSS table 4.20 - EMMCSC cards use byte addresses rather than block addresses
	if(!edev->card_supports_sdhc)   {block_no *= 512; }
    
	// This is as per HCSS 3.7.2.1
	if(buf_size < edev->block_size){ return -1; }

	edev->blocks_to_transfer = buf_size / edev->block_size;
	if(buf_size % edev->block_size)     {return -1;}
	edev->buf = buf;

	int command;
	if(is_write){
	    if(edev->blocks_to_transfer > 1){
            command = WRITE_MULTIPLE_BLOCK;
        }else{
            command = WRITE_BLOCK;
        }
	}else{
        if(edev->blocks_to_transfer > 1){
            command = READ_MULTIPLE_BLOCK;
        }else{
            command = READ_SINGLE_BLOCK;
        }
    }

	int retry_count = 0;
	int max_retries = 3;
	while(retry_count < max_retries){
        emmc_command(edev, command, block_no, 500);
        if(SUCCESS(edev)){
            break;
        }else{
            retry_count++;
        }
	}
	if(retry_count == max_retries) {
        edev->card_rca = 0;
        return -1;
    }
    return 0;
}

static struct emmc_dev *device;

int emmc_init(void){
    if( emmc_card_init(&device) == -1){
        uart_puts("EMMC Driver initialization failed\r\n");
        return -1;
    }
    uart_puts("EMMC Driver initialization succesful\r\n");
    return 0;
}

int emmc_read(uint8_t *buf, size_t buf_size, uint32_t block_no){
	// Check the status of the card
    if(emmc_data_mode(device) != 0){     return -1; }
    if(emmc_data_command(device, 0, buf, buf_size, block_no) < 0){ return -1;}
	return buf_size;
}

int emmc_write(uint8_t *buf, size_t buf_size, uint32_t block_no){
	// Check the status of the card
    if(emmc_data_mode(device) != 0){ return -1; }
    if(emmc_data_command(device, 1, buf, buf_size, block_no) < 0){ return -1;}
	return buf_size;
}

size_t emmc_get_dev_block_size(void){ 
    return device->block_size;
}

