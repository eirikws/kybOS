#ifndef MEMORY_H
#define MEMORY_H

#include "stdint.h"

void memory_init(void);
void* memory_slot_get(void);
void memory_slot_free(void* addr);

#endif
