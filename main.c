
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
extern uint32_t _get_user_sp();
extern uint32_t _get_stack_pointer();

void loop_forever_and_ever(void){
    int volatile i = 0;
    while(1){
        i++;   // do nothing
    }
}

/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    uart_init();
    uart_puts("kernel start!\r\n");
    init_pri_array();
    //  enable LED pin as an output 
    GetGpio()->LED_GPFSEL |= LED_GPFBIT;
    /* Enable interrupts! */
    _enable_interrupts();

    _set_cpu_mode(CPSR_MODE_SYSTEM | CPSR_FIQ_INHIBIT);
    uart_puts("registering threads\r\n");
    //  registering first threads!
    thread_register( prog2, 10,1000, 2);
    priority_print_list();
    thread_register( prog1, 10,1000, 1);
    thread_register( prog3, 1,1000, 3);
    priority_print_list();
    uart_puts("starting threads\r\n");
    //  starting them
    thread_start( 1, 0);
    thread_start( 2, 0);
    thread_start( 3, 0);
    uart_puts("init threads\r\n");
    //pcb_print();
    threading_init();
    uart_puts("threads initiated\r\n");
    
    
     /* Never exit as there is no OS to exit to! */
    loop_forever_and_ever();
}



