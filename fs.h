#ifndef FS_H
#define FS_H

#include "dirent.h"
#include <stdio.h>
#include <stdint.h>


struct fs {
	const char *fs_name;
    int     (*fs_load)(struct fs *, char *path, uint8_t *buf, uint32_t buf_size);
    int     (*fs_store)(struct fs *, char *path, uint8_t *buf);
	struct dirent *(*enter_dir)(struct fs *, char *name);
};

#endif
