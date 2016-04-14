
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "mmu.h"
#include "mailbox.h"
#include "base.h"
#include "time.h"
#include "uart.h"
#include "emmc.h"

#define EMMC_CONTROLLER_BASE        (PERIPHERAL_BASE + 0x300000)

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

typedef struct emmc_scr{
    uint32_t scr[2];
    uint32_t emmc_bus_widths;
    int emmc_version;
}emmc_scr_t;



struct emmc_dev
{
    size_t dev_id_len;
    uint32_t card_supports_emmchc;
    uint32_t card_supports_18v;
    uint32_t card_ocr;
    uint32_t card_rca;
    uint32_t last_interrupt;
    uint32_t last_error;

    struct emmc_scr *scr;
    
    size_t dev_num_blocks;
    size_t dev_block_size;

    int failed_voltage_switch;

    uint32_t last_cmd_reg;
    uint32_t last_cmd;
    uint32_t last_cmd_success;
    uint32_t last_r0;
    uint32_t last_r1;
    uint32_t last_r2;
    uint32_t last_r3;

	int supports_multiple_block_read;
	int supports_multiple_block_write;

    void *buf;
    int blocks_to_transfer;
    size_t block_size;
    int use_emmcma;
    int card_removal;
    uint32_t base_clock;
};




# define EMMC_BASE        0x20300000
# define EMMC_ARG2        0
# define EMMC_BLKSIZECNT        4
# define EMMC_ARG1        8
# define EMMC_CMDTM        0xC
# define EMMC_RESP0        0x10
# define EMMC_RESP1        0x14
# define EMMC_RESP2        0x18
# define EMMC_RESP3        0x1C
# define EMMC_DATA        0x20
# define EMMC_STATUS        0x24
# define EMMC_CONTROL0        0x28
# define EMMC_CONTROL1        0x2C
# define EMMC_INTERRUPT        0x30
# define EMMC_IRPT_MASK        0x34
# define EMMC_IRPT_EN        0x38
# define EMMC_CONTROL2        0x3C
# define EMMC_CAPABILITIES_0    0x40
# define EMMC_CAPABILITIES_1    0x44
# define EMMC_FORCE_IRPT        0x50
# define EMMC_BOOT_TIMEOUT    0x70
# define EMMC_DBG_SEL        0x74
# define EMMC_EXRDFIFO_CFG    0x80
# define EMMC_EXRDFIFO_EN    0x84
# define EMMC_TUNE_STEP        0x88
# define EMMC_TUNE_STEPS_STD    0x8C
# define EMMC_TUNE_STEPS_DDR    0x90
# define EMMC_SPI_INT_SPT    0xF0
# define EMMC_SLOTISR_VER    0xFC

# define SD_CMD_INDEX(a)        ((a) << 24)
# define SD_CMD_TYPE_NORMAL    0x0
# define SD_CMD_TYPE_SUSPEND    (1 << 22)
# define SD_CMD_TYPE_RESUME    (2 << 22)
# define SD_CMD_TYPE_ABORT    (3 << 22)
# define SD_CMD_TYPE_MASK    (3 << 22)
# define SD_CMD_ISDATA        (1 << 21)
# define SD_CMD_IXCHK_EN        (1 << 20)
# define SD_CMD_CRCCHK_EN    (1 << 19)
# define SD_CMD_RSPNS_TYPE_NONE    0            // For no response
# define SD_CMD_RSPNS_TYPE_136    (1 << 16)        // For response R2 (with CRC), R3,4 (no CRC)
# define SD_CMD_RSPNS_TYPE_48    (2 << 16)        // For responses R1, R5, R6, R7 (with CRC)
# define SD_CMD_RSPNS_TYPE_48B    (3 << 16)        // For responses R1b, R5b (with CRC)
# define SD_CMD_RSPNS_TYPE_MASK  (3 << 16)
# define SD_CMD_MULTI_BLOCK    (1 << 5)
# define SD_CMD_DAT_DIR_HC    0
# define SD_CMD_DAT_DIR_CH    (1 << 4)
# define SD_CMD_AUTO_CMD_EN_NONE    0
# define SD_CMD_AUTO_CMD_EN_CMD12    (1 << 2)
# define SD_CMD_AUTO_CMD_EN_CMD23    (2 << 2)
# define SD_CMD_BLKCNT_EN        (1 << 1)
# define SD_CMD_DMA          1

# define SD_ERR_CMD_TIMEOUT    0
# define SD_ERR_CMD_CRC        1
# define SD_ERR_CMD_END_BIT    2
# define SD_ERR_CMD_INDEX    3
# define SD_ERR_DATA_TIMEOUT    4
# define SD_ERR_DATA_CRC        5
# define SD_ERR_DATA_END_BIT    6
# define SD_ERR_CURRENT_LIMIT    7
# define SD_ERR_AUTO_CMD12    8
# define SD_ERR_ADMA        9
# define SD_ERR_TUNING        10
# define SD_ERR_RSVD        11

