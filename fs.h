#ifndef FS_H
#define FS_H

#include "dirent.h"
#include <stdio.h>
#include <stdint.h>
#include "block.h"

#define FS_FLAG_SUPPORTS_EMPTY_FNAME		1


struct fs {
	const char *fs_name;
    
    int     (*fs_load)(struct fs *, struct dirent *, char * name, uint8_t buf);
	struct dirent *(*enter_dir)(struct fs *, char *name);
};

#endif
