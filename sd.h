#ifndef SD_H
#define SD_H


#include <stdlib.h>
#include <stdint.h>

/*
 *  Return amount of bytes read
 */
int sd_read(uint8_t *buf, size_t buf_size, uint32_t block_no);

int sd_write(uint8_t *buf, size_t buf_sie, uint32_t block_no);

#endif
