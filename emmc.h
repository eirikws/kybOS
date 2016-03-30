#ifndef EMMC_H
#define EMMC_H

#include <stdint.h>
#include "time.h"


typedef struct block_device{
    char        *name;
    uint8_t     id;
    uint32_t    dev_id_len;

    int supports_multiple_block_read;
    int suppoers_multiple_block_write;

    int (*read)(struct block_device *dev, uint8_t *buf, uint32_t buf_size, uint32_t block_num);
    int (*write)(struct block_device *dev, uint8_t *buf, uint32_t buf_size, uint32_t block_num);
    
    uint32_t    block_size;
    uint32_t    num_blocks;
} block_device_t;

typedef struct emmc_scr{
    uint32_t scr[2];
    uint32_t emmc_bus_width;
    int emmc_version;
} emmc_scr_t;


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


emmc_controller_t *emmc_get(void);
int emmc_card_init(void);
int emmc_read(uint8_t *buf, uint32_t buf_size, uint32_t block_no);
int emmc_write(uint8_t *buf, uint32_t buf_size, uint32_t block_no);
int emmc_command(uint32_t command, uint32_t arg, uint32_t timeout_msec);
#endif
