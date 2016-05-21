#ifndef PROCESS_H
#define PROCESS_H

#include <stdlib.h>
#include "system_calls.h"

typedef enum{
    SPAWN_USER,
    SPAWN_SUPERVISOR,
}spawn_mode_t;

typedef struct{
    char* path;
    process_id_t id;
    spawn_mode_t mode;
    size_t priority;
    int flags;
}spawn_args_t;

// return flags, indicate errors
#define SPAWN_MODE_ERROR        (1 << 0)    // something wrong with arg mode
#define SPAWN_LOAD_ERROR        (1 << 1)    // someething wrong with the file or path
#define SPAWN_ID_OCCUPIED       (1 << 2)    // ID is already occupied

void process_spawn( spawn_args_t *args);

#endif

