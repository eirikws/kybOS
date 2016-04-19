#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "base.h"
#include "mailbox.h"
#include "uart.h"
#include "mmu.h"
#include "block.h"
#include "time.h"
#include "emmc.h"

// SD Clock Frequencies (in Hz)
#define SD_CLOCK_ID         400000
#define SD_CLOCK_NORMAL     25000000
#define SD_CLOCK_HIGH       50000000
#define SD_CLOCK_100        100000000
#define SD_CLOCK_208        208000000


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
     volatile uint32_t TUNE_STEP_STD; // Card clock tuning steps for SDR        8c-90
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


static uint32_t hci_ver = 0;

struct emmc_scr{
    uint32_t    scr[2];
    uint32_t    sd_bus_widths;
    int         sd_version;
};

struct emmc_dev{
    struct block_device bd;
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


#define SD_CMD_INDEX(a)		((a) << 24)
#define SD_CMD_TYPE_NORMAL	0x0
#define SD_CMD_TYPE_SUSPEND	(1 << 22)
#define SD_CMD_TYPE_RESUME	(2 << 22)
#define SD_CMD_TYPE_ABORT	(3 << 22)
#define SD_CMD_TYPE_MASK    (3 << 22)
#define SD_CMD_ISDATA		(1 << 21)
#define SD_CMD_IXCHK_EN		(1 << 20)
#define SD_CMD_CRCCHK_EN	(1 << 19)
#define SD_CMD_RSPNS_TYPE_NONE	0			// For no response
#define SD_CMD_RSPNS_TYPE_136	(1 << 16)		// For response R2 (with CRC), R3,4 (no CRC)
#define SD_CMD_RSPNS_TYPE_48	(2 << 16)		// For responses R1, R5, R6, R7 (with CRC)
#define SD_CMD_RSPNS_TYPE_48B	(3 << 16)		// For responses R1b, R5b (with CRC)
#define SD_CMD_RSPNS_TYPE_MASK  (3 << 16)
#define SD_CMD_MULTI_BLOCK	(1 << 5)
#define SD_CMD_DAT_DIR_HC	0
#define SD_CMD_DAT_DIR_CH	(1 << 4)
#define SD_CMD_AUTO_CMD_EN_NONE	0
#define SD_CMD_AUTO_CMD_EN_CMD12	(1 << 2)
#define SD_CMD_AUTO_CMD_EN_CMD23	(2 << 2)
#define SD_CMD_BLKCNT_EN		(1 << 1)
#define SD_CMD_DMA          1

#define SD_ERR_CMD_TIMEOUT	0
#define SD_ERR_CMD_CRC		1
#define SD_ERR_CMD_END_BIT	2
#define SD_ERR_CMD_INDEX	3
#define SD_ERR_DATA_TIMEOUT	4
#define SD_ERR_DATA_CRC		5
#define SD_ERR_DATA_END_BIT	6
#define SD_ERR_CURRENT_LIMIT	7
#define SD_ERR_AUTO_CMD12	8
#define SD_ERR_ADMA		9
#define SD_ERR_TUNING		10
#define SD_ERR_RSVD		11

#define SD_ERR_MASK_CMD_TIMEOUT		(1 << (16 + SD_ERR_CMD_TIMEOUT))
#define SD_ERR_MASK_CMD_CRC		(1 << (16 + SD_ERR_CMD_CRC))
#define SD_ERR_MASK_CMD_END_BIT		(1 << (16 + SD_ERR_CMD_END_BIT))
#define SD_ERR_MASK_CMD_INDEX		(1 << (16 + SD_ERR_CMD_INDEX))
#define SD_ERR_MASK_DATA_TIMEOUT	(1 << (16 + SD_ERR_CMD_TIMEOUT))
#define SD_ERR_MASK_DATA_CRC		(1 << (16 + SD_ERR_CMD_CRC))
#define SD_ERR_MASK_DATA_END_BIT	(1 << (16 + SD_ERR_CMD_END_BIT))
#define SD_ERR_MASK_CURRENT_LIMIT	(1 << (16 + SD_ERR_CMD_CURRENT_LIMIT))
#define SD_ERR_MASK_AUTO_CMD12		(1 << (16 + SD_ERR_CMD_AUTO_CMD12))
#define SD_ERR_MASK_ADMA		(1 << (16 + SD_ERR_CMD_ADMA))
#define SD_ERR_MASK_TUNING		(1 << (16 + SD_ERR_CMD_TUNING))

#define SD_COMMAND_COMPLETE     1
#define SD_TRANSFER_COMPLETE    (1 << 1)
#define SD_BLOCK_GAP_EVENT      (1 << 2)
#define SD_DMA_INTERRUPT        (1 << 3)
#define SD_BUFFER_WRITE_READY   (1 << 4)
#define SD_BUFFER_READ_READY    (1 << 5)
#define SD_CARD_INSERTION       (1 << 6)
#define SD_CARD_REMOVAL         (1 << 7)
#define SD_CARD_INTERRUPT       (1 << 8)

#define SD_RESP_NONE        SD_CMD_RSPNS_TYPE_NONE
#define SD_RESP_R1          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)
#define SD_RESP_R1b         (SD_CMD_RSPNS_TYPE_48B | SD_CMD_CRCCHK_EN)
#define SD_RESP_R2          (SD_CMD_RSPNS_TYPE_136 | SD_CMD_CRCCHK_EN)
#define SD_RESP_R3          SD_CMD_RSPNS_TYPE_48
#define SD_RESP_R4          SD_CMD_RSPNS_TYPE_136
#define SD_RESP_R5          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)
#define SD_RESP_R5b         (SD_CMD_RSPNS_TYPE_48B | SD_CMD_CRCCHK_EN)
#define SD_RESP_R6          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)
#define SD_RESP_R7          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)

#define SD_DATA_READ        (SD_CMD_ISDATA | SD_CMD_DAT_DIR_CH)
#define SD_DATA_WRITE       (SD_CMD_ISDATA | SD_CMD_DAT_DIR_HC)

#define SD_CMD_RESERVED(a)  0xffffffff

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

#define SD_VER_UNKNOWN      0
#define SD_VER_1            1
#define SD_VER_1_1          2
#define SD_VER_2            3
#define SD_VER_3            4
#define SD_VER_4            5

static uint32_t emmc_commands[] = {
    SD_CMD_INDEX(0),
    SD_CMD_RESERVED(1),
    SD_CMD_INDEX(2) | SD_RESP_R2,
    SD_CMD_INDEX(3) | SD_RESP_R6,
    SD_CMD_INDEX(4),
    SD_CMD_INDEX(5) | SD_RESP_R4,
    SD_CMD_INDEX(6) | SD_RESP_R1,
    SD_CMD_INDEX(7) | SD_RESP_R1b,
    SD_CMD_INDEX(8) | SD_RESP_R7,
    SD_CMD_INDEX(9) | SD_RESP_R2,
    SD_CMD_INDEX(10) | SD_RESP_R2,
    SD_CMD_INDEX(11) | SD_RESP_R1,
    SD_CMD_INDEX(12) | SD_RESP_R1b | SD_CMD_TYPE_ABORT,
    SD_CMD_INDEX(13) | SD_RESP_R1,
    SD_CMD_RESERVED(14),
    SD_CMD_INDEX(15),
    SD_CMD_INDEX(16) | SD_RESP_R1,
    SD_CMD_INDEX(17) | SD_RESP_R1 | SD_DATA_READ,
    SD_CMD_INDEX(18) | SD_RESP_R1 | SD_DATA_READ | SD_CMD_MULTI_BLOCK | SD_CMD_BLKCNT_EN,
    SD_CMD_INDEX(19) | SD_RESP_R1 | SD_DATA_READ,
    SD_CMD_INDEX(20) | SD_RESP_R1b,
    SD_CMD_RESERVED(21),
    SD_CMD_RESERVED(22),
    SD_CMD_INDEX(23) | SD_RESP_R1,
    SD_CMD_INDEX(24) | SD_RESP_R1 | SD_DATA_WRITE,
    SD_CMD_INDEX(25) | SD_RESP_R1 | SD_DATA_WRITE | SD_CMD_MULTI_BLOCK | SD_CMD_BLKCNT_EN,
    SD_CMD_RESERVED(26),
    SD_CMD_INDEX(27) | SD_RESP_R1 | SD_DATA_WRITE,
    SD_CMD_INDEX(28) | SD_RESP_R1b,
    SD_CMD_INDEX(29) | SD_RESP_R1b,
    SD_CMD_INDEX(30) | SD_RESP_R1 | SD_DATA_READ,
    SD_CMD_RESERVED(31),
    SD_CMD_INDEX(32) | SD_RESP_R1,
    SD_CMD_INDEX(33) | SD_RESP_R1,
    SD_CMD_RESERVED(34),
    SD_CMD_RESERVED(35),
    SD_CMD_RESERVED(36),
    SD_CMD_RESERVED(37),
    SD_CMD_INDEX(38) | SD_RESP_R1b,
    SD_CMD_RESERVED(39),
    SD_CMD_RESERVED(40),
    SD_CMD_RESERVED(41),
    SD_CMD_RESERVED(42) | SD_RESP_R1,
    SD_CMD_RESERVED(43),
    SD_CMD_RESERVED(44),
    SD_CMD_RESERVED(45),
    SD_CMD_RESERVED(46),
    SD_CMD_RESERVED(47),
    SD_CMD_RESERVED(48),
    SD_CMD_RESERVED(49),
    SD_CMD_RESERVED(50),
    SD_CMD_RESERVED(51),
    SD_CMD_RESERVED(52),
    SD_CMD_RESERVED(53),
    SD_CMD_RESERVED(54),
    SD_CMD_INDEX(55) | SD_RESP_R1,
    SD_CMD_INDEX(56) | SD_RESP_R1 | SD_CMD_ISDATA,
    SD_CMD_RESERVED(57),
    SD_CMD_RESERVED(58),
    SD_CMD_RESERVED(59),
    SD_CMD_RESERVED(60),
    SD_CMD_RESERVED(61),
    SD_CMD_RESERVED(62),
    SD_CMD_RESERVED(63)
};

static uint32_t emmc_acommands[] = {
    SD_CMD_RESERVED(0),
    SD_CMD_RESERVED(1),
    SD_CMD_RESERVED(2),
    SD_CMD_RESERVED(3),
    SD_CMD_RESERVED(4),
    SD_CMD_RESERVED(5),
    SD_CMD_INDEX(6) | SD_RESP_R1,
    SD_CMD_RESERVED(7),
    SD_CMD_RESERVED(8),
    SD_CMD_RESERVED(9),
    SD_CMD_RESERVED(10),
    SD_CMD_RESERVED(11),
    SD_CMD_RESERVED(12),
    SD_CMD_INDEX(13) | SD_RESP_R1,
    SD_CMD_RESERVED(14),
    SD_CMD_RESERVED(15),
    SD_CMD_RESERVED(16),
    SD_CMD_RESERVED(17),
    SD_CMD_RESERVED(18),
    SD_CMD_RESERVED(19),
    SD_CMD_RESERVED(20),
    SD_CMD_RESERVED(21),
    SD_CMD_INDEX(22) | SD_RESP_R1 | SD_DATA_READ,
    SD_CMD_INDEX(23) | SD_RESP_R1,
    SD_CMD_RESERVED(24),
    SD_CMD_RESERVED(25),
    SD_CMD_RESERVED(26),
    SD_CMD_RESERVED(27),
    SD_CMD_RESERVED(28),
    SD_CMD_RESERVED(29),
    SD_CMD_RESERVED(30),
    SD_CMD_RESERVED(31),
    SD_CMD_RESERVED(32),
    SD_CMD_RESERVED(33),
    SD_CMD_RESERVED(34),
    SD_CMD_RESERVED(35),
    SD_CMD_RESERVED(36),
    SD_CMD_RESERVED(37),
    SD_CMD_RESERVED(38),
    SD_CMD_RESERVED(39),
    SD_CMD_RESERVED(40),
    SD_CMD_INDEX(41) | SD_RESP_R3,
    SD_CMD_INDEX(42) | SD_RESP_R1,
    SD_CMD_RESERVED(43),
    SD_CMD_RESERVED(44),
    SD_CMD_RESERVED(45),
    SD_CMD_RESERVED(46),
    SD_CMD_RESERVED(47),
    SD_CMD_RESERVED(48),
    SD_CMD_RESERVED(49),
    SD_CMD_RESERVED(50),
    SD_CMD_INDEX(51) | SD_RESP_R1 | SD_DATA_READ,
    SD_CMD_RESERVED(52),
    SD_CMD_RESERVED(53),
    SD_CMD_RESERVED(54),
    SD_CMD_RESERVED(55),
    SD_CMD_RESERVED(56),
    SD_CMD_RESERVED(57),
    SD_CMD_RESERVED(58),
    SD_CMD_RESERVED(59),
    SD_CMD_RESERVED(60),
    SD_CMD_RESERVED(61),
    SD_CMD_RESERVED(62),
    SD_CMD_RESERVED(63)
};

// The actual command indices
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
#define SEND_CSD                9
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
#define PROGRAM_CSD             27
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
#define SD_STATUS               (13 | IS_APP_CMD)
#define SEND_NUM_WR_BLOCKS      (22 | IS_APP_CMD)
#define SET_WR_BLK_ERASE_COUNT  (23 | IS_APP_CMD)
#define SD_SEND_OP_COND         (41 | IS_APP_CMD)
#define SET_CLR_CARD_DETECT     (42 | IS_APP_CMD)
#define SEND_SCR                (51 | IS_APP_CMD)

#define SD_RESET_CMD            (1 << 25)
#define SD_RESET_DAT            (1 << 26)
#define SD_RESET_ALL            (1 << 24)

#define SD_GET_CLOCK_DIVIDER_FAIL	0xffffffff

static uint32_t byte_swap(unsigned int in){
    uint32_t b0 = in & 0xFF;
    uint32_t b1 = (in >> 8) & 0xFF;
    uint32_t b2 = (in >> 16) & 0xFF;
    uint32_t b3 = (in >> 24) & 0xFF;
    uint32_t ret = (b0 << 24) | (b1 << 16) | (b2 << 8) | b3;
    return ret;
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
    /* Power off the SD card */
    uint32_t control0 = emmc_get()->CONTROL0;
    control0 &= ~(1 << 8);    // Set SD Bus Power bit off in Power Control Register
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

static int bcm_power_cycle(void){
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

    if(hci_ver >= 2){
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
        return SD_GET_CLOCK_DIVIDER_FAIL;
    }
}

// Switch the clock rate 
static int emmc_switch_clock_rate(uint32_t base_clock, uint32_t target_rate){
    // get divider
    uint32_t div = emmc_get_clock_divider(base_clock, target_rate);
    if(div == SD_GET_CLOCK_DIVIDER_FAIL){
        return -1;
    }
    // wait for cmd and dat inhibit to clear
    while( emmc_get()->STATUS & 0x3){
        time_delay_microseconds(1);
    }
    // Set the emmc clock off
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 &= ~(1 << 2);
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    // Write the new divider
    control1 &= ~0xffe0;        // Clear old
    control1 |= div;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    // Enable the emmc clock
    control1 |= (1 << 2);
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    return 0;
}


// Reset the CMD line
static int emmc_reset_cmd(void){
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SD_RESET_CMD;
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), SD_RESET_CMD, 0, 1000);
    if( (emmc_get()->CONTROL1 & SD_RESET_CMD) != 0){    return -1;}
    return 0;
}

