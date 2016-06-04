#include <string.h>
#include <stdint.h>
#include <stdlib.h>

#include "drivers.h"
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
#include "emmc.h"

extern void _enable_interrupts(void);
void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);



/* Main function - we'll never return from here */
void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags ){
    
    uart_init();
    gpio_init();
    _enable_interrupts();
    uart_puts("kernel start!\r\n");
    drivers_init();

    uart_puts("enabling jtag\r\n");
    // enable jtag for debugging
    jtag_enable();
    // initiate the OS clock
    uart_puts("initiating system clock\r\n");
    arm_timer_set_freq(1000);
    arm_timer_init();
    uart_puts("starting mmu\r\n");
    mmu_init_table();
    mmu_configure();
    cpu_control_config();
    uart_puts("mmu started\r\n");
    
    _SYSTEM_CALL(DUMMY,0,0,0);
    

    
    uart_puts("initiating memory\r\n");
    memory_init();

    uart_puts("initiating filesystem emmc\r\n");
    fs_init();
    
   // gpio_test();

    if(fs_get() == NULL){
        uart_puts("filesys is NULL!!!\r\n");
    }
        
    uart_puts("loading process 1\r\n");
/*    process_load("prog1.elf", 20, CPSR_MODE_USER, (process_id_t){1});
    uart_puts("loading process 2\r\n");
    process_load("prog2.elf", 20, CPSR_MODE_USER, (process_id_t){2});
    uart_puts("loading gpio_driver\r\n");
*/    process_load("gpio.elf", 22, CPSR_MODE_USER, (process_id_t){4});
    process_load("prog3.elf", 1, CPSR_MODE_USER, (process_id_t){5});
  //  uart_puts("loading process 3\r\n");
   // process_load("prog3.elf",  0, CPSR_MODE_USER, (process_id_t){3});


    
    uart_puts("starting processes\r\n");
    pcb_print();
    //  starting them
/*    process_start( (process_id_t){2});
    process_start( (process_id_t){1});
  */  process_start( (process_id_t){4});
    process_start((process_id_t){5});
 //   process_start( (process_id_t){3});
    

    set_preemptive_timer(0);
    /*  call yield and never return*/
    _SYSTEM_CALL(YIELD,0,0,0);
}
