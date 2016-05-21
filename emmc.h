#ifndef EMMC_H
# define EMMC_H

#include <stdint.h>
#include <stdlib.h>



int emmc_init(void);
int emmc_read(uint8_t *buf, size_t buf_size, uint32_t block_no);
int emmc_write(uint8_t *buf, size_t buf_size, uint32_t block_no);
size_t emmc_get_dev_block_size(void);
#endif
