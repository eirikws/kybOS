#include <string.h>
#include <stdint.h>
#include "mmu.h"
#include "mailbox.h"
#include "base.h"
#include "time.h"
#include "uart.h"
#include "emmc.h"


#define EMMC_CONTROLLER_BASE   (PERIPHERAL_BASE + 0x300000)

static emmc_controller_t *EMMCController = 
        (emmc_controller_t*)EMMC_CONTROLLER_BASE;

emmc_controller_t *emmc_get(void){
    return EMMCController;
}

static uint32_t version;


/* returns 0 if successfull wait, -1 if it timed out*/
static int timeout_wait(volatile uint32_t *reg, uint32_t mask, int value, uint32_t msec){
    time_unit_t time1 = time_get();
    time_add_microseconds(&time1 ,msec);
    do{
        uart_puts("actually waiting----------------------------\r\n");
        if ( (*reg & mask) ? value : !value){ return 0;}
    } while( time_compare(time1, time_get()) == 1);
    return -1;
}

typedef struct emmc_block_dev{
    uint32_t card_supports_emmchc;
    uint32_t card_ocr;
    uint32_t card_supports_18v;
    uint32_t card_rca;
    uint32_t last_interrupt;
    uint32_t last_error;
    
    int failed_voltage_switch;

    uint32_t last_cmd_reg;
    uint32_t last_cmd;
    uint32_t last_cmd_success;
    uint32_t last_r0;
    uint32_t last_r1;
    uint32_t last_r2;
    uint32_t last_r3;

    void    *buf;
    int     blocks_to_transfer;
    uint32_t block_size;
    int use_emmcma;
    int card_removal;
    uint32_t base_clock;
} emmc_dev_t;

emmc_dev_t emmc_dev;

#define SDMA_BUFFER                 0x6000
#define SDMA_BUFFER_PA              (SDMA_BUFFER + 0x40000000)

// Emmc command index
#define GO_IDLE_STATE               0 
#define ALL_SEND_CID                2
#define SEND_RELATIVE_ADDR          3   
#define SET_DSR                     4 
#define IO_SET_OP_COND              5
#define SWITCH_FUNC                 6
#define SELECT_CARD                 7
#define DESELECT_CARD               7
#define SELECT_DESELECT_CARD        7
#define SEND_IF_COND                8
#define SEND_CSD                    9
#define SEND_CID                    10
#define VOLTAGE_SWITCH              11
#define STOP_TRANSMISSION           12
#define SEND_STATUS                 13
#define GO_INACTIVE_STATE           15
#define SET_BLOCKLEN                16
#define READ_SINGLE_BLOCK           17
#define READ_MULTIPLE_BLOCK         18
#define SEND_TUNING_BLOCK           19
#define SPEED_CLASS_CONTROL         20
#define SET_BLOCK_COUNT             23
#define WRITE_BLOCK                 24
#define WRITE_MULTIPLE_BLOCK        25
#define PROGRAM_CSD                 27
#define SET_WRITE_PROT              28
#define CLR_WRITE_PROT              29
#define SEND_WRITE_PROT             30
#define ERASE_WR_BLK_START          32
#define ERASE_WR_BLK_END            33
#define ERASE                       38
#define LOCK_UNLOCK                 42
#define APP_CMD                     55
#define GEN_CMD                     56


// SD CLOCK ID
#define SD_CLOCK_ID                 0x400000

// STATUS bits
#define DAT_LEVEL1                  (1 << 25)
#define CMD_LEVEL                   (1 << 24)
#define DAT_LEVEL0                  (1 << 20)
#define READ_TRANSFER               (1 << 9)
#define WRITE_TRANSFER              (1 << 8)
#define DAT_ACTIVE                  (1 << 2)
#define DAT_INHIBIT                 (1 << 1)
#define CMD_INHIBIT                 (1 << 0)

