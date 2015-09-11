
#include <string.h>
#include <stdlib.h>

#include "gpio.h"
#include "armtimer.h"
#include "systimer.h"
#include "interrupts.h"

/** Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags )
{
    //  enable LED pin as an output 
    GetGpio()->LED_GPFSEL |= LED_GPFBIT;

    //  enable the timer interrupt IRQ
    GetIrqController()->Enable_Basic_IRQs = ARM_TIMER_IRQ;

    /* Setup the system timer interrupt */
    /* Timer frequency = Clk/256 * 0x400 */
    GetArmTimer()->Load = 0x400;

    /* Setup the ARM Timer */
    GetArmTimer()->Control =
            ARMTIMER_CTRL_23BIT |
            ARMTIMER_CTRL_ENABLE |
            ARMTIMER_CTRL_INT_ENABLE |
            ARMTIMER_CTRL_PRESCALE_256;

    /* Enable interrupts! */
    _enable_interrupts();

    /* Never exit as there is no OS to exit to! */
    while(1)
    {
        // NOTHING FOREVER ND EVER!!
    }
}
