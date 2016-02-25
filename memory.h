#ifndef MEMORY_H
#define MEMORY_H

#include "stdint.h"

void memory_init(void);

uint32_t memory_map(void);
void memory_unmap(uint32_t mem);


#endif
