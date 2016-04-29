
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
#include "time.h"
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
    Reset handler
*/
void __attribute__((interrupt("ABORT"))) reset_vector(void){
    uart_puts("ABORT_interrupt!!\r\n");
    
}

/*
    Undefined interrupt handler
*/
void __attribute__((interrupt("UNDEF"))) undefined_instruction_vector(void){
    uint32_t origin;
    __asm volatile ("mov %[out], lr" : [out] "=r" (origin) ::);
    uart_puts("undefined mode from: ");
    uart_put_uint32_t(origin , 16);
    uart_puts("\r\n");
    
}


/*
    Software interrupt handler.
    return 1 for context switch
    return 0 for no context switch
*/
uint32_t software_interrupt_vector_c(void* arg0, void* arg1, void* arg2, void* arg3){
    switch( (system_call_t)arg0) {
        case IPC_SEND: 
        system_send(arg1, (uint32_t)arg2, *(process_id_t*)arg3);
        reschedule();
        return 1;
        break;
        case IPC_RECV:
        system_receive(arg1, (uint32_t)arg2);
        reschedule();
        return 1;
        break;
        case DUMMY:
        uart_puts("DUMMY CALL!!!\r\n");
        return 0;
        break;
        case YIELD:
        uart_puts("yield!\r\n");
        reschedule();
        return 1;
        break;
        case PRINT:
        uart_puts(arg1);
        return 0;
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
}


/*
    IRQ handler
*/
uint32_t interrupt_vector_c(void){
   /****************************************   OLD
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
    
        // do uart stuff
        uart_get()->ICR = RECEIVE_CLEAR;
        c = uart_getc();
        if (c == '\r'){
            uart_putc('\n');
            uart_putc(c);
        }else{   uart_putc(c);}
    
    }   OLD       ***********************/

//  find irq source

    irq_controller_t *irq_flags = irq_controller_get();
    //  timer
    if( irq_flags->IRQ_basic_pending & ARM_TIMER_IRQ ){
        // Do all timer things
        return time_handler();
    }
    // uart
    if ( irq_flags->IRQ_pending_2 & UART_IRQ){
        // Do all uart things
        return uart_handler();
    }
    return 0;
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
