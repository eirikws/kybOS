#ifndef BLOCK_H
#define BLOCK_H

#include <stdint.h>
#include <stddef.h>

struct fs;

struct block_device {
	char *driver_name;
	char *device_name;
	uint8_t *device_id;
	size_t dev_id_len;

	int supports_multiple_block_read;
	int supports_multiple_block_write;

	int (*dev_read)(uint8_t *buf, size_t buf_size, uint32_t block_num);
	int (*dev_write)(uint8_t *buf, size_t buf_size, uint32_t block_num);
	size_t block_size;
	size_t num_blocks;

	struct fs *fs;
};

size_t block_read(struct block_device *dev, uint8_t *buf, size_t buf_size, uint32_t starting_block);
size_t block_write(struct block_device *dev, uint8_t *buf, size_t buf_size, uint32_t starting_block);

#endif

#include "fs.h"

