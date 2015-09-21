#ifndef THREADING_H
#define THREADING_H

int thread_create(void*(* program), size_t priority,size_t stack_space, char* id);


#endif
