#include <string.h>
#include <stdint.h>
#include <stdlib.h>

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
#include "prog1.h"
#include "emmc.h"

extern void _enable_interrupts(void);
void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);
//int fat_init( struct fs ** filesys);


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
    
    uart_puts("sizeof int64_t");
    uart_put_uint32_t(sizeof(uint64_t), 10);
    uart_puts("\r\n");

    // enable jtag for debugging
    jtag_enable();
    
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
    
    uart_puts("enabling emmc\r\n");
    emmc_init();

    uart_puts("initiating FAT\r\n");
    struct fs* filesys = NULL;
    fat_init(&filesys);

    if(filesys == NULL){
        uart_puts("filesys is NULL!!!\r\n");
    }

    uart_puts("trying to load \r\n");
    uart_puts(filesys->fs_name);
    uart_puts("\r\n");


    filesys->fs_load(filesys, "test/hehe.txt", (uint8_t)0x3000);

    uart_puts("registering threads\r\n");
    //  registering first threads!
    
    thread_register( prog4, 10, 1000, (process_id_t){4}, CPSR_MODE_USER);
   // thread_register( prog2, 10,1000, (process_id_t){2}, CPSR_MODE_USER);
   // thread_register( prog2, 10,1000, (process_id_t){1}, CPSR_MODE_USER);
   // thread_register( prog3, 1 ,1000, (process_id_t){3}, CPSR_MODE_USER);
    
    uart_puts("starting threads\r\n");
    pcb_print();
    //  starting them
    
    thread_start( (process_id_t){4}, 0);          
   // thread_start( (process_id_t){1}, 0);
   // thread_start( (process_id_t){2}, 0);
   // thread_start( (process_id_t){3}, 0);          
    
    scheduling_set(1);
    uart_puts("threads_started. starting timer irqs\r\n");
    _SYSTEM_CALL(YIELD,0,0,0);
    
     /* Never exit as there is no OS to exit to! */
    loop_forever_and_ever();
}
