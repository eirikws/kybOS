#ifndef PROCESS_H
#define PROCESS_H

#include <stdint.h>
#include "scheduler.h"
#include "pcb.h"

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

/*
 * spawn a new process
 */
scheduling_type_t process_spawn( spawn_args_t *args);

/*
 * load a elf file into a process
 */
int process_load(const char* file_path, size_t priority, int mode, process_id_t id);

/*
 * start process
 */
int process_start(process_id_t id);

/*
 * kill a process
 */
scheduling_type_t process_kill(process_id_t id);

#endif

