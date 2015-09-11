
#include <stdint.h>
#include "systimer.h"

static sys_timer_t* SystemTimer = (sys_timer_t*)SYSTIMER_BASE;

sys_timer_t* GetSystemTimer(void)
{
    return SystemTimer;
}

void WaitMicroSeconds( uint32_t us )
{
    volatile uint32_t ts = SystemTimer->counter_lo;

    while( ( SystemTimer->counter_lo - ts ) < us )
    {
        /* BLANK */
    }
}
