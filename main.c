
#include <string.h>
#include <stdlib.h>

#include "gpio.h"
#include "armtimer.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
#include "pcb.h"
#include "threading.h"
#include "prog1.h"
#include "dispatcher.h"


extern void _generate_swi(void* arg);
extern void _enable_interrupts();

/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    
    uart_init();
    init_pri_array();
    uart_puts("kernel start!\r\n");
    //  enable LED pin as an output 
    GetGpio()->LED_GPFSEL |= LED_GPFBIT;
    /* Enable interrupts! */
    _enable_interrupts();
   
    get_cpu_mode();

    _set_cpu_mode(CPSR_MODE_USER | CPSR_FIQ_INHIBIT);
    get_cpu_mode();
    
    _generate_swi( (void*) 'a');
    uart_puts("registering threads\r\n");
    //  registering first threads!
    
    thread_register( prog1, 10,200, 1);
    //thread_register( prog2, 10,100, 2);
    uart_puts("starting threads\r\n");
    //  starting them
    thread_start( 1, 0);
    //thread_start( 2, 0);
    uart_puts("init threads\r\n");
    threading_init();
    
     /* Never exit as there is no OS to exit to! */
    while(1){ }
}



