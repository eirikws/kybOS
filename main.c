
#include <string.h>
#include <stdlib.h>

#include "pcb.h"
#include "gpio.h"
#include "armtimer.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
#include "threading.h"
#include "prog1.h"

extern void _enable_interrupts();
void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);

void loop_forever_and_ever(void){
    int volatile i = 0;
    while(1){
        i++;   // do nothing
        if (i % 1000 == 0){}
    }
}

/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    
    uart_init();
    _enable_interrupts();
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
    
    //delay(10000000);
    
    
    init_pri_array();
    uart_puts("starting mmu\r\n");
    mmu_init_table();
    mmu_init();
    uart_puts("mmu started\r\n");
    
    _SYSTEM_CALL(DUMMY,0,0,0);
    
    //  enable LED pin as an output 
    get_gpio()->LED_GPFSEL |= LED_GPFBIT;
    /* Enable interrupts! */
    
    

    //_set_cpu_mode(CPSR_MODE_USER | CPSR_FIQ_INHIBIT);
    uart_puts("registering threads\r\n");
    //  registering first threads!
    thread_register( prog2, 10,1000, (process_id_t){2}, CPSR_MODE_USER);
    thread_register( prog1, 10,1000, (process_id_t){1}, CPSR_MODE_USER);
    thread_register( prog3, 1 ,1000, (process_id_t){3}, CPSR_MODE_USER);
    uart_puts("starting threads\r\n");
    pcb_print();
    //  starting them
    thread_start( (process_id_t){1}, 0);
    thread_start( (process_id_t){2}, 0);
    thread_start( (process_id_t){3}, 0);
    uart_puts("threads_started. starting timer irqs\r\n");
    arm_timer_set_frq(1);
    arm_timer_init();
    _SYSTEM_CALL(YIELD,0,0,0);
    
     /* Never exit as there is no OS to exit to! */
    loop_forever_and_ever();
}



