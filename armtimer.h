
#ifndef ARMTIMER_H
#define ARMTIMER_H

#include <stdint.h>
#include "base.h"

/*
    timer control bits
*/
#define ARMTIMER_CTRL_23BIT         ( 1 << 1 )
#define ARMTIMER_CTRL_PRESCALE_1    ( 0 << 2 ) | (0 << 3) 
#define ARMTIMER_CTRL_PRESCALE_16   ( 1 << 2 ) | (0 << 3)
#define ARMTIMER_CTRL_PRESCALE_256  ( 0 << 2 ) | (1 << 3)
#define ARMTIMER_CTRL_INT_ENABLE    ( 1 << 5 )
#define ARMTIMER_CTRL_INT_DISABLE   ( 0 << 5 )
#define ARMTIMER_CTRL_ENABLE        ( 1 << 7 )
#define ARMTIMER_CTRL_DISABLE       ( 0 << 7 )

/*
    timer irq_clear bits
*/
#define IRQ_CLEAR_PENDING           (0 << 0 )
#define IRQ_SET__PENDING            (1 << 0 )




typedef struct {
    // the value the counter will load to after reaching zero
    volatile uint32_t Load;
    // the current value of the counter
    volatile uint32_t Value;
    // control bits
    volatile uint32_t Control;
    // write to clear or set IRQ pending bit
    volatile uint32_t IRQClear;
    // read to get the status of IRQ_pending
    volatile uint32_t RAWIRQ;
    // the IRQ mask
    volatile uint32_t MaskedIRQ;
    // when reload is written to, counter will be set to this when it reaches zero
    volatile uint32_t Reload;
    // timer_clock = apb_clock/(pre_divider + 1)
    volatile uint32_t PreDivider;
    volatile uint32_t FreeRunningCounter;
} arm_timer_t;

arm_timer_t* GetArmTimer(void);
void ArmTimerInit(void);
void ArmTimer_interrupts_set(uint32_t freq);

#endif
