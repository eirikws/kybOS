#ifndef DISPATCHER_H
#define DISPATCHER_H

#include <stdint.h>
#include "pcb.h"


process_id_t schedule(void);
int dispatch_enqueue(process_id_t id);
//uint32_t dispatch(uint32_t stack_pointer);
process_id_t get_current_running_process(void);
void priority_print_list(void);
#endif
