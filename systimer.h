
#ifndef SYSTIMER_H
#define SYSTIMER_H

#include <stdint.h>

#include "base.h"

#define SYSTIMER_BASE       ( PERIPHERAL_BASE + 0x3000 )


typedef struct {
    volatile uint32_t control_status;
    volatile uint32_t counter_lo;
    volatile uint32_t counter_hi;
    volatile uint32_t compare0;
    volatile uint32_t compare1;
    volatile uint32_t compare2;
    volatile uint32_t compare3;
} sys_timer_t;


extern sys_timer_t* GetSystemTimer(void);
extern void WaitMicroSeconds( uint32_t us );

#endif
