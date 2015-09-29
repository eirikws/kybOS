#ifndef DISPATCHER_H
#define DISPATCHER_H

#include <stdint.h>

#define NUM_PRIORITIES 64

int dispatch_enqueue(uint32_t id);
void dispatch(void);
uint32_t get_current_running(void);

#endif
