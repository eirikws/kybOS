
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
extern void _mmu_test(void);
extern uint32_t _get_user_sp();
extern uint32_t _get_stack_pointer();

void loop_forever_and_ever(void){
    int volatile i = 0;
    while(1){
        i++;   // do nothing
        if (i % 1000 == 0){
            uart_puts("Doing NOTHING, MUAHAHHAHAHAHAHAHAHAHAHHAHAHAHAHAHAHAHAHAHAHAHAHA\r\n");
        }
    }
}

/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    
    uart_init();
    
    uart_puts("kernel start!\r\n");
    uart_puts("itoa test: ");
    uart_puts("     binary:");
    uart_put_uint32_t(0xFFFFFFFF, 2);
    uart_puts("     decimal:");
    uart_put_uint32_t(0xFFFFFFFF, 10);
    uart_puts("     hexadecimal:");
    uart_put_uint32_t(0xFFFFFFFF, 16);
    uart_puts("\r\n");
    
    
    
    jtag_enable();
    
    delay(10000000);
    
    
    init_pri_array();
    uart_puts("starting mmu\r\n");
    mmu_init_table();
    mmu_init();
    uart_puts("mmu started\r\n");
    
    //  enable LED pin as an output 
    GetGpio()->LED_GPFSEL |= LED_GPFBIT;
    /* Enable interrupts! */
    _enable_interrupts();

    //_set_cpu_mode(CPSR_MODE_USER | CPSR_FIQ_INHIBIT);
    uart_puts("registering threads\r\n");
    //  registering first threads!
    thread_register( prog2, 10,1000, 2);
    thread_register( prog1, 10,1000, 1);
    thread_register( prog3, 1,1000, 3);
    uart_puts("starting threads\r\n");
    //  starting them
    thread_start( 1, 0);
    thread_start( 2, 0);
    thread_start( 3, 0);
    threading_init();
    
    
     /* Never exit as there is no OS to exit to! */
    loop_forever_and_ever();
}



