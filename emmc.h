#ifndef EMMC_H
# define EMMC_H

#include <stdint.h>
#include <stdlib.h>

// SD Clock Frequencies (in Hz)
# define SD_CLOCK_ID         400000
# define SD_CLOCK_NORMAL     25000000
# define SD_CLOCK_HIGH       50000000
# define SD_CLOCK_100        100000000
# define SD_CLOCK_208        208000000

// SDMA buffer address
# define SDMA_BUFFER     0x6000
# define SDMA_BUFFER_PA  (SDMA_BUFFER + 0xC0000000)

// Enable EXPERIMENTAL (and possibly DANGEROUS) SD write support
# define SD_WRITE_SUPPORT

// The particular SDHCI implementation
# define SDHCI_IMPLEMENTATION_GENERIC        0
# define SDHCI_IMPLEMENTATION_BCM_2708       1
# ifndef QEMU
#  define SDHCI_IMPLEMENTATION               SDHCI_IMPLEMENTATION_BCM_2708
# else
#  define SDHCI_IMPLEMENTATION               SDHCI_IMPLEMENTATION_GENERIC
# endif

//typedef unsigned int size_t;


int emmc_init(void);
size_t emmc_get_dev_block_size(void);
int emmc_get_multiblock_read_support(void);
int emmc_read(uint8_t *buf, size_t buf_size, uint32_t block_no);
int emmc_write(uint8_t *buf, size_t buf_size, uint32_t block_no);

#endif
