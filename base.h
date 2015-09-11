#ifndef BASE_H
#define BASE_H

#include <stdint.h>

#define PERIPHERAL_BASE     0x3F000000UL


typedef volatile uint32_t reg_rw_t;
typedef volatile const uint32_t reg_ro_t;
typedef volatile uint32_t reg_wo_t;

typedef volatile uint64_t wreg_rw_t;
typedef volatile const uint64_t wreg_ro_t;

#endif
