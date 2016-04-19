#include <stdint.h>
#include <stdio.h>
#include "block.h"

#define MAX_TRIES		1

size_t block_read(struct block_device *dev, uint8_t *buf, size_t buf_size, uint32_t starting_block)
{
	// Read the required number of blocks to satisfy the request
	int buf_offset = 0;
	uint32_t block_offset = 0;

	if(!dev->read)
		return 0;

	// Perform a multi-block read if the device supports it
	if(dev->supports_multiple_block_read && ((buf_size / dev->block_size) > 1))
	{
		return dev->read(dev, buf, buf_size, starting_block);
	}

	do
	{
		size_t to_read = buf_size;
		if(to_read > dev->block_size)
			to_read = dev->block_size;
		int tries = 0;
		while(1)
		{
			int ret = dev->read(dev, &buf[buf_offset], to_read,
					starting_block + block_offset);
			if(ret < 0)
			{
				tries++;
				if(tries >= MAX_TRIES)
					return ret;
			}
			else
				break;
		}

		buf_offset += (int)to_read;
		block_offset++;

		if(buf_size < dev->block_size)
			buf_size = 0;
		else
			buf_size -= dev->block_size;
	} while(buf_size > 0);

	return (size_t)buf_offset;
}

size_t block_write(struct block_device *dev, uint8_t *buf, size_t buf_size, uint32_t starting_block)
{
	// Write the required number of blocks to satisfy the request
	int buf_offset = 0;
	uint32_t block_offset = 0;

	if(!dev->write)
		return 0;

	do
	{
		size_t to_write = buf_size;
		if(to_write > dev->block_size)
			to_write = dev->block_size;
		int tries = 0;
		while(1)
		{
			int ret = dev->write(dev, &buf[buf_offset], to_write,
					starting_block + block_offset);
			if(ret < 0)
			{
				tries++;
				if(tries >= MAX_TRIES)
					return ret;
			}
			else
				break;
		}

		buf_offset += (int)to_write;
		block_offset++;

		if(buf_size < dev->block_size)
			buf_size = 0;
		else
			buf_size -= dev->block_size;
	} while(buf_size > 0);

	return (size_t)buf_offset;
}
