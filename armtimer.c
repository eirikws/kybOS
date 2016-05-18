
#include <stdint.h>
#include "armtimer.h"
#include "interrupts.h"

#define ARMTIMER_BASE               ( PERIPHERAL_BASE + 0xB400 )
#define SYSTEM_CLOCK                (2000000)


static int arm_timer_freq;
static arm_timer_t* ArmTimer = (arm_timer_t*)ARMTIMER_BASE;

int arm_timer_get_freq(void){
    return arm_timer_freq;
}


static arm_timer_t* arm_timer_get(void){
    return ArmTimer;
}

void arm_timer_irq_ack(void){
    arm_timer_get()->IRQClear = 1;
    return;
}

void arm_timer_set_freq(int freq){   
    /* Setup the system timer interrupt */
    /* Timer frequency = Clk/256 * LOAD */
    /* Clk = 1 GHz (set in config.txt) */
    /* Load = frquency * 256 / clk  */
    arm_timer_get()->Load = ( SYSTEM_CLOCK / 256) / freq;
    arm_timer_freq = freq;
}

void arm_timer_init(void){
    //  enable the timer interrupt IRQ
    irq_controller_get()->Enable_Basic_IRQs |= ARM_TIMER_IRQ;
    
    arm_timer_get()->Control =
            ARMTIMER_CTRL_23BIT |
            ARMTIMER_CTRL_ENABLE |
            ARMTIMER_CTRL_INT_ENABLE |
            ARMTIMER_CTRL_PRESCALE_256;
}

