#include <stdlib.h>
#include <stdint.h>
#include "emmc.h"
#include "sd.h"

int sd_read(uint8_t *buf, size_t buf_size, uint32_t block_no){
    int buf_offset = 0;
	uint32_t block_offset = 0;
    do{
        size_t to_read = buf_size;
        if( to_read > emmc_get_dev_block_size()){
            to_read = emmc_get_dev_block_size();
        }
        int ret = emmc_read(&buf[buf_offset], to_read, block_no + block_offset);
		if(ret < 0){
			return ret;
        }
		buf_offset += (int)to_read;
		block_offset++;

		if(buf_size < emmc_get_dev_block_size()){
			buf_size = 0;
		}else{
			buf_size -= emmc_get_dev_block_size();
		}
	} while(buf_size > 0);
	return buf_offset;
}

