
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "process.h"
#include "memory.h"
#include "armtimer.h"
#include "base.h"
#include "gpio.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
#include "scheduler.h"
#include "ipc.h"
#include "system_calls.h"
#include "pcb.h"
#include "time.h"
#include "drivers.h"

#define INTERRUPT_CONTROLLER_BASE   ( PERIPHERAL_BASE + 0xB200 )

/*
    Put the interupt controller peripheral at it's base address
*/
static irq_controller_t* IRQController =
        (irq_controller_t*)INTERRUPT_CONTROLLER_BASE;

/*
     Return the IRQ Controller register set
*/
irq_controller_t* irq_controller_get( void ){
    return IRQController;
}

/*
    Software interrupt handler.
    return 1 for context switch
    return 0 for no context switch
*/
scheduling_type_t software_interrupt_vector_c(void* arg0, void* arg1, void* arg2, void* arg3){
    switch( (system_call_t)arg0) {
        case IPC_SEND: 
        // system_send(void* payload, uint32_t size, process_id_t coid)
        return system_send(arg1, (ipc_msg_config_t*)arg2);
        break;
        case IPC_SEND_DRIVER:
        // send a msg to driver
        return system_send_driver(arg1, (ipc_msg_config_driver_t*)arg2);
        break;
        case IPC_RECV:
        // system_receive(ipc_msg_t *recv_msg, uint32_t size, int* success)
        return system_receive(arg1, (uint32_t)arg2, (int*)arg3);
        break;
        case DUMMY:
        uart_puts("DUMMY CALL!!!\r\n");
        return NO_RESCHEDULE;
        break;
        case YIELD:
        return RESCHEDULE;
        break;
        case PRINT_STR:
        uart_puts((char*)arg1);
        return NO_RESCHEDULE;
        break;
        case PRINT_INT:
        uart_put_uint32_t((int)arg1, 10);
        return NO_RESCHEDULE;
        break;
        case EXIT:
        return process_kill( get_current_running_process() );
        break;
        case KILL:
        return process_kill( *(process_id_t*)arg1);
        break;
        case MMAP:
        // void* memory_map(void' location);
        return memory_map(arg1, (uint32_t)arg2, get_current_running_process());
        break;
        case DRIVER_REGISTER:
        // register a new driver
        return driver_register(get_current_running_process(), (char*)arg1, (int*)arg2);
        break;
        case SPAWN:
        return process_spawn( (spawn_args_t*)arg1); 
        break;
        case SRBK:
        return memory_srbk( (int)arg1, get_current_running_process());
        break;
    }
    uart_puts("Software irq vector c: did not find source of exception!\r\n");
    return 0;
}

/*
    Pefetch abort interrupt handler
*/
void prefetch_abort_vector_c( uint32_t origin, uint32_t stack ){
    uart_puts("prefetch abort from: ");
    uart_put_uint32_t(origin, 16);
    uart_puts(" with stack: ");
    uart_put_uint32_t(stack, 16);
    uart_puts("\r\n");
    process_kill( get_current_running_process() );
}

/*
    Data abort interrupt handler
*/
void data_abort_vector_c( uint32_t origin, uint32_t stack ){
    uart_puts("data abort from: ");
    uart_put_uint32_t(origin , 16);
    uart_puts(" with stack: ");
    uart_put_uint32_t(stack, 16);
    uart_puts("\r\n");
    process_kill( get_current_running_process() );
}

/*
    Undefined interrupt handler
*/
void undefined_instruction_vector_c(uint32_t origin, uint32_t stack){
    uart_puts("undefined mode from: ");
    uart_put_uint32_t(origin , 16);
    uart_puts("\r\n");
    process_kill( get_current_running_process());   
}

/*
    IRQ handler
*/
scheduling_type_t interrupt_vector_c(void){
//  find irq source
    irq_controller_t *irq_flags = irq_controller_get();
    //  timer
 /*   uart_put_uint32_t( uart_get()->MIS, 16);
    uart_puts("\r\n");
  */  if( irq_flags->IRQ_basic_pending & ARM_TIMER_IRQ ){
        // Do all timer things
        // message timer irq driver
        ipc_kernel_send(NULL, 0, driver_irq_get(DRIVER_TIMER));
        return time_handler();
    }
    // uart
    if ( irq_flags->IRQ_pending_2 & UART_IRQ){
        // Do all uart things
        ipc_kernel_send(NULL, 0, driver_irq_get(DRIVER_UART));
        return uart_handler();
    }
    static int i = 0;
    if( irq_flags->IRQ_pending_2 & GPIO_IRQ){
        if( i == 0){
            i++;
            test_begin();
        }
        return gpio_handler();
    }
    return 0;
}


/*
    Fast irq handler
*/
void __attribute__((interrupt("FIQ"))) fast_interrupt_vector(void){
    uart_puts("FIQ\r\n");
}

