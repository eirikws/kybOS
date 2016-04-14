#ifndef DIRENT_H
#define DIRENT_H

#include <stdint.h>

struct dirent{
    struct dirent *next;
    char *name;
    uint32_t byte_size;
    uint8_t is_dir;
    uint32_t cluster_no;
};

#endif

