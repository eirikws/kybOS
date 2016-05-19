#ifndef PROCESS_H
#define PROCESS_H

#include <stdint.h>
#include "scheduler.h"
#include "pcb.h"


int process_load(const char* file_path, size_t priority, int mode, process_id_t id);

int process_start(process_id_t id);

scheduling_type_t process_kill(process_id_t id);

#endif
