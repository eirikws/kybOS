
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "armtimer.h"
#include "base.h"
#include "gpio.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
#include "dispatcher.h"
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
    //uart_puts("SWI handler!\r\n");
    /*
    uart_putc((uint32_t)arg0);
    uart_puts("\r\n");
    get_cpu_mode();
    uart_puts("SWI handler ends! \r\n");
    */
    uint32_t size;
    switch( (system_call_t)arg0) {
        case IPC_SEND:    
        //uart_puts("swi ipc send\r\n");      
        system_send(arg1, (uint32_t)arg2, (uint32_t)arg3);
        break;
        case IPC_RECV:
        //uart_puts("swi ipc recv\r\n");  
        system_receive(arg1, (uint32_t)arg2, (int*)arg3);
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
        GetGpio()->LED_GPSET = (1 << LED_GPIO_BIT);
        lit = 0;
    } else {
        GetGpio()->LED_GPCLR = (1 << LED_GPIO_BIT);
        lit = 1;
    }
    

    
    if (GetIrqController()->IRQ_pending_2 & UART_IRQ){
    
        GetUartController()->ICR = RECEIVE_CLEAR;
        c = uart_getc();
        uart_puts("interrupt\r\n");
    /*
        // do uart stuff
        GetUartController()->ICR = RECEIVE_CLEAR;
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
    Fast irq handler
*/
void __attribute__((interrupt("FIQ"))) fast_interrupt_vector(void){
    uart_puts("FIQ\r\n");
}


void _ack_timer_irq(void){
    GetArmTimer()->IRQClear = 1;
    return;
}

int _get_dispatch_val(void){
    return DISPATCH;
}
