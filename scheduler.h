#ifndef SCHEDULER_H
#define SCHEDULER_H

#include <stdint.h>
#include "pcb.h"


void reschedule(void);
int scheduler_enqueue(process_id_t id);
process_id_t get_current_running_process(void);
void priority_print_list(void);
#endif
