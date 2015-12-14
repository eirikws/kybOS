
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "armtimer.h"
#include "base.h"
#include "gpio.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
#include "scheduler.h"
#include "ipc.h"
#include "pcb.h"
#define INTERRUPT_CONTROLLER_BASE   ( PERIPHERAL_BASE + 0xB200 )


/*
    Put the interupt controller peripheral at it's base address
*/
static irq_controller_t* IRQController =
        (irq_controller_t*)INTERRUPT_CONTROLLER_BASE;


/*
     Return the IRQ Controller register set
*/
irq_controller_t* GetIrqController( void ){
    return IRQController;
}

/*
    Reset handler
*/
void __attribute__((interrupt("ABORT"))) reset_vector(void){
    uart_puts("ABORT_interrupt!!\r\n");
    
}

/*
    Undefined interrupt handler
*/
void __attribute__((interrupt("UNDEF"))) undefined_instruction_vector(void){
    uart_puts("undefined mode!\r\n");
}


/*
    Software interrupt handler. This switches to supervisor mode
*/
void software_interrupt_vector_c(void* arg0, void* arg1, void* arg2, void* arg3){
    uint32_t size;
    switch( (system_call_t)arg0) {
        case IPC_SEND: 
        system_send(arg1, (uint32_t)arg2, *(process_id_t*)arg3);
        break;
        case IPC_RECV:
        system_receive(arg1, (uint32_t)arg2, (int*)arg3);
        break;
        case DUMMY:
        uart_puts("DUMMY CALL!!!\r\n");
        break;
    }
    return;
}


/*
    Pefetch abort interrupt handler
*/
void __attribute__((interrupt("ABORT"))) prefetch_abort_vector(void){
    uart_puts("prefetch abort\r\n");
}


/*
    Data abort interrupt handler
*/
void __attribute__((interrupt("ABORT"))) data_abort_vector(void){
    uart_puts("data abort\r\n");
}


/*
    IRQ handler
*/
void interrupt_vector_c(void){
    char c;
    static int lit = 0;
    if( lit ){
        get_gpio()->LED_GPSET = (1 << LED_GPIO_BIT);
        lit = 0;
    } else {
        get_gpio()->LED_GPCLR = (1 << LED_GPIO_BIT);
        lit = 1;
    }

    
    if (GetIrqController()->IRQ_pending_2 & UART_IRQ){
    
        uart_get()->ICR = RECEIVE_CLEAR;
        c = uart_getc();
        uart_puts("interrupt\r\n");
    /*
        // do uart stuff
        uart_get()->ICR = RECEIVE_CLEAR;
        c = uart_getc();
        if (c == '\r'){
            uart_putc('\n');
            uart_putc(c);
        }else{   uart_putc(c);}
    */
    }
    
    return;
}

/*
    called everytime there is a timer interrupt, and
    when there is a yield system call
*/
uint32_t timer_handler_c(uint32_t stack_pointer) {
    // we want to call the scheduler, which will return
    // with the correct stack pointer of the process we switch to
    // save current stack pointer in PCB
    save_stack_ptr(get_current_running(), stack_pointer);
    process_id_t new_process = schedule();
    return pcb_get(new_process)->context_data.SP;
}

/*
    Fast irq handler
*/
void __attribute__((interrupt("FIQ"))) fast_interrupt_vector(void){
    uart_puts("FIQ\r\n");
}

int _get_yield_val(void){
    return YIELD;
}