// CONTROL1 bits
#define SRST_DATA                   (1 << 26)
#define SRST_CMD                    (1 << 25)
#define SRST_HC                     (1 << 24)
#define DATA_TOUNIT                 (1 << 16)
#define CLK_FREQ8                   (1 << 8)
#define CLK_FREQ_MS2                (1 << 6)
#define CLK_GENSEL                  (1 << 5)
#define CLK_EN                      (1 << 2)
#define CLK_STABLE                  (1 << 1)
#define CLK_INTLEN                  (1 << 0)

//  INTERRUPT bits
#define ACMD_ERR            (1 << 24)
#define DEND_ERR            (1 << 22)
#define DCRC_ERR            (1 << 21)
#define DTO_ERR             (1 << 20)
#define CBAD_ERR            (1 << 19)
#define CEND_ERR            (1 << 18)
#define CCRC_ERR            (1 << 17)
#define CTO_ERR             (1 << 16)
#define IS_ERROR            (1 << 15)
#define ENDBOOT             (1 << 14)
#define BOOTACK             (1 << 13)
#define RETUNE              (1 << 12)
#define CARD                (1 << 8)
#define CARD_REMOVE         (1 << 7)
#define CARD_INSERT         (1 << 6)
#define READ_RDY            (1 << 5)
#define WRITE_RDY           (1 << 4)
#define DMA_IRQ             (1 << 3)
#define BLOCK_GAP           (1 << 2)
#define DATA_DONE           (1 << 1)
#define CMD_DONE            (1 << 0)

// Control 2 bits
#define TUNED               (1 << 23)
#define TUNEON              (1 << 22)
#define UHSMODE             (1 << 16)
#define NOTC12_ERR          (1 << 7)
#define ACBAD_ERR           (1 << 4)
#define ACEND_ERR           (1 << 3)
#define ACCRC_ERR           (1 << 2)
#define ACTO_ERR            (1 << 1)
#define ACNOX_ERR           (1 << 0)

// SLOTISR_VER bits
#define SLOTISR_VER_VENDOR          24
#define SLOTISR_VER_SD_VERSION      16
#define SLOTISR_VER_SLOT_STATUS     0

#define SD_DATA_READ        (SD_CMD_ISDATA | SD_CMD_DAT_DIR_CH)
#define SD_DATA_WRITE       (SD_CMD_ISDATA | SD_CMD_DAT_DIR_HC)

//  card commands
#define SD_CMD_INDEX(v)             ((v) << 24)
#define SD_CMD_RESERVED(v)          (0xffffffff)
#define SD_CMD_TYPE_NORMAL         0x0
#define SD_CMD_TYPE_SUSPEND        (1 << 22)
#define SD_CMD_TYPE_RESUME         (2 << 22)
#define SD_CMD_TYPE_ABORT          (3 << 22)
#define SD_CMD_TYPE_MASK           (3 << 22)
#define SD_CMD_ISDATA              (1 << 21)
#define SD_CMD_IXCHK_EN            (1 << 20)
#define SD_CMD_CRCCHK_EN           (1 << 19)
#define SD_CMD_RSPNS_TYPE_NONE     0            // For no response
#define SD_CMD_RSPNS_TYPE_136      (1 << 16)        // For response R2 (with CRC), R3,4 (no CRC)
#define SD_CMD_RSPNS_TYPE_48       (2 << 16)        // For responses R1, R5, R6, R7 (with CRC)
#define SD_CMD_RSPNS_TYPE_48B      (3 << 16)        // For responses R1b, R5b (with CRC)
#define SD_CMD_RSPNS_TYPE_MASK     (3 << 16)
#define SD_CMD_MULTI_BLOCK         (1 << 5)
#define SD_CMD_DAT_DIR_HC          0
#define SD_CMD_DAT_DIR_CH          (1 << 4)
#define SD_CMD_AUTO_CMD_EN_NONE    0
#define SD_CMD_AUTO_CMD_EN_CMD12   (1 << 2)
#define SD_CMD_AUTO_CMD_EN_CMD23   (2 << 2)
#define SD_CMD_BLKCNT_EN           (1 << 1)
#define SD_CMD_DMA                 1


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

