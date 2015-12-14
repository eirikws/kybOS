#ifndef THREADING_H
#define THREADING_H

#include <stdint.h>
#include "pcb.h"
#include "control.h"

/*
    initialize
*/
int thread_register(void (*f)(void), size_t priority,size_t stack_space,
                                     process_id_t id, cpu_mode_t mode);

/*
    start it
*/
int thread_start( process_id_t id, void* arg);
#endif