# define SD_ERR_MASK_CMD_TIMEOUT        (1 << (16 + SD_ERR_CMD_TIMEOUT))
# define SD_ERR_MASK_CMD_CRC        (1 << (16 + SD_ERR_CMD_CRC))
# define SD_ERR_MASK_CMD_END_BIT        (1 << (16 + SD_ERR_CMD_END_BIT))
# define SD_ERR_MASK_CMD_INDEX        (1 << (16 + SD_ERR_CMD_INDEX))
# define SD_ERR_MASK_DATA_TIMEOUT    (1 << (16 + SD_ERR_CMD_TIMEOUT))
# define SD_ERR_MASK_DATA_CRC        (1 << (16 + SD_ERR_CMD_CRC))
# define SD_ERR_MASK_DATA_END_BIT    (1 << (16 + SD_ERR_CMD_END_BIT))
# define SD_ERR_MASK_CURRENT_LIMIT    (1 << (16 + SD_ERR_CMD_CURRENT_LIMIT))
# define SD_ERR_MASK_AUTO_CMD12        (1 << (16 + SD_ERR_CMD_AUTO_CMD12))
# define SD_ERR_MASK_ADMA        (1 << (16 + SD_ERR_CMD_ADMA))
# define SD_ERR_MASK_TUNING        (1 << (16 + SD_ERR_CMD_TUNING))

# define SD_COMMAND_COMPLETE     1
# define SD_TRANSFER_COMPLETE    (1 << 1)
# define SD_BLOCK_GAP_EVENT      (1 << 2)
# define SD_DMA_INTERRUPT        (1 << 3)
# define SD_BUFFER_WRITE_READY   (1 << 4)
# define SD_BUFFER_READ_READY    (1 << 5)
# define SD_CARD_INSERTION       (1 << 6)
# define SD_CARD_REMOVAL         (1 << 7)
# define SD_CARD_INTERRUPT       (1 << 8)

# define SD_RESP_NONE        SD_CMD_RSPNS_TYPE_NONE
# define SD_RESP_R1          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)
# define SD_RESP_R1b         (SD_CMD_RSPNS_TYPE_48B | SD_CMD_CRCCHK_EN)
# define SD_RESP_R2          (SD_CMD_RSPNS_TYPE_136 | SD_CMD_CRCCHK_EN)
# define SD_RESP_R3          SD_CMD_RSPNS_TYPE_48
# define SD_RESP_R4          SD_CMD_RSPNS_TYPE_136
# define SD_RESP_R5          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)
# define SD_RESP_R5b         (SD_CMD_RSPNS_TYPE_48B | SD_CMD_CRCCHK_EN)
# define SD_RESP_R6          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)
# define SD_RESP_R7          (SD_CMD_RSPNS_TYPE_48 | SD_CMD_CRCCHK_EN)

# define SD_DATA_READ        (SD_CMD_ISDATA | SD_CMD_DAT_DIR_CH)
# define SD_DATA_WRITE       (SD_CMD_ISDATA | SD_CMD_DAT_DIR_HC)

# define SD_CMD_RESERVED(a)  0xffffffff

# define SUCCESS(a)          (a->last_cmd_success)
# define FAIL(a)             (a->last_cmd_success == 0)
# define TIMEOUT(a)          (FAIL(a) && (a->last_error == 0))
# define CMD_TIMEOUT(a)      (FAIL(a) && (a->last_error & (1 << 16)))
# define CMD_CRC(a)          (FAIL(a) && (a->last_error & (1 << 17)))
# define CMD_END_BIT(a)      (FAIL(a) && (a->last_error & (1 << 18)))
# define CMD_INDEX(a)        (FAIL(a) && (a->last_error & (1 << 19)))
# define DATA_TIMEOUT(a)     (FAIL(a) && (a->last_error & (1 << 20)))
# define DATA_CRC(a)         (FAIL(a) && (a->last_error & (1 << 21)))
# define DATA_END_BIT(a)     (FAIL(a) && (a->last_error & (1 << 22)))
# define CURRENT_LIMIT(a)    (FAIL(a) && (a->last_error & (1 << 23)))
# define ACMD12_ERROR(a)     (FAIL(a) && (a->last_error & (1 << 24)))
# define ADMA_ERROR(a)       (FAIL(a) && (a->last_error & (1 << 25)))
# define TUNING_ERROR(a)     (FAIL(a) && (a->last_error & (1 << 26)))

# define SD_VER_UNKNOWN      0
# define SD_VER_1            1
# define SD_VER_1_1          2
# define SD_VER_2            3
# define SD_VER_3            4
# define SD_VER_4            5