// Reset the CMD line
static int emmc_reset_dat(void){
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SD_RESET_DAT;
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), SD_RESET_DAT, 0, 1000);
    if(( emmc_get()->CONTROL1 & SD_RESET_DAT) != 0)  {return -1;}
    return 0;
}

static void emmc_command_single(         struct emmc_dev *dev,
                                        uint32_t cmd_reg, uint32_t argument, 
                                        uint32_t timeout){
    dev->last_cmd_reg = cmd_reg;
    dev->last_cmd_success = 0;

    while(emmc_get()->STATUS & 0x1)
        time_delay_microseconds(1);

    // Is the command busy?
    if((cmd_reg & SD_CMD_RSPNS_TYPE_MASK) == SD_CMD_RSPNS_TYPE_48B){
        if((cmd_reg & SD_CMD_TYPE_MASK) != SD_CMD_TYPE_ABORT){
            // Wait for the data line to be free
            while( emmc_get()->STATUS & 0x2){
                time_delay_microseconds(1);
            }
        }
    }

    // Set block size and block count
    // For now, block size = 512 bytes, block count = 1,
    //  host SDMA buffer boundary = 4 kiB
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

    // Wait for command complete interrupt
    timeout_wait( &(emmc_get()->INTERRUPT), 0x8001, 1, timeout);
    uint32_t irpts = emmc_get()->INTERRUPT;

    // Clear command complete status
    emmc_get()->INTERRUPT = 0xffff0001;

    // Test for errors
    if((irpts & 0xffff0001) != 0x1)
    {
        dev->last_error = irpts & 0xffff0000;
        dev->last_interrupt = irpts;
        return;
    }

    time_delay_microseconds(2);

    // Get response data
    switch(cmd_reg & SD_CMD_RSPNS_TYPE_MASK){
        case SD_CMD_RSPNS_TYPE_48:
        case SD_CMD_RSPNS_TYPE_48B:
            dev->last_r0 = emmc_get()->RESP0;
            break;

        case SD_CMD_RSPNS_TYPE_136:
            dev->last_r0 = emmc_get()->RESP0;
            dev->last_r1 = emmc_get()->RESP1;
            dev->last_r2 = emmc_get()->RESP2;
            dev->last_r3 = emmc_get()->RESP3;
            break;
    }

    // If with data, wait for the appropriate interrupt
    if(cmd_reg & SD_CMD_ISDATA){
        uint32_t wr_irpt;
        int is_write = 0;
        if(cmd_reg & SD_CMD_DAT_DIR_CH)
            wr_irpt = (1 << 5);     // read
        else
        {
            is_write = 1;
            wr_irpt = (1 << 4);     // write
        }

        int cur_block = 0;
        uint32_t *cur_buf_addr = (uint32_t *)dev->buf;
        while(cur_block < dev->blocks_to_transfer)
        {

            timeout_wait( &(emmc_get()->INTERRUPT), wr_irpt | 0x8000, 1, timeout);
            irpts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = 0xffff0000 | wr_irpt;

            if((irpts & (0xffff0000 | wr_irpt)) != wr_irpt)
            {
                dev->last_error = irpts & 0xffff0000;
                dev->last_interrupt = irpts;
                return;
            }

            // Transfer the block
            size_t cur_byte_no = 0;
            while(cur_byte_no < dev->block_size)
            {
                if(is_write)
				{
					uint32_t data = read_word((uint8_t *)cur_buf_addr, 0);
                    emmc_get()->DATA = data;
				}
                else
				{
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
    if(((cmd_reg & SD_CMD_RSPNS_TYPE_MASK) == SD_CMD_RSPNS_TYPE_48B) ||
       (cmd_reg & SD_CMD_ISDATA)){
        // First check command inhibit (DAT) is not already 0
        if( ((emmc_get()->STATUS) & 0x2) == 0)
            emmc_get()->INTERRUPT = 0xffff0002;
        else
        {
            timeout_wait( &(emmc_get()->INTERRUPT), 0x8002, 1, timeout);
            irpts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = 0xffff0002;

            // Handle the case where both data timeout and transfer complete
            //  are set - transfer complete overrides data timeout: HCSS 2.2.17
            if(((irpts & 0xffff0002) != 0x2) && ((irpts & 0xffff0002) != 0x100002))
            {
                dev->last_error = irpts & 0xffff0000;
                dev->last_interrupt = irpts;
                return;
            }
            emmc_get()->INTERRUPT = 0xffff0002;
        }
    }
    // Return success
    dev->last_cmd_success = 1;
}

static void emmc_handle_card_interrupt(struct emmc_dev *dev){
    // Handle a card interrupt
    if(dev->card_rca)
        emmc_command_single(dev, emmc_commands[SEND_STATUS], dev->card_rca << 16,
                         500);
}

static void emmc_handle_interrupts(struct emmc_dev *dev){
    uint32_t irpts = emmc_get()->INTERRUPT;
    uint32_t reset_mask = 0;

    if(irpts & SD_COMMAND_COMPLETE)
        reset_mask |= SD_COMMAND_COMPLETE;
    if(irpts & SD_TRANSFER_COMPLETE)
        reset_mask |= SD_TRANSFER_COMPLETE;
    if(irpts & SD_BLOCK_GAP_EVENT)
        reset_mask |= SD_BLOCK_GAP_EVENT;
    if(irpts & SD_DMA_INTERRUPT)
        reset_mask |= SD_DMA_INTERRUPT;
    if(irpts & SD_BUFFER_WRITE_READY)
    {
        reset_mask |= SD_BUFFER_WRITE_READY;
        emmc_reset_dat();
    }
    if(irpts & SD_BUFFER_READ_READY)
    {
        reset_mask |= SD_BUFFER_READ_READY;
        emmc_reset_dat();
    }
    if(irpts & SD_CARD_INSERTION)
        reset_mask |= SD_CARD_INSERTION;
    if(irpts & SD_CARD_REMOVAL)
    {
        reset_mask |= SD_CARD_REMOVAL;
        dev->card_removal = 1;
    }
    if(irpts & SD_CARD_INTERRUPT)
    {
        emmc_handle_card_interrupt(dev);
        reset_mask |= SD_CARD_INTERRUPT;
    }
    if(irpts & 0x8000)
        reset_mask |= 0xffff0000;
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
    if(command & IS_APP_CMD){
        command &= 0xff;

        if(emmc_acommands[command] == SD_CMD_RESERVED(0)){
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
        if(emmc_commands[command] == SD_CMD_RESERVED(0)){
            dev->last_cmd_success = 0;
            return -1;
        }

        dev->last_cmd = command;
        emmc_command_single(dev, emmc_commands[command], argument, timeout);
    }
    return 0;
}

static int emmc_card_init(struct block_device **dev){
    // Check the sanity of the sd_commands and emmc_acommands structures
    if(sizeof(emmc_commands) != (64 * sizeof(uint32_t))){
        return -1;
    }
    if(sizeof(emmc_acommands) != (64 * sizeof(uint32_t))){
        return -1;
    }

	// Power cycle the card to ensure its in its startup state
	if(bcm_power_cycle() != 0){
        return -1;
	}

	// Read the controller version
	uint32_t ver =emmc_get()->SLOTISR_VER;
    uint32_t emmcversion = (ver >> 16) & 0xff;
    hci_ver = emmcversion;

	if(hci_ver < 2){
		return -1;
	}

	// Reset the controller
	uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= (1 << 24);
    // Disable clock
    control1 &= ~(1 << 2);
    control1 &= ~(1 << 0);
    emmc_get()->CONTROL1 = control1;
	if (timeout_wait( &(emmc_get()->CONTROL1), 7 << 24, 0, 10) < 0){
		return -1;
	}
    if((emmc_get()->CONTROL1 & (0x7 << 24)) != 0){
        return -1;
    }

	// Check for a valid card
    timeout_wait( &(emmc_get()->STATUS), (1 << 16), 1, 500);
    uint32_t status_reg = emmc_get()->STATUS;
    if((status_reg & (1 << 16)) == 0){
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
    control1 |= 1;            // enable clock

	// Set to identification frequency (400 kHz)
	uint32_t f_id = emmc_get_clock_divider(base_clock, SD_CLOCK_ID);
    if(f_id == SD_GET_CLOCK_DIVIDER_FAIL)
        return -1;
    control1 |= f_id;

	control1 |= (7 << 16);		// data timeout = TMCLK * 2^10
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), 0x2, 1, 0x100);
    if((emmc_get()->CONTROL1 & 0x2) == 0){
        return -1;
    }

	// Enable the SD clock
	time_delay_microseconds(2);
    control1 = emmc_get()->CONTROL1;
    control1 |= 4;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

	// Mask off sending interrupts to the ARM
	emmc_get()->IRPT_EN = 0;
	// Reset interrupts
	emmc_get()->INTERRUPT = 0xffffffff;
	// Have all interrupts sent to the INTERRUPT register
	uint32_t irpt_mask = 0xffffffff & (~SD_CARD_INTERRUPT);
    irpt_mask |= SD_CARD_INTERRUPT;
	emmc_get()->IRPT_MASK = irpt_mask;

	time_delay_microseconds(2);

    // Prepare the device 
	struct emmc_dev *ret;
	if(*dev == NULL){
		ret = (struct emmc_dev *)malloc(sizeof(struct emmc_dev));
	}else{
		ret = (struct emmc_dev *)*dev;
    }

	memset(ret, 0, sizeof(struct emmc_dev));
	ret->bd.block_size = 512;
	ret->bd.dev_read = emmc_read;
    ret->bd.dev_write = emmc_write;
    ret->bd.supports_multiple_block_read = 1;
    ret->bd.supports_multiple_block_write = 1;
	ret->base_clock = base_clock;

	// Send CMD0 to the card (reset to idle state)
	emmc_command(ret, GO_IDLE_STATE, 0, 500);
	if(FAIL(ret))   {return -1;}

	// Send CMD8 to the card
	// Voltage supplied = 0x1 = 2.7-3.6V (standard)
	// Check pattern = 10101010b (as per PLSS 4.3.13) = 0xAA
	emmc_command(ret, SEND_IF_COND, 0x1aa, 500);
	int v2 = 0;
	if(TIMEOUT(ret)){   v2 = 0; }
    else if(CMD_TIMEOUT(ret)){
        if(emmc_reset_cmd() == -1){     return -1; }
        emmc_get()->INTERRUPT = SD_ERR_MASK_CMD_TIMEOUT;
        v2 = 0;
    }
    else if(FAIL(ret)){     return -1; }
    else{
        if((ret->last_r0 & 0xfff) != 0x1aa){
            uart_puts("EMMC: not usable card\n");
            return -1;
        }else{
            v2 = 1;
        }
    }

    // Here we are supposed to check the response to CMD5 (HCSS 3.6)
    // It only returns if the card is a SDIO card
    emmc_command(ret, IO_SET_OP_COND, 0, 10);
    if(!TIMEOUT(ret)){
        if(CMD_TIMEOUT(ret)){
            if(emmc_reset_cmd() == -1){ return -1;}
            emmc_get()->INTERRUPT = SD_ERR_MASK_CMD_TIMEOUT;
        }else{
            return -1;
        }
    }

    // Call an inquiry ACMD41 (voltage window = 0) to get the OCR
    emmc_command(ret, ACMD(41), 0, 500);
    if(FAIL(ret)){   return -1;}

	// Call initialization ACMD41
	int card_is_busy = 1;
	while(card_is_busy){
	    uint32_t v2_flags = 0;
	    if(v2){
	        // Set SDHC support
	        v2_flags |= (1 << 30);

	        // Set 1.8v support
	        if(!ret->failed_voltage_switch){
                v2_flags |= (1 << 24);
            }

            // Enable SDXC maximum performance
            v2_flags |= (1 << 28);
	    }

	    emmc_command(ret, ACMD(41), 0x00ff8000 | v2_flags, 500);
	    if(FAIL(ret)){
	        uart_puts("SD: error issuing ACMD41\n");
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

    emmc_switch_clock_rate(base_clock, SD_CLOCK_NORMAL);

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
	        return emmc_card_init((struct block_device **)&ret);
	    }

	    // Disable SD clock
	    control1 = emmc_get()->CONTROL1;
        control1 &= ~(1 << 2);
        emmc_get()->CONTROL1 = control1;

	    // Check DAT[3:0]
	    status_reg = emmc_get()->STATUS;
        uint32_t dat30 = (status_reg >> 20) & 0xf;
	    if(dat30 != 0){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
			uart_puts("EMMC: dat30 error\r\n");
	        return emmc_card_init((struct block_device **)&ret);
	    }

	    // Set 1.8V signal enable to 1
	    uint32_t control0 = emmc_get()->CONTROL0;
        control0 |= (1 << 8);
        emmc_get()->CONTROL0 = control0;
	    // Wait 5 ms
	    time_delay_microseconds(5);

	    // Check the 1.8V signal enable is set
	    control0 = emmc_get()->CONTROL0;
	    if(((control0 >> 8) & 0x1) == 0){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
	        return emmc_card_init((struct block_device **)&ret);
	    }

	    // Re-enable the SD clock
	    control1 = emmc_get()->CONTROL1;
        control1 |= (1 << 2);
        emmc_get()->CONTROL1 = control1;

	    // Wait 1 ms
	    time_delay_microseconds(1);

	    // Check DAT[3:0]
	    status_reg = emmc_get()->STATUS;
        dat30 = (status_reg >> 20) & 0xf;
        if(dat30 != 0xf){
	        ret->failed_voltage_switch = 1;
			emmc_power_off();
	        return emmc_card_init((struct block_device **)&ret);
	    }
	}

	// Send CMD2 to get the cards CID
	emmc_command(ret, ALL_SEND_CID, 0, 500);
	if(FAIL(ret)){
	    uart_puts("SD: error sending ALL_SEND_CID\n");
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
	ret->bd.device_id = (uint8_t *)dev_id;
	ret->bd.dev_id_len = 4 * sizeof(uint32_t);

	// Send CMD3 to enter the data state
	emmc_command(ret, SEND_RELATIVE_ADDR, 0, 500000);
	if(FAIL(ret)){
        free(ret);
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
		free(dev_id);
		return -1;
	}

	if(illegal_cmd){
		free(ret);
		free(dev_id);
		return -1;
	}

	if(error){
		free(ret);
		free(dev_id);
		return -1;
	}

	if(!ready){
		free(ret);
		free(dev_id);
		return -1;
	}


	// Now select the card (toggles it to transfer state)
	emmc_command(ret, SELECT_CARD, ret->card_rca << 16, 500);
	if(FAIL(ret)){
	    free(ret);
	    return -1;
	}

	uint32_t cmd7_resp = ret->last_r0;
	status = (cmd7_resp >> 9) & 0xf;

	if((status != 3) && (status != 4)){
		free(ret);
		free(dev_id);
		return -1;
	}

	// If not an SDHC card, ensure BLOCKLEN is 512 bytes
	if(!ret->card_supports_sdhc){
	    emmc_command(ret, SET_BLOCKLEN, 512, 500);
	    if(FAIL(ret)){
	        uart_puts("SD: error sending SET_BLOCKLEN\n\r");
	        free(ret);
	        return -1;
	    }
	}
	ret->block_size = 512;
	uint32_t controller_block_size = emmc_get()->BLKSIZECNT;
    controller_block_size &= (~0xfff);
    controller_block_size |= 0x200;
    emmc_get()->BLKSIZECNT = controller_block_size;

	// Get the cards SCR register
	ret->scr = (struct emmc_scr *)malloc(sizeof(struct emmc_scr));
	ret->buf = &ret->scr->scr[0];
	ret->block_size = 8;
	ret->blocks_to_transfer = 1;
	emmc_command(ret, SEND_SCR, 0, 500);
	ret->block_size = 512;
	if(FAIL(ret)){
	    uart_puts("SD: error sending SEND_SCR\n\r");
	    free(ret->scr);
        free(ret);
	    return -1;
	}

	// Determine card version
	// Note that the SCR is big-endian
	uint32_t scr0 = byte_swap(ret->scr->scr[0]);
	ret->scr->sd_version = SD_VER_UNKNOWN;
	uint32_t emmc_spec = (scr0 >> (56 - 32)) & 0xf;
	uint32_t emmc_spec3 = (scr0 >> (47 - 32)) & 0x1;
	uint32_t emmc_spec4 = (scr0 >> (42 - 32)) & 0x1;
	ret->scr->sd_bus_widths = (scr0 >> (48 - 32)) & 0xf;
	if(emmc_spec == 0)      { ret->scr->sd_version = SD_VER_1; }
    else if(emmc_spec == 1) { ret->scr->sd_version = SD_VER_1_1; }
    else if(emmc_spec == 2) {
        if(emmc_spec3 == 0) {ret->scr->sd_version = SD_VER_2; }
        else if(emmc_spec3 == 1){
            if(emmc_spec4 == 0){
                ret->scr->sd_version = SD_VER_3;
            }else if(emmc_spec4 == 1){
                ret->scr->sd_version = SD_VER_4;
            }
        }
    }

    if(ret->scr->sd_bus_widths & 0x4){
        // Set 4-bit transfer mode (ACMD6)
        // See HCSS 3.4 for the algorithm

        // Disable card interrupt in host
        uint32_t old_irpt_mask = emmc_get()->IRPT_MASK;
        uint32_t new_iprt_mask = old_irpt_mask & ~(1 << 8);
        emmc_get()->IRPT_MASK = new_iprt_mask;

        // Send ACMD6 to change the card's bit mode
        emmc_command(ret, SET_BUS_WIDTH, 0x2, 500);
        if(FAIL(ret)){
            uart_puts("EMMC init: switch to 4-bit data mode failed\n\r");
        }else{
            // Change bit mode for Host
            uint32_t control0 = emmc_get()->CONTROL0;
            control0 |= 0x2;
            emmc_get()->CONTROL0 = control0;

            // Re-enable card interrupt in host
            emmc_get()->IRPT_MASK = old_irpt_mask;
        }
    }

	// Reset interrupt register
	emmc_get()->INTERRUPT = 0xffffffff;

	*dev = (struct block_device *)ret;
    uart_puts("card init successfull\r\n");
	return 0;
}

static int emmc_ensure_data_mode(struct emmc_dev *edev){
	if(edev->card_rca == 0){
		// Try again to initialise the card
		int ret = emmc_card_init((struct block_device **)&edev);
		if(ret != 0){   return ret;}
	}

    emmc_command(edev, SEND_STATUS, edev->card_rca << 16, 500);
    if(FAIL(edev)){
        uart_puts("SD: ensure_data_mode() error sending CMD13\n");
        edev->card_rca = 0;
        return -1;
    }

	uint32_t status = edev->last_r0;
	uint32_t cur_state = (status >> 9) & 0xf;
	if(cur_state == 3){
		// Currently in the stand-by state - select it
		emmc_command(edev, SELECT_CARD, edev->card_rca << 16, 500);
		if(FAIL(edev)){
			uart_puts("SD: ensure_data_mode() no response from CMD17\n");
			edev->card_rca = 0;
			return -1;
		}
	}else if(cur_state == 5){
		// In the data transfer state - cancel the transmission
		emmc_command(edev, STOP_TRANSMISSION, 0, 500);
		if(FAIL(edev)){
			edev->card_rca = 0;
			return -1;
		}

		// Reset the data circuit
		emmc_reset_dat();
		
	}else if(cur_state != 4){
		// Not in the transfer state - re-initialise
		int ret = emmc_card_init((struct block_device **)&edev);
		if(ret != 0){   return ret; }
	}

	// Check again that we're now in the correct mode
	if(cur_state != 4){
        emmc_command(edev, SEND_STATUS, edev->card_rca << 16, 500000);
        if(FAIL(edev)){
			edev->card_rca = 0;
			return -1;
		}
		status = edev->last_r0;
		cur_state = (status >> 9) & 0xf;

		if(cur_state != 4){
			edev->card_rca = 0;
			return -1;
		}
	}

	return 0;
}

static int emmc_do_data_command(        struct emmc_dev *edev,
                                        int is_write, uint8_t *buf,
                                        size_t buf_size,
                                        uint32_t block_no){
	// PLSS table 4.20 - SDSC cards use byte addresses rather than block addresses
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


static struct block_device *device = NULL;

int emmc_init(void){
    if( emmc_card_init(&device) == -1){
        uart_puts("EMMC Driver initialization failed\r\n");
        return -1;
    }
    uart_puts("EMMC Driver initialization succesful\r\n");
    return 0;
}

int emmc_read(uint8_t *buf, size_t buf_size, uint32_t block_no)
{
	// Check the status of the card
	struct emmc_dev *edev = (struct emmc_dev *)device;
    if(emmc_ensure_data_mode(edev) != 0)
        return -1;

    if(emmc_do_data_command(edev, 0, buf, buf_size, block_no) < 0)
        return -1;

	return buf_size;
}

int emmc_write(uint8_t *buf, size_t buf_size, uint32_t block_no)
{
	// Check the status of the card
	struct emmc_dev *edev = (struct emmc_dev *)device;
    if(emmc_ensure_data_mode(edev) != 0)
        return -1;
    if(emmc_do_data_command(edev, 1, buf, buf_size, block_no) < 0)
        return -1;
	return buf_size;
}

size_t emmc_get_dev_block_size(void){ 
    return device->block_size;
}

int emmc_get_multiblock_read_support(void){
    return device->supports_multiple_block_read;
}
