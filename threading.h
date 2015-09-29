#ifndef THREADING_H
#define THREADING_H

#include <stdint.h>

int threading_init(void);
int thread_start( uint32_t id, void* arg);
int thread_register(void (* f)(void), size_t priority,size_t stack_space, uint32_t id);

#endif