// The actual command indices
# define GO_IDLE_STATE           0
# define ALL_SEND_CID            2
# define SEND_RELATIVE_ADDR      3
# define SET_DSR                 4
# define IO_SET_OP_COND          5
# define SWITCH_FUNC             6
# define SELECT_CARD             7
# define DESELECT_CARD           7
# define SELECT_DESELECT_CARD    7
# define SEND_IF_COND            8
# define SEND_CSD                9
# define SEND_CID                10
# define VOLTAGE_SWITCH          11
# define STOP_TRANSMISSION       12
# define SEND_STATUS             13
# define GO_INACTIVE_STATE       15
# define SET_BLOCKLEN            16
# define READ_SINGLE_BLOCK       17
# define READ_MULTIPLE_BLOCK     18
# define SEND_TUNING_BLOCK       19
# define SPEED_CLASS_CONTROL     20
# define SET_BLOCK_COUNT         23
# define WRITE_BLOCK             24
# define WRITE_MULTIPLE_BLOCK    25
# define PROGRAM_CSD             27
# define SET_WRITE_PROT          28
# define CLR_WRITE_PROT          29
# define SEND_WRITE_PROT         30
# define ERASE_WR_BLK_START      32
# define ERASE_WR_BLK_END        33
# define ERASE                   38
# define LOCK_UNLOCK             42
# define APP_CMD                 55
# define GEN_CMD                 56

# define IS_APP_CMD              0x80000000
# define ACMD(a)                 (a | IS_APP_CMD)
# define SET_BUS_WIDTH           (6 | IS_APP_CMD)
# define SD_STATUS               (13 | IS_APP_CMD)
# define SEND_NUM_WR_BLOCKS      (22 | IS_APP_CMD)
# define SET_WR_BLK_ERASE_COUNT  (23 | IS_APP_CMD)
# define SD_SEND_OP_COND         (41 | IS_APP_CMD)
# define SET_CLR_CARD_DETECT     (42 | IS_APP_CMD)
# define SEND_SCR                (51 | IS_APP_CMD)

# define SD_RESET_CMD            (1 << 25)
# define SD_RESET_DAT            (1 << 26)
# define SD_RESET_ALL            (1 << 24)

# define SD_GET_CLOCK_DIVIDER_FAIL    0xffffffff


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

static void emmc_power_off(){
    /* Power off the SD card */
    uint32_t control0 = emmc_get()->CONTROL0;
    control0 &= ~(1 << 8);    // Set SD Bus Power bit off in Power Control Register
    emmc_get()->CONTROL0, control0;
}

static uint32_t emmc_get_base_clock_hz(void){
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

#if SDHCI_IMPLEMENTATION == SDHCI_IMPLEMENTATION_BCM_2708
static int bcm_2708_power_off()
{
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
        uart_puts("error: emmc power off: request not successfull:\r\n");
        return -1;
    }
    if(mailbuffer[5] != MAILBOX_SD_CARD) {
        uart_puts("error: emmc power off: Wrong device ID returned!\r\n");
        return -1;
    }
    if(mailbuffer[6] & (1 << 0)){
        uart_puts("error: emmc power off: power still on!   ");
        uart_put_uint32_t(mailbuffer[6], 16);
        uart_puts("\r\n");
        return -1;
    }
    if(mailbuffer[6] & (1 << 1)){
        uart_puts("error: emmc power off: device does not exist!\r\n");
        return -1;
    } return 0;
}

static int bcm_2708_power_on()
{
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
        uart_puts("error: emmc power on: request not successfull:\r\n");
        return -1;
    }
    if(mailbuffer[5] != MAILBOX_SD_CARD) {
        uart_puts("error: emmc power on: Wrong device ID returned!\r\n");
        return -1;
    }
    if(mailbuffer[6] & (1 << 1)){
        uart_puts("error: emmc power on: device does not exist!\r\n");
        return -1;
    }
    if(!(mailbuffer[6] & (1 << 0))){
        uart_puts("error: emmc power on: device still off!\r\n");
        return -1;
    }
    return 0;
}

static int bcm_2708_power_cycle()
{
    if(bcm_2708_power_off() < 0)
        return -1;

    time_delay_microseconds(5);

    return bcm_2708_power_on();
}
#endif

// Set the clock dividers to generate a target value
static uint32_t emmc_get_clock_divider(uint32_t base_clock, uint32_t target_rate)
{
    uint32_t targetted_divisor = 0;
    if(target_rate > base_clock)
        targetted_divisor = 1;
    else
    {
        targetted_divisor = base_clock / target_rate;
        uint32_t mod = base_clock % target_rate;
        if(mod)
            targetted_divisor--;
    }

    // Decide on the clock mode to use

    // Currently only 10-bit divided clock mode is supported

    if(hci_ver >= 2)
    {
        // HCI version 3 or greater supports 10-bit divided clock mode
        // This requires a power-of-two divider

        // Find the first bit set
        int divisor = -1;
        int first_bit;
        for(first_bit = 31; first_bit >= 0; first_bit--)
        {
            uint32_t bit_test = (1 << first_bit);
            if(targetted_divisor & bit_test)
            {
                divisor = first_bit;
                targetted_divisor &= ~bit_test;
                if(targetted_divisor)
                    divisor++;
                break;
            }
        }

        if(divisor == -1)
            divisor = 31;
        if(divisor >= 32)
            divisor = 31;

        if(divisor != 0)
            divisor = (1 << (divisor - 1));

        if(divisor >= 0x400)
            divisor = 0x3ff;

        uint32_t freq_select = divisor & 0xff;
        uint32_t upper_bits = (divisor >> 8) & 0x3;
        uint32_t ret = (freq_select << 8) | (upper_bits << 6) | (0 << 5);

        return ret;
    }
    else
        return SD_GET_CLOCK_DIVIDER_FAIL;
}

