
#include <stdint.h>
#include "mailbox.h"
#include "control.h"
#include "base.h"
#include "time.h"
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
        if ( (*reg & mask) ? value : !value){ return 0;}
    } while( time_compare(time1, time_get()) == 1);
    return -1;
}


// STATUS bits
#define DAT_LEVEL1                  25
#define CMD_LEVEL                   24
#define DAT_LEVEL0                  20
#define READ_TRANSFER               9
#define WRITE_TRANSFER              8
#define DAT_ACTIVE                  2
#define DAT_INHIBIT                 1
#define CMD_INHIBIT                 0

// CONTROL1 bits
#define SRST_DATA                   26
#define SRST_CMD                    25
#define SRST_HC                     24
#define DATA_TOUNIT                 16
#define CLK_FREQ8                   8
#define CLK_FREQ_MS2                6
#define CLK_GENSEL                  5
#define CLK_EN                      2
#define CLK_STABLE                  1
#define CLK_INTLEN                  0

// CONTROL1 reg utility
#define EMMC_RESET          (1 << SRST_HC)
#define SD_CLOCK_DISABLE   ~(1 << CLK_EN)
#define EMMC_CLOCK_DISABLE ~(1 << CLK_INTLEN)

// Control 2 bits
#define ACMD_ERR                    24
#define DEND_ERR                    22
#define DCRD_ERR                    21
#define DTO_ERR                     20
#define CBAD_ERR                    19
#define CEND_ERR                    18
#define CCRC_ERR                    17
#define CTO_ERR                     16
#define ERR                         15
#define ENDBOOT                     14
#define BOOTACK                     13
#define RETUNE                      12
#define CARD                        8
#define READ_RDY                    5
#define WRITE_RDY                   4
#define BLOCK_GAP                   2
#define DATA_DONE                   1
#define CMD_DONE                    0


// SLOTISR_VER bits
#define SLOTISR_VER_VENDOR          24
#define SLOTISR_VER_SD_VERSION      16
#define SLOTISR_VER_SLOT_STATUS     0

static uint32_t emmc_get_base_clock(void){
    uint32_t base_clock;
    //      mailbox needs to be 0x100 aligned
    volatile __attribute__((aligned(0x100))) uint32_t mailbuffer[8];  // response needs 8 bits
    // use mailbox to get clock
    mailbuffer[0] = 4*8 /*sizeof(mailbuffer)*/;         // length of buffer
    mailbuffer[1] = MAILBOX_REQUEST;            // length
    mailbuffer[2] = MAILBOX_GET_CLOCK_RATE;
    mailbuffer[3] = 0x8;                        // value buffer size
    mailbuffer[4] = 4;                        // value length size
    mailbuffer[5] = 1;                          // clock id and space to return clock id
    mailbuffer[6] = 0;                          // space for clock rate
    mailbuffer[7] = MAILBOX_PROPERTY_END;
    //  invalidate the location of mailbuffer in cache. it has not been written to main memory yet.
    mmu_cache_invalidate(mailbuffer);
    //  send and receive
    uint32_t dim = mailbox_write_read(mailbuffer, 8);
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



    // my particular sd card has version 2, which compilise to spesification version 3.0
int emmc_card_init(void){
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
    uint32_t control1 = EMMC_RESET & (SD_CLOCK_DISABLE & EMMC_CLOCK_DISABLE);
    emmc_get()->CONTROL1 = control1;
    time_delay_microseconds(1000);
    //  check if the emmc was reset properly:
    if ( timeout_wait(  &(emmc_get()->CONTROL1),
                        (1 << SRST_HC) | (1 << SRST_CMD) | (1 << SRST_DATA),
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
    // set clock speed slow


}