static void write_word(uint32_t data, uint8_t* buf, int offset){
    buf[offset] = data & 0xff;
    buf[offset + 1] = (data >> 8) & 0xff;
    buf[offset + 2] = (data >> 16) & 0xff;
    buf[offset + 3] = (data >> 24) & 0xff;
}

static uint32_t read_word(uint8_t* buf, int offset){
    return   (buf[offset] & 0xff)
           | ((buf[offset + 1] & 0xff) << 8)
           | ((buf[offset + 2] & 0xff) << 16)
           | ((buf[offset + 3] & 0xff) << 24);
}


static int emmc_power_off(void){
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

static int emmc_power_on(void){
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


static uint32_t emmc_reset(void){
    if(emmc_power_off() < 0){   return -1;}
    time_delay_microseconds(5);
    return emmc_power_on();
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

#define EMMC_GET_CLOCK_DIV_FAIL         0xffffffff
static uint32_t emmc_get_clock_divider(uint32_t base_clock, uint32_t rate, uint32_t sd_version){
    uint32_t div = 0;
    uint32_t mod;
    if(rate > base_clock){
        div = 1;
    } else {
        div = base_clock / rate;
        mod = base_clock % rate;
        if (mod){
            rate--;
        }
    }
    // decide on a clock mode
    if (sd_version < 2){
        return -1;  // do not support sd version lower than 2
    }

    int divider = -1;
    int f_bit;
    for (f_bit = 31; f_bit > -1 ; f_bit--){
        uint32_t test = (1 << f_bit);
        if(div & test){
            divider = f_bit;
            div &= ~test;
            if(div){ divider++;}
            break;
        }
    }
    if(divider == -1)   {   divider = 31;       }
    if(divider >= 32)   {   divider = 31;       }
    if(divider != 0)    {   divider = (1 << (divider -1));}
    if(divider >= 0x400){   divider = 0x3ff;    }

    return (((divider & 0xff) << 8) | ((divider >> 8 ) & 3) << 6);
}

static int emmc_reset_data(void){
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SRST_DATA;
    emmc_get()->CONTROL1 = control1;
    if( timeout_wait( &(emmc_get()->CONTROL1), SRST_DATA, 0, 1000)){
        uart_puts("emmc error: reset DATA line did not respond\r\n");
        return -1;
    } return 0;
}

static int emmc_reset_cmd(void){
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SRST_CMD;
    emmc_get()->CONTROL1 = control1;
    if( timeout_wait( &(emmc_get()->CONTROL1), SRST_CMD, 0, 1000)){
        uart_puts("emmc error: reset CMD line did not respond\r\n");
        return -1;
    } return 0;
}

static void emmc_command_int( uint32_t cmd_reg, uint32_t arg, uint32_t timeout_msec){
    uart_puts("blocks to transfer: ");
    uart_put_uint32_t(emmc_dev.blocks_to_transfer, 10);
    uart_puts("\r\n");
    emmc_dev.last_cmd_reg = cmd_reg;
    emmc_dev.last_cmd_success = 0;
    uart_puts("enter command_int\r\n");
    //  check cmd inhibit
    while( emmc_get()->STATUS & CMD_INHIBIT){
        uart_puts("checking cmd inhibit     ");
        uart_put_uint32_t(emmc_get()->STATUS, 16);
        uart_puts("\r\n");
        time_delay_microseconds(1000);
        uart_puts("checking cmd inhibit INTERRUPT     ");
        uart_put_uint32_t(emmc_get()->INTERRUPT, 16);
        uart_puts("\r\n");
    }
    // check busy
    if(( cmd_reg &  SD_CMD_RSPNS_TYPE_MASK) == SD_CMD_RSPNS_TYPE_48B){
        // is busy
        // is an abort command?
        if((cmd_reg & SD_CMD_TYPE_MASK) != SD_CMD_TYPE_ABORT){
            // not abort
            // wait for data line to be free
            while( emmc_get()->STATUS & DAT_INHIBIT){
                uart_puts("waiting for dat inhibit\r\n");
            }
        }
    }
    // dma transfer?
    int is_emmcma = 0;
    if(( cmd_reg & SD_CMD_ISDATA) && emmc_dev.use_emmcma){  is_emmcma = 1;}
    //set system adress reg
    //define 4KB aligned buffer
    if(is_emmcma){   
        uart_puts("using DMA\r\n");
        emmc_get()->ARG2 = SDMA_BUFFER_PA;
    }

    // set block size = 512bytes and block count = 1
    // SDMA buffer boundry = 4KB
    if(emmc_dev.blocks_to_transfer > 0xffff){
        emmc_dev.last_cmd_success = 0;
        return;
    }
    uint32_t blksize = emmc_dev.block_size | (emmc_dev.blocks_to_transfer << 16);
    emmc_get()->BLKSIZECNT = blksize;

    emmc_get()->ARG1 = arg;
    // write command!
    if(is_emmcma){  cmd_reg |= SD_CMD_DMA;}
    emmc_get()->CMDTM = cmd_reg;
    time_delay_microseconds(2);
    // wait for cmd complete
    
    // SOMETHING WRONG HERE§
    timeout_wait( &(emmc_get()->INTERRUPT), (CMD_DONE | IS_ERROR), 1, timeout_msec);
    uint32_t irpts = emmc_get()->INTERRUPT;

    // clear command complete flag
    emmc_get()->INTERRUPT = 0xffff0001;
    // errors?
    if( (irpts & 0xffff0001) != 1){
        uart_puts("command int there are errors\r\n");
        emmc_dev.last_error = irpts & 0xffff0000;
        emmc_dev.last_interrupt = irpts;
        return;
    }
    time_delay_microseconds(2);
    switch( cmd_reg & SD_CMD_RSPNS_TYPE_MASK){
        case SD_CMD_RSPNS_TYPE_48:
        case SD_CMD_RSPNS_TYPE_48B:
            uart_puts("receiving input and putting them in r0\r\n");
            emmc_dev.last_r0 = emmc_get()->RESP0;
            uart_puts("R0: ");
            uart_put_uint32_t(emmc_dev.last_r0, 16);
            uart_puts("\r\n");
            break;
        case SD_CMD_RSPNS_TYPE_136:
            uart_puts("receiving input and putting them in r0-4\r\n");
            emmc_dev.last_r0 = emmc_get()->RESP0;
            emmc_dev.last_r1 = emmc_get()->RESP1;
            emmc_dev.last_r2 = emmc_get()->RESP2;
            emmc_dev.last_r3 = emmc_get()->RESP3;
            uart_puts("R3: ");
            uart_put_uint32_t(emmc_dev.last_r3, 16);
            uart_puts(" R2: ");
            uart_put_uint32_t(emmc_dev.last_r2, 16);
            uart_puts(" R1: ");
            uart_put_uint32_t(emmc_dev.last_r1, 16);
            uart_puts(" R0: ");
            uart_put_uint32_t(emmc_dev.last_r0, 16);
            uart_puts("\r\n");
    }
    if(( cmd_reg & SD_CMD_ISDATA) && (is_emmcma == 0)){
        uint32_t wr_irpt;
        int is_write = 0;
        if( cmd_reg & SD_CMD_DAT_DIR_CH){   wr_irpt = READ_RDY;}
        else {
            is_write = 1;
            wr_irpt = WRITE_RDY;
        }
        int cur_block = 0;
        uint32_t *cur_buf = (uint32_t*)emmc_dev.buf;
        while( cur_block < emmc_dev.blocks_to_transfer ){
            uart_puts("in while loop\r\n");
            timeout_wait( &(emmc_get()->INTERRUPT), wr_irpt | 0x8000, 1, timeout_msec);
            irpts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = 0xffff | wr_irpt;
            if(( irpts & (0xffff0000 | wr_irpt)) != wr_irpt ){
                emmc_dev.last_error = irpts & 0xffff0000;
                emmc_dev.last_interrupt = irpts;
            }
            // block
            unsigned int cur_byte_no = 0;
            while( cur_byte_no < emmc_dev.block_size ){
                if( is_write){  // write
                    uint32_t data = read_word((uint8_t*)cur_buf, 0);
                    emmc_get()->DATA = data;
                }else{          // read
                    uint32_t data = emmc_get()->DATA;
                    write_word(data, (uint8_t*)cur_buf, 0);
                }
                cur_byte_no += 4;
                cur_buf++;
            }
            cur_block++;
        }
    }
    if((((cmd_reg & SD_CMD_RSPNS_TYPE_MASK) == SD_CMD_RSPNS_TYPE_48B) 
            || (cmd_reg & SD_CMD_ISDATA)) && (is_emmcma == 0)) {
        // check if data inhibit is 0 already
        if(( emmc_get()->STATUS & DAT_INHIBIT) == 0){
            emmc_get()->INTERRUPT = 0xffff0002;
        }else{
            timeout_wait( &(emmc_get()->INTERRUPT), DATA_DONE | (1<<15) ,  1, timeout_msec);
            irpts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = 0xffff0002;
            // check if both adata timeout ad transfer complete are set
            if((( irpts & 0xffff0002) != DATA_DONE) && ((irpts & 0xffff0002) != 0x100002)){
                emmc_dev.last_error = irpts & 0xffff0000;
                emmc_dev.last_interrupt = irpts;
                return;
            }
            emmc_get()->INTERRUPT = 0xffff0002;
        }
    }
    else if(is_emmcma){
        // if is dma transfer
        if(( emmc_get()->STATUS &  DAT_INHIBIT) == 0){
            emmc_get()->INTERRUPT = 0xffff000a;
        }else{
            timeout_wait( &(emmc_get()->INTERRUPT), 0x800a, 1, timeout_msec);
            irpts = emmc_get()->INTERRUPT;
            emmc_get()->INTERRUPT = 0xffff000a;
            // find errors
            if(( irpts & 0x8000) && (( irpts & DATA_DONE) != 2)){
                emmc_dev.last_error = irpts & 0xffff0000;
                emmc_dev.last_interrupt = irpts;
                return;
            }
            // if transfer complete
            if( irpts & DATA_DONE){
                memcpy(emmc_dev.buf, (void*)SDMA_BUFFER, emmc_dev.block_size);
            }else{
                if(( irpts == 0) && ((emmc_get()->STATUS & (DAT_INHIBIT | CMD_INHIBIT)) == 2)){
                    emmc_get()->CMDTM = emmc_commands[STOP_TRANSMISSION];
                }
                emmc_dev.last_error = irpts & 0xffff0000;
                emmc_dev.last_interrupt = irpts;
                return;
            }
        }
    }
    uart_puts("command int done!\r\n");
    emmc_dev.last_cmd_success = 1;
}



static void emmc_handle_card_irq(){
    if( emmc_dev.card_rca){
        emmc_command_int(     emmc_commands[SEND_STATUS], 
                                    (emmc_dev.card_rca << 16),
                                    500);
    }
}

void emmc_handle_interrupts(void){
    uint32_t irpts = emmc_get()->INTERRUPT;
    uint32_t reset_irqs = 0;
    uart_puts("irpts = ");
    uart_put_uint32_t(irpts, 16);
    uart_puts("\r\n");
    if( irpts & CMD_DONE){
        uart_puts("handle interrupts command finished\r\n");
        reset_irqs |= CMD_DONE;
    }
    if( irpts & DATA_DONE){
        uart_puts("handle interrupts data done\r\n");
        reset_irqs |= DATA_DONE;
    } 
    if( irpts & BLOCK_GAP){
        reset_irqs |= BLOCK_GAP;
    }
    if( irpts & DMA_IRQ){
        reset_irqs |= DMA_IRQ;
    }
    if( irpts & WRITE_RDY){
        reset_irqs |= WRITE_RDY;
        emmc_reset_data();
    }
    if( irpts & READ_RDY){
        reset_irqs |= READ_RDY;
        emmc_reset_data();
    }
    if( irpts & CARD_INSERT){
        reset_irqs |= CARD_INSERT;
    }
    if( irpts & CARD_REMOVE){
        reset_irqs |= CARD_REMOVE;
    }
    if (irpts & CARD){
        reset_irqs |= CARD;
        emmc_handle_card_irq();
    }
    if( irpts & 0x8000){
        reset_irqs |= 0xffff;
    }
    emmc_get()->INTERRUPT = reset_irqs;
}

#define APP_CMD                 55
#define APP_CMD_CHECK           0x80000000

int emmc_command(uint32_t command, uint32_t arg, uint32_t timeout_msec){
    emmc_handle_interrupts();
    if(emmc_dev.card_removal){
        emmc_dev.last_cmd_success = 0;
        return -1;
    }
    if( command & APP_CMD_CHECK){
        command &= 0xff;
        if( emmc_acommands[command] == SD_CMD_RESERVED(0)){
            // command does not exist!
            emmc_dev.last_cmd_success = 0;
            return -1;
        }
        emmc_dev.last_cmd = APP_CMD;
        uint32_t rca = 0;
        if(emmc_dev.card_rca){
            rca = emmc_dev.card_rca << 16;
        }
        uart_puts("Sending APP_CMD \r\n");
        emmc_command_int(emmc_commands[APP_CMD], rca, timeout_msec);
        uart_puts("APP_CMD done. next should be a acommand!\r\n");
        if(emmc_dev.last_cmd_success){
            emmc_dev.last_cmd = command | APP_CMD_CHECK;
            uart_puts("SENDING ACOMMAND\r\n");
            emmc_command_int(emmc_acommands[command], arg, timeout_msec);
            uart_puts("ACOMMAND done\r\n");
        }
    }else{
        if(emmc_commands[command] == SD_CMD_RESERVED(0)){
            emmc_dev.last_cmd_success = 0;
            return -1;
        }
        emmc_dev.last_cmd = command;
        emmc_command_int( emmc_commands[command], arg, timeout_msec);
    }
    return 0;
}



    // my particular sd card has version 2, which compilise to spesification version 3.0
int emmc_card_init(void){
    // reset the card
    if(emmc_reset() != 0 ){     
        uart_puts("emmc error: init: reset failed!\r\n");
        return -1;
    }
    // read controller version
    uint32_t ver = emmc_get()->SLOTISR_VER;
    uint32_t vendor = ver >> SLOTISR_VER_VENDOR;
    version = (ver >> SLOTISR_VER_SD_VERSION) & 0xFF;
    uint32_t slot_status = (ver >> SLOTISR_VER_SLOT_STATUS ) & 0xFFFF;
    

    uart_puts("ver: ");
    uart_put_uint32_t(ver, 10);
    uart_puts("\r\n");
    uart_puts("Emmc vendor: ");
    uart_put_uint32_t( vendor, 10);
    uart_puts(" Emmc SD version: ");
    uart_put_uint32_t( version, 10);
    uart_puts(" Emmc vendor: ");
    uart_put_uint32_t( slot_status, 10);
    uart_puts("\r\n");

    // there are three versions of SD cards, 0,1 and 2. if not one of these, 
    // return with an error
    if (version > 2){ 
        uart_puts("emmc sd version number is not within bounds\r\n");
        return -1;
    }
    
    // we want to reset the controller first!
    // disable clocks and do reset bit. then wait.
    
    uint32_t control1 = emmc_get()->CONTROL1;
    control1 |= SRST_HC;
    control1 &= ~CLK_EN;
    control1 &= ~CLK_INTLEN;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(1000);
    //  check if the emmc was reset properly:
    if ( timeout_wait(  &(emmc_get()->CONTROL1),
                        SRST_HC | SRST_CMD | SRST_DATA,
                        0,
                        1000)   < 0   ){
        uart_puts("Emmc not properly reset\r\n");
        return -1;
    }
    
    // check that there is a valid card
    timeout_wait( &(emmc_get()->STATUS), 1 << 16, 1, 500);
    uint32_t status_reg = emmc_get()->STATUS;
    if ((status_reg & (1 << 16)) == 0){
        uart_puts("emmc no card inserted\r\n");
        return -1;
    }
    


    // clear control2
    emmc_get()->CONTROL2 = 0;

    // find base clock rate
    uint32_t base_clock = emmc_get_base_clock();
    uart_puts("Emmc base clock speed: ");
    uart_put_uint32_t(base_clock, 10);
    uart_puts("\r\n");
    
    if( base_clock == 0){
        uart_puts("emmc error: init: base clock is zero!\r\n");
        return -1;
    }

    // set clock speed slow
    control1 =  emmc_get()->CONTROL1;
    control1 |= 1;   // enable clock

    // id freq = 400kHZ
    uint32_t freq_div = emmc_get_clock_divider(base_clock, SD_CLOCK_ID, version); 
    if (freq_div == EMMC_GET_CLOCK_DIV_FAIL){    return -1;}

    control1 |=     freq_div                // set div
             |      DATA_TOUNIT;     // data timeout = TMCLK * 2^(x+13)
    
    emmc_get()->CONTROL1 = control1;
    // wait untill stable
    if ( timeout_wait(  &(emmc_get()->CONTROL1),
                        CLK_STABLE,
                        1,
                        1000)   < 0   ){
        uart_puts("Emmc error: clock failed to stailize\r\n");
        return -1;
    }
    
    //  enable sd clock
    control1 =  emmc_get()->CONTROL1;
    control1 |= CLK_EN;
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(2);     // small time delay after enabling the clock

    // disable interrupts for emmc to arm
    emmc_get()->IRPT_EN = 0;
    // reset interrupt flags
    emmc_get()->INTERRUPT = 0xffffffff;
    //  sent IRQs to interrupt reg
    emmc_get()->IRPT_MASK = 0xffffffff;

    time_delay_microseconds(2);
    

    // initialize device struct
    memset(&emmc_dev, 0, sizeof(emmc_dev));
    emmc_dev.base_clock = base_clock;


    uart_puts("Doing GO_IDLE_STATE\r\n");
    emmc_command(GO_IDLE_STATE, 0, 500);
    uart_puts("GO_IDLE_STATE done \r\n");
    
    if( !emmc_dev.last_cmd_success ){
        uart_puts("Emmc error: init: go idle state failed\r\n");
        return -1;
    }

    //volt supplied = 1 = 2.7-3.6 V
    //should be 0xAA
    
    uart_puts("Doing SEND_IF_COND\r\n");
    emmc_command(SEND_IF_COND, 0x1aa, 500);
    uart_puts("SEND_IF_COND done \r\n");
    
    uart_puts("1\r\n");
    int v2 = 0;
    // timeout
    if( (emmc_dev.last_cmd_success == 0) && (emmc_dev.last_error == 0) ){
        v2 = 0;
    }else if( (emmc_dev.last_cmd_success == 0) && (emmc_dev.last_error & CTO_ERR)){
        if( emmc_reset_cmd() == -1){
            uart_puts("Emmc error: init: emmc_reset_cmd failed\r\n");
            return -1;
        }
        emmc_get()->INTERRUPT = CTO_ERR;
        v2 = 0;
    }else if( emmc_dev.last_cmd_success == 0){
        uart_puts("Emmc error: init: timeout-last cmd failed\r\n");
        return -1;
    }else{
        if(( emmc_dev.last_r0 & 0xfff) != 0x1aa){
            uart_puts("Emmc error: init: timerout-last_r0 incorrect value\r\n");
            return -1;
        }else{
            v2 = 1;
        }
    }
    
    uart_puts("2\r\n");

    // check response to command 5
    uart_puts("Doing IO_SET_OP_COND\r\n");
    //emmc_command(IO_SET_OP_COND, 0, 100);
    uart_puts("IO_SET_OP_COND done\r\n");
    uart_puts("cmd5 returned ");
    uart_put_uint32_t(emmc_dev.last_r0, 16);
    uart_puts(" ");
    uart_put_uint32_t(emmc_dev.last_r1, 16);
    uart_puts("\r\n");
    if( !((emmc_dev.last_cmd_success==0) && (emmc_dev.last_error == 0)) ){
        // check if there was a command timeout
        // this is normal
        uart_puts("last cmd success: ");
        uart_put_uint32_t(emmc_dev.last_cmd_success, 10);
        uart_puts(" last error: ");
        uart_put_uint32_t(emmc_dev.last_error, 16);
        uart_puts("\r\n");
        if( (emmc_dev.last_cmd_success == 0) && (emmc_dev.last_error & CTO_ERR) ){
            if( emmc_reset_cmd() == -1){
                uart_puts("Emmc error: init: check response 5-emmc_reset_cmd error\r\n");
                return -1;
            }
            uart_puts("not SDIO, thats OK \r\n");
            emmc_get()->INTERRUPT = CTO_ERR;
        }else{
            uart_puts("Emmc error: init: check response 5-error\r\n");
       //     return -1;
        }
    }

    uart_puts("3\r\n");
    // inquiry aCMD41 to get OCR
    uart_puts("Doing 41 & APP_CMD_CHECK\r\n");
    emmc_command( 41 | APP_CMD_CHECK, 0, 500);
    uart_puts("41 & APP_CMD_CHECK done\r\n");
    if (emmc_dev.last_cmd_success == 0){
        uart_puts("Emmc error: init; inquire ACMD41\r\n");
        return -1;
    }
    uart_puts("4\r\n");
    int card_busy = 1;
    uart_puts("v2: ");
    uart_put_uint32_t(v2, 10);
    uart_puts("\r\n");
    while( card_busy){
        uint32_t v2_flags = 0;
        if(v2){
            v2 |= (1 << 30); // SDHC support
            if (!emmc_dev.failed_voltage_switch){
           //     v2_flags |= (1 << 24); // 1.8V support
            }
         //   v2_flags |= (1 << 28); // perforamcne boost SDXC
        }
        uart_puts("doing 41 | APP_CMD_CHECK with 0xff8000\r\n");
        emmc_command(41 | APP_CMD_CHECK, 0x80ff8000| v2_flags, 500);
        uart_puts("41 | APP_CMD_CHECK done with 0xff8000\r\n");
        if( emmc_dev.last_cmd_success == 0){
            uart_puts("Emmc error: init: write v2_flags\r\n");
            return -1;
        }
        uart_puts("last r0 check: ");
        uart_put_uint32_t(emmc_dev.last_r0, 16);
        uart_puts("\r\n");
        if(( emmc_dev.last_r0 >> 31) & 1){
            // init finished
            uart_puts("Init is finished in loop\r\n");
            emmc_dev.card_ocr = (emmc_dev.last_r0 >> 8) & 0xffff;
            emmc_dev.card_supports_emmchc = (emmc_dev.last_r0 >> 30) & 1;
            if(!emmc_dev.failed_voltage_switch){
                emmc_dev.card_supports_18v = (emmc_dev.last_r0 >> 24) & 1;
            }
            card_busy = 0;
        }
        else{
            time_delay_microseconds(1000);
        }
        uart_puts("emmc init loop\r\n");
    }


    uart_puts("emmc_initialized\r\n");
    return 1;
}





































