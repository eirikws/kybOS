
#ifndef ARMTIMER_H
#define ARMTIMER_H

#include <stdint.h>

#include "base.h"

#define ARMTIMER_BASE               ( PERIPHERAL_BASE + 0xB400 )
#define ARMTIMER_CTRL_23BIT         ( 1 << 1 )
#define ARMTIMER_CTRL_PRESCALE_1    ( 0 << 2 )
#define ARMTIMER_CTRL_PRESCALE_16   ( 1 << 2 )
#define ARMTIMER_CTRL_PRESCALE_256  ( 2 << 2 )
#define ARMTIMER_CTRL_INT_ENABLE    ( 1 << 5 )
#define ARMTIMER_CTRL_INT_DISABLE   ( 0 << 5 )
#define ARMTIMER_CTRL_ENABLE        ( 1 << 7 )
#define ARMTIMER_CTRL_DISABLE       ( 0 << 7 )


typedef struct {
    volatile uint32_t Load;
    volatile uint32_t Value;
    volatile uint32_t Control;
    volatile uint32_t IRQClear;
    volatile uint32_t RAWIRQ;
    volatile uint32_t MaskedIRQ;
    volatile uint32_t Reload;
    volatile uint32_t PreDivider;
    volatile uint32_t FreeRunningCounter;
} arm_timer_t;

extern arm_timer_t* GetArmTimer(void);
extern void ArmTimerInit(void);

#endif
