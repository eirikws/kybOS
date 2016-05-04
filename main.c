#include <string.h>
#include <stdint.h>
#include <stdlib.h>

#include "system_calls.h"
#include "process.h"
#include "memory.h"
#include "fat.h"
#include "jtag.h"
#include "mmu.h"
#include "pcb.h"
#include "gpio.h"
#include "armtimer.h"
#include "interrupts.h"
#include "uart.h"
#include "fs.h"
#include "time.h"
#include "control.h"
#include "threading.h"
#include "emmc.h"

extern void _enable_interrupts(void);
void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);

void loop_forever_and_ever(void){
    int volatile i = 0;
    while(1){
        i++;   // do nothing
        if (i % 100000 == 0){
            uart_puts("loooooooooooooooooping in kernel forever and ever!\r\n");
        }
    }
}



/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    
    uart_init();
    _enable_interrupts();
    uart_puts("kernel start!\r\n");

    // enable jtag for debugging
    jtag_enable();
    // enable floting point module   
    cpu_fpu_enable();
    // initiate the OS clock
    uart_puts("initiating system clock and doing a wait for 1 seconds to check if it works\r\n");
    arm_timer_set_freq(1000);
    arm_timer_init();
    time_delay_microseconds(1000);
    uart_puts("you should now have waited 1 second\r\n");

    //delay(10000000);
    
    //init_pri_array();
    uart_puts("starting mmu\r\n");
    mmu_init_table();
    mmu_configure();
    cpu_control_config();
    uart_puts("mmu started\r\n");
    
    _SYSTEM_CALL(DUMMY,0,0,0);
    

    //  enable LED pin as an output 
    get_gpio()->LED_GPFSEL |= LED_GPFBIT;
    /* Enable interrupts! */
    
    uart_puts("initiating memory\r\n");
    memory_init();

    uart_puts("initiating filesystem emmc\r\n");
    fs_init();
    
    if(fs_get() == NULL){
        uart_puts("filesys is NULL!!!\r\n");
    }

        
    uart_puts("loading processes\r\n");
    process_load("prog1.elf", 20, CPSR_MODE_USER, (process_id_t){1});
    process_load("prog2.elf", 20, CPSR_MODE_USER, (process_id_t){2});
    process_load("prog3.elf",  0, CPSR_MODE_USER, (process_id_t){3});


    
    uart_puts("starting processes\r\n");
    pcb_print();
    //  starting them
    process_start( (process_id_t){2});
    process_start( (process_id_t){1});
    process_start( (process_id_t){3});
    

    scheduling_set(0);
    _SYSTEM_CALL(YIELD,0,0,0);
    
     /* Never exit as there is no OS to exit to! */
    loop_forever_and_ever();
}