// Switch the clock rate whilst running
static int emmc_switch_clock_rate(uint32_t base_clock, uint32_t target_rate)
{
    // Decide on an appropriate divider
    uint32_t divider = emmc_get_clock_divider(base_clock, target_rate);
    if(divider == SD_GET_CLOCK_DIVIDER_FAIL)
        return -1;

    // Wait for the command inhibit (CMD and DAT) bits to clear
    while( emmc_get()->STATUS & 0x3)
        time_delay_microseconds(1);

    // Set the SD clock off
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 &= ~(1 << 2);
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    // Write the new divider
    control1 &= ~0xffe0;        // Clear old setting + clock generator select
    control1 |= divider;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    // Enable the SD clock
    control1 |= (1 << 2);
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);

    return 0;
}


// Reset the CMD line
static int emmc_reset_cmd()
{
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SD_RESET_CMD;
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), SD_RESET_CMD, 0, 1000);
    if( (emmc_get()->CONTROL1 & SD_RESET_CMD) != 0)
        return -1;
    return 0;
}

// Reset the CMD line
static int emmc_reset_dat()
{
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SD_RESET_DAT;
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), SD_RESET_DAT, 0, 1000);
    if(( emmc_get()->CONTROL1 & SD_RESET_DAT) != 0)
        return -1;
    return 0;
}

static uint32_t byte_swap(unsigned int in)
{
    uint32_t b0 = in & 0xFF;
    uint32_t b1 = (in >> 8) & 0xFF;
    uint32_t b2 = (in >> 16) & 0xFF;
    uint32_t b3 = (in >> 24) & 0xFF;
    uint32_t ret = (b0 << 24) | (b1 << 16) | (b2 << 8) | b3;
    return ret;
}

static void write_word(uint32_t val, uint8_t* buf, int offset)
{
    buf[offset + 0] = val & 0xff;
    buf[offset + 1] = (val >> 8) & 0xff;
    buf[offset + 2] = (val >> 16) & 0xff;
    buf[offset + 3] = (val >> 24) & 0xff;
}

static uint32_t read_word(uint8_t* buf, int offset)
{
    uint32_t b0 = buf[offset + 0] & 0xff;
    uint32_t b1 = buf[offset + 1] & 0xff;
    uint32_t b2 = buf[offset + 2] & 0xff;
    uint32_t b3 = buf[offset + 3] & 0xff;
    return b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
}

