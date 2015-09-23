#ifndef DISPATCHER_H
#define DISPATCHER_H

#include <stdint.h>

#define NUM_PRIORITIES 64

int dispatch_enqueue(int32_t id);
void dispatch(void);


#endif
