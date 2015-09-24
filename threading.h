#ifndef THREADING_H
#define THREADING_H

int threading_init(void);
int thread_create(void (* f)(void), size_t priority,size_t stack_space, char* id);
int thread_register(void (* f)(void), size_t priority,size_t stack_space, int32_t id);

#endif
