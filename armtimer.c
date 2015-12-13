
#include <stdint.h>
#include "armtimer.h"
#include "interrupts.h"

#define ARMTIMER_BASE               ( PERIPHERAL_BASE + 0xB400 )

static arm_timer_t* ArmTimer = (arm_timer_t*)ARMTIMER_BASE;

static arm_timer_t* arm_timer_get(void){
    return ArmTimer;
}

void arm_timer_irq_ack(void){
    arm_timer_get()->IRQClear = 1;
    return;
}

void arm_timer_set_frq(int freq){   
    /* Setup the system timer interrupt */
    /* Timer frequency = Clk/256 * LOAD */
    /* Clk = 3000000?, 7 000 000 in config.txt , baud rate = 115200*/
    arm_timer_get()->Load = 0x2000;
    /* Setup the ARM Timer */
    
}

void arm_timer_init(void){
    //  enable the timer interrupt IRQ
    GetIrqController()->Enable_Basic_IRQs |= ARM_TIMER_IRQ;
    
    arm_timer_get()->Control =
            ARMTIMER_CTRL_23BIT |
            ARMTIMER_CTRL_ENABLE |
            ARMTIMER_CTRL_INT_ENABLE |
            ARMTIMER_CTRL_PRESCALE_256;
}
