
#include <string.h>
#include <stdlib.h>

#include "gpio.h"
#include "armtimer.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"


extern void _generate_swi(void* arg);
extern void _enable_interrupts();

/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    uart_init();
    uart_puts("Hello, World\r\n");
    //  enable LED pin as an output 
    GetGpio()->LED_GPFSEL |= LED_GPFBIT;

    //  enable the timer interrupt IRQ
    GetIrqController()->Enable_Basic_IRQs = ARM_TIMER_IRQ;

    /* Setup the system timer interrupt */
    /* Timer frequency = Clk/256 * LOAD */
    GetArmTimer()->Load = 0x800;
    
    /* Setup the ARM Timer */
    GetArmTimer()->Control =
            ARMTIMER_CTRL_23BIT |
            ARMTIMER_CTRL_ENABLE |
            ARMTIMER_CTRL_INT_ENABLE |
            ARMTIMER_CTRL_PRESCALE_256;

    /* Enable interrupts! */
    _enable_interrupts();
    uart_puts("Init done, led should be blinking!\r\n");
    /* Never exit as there is no OS to exit to! */
    char c;
    int i = 0;
    get_cpu_mode();
    _set_cpu_mode(CPSR_MODE_USER | CPSR_FIQ_INHIBIT);
    while(1){   
        c = uart_getc();
        //uart_puts("returning :");
        //uart_putc(c);
        //uart_puts("\r\n");
        if (i++ > 2){
            
            _generate_swi((void*)'a');
            i = 0;
        }
        get_cpu_mode();
        
    }
}



