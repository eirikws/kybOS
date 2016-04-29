#ifndef FS_H
#define FS_H

#include "dirent.h"
#include <stdio.h>
#include <stdint.h>


struct fs {
	const char *fs_name;
    int     (*fs_load)(const char *path, uint8_t *buf, uint32_t buf_size);
    int     (*fs_store)(const char *path, uint8_t *buf);
};

void fs_init(void);
struct fs *fs_get(void);

#endif
