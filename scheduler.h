#ifndef SCHEDULER_H
#define SCHEDULER_H

#include <stdint.h>
#include "pcb.h"


/* 
 * these values must not be saved
 * they are hardcoded in the assembler
 * context switch functions in start.S
 */
typedef enum{
    NO_RESCHEDULE                   = 0,
    RESCHEDULE                      = 1,
    RESCHEDULE_DONT_SAVE_CONTEXT    = 2,
}scheduling_type_t;

void reschedule(void);
int scheduler_enqueue(process_id_t id);
process_id_t get_current_running_process(void);
void test_begin(void);
#endif