static void emmc_issue_command_int(struct emmc_dev *dev, uint32_t cmd_reg, uint32_t argument, uint64_t timeout)
{
    dev->last_cmd_reg = cmd_reg;
    dev->last_cmd_success = 0;

    // This is as per HCSS 3.7.1.1/3.7.2.2

    // Check Command Inhibit
    while(emmc_get()->STATUS & 0x1)
        time_delay_microseconds(1);

    // Is the command with busy?
    if((cmd_reg & SD_CMD_RSPNS_TYPE_MASK) == SD_CMD_RSPNS_TYPE_48B)
    {
        // With busy

        // Is is an abort command?
        if((cmd_reg & SD_CMD_TYPE_MASK) != SD_CMD_TYPE_ABORT)
        {
            // Not an abort command

            // Wait for the data line to be free
            while(emmc_get()->STATUS & 0x2)
                time_delay_microseconds(1);
        }
    }

    // Is this a DMA transfer?
    int is_emmcma = 0;
    if((cmd_reg & SD_CMD_ISDATA) && (dev->use_emmcma))
        is_emmcma = 1;

    if(is_emmcma)
    {
        // Set system address register (ARGUMENT2 in RPi)

        // We need to define a 4 kiB aligned buffer to use here
        // Then convert its virtual address to a bus address
        emmc_get()->ARG2 = SDMA_BUFFER_PA;
    }

    // Set block size and block count
    // For now, block size = 512 bytes, block count = 1,
    //  host SDMA buffer boundary = 4 kiB
    if(dev->blocks_to_transfer > 0xffff)
    {
        dev->last_cmd_success = 0;
        return;
    }
    uint32_t blksizecnt = dev->block_size | (dev->blocks_to_transfer << 16);
    emmc_get()->BLKSIZECNT = blksizecnt;

    // Set argument 1 reg
    emmc_get()->ARG1 = argument;

    if(is_emmcma)
    {
        // Set Transfer mode register
        cmd_reg |= SD_CMD_DMA;
    }

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
    switch(cmd_reg & SD_CMD_RSPNS_TYPE_MASK)
    {
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
    if((cmd_reg & SD_CMD_ISDATA) && (is_emmcma == 0))
    {
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
    if((((cmd_reg & SD_CMD_RSPNS_TYPE_MASK) == SD_CMD_RSPNS_TYPE_48B) ||
       (cmd_reg & SD_CMD_ISDATA)) && (is_emmcma == 0))
    {
        // First check command inhibit (DAT) is not already 0
        if((emmc_get()->STATUS & 0x2) == 0)
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
    else if (is_emmcma)
    {
        // For SDMA transfers, we have to wait for either transfer complete,
        //  DMA int or an error

        // First check command inhibit (DAT) is not already 0
        if((emmc_get()->STATUS & 0x2) == 0)
            emmc_get()->INTERRUPT = 0xffff000a;
        else
        {
            timeout_wait( (&emmc_get()->INTERRUPT), 0x800a, 1, timeout);
            irpts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = 0xffff000a;

            // Detect errors
            if((irpts & 0x8000) && ((irpts & 0x2) != 0x2))
            {
                dev->last_error = irpts & 0xffff0000;
                dev->last_interrupt = irpts;
                return;
            }

            // Detect DMA interrupt without transfer complete
            // Currently not supported - all block sizes should fit in the
            // buffer
            if((irpts & 0x8) && ((irpts & 0x2) != 0x2))
            {
                dev->last_error = irpts & 0xffff0000;
                dev->last_interrupt = irpts;
                return;
            }

            // Detect transfer complete
            if(irpts & 0x2)
                memcpy(dev->buf, (const void *)SDMA_BUFFER, dev->block_size);
            else
            {
                if((irpts == 0) && ((emmc_get()->STATUS & 0x3) == 0x2))
                    emmc_get()->CMDTM = emmc_commands[STOP_TRANSMISSION];
                dev->last_error = irpts & 0xffff0000;
                dev->last_interrupt = irpts;
                return;
            }
        }
    }

    // Return success
    dev->last_cmd_success = 1;
}

static void emmc_handle_card_interrupt(struct emmc_dev *dev)
{
    // Handle a card interrupt
    if(dev->card_rca)
        emmc_issue_command_int(dev, emmc_commands[SEND_STATUS], dev->card_rca << 16,
                         500000);
}

static void emmc_handle_interrupts(struct emmc_dev *dev)
{
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

static int emmc_issue_command(struct emmc_dev *dev, uint32_t command, uint32_t argument, uint64_t timeout)
{
    // First, handle any pending interrupts
    emmc_handle_interrupts(dev);

    // Stop the command issue if it was the card remove interrupt that was
    //  handled
    if(dev->card_removal)
    {
        dev->last_cmd_success = 0;
        return -1;
    }

    // Now run the appropriate commands by calling emmc_issue_command_int()
    if(command & IS_APP_CMD)
    {
        command &= 0xff;
        if(emmc_acommands[command] == SD_CMD_RESERVED(0))
        {
            dev->last_cmd_success = 0;
            return -1;
        }
        dev->last_cmd = APP_CMD;

        uint32_t rca = 0;
        if(dev->card_rca)
            rca = dev->card_rca << 16;
        emmc_issue_command_int(dev, emmc_commands[APP_CMD], rca, timeout);
        if(dev->last_cmd_success)
        {
            dev->last_cmd = command | IS_APP_CMD;
            emmc_issue_command_int(dev, emmc_acommands[command], argument, timeout);
        }
    }
    else
    {
        if(emmc_commands[command] == SD_CMD_RESERVED(0))
        {
            dev->last_cmd_success = 0;
            return -1;
        }

        dev->last_cmd = command;
        emmc_issue_command_int(dev, emmc_commands[command], argument, timeout);
    }

    return 0;
}

static int emmc_card_init(struct emmc_dev *dev)
{
    // Check the sanity of the emmc_commands and emmc_acommands structures
    if(sizeof(emmc_commands) != (64 * sizeof(uint32_t)))
        return -1;
    if(sizeof(emmc_acommands) != (64 * sizeof(uint32_t)))
        return -1;
    // Power cycle the card to ensure its in its startup state
    if(bcm_2708_power_cycle() != 0)
        return -1;

    // Read the controller version
    uint32_t ver =emmc_get()->SLOTISR_VER;
    uint32_t emmcversion = (ver >> 16) & 0xff;
    hci_ver = emmcversion;

    if(hci_ver < 2)
        return -1;

    // Reset the controller
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= (1 << 24);
    // Disable clock
    control1 &= ~(1 << 2);
    control1 &= ~(1 << 0);
    emmc_get()->CONTROL1 = control1;
    if (timeout_wait( &(emmc_get()->CONTROL1), 7 << 24, 0, 1000) < 0){
		return -1;
	}
    if((emmc_get()->CONTROL1 & (0x7 << 24)) != 0)
        return -1;

    // Read the capabilities registers
  //  capabilities_0 = read_mmio(EMMC_BASE + EMMC_CAPABILITIES_0);
    //capabilities_1 = read_mmio(EMMC_BASE + EMMC_CAPABILITIES_1);

    // Check for a valid card
    timeout_wait( &(emmc_get()->STATUS), (1 << 16), 1, 500);
    uint32_t status_reg = emmc_get()->STATUS;
    if((status_reg & (1 << 16)) == 0)
        return -1;

    // Clear control2
    emmc_get()->CONTROL2 = 0;

    // Get the base clock rate
    uint32_t base_clock = emmc_get_base_clock_hz();
    if(base_clock == 0)
        base_clock = 100000000;

    // Set clock rate to something slow
    control1 = emmc_get()->CONTROL1;
    control1 |= 1;            // enable clock

    // Set to identification frequency (400 kHz)
    uint32_t f_id = emmc_get_clock_divider(base_clock, SD_CLOCK_ID);
    if(f_id == SD_GET_CLOCK_DIVIDER_FAIL)
        return -1;
    control1 |= f_id;

    control1 |= (7 << 16);        // data timeout = TMCLK * 2^10
    emmc_get()->CONTROL1 = control1;
    timeout_wait( &(emmc_get()->CONTROL1), 0x2, 1, 0x100);
    if((emmc_get()->CONTROL1 & 0x2) == 0)
        return -1;

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
#ifdef SD_CARD_INTERRUPTS
    irpt_mask |= SD_CARD_INTERRUPT;
#endif
    emmc_get()->IRPT_MASK = irpt_mask;

    time_delay_microseconds(2);

    // Prepare the device structure
    struct emmc_dev *ret;
    if(dev == NULL)
        ret = (struct emmc_dev *)malloc(sizeof(struct emmc_dev));
    else
        ret = dev;
    if (!ret)
        return -1;

    memset(ret, 0, sizeof(struct emmc_dev));
   // ret->bd.driver_name = driver_name;
   // ret->bd.device_name = device_name;
    ret->dev_block_size = 512;
 //   ret->bd.read = emmc_read;
#ifdef SD_WRITE_SUPPORT
 //   ret->bd.write = emmc_write;
#endif
    ret->supports_multiple_block_read = 1;
    ret->supports_multiple_block_write = 1;
    ret->base_clock = base_clock;

    // Send CMD0 to the card (reset to idle state)
    emmc_issue_command(ret, GO_IDLE_STATE, 0, 500);
    if(FAIL(ret))
        return -1;

    // Send CMD8 to the card
    // Voltage supplied = 0x1 = 2.7-3.6V (standard)
    // Check pattern = 10101010b (as per PLSS 4.3.13) = 0xAA
    emmc_issue_command(ret, SEND_IF_COND, 0x1aa, 500);
    int v2_later = 0;
    if(TIMEOUT(ret))
        v2_later = 0;
    else if(CMD_TIMEOUT(ret))
    {
        if(emmc_reset_cmd() == -1)
            return -1;
        emmc_get()->INTERRUPT = SD_ERR_MASK_CMD_TIMEOUT;
        v2_later = 0;
    }
    else if(FAIL(ret))
        return -1;
    else
    {
        if((ret->last_r0 & 0xfff) != 0x1aa)
            return -1;
        else
            v2_later = 1;
    }

    // Here we are supposed to check the response to CMD5 (HCSS 3.6)
    // It only returns if the card is a SDIO card
    emmc_issue_command(ret, IO_SET_OP_COND, 0, 10);
    if(!TIMEOUT(ret))
    {
        if(CMD_TIMEOUT(ret))
        {
            if(emmc_reset_cmd() == -1)
                return -1;
            emmc_get()->INTERRUPT = SD_ERR_MASK_CMD_TIMEOUT;
        }
        else
            return -1;
    }

    // Call an inquiry ACMD41 (voltage window = 0) to get the OCR
    emmc_issue_command(ret, ACMD(41), 0, 500);
    if(FAIL(ret))
        return -1;

    // Call initialization ACMD41
    int card_is_busy = 1;
    while(card_is_busy)
    {
        uart_puts("in card_busy loop\r\n");
        uint32_t v2_flags = 0;
        if(v2_later)
        {
            // Set SDHC support
            v2_flags |= (1 << 30);

            // Set 1.8v support
#ifdef SD_1_8V_SUPPORT
            if(!ret->failed_voltage_switch)
                v2_flags |= (1 << 24);
#endif

            // Enable SDXC maximum performance
#ifdef SDXC_MAXIMUM_PERFORMANCE
            v2_flags |= (1 << 28);
#endif
        }

        emmc_issue_command(ret, ACMD(41), 0x00ff8000 | v2_flags, 500000);
        if(FAIL(ret))
            return -1;

        if((ret->last_r0 >> 31) & 0x1)
        {
            // Initialization is complete
            ret->card_ocr = (ret->last_r0 >> 8) & 0xffff;
            ret->card_supports_emmchc = (ret->last_r0 >> 30) & 0x1;

#ifdef SD_1_8V_SUPPORT
            if(!ret->failed_voltage_switch)
                ret->card_supports_18v = (ret->last_r0 >> 24) & 0x1;
#endif
            card_is_busy = 0;
        }
        else
            time_delay_microseconds(5);
    }

    // At this point, we know the card is definitely an SD card, so will definitely
    //  support SDR12 mode which runs at 25 MHz
    emmc_switch_clock_rate(base_clock, SD_CLOCK_NORMAL);

    // A small wait before the voltage switch
    time_delay_microseconds(5);

    // Switch to 1.8V mode if possible
    if(ret->card_supports_18v)
    {
        // As per HCSS 3.6.1

        // Send VOLTAGE_SWITCH
        emmc_issue_command(ret, VOLTAGE_SWITCH, 0, 50);
        if(FAIL(ret))
        {
            ret->failed_voltage_switch = 1;
            emmc_power_off();
            uart_puts("EMMC: voltage switch error\r\n");
            return emmc_card_init(ret);
        }

        // Disable SD clock
        control1 = emmc_get()->CONTROL1;
        control1 &= ~(1 << 2);
        emmc_get()->CONTROL1 = control1;

        // Check DAT[3:0]
        status_reg = emmc_get()->STATUS;
        uint32_t dat30 = (status_reg >> 20) & 0xf;
        if(dat30 != 0)
        {
            ret->failed_voltage_switch = 1;
            emmc_power_off();
            uart_puts("EMMC: dat30 error\r\n");
            return emmc_card_init(ret);
        }

        // Set 1.8V signal enable to 1
        uint32_t control0 = emmc_get()->CONTROL0;
        control0 |= (1 << 8);
        emmc_get()->CONTROL0 = control0;

        // Wait 5 ms
        time_delay_microseconds(5);

        // Check the 1.8V signal enable is set
        control0 = emmc_get()->CONTROL0;
        if(((control0 >> 8) & 0x1) == 0)
        {
            ret->failed_voltage_switch = 1;
            emmc_power_off();
            return emmc_card_init(ret);
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
        if(dat30 != 0xf)
        {
            ret->failed_voltage_switch = 1;
            emmc_power_off();
            return emmc_card_init(ret);
        }
    }

    // Send CMD2 to get the cards CID
    emmc_issue_command(ret, ALL_SEND_CID, 0, 500);
    if(FAIL(ret))
        return -1;


    // Send CMD3 to enter the data state
    emmc_issue_command(ret, SEND_RELATIVE_ADDR, 0, 500);
    if(FAIL(ret))
    {
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

    if(crc_error)
    {
        free(ret);
        return -1;
    }

    if(illegal_cmd)
    {
        free(ret);
        return -1;
    }

    if(error)
    {
        free(ret);
        return -1;
    }

    if(!ready)
    {
        free(ret);
        return -1;
    }

    // Now select the card (toggles it to transfer state)
    emmc_issue_command(ret, SELECT_CARD, ret->card_rca << 16, 500);
    if(FAIL(ret))
    {
        free(ret);
        return -1;
    }

    uint32_t cmd7_resp = ret->last_r0;
    status = (cmd7_resp >> 9) & 0xf;

    if((status != 3) && (status != 4))
    {
        free(ret);
        return -1;
    }

    // If not an SDHC card, ensure BLOCKLEN is 512 bytes
    if(!ret->card_supports_emmchc)
    {
        emmc_issue_command(ret, SET_BLOCKLEN, 512, 500);
        if(FAIL(ret))
        {
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
    emmc_issue_command(ret, SEND_SCR, 0, 500);
    ret->block_size = 512;
    if(FAIL(ret))
    {
        free(ret->scr);
        free(ret);
        return -1;
    }

    // Determine card version
    // Note that the SCR is big-endian
    uint32_t scr0 = byte_swap(ret->scr->scr[0]);
    ret->scr->emmc_version = SD_VER_UNKNOWN;
    uint32_t emmc_spec = (scr0 >> (56 - 32)) & 0xf;
    uint32_t emmc_spec3 = (scr0 >> (47 - 32)) & 0x1;
    uint32_t emmc_spec4 = (scr0 >> (42 - 32)) & 0x1;
    ret->scr->emmc_bus_widths = (scr0 >> (48 - 32)) & 0xf;
    if(emmc_spec == 0)
        ret->scr->emmc_version = SD_VER_1;
    else if(emmc_spec == 1)
        ret->scr->emmc_version = SD_VER_1_1;
    else if(emmc_spec == 2)
    {
        if(emmc_spec3 == 0)
            ret->scr->emmc_version = SD_VER_2;
        else if(emmc_spec3 == 1)
        {
            if(emmc_spec4 == 0)
                ret->scr->emmc_version = SD_VER_3;
            else if(emmc_spec4 == 1)
                ret->scr->emmc_version = SD_VER_4;
        }
    }

    if(ret->scr->emmc_bus_widths & 0x4)
    {
        // Set 4-bit transfer mode (ACMD6)
        // See HCSS 3.4 for the algorithm
#ifdef SD_4BIT_DATA
        // Disable card interrupt in host
        uint32_t old_irpt_mask = emmc_get()->IRPT_MASK);
        uint32_t new_iprt_mask = old_irpt_mask & ~(1 << 8);
        emmc_get()->IRPT_MASK = new_iprt_mask;

        // Send ACMD6 to change the card's bit mode
        emmc_issue_command(ret, SET_BUS_WIDTH, 0x2, 500);
        if (!FAIL(ret))
        {
            // Change bit mode for Host
            uint32_t control0 = emmc_get()->CONTROL0;
            control0 |= 0x2;
            emmc_get()->CONTROL0 = control0;

            // Re-enable card interrupt in host
            emmc_get()->IRPT_MASK = old_irpt_mask;
        }
#endif
    }

    // Reset interrupt register
    emmc_get()->INTERRUPT = 0xffffffff;

    dev = ret;
    uart_puts("card init successfull\r\n");
    return 0;
}

static int emmc_ensure_data_mode(struct emmc_dev *edev)
{
    if(edev->card_rca == 0)
    {
        // Try again to initialise the card
        int ret = emmc_card_init(edev);
        if(ret != 0)
            return ret;
    }

    emmc_issue_command(edev, SEND_STATUS, edev->card_rca << 16, 500);
    if(FAIL(edev))
    {
        edev->card_rca = 0;
        return -1;
    }

    uint32_t status = edev->last_r0;
    uint32_t cur_state = (status >> 9) & 0xf;
    if(cur_state == 3)
    {
        // Currently in the stand-by state - select it
        emmc_issue_command(edev, SELECT_CARD, edev->card_rca << 16, 500);
        if(FAIL(edev))
        {
            edev->card_rca = 0;
            return -1;
        }
    }
    else if(cur_state == 5)
    {
        // In the data transfer state - cancel the transmission
        emmc_issue_command(edev, STOP_TRANSMISSION, 0, 500);
        if(FAIL(edev))
        {
            edev->card_rca = 0;
            return -1;
        }

        // Reset the data circuit
        emmc_reset_dat();
    }
    else if(cur_state != 4)
    {
        // Not in the transfer state - re-initialise
        int ret = emmc_card_init(edev);
        if(ret != 0)
            return ret;
    }

    // Check again that we're now in the correct mode
    if(cur_state != 4)
    {
        emmc_issue_command(edev, SEND_STATUS, edev->card_rca << 16, 500);
        if(FAIL(edev))
        {
            edev->card_rca = 0;
            return -1;
        }
        status = edev->last_r0;
        cur_state = (status >> 9) & 0xf;

        if(cur_state != 4)
        {
            edev->card_rca = 0;
            return -1;
        }
    }

    return 0;
}

#ifdef SDMA_SUPPORT
// We only support DMA transfers to buffers aligned on a 4 kiB boundary
static int emmc_suitable_for_dma(void *buf)
{
    if((uintptr_t)buf & 0xfff)
        return 0;
    else
        return 1;
}
#endif

static int emmc_do_data_command(struct emmc_dev *edev, int is_write, uint8_t *buf, size_t buf_size, uint32_t block_no)
{
    // PLSS table 4.20 - SDSC cards use byte addresses rather than block addresses
    if(!edev->card_supports_emmchc)
        block_no *= 512;

    // This is as per HCSS 3.7.2.1
    if(buf_size < edev->block_size)
        return -1;

    edev->blocks_to_transfer = buf_size / edev->block_size;
    if(buf_size % edev->block_size)
        return -1;
    edev->buf = buf;

    // Decide on the command to use
    int command;
    if(is_write)
    {
        if(edev->blocks_to_transfer > 1)
            command = WRITE_MULTIPLE_BLOCK;
        else
            command = WRITE_BLOCK;
    }
    else
    {
        if(edev->blocks_to_transfer > 1)
            command = READ_MULTIPLE_BLOCK;
        else
            command = READ_SINGLE_BLOCK;
    }

    int retry_count = 0;
    int max_retries = 3;
    while(retry_count < max_retries)
    {
#ifdef SDMA_SUPPORT
        // use SDMA for the first try only
        if((retry_count == 0) && emmc_suitable_for_dma(buf))
            edev->use_emmcma = 1;
        else
            edev->use_emmcma = 0;
#else
        edev->use_emmcma = 0;
#endif

        emmc_issue_command(edev, command, block_no, 5000000);

        if(SUCCESS(edev))
            break;
        else
            retry_count++;
    }
    if(retry_count == max_retries)
    {
        edev->card_rca = 0;
        return -1;
    }

    return 0;
}

static struct emmc_dev *device = NULL;

int emmc_init(void){
    if( emmc_card_init(device) == -1){
        uart_puts("EMMC Driver initialization failed\r\n");
        return -1;
    }
    uart_puts("EMMC Driver initialization succesful\r\n");
    return 0;
}

int emmc_read(uint8_t *buf, size_t buf_size, uint32_t block_no)
{
    // Check the status of the card
    if(emmc_ensure_data_mode(device) != 0)
        return -1;

    if(emmc_do_data_command(device, 0, buf, buf_size, block_no) < 0)
        return -1;

    return buf_size;
}

#ifdef SD_WRITE_SUPPORT
int emmc_write(uint8_t *buf, size_t buf_size, uint32_t block_no)
{
    // Check the status of the card
    if(emmc_ensure_data_mode(device) != 0)
        return -1;

    if(emmc_do_data_command(device, 1, buf, buf_size, block_no) < 0)
        return -1;

    return buf_size;
}

size_t emmc_get_dev_block_size(void){ 
    return device->dev_block_size;
}

int emmc_get_multiblock_read_support(void){
    return device->supports_multiple_block_read;
}

#endif
