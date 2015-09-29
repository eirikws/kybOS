
#include <stdint.h>

#include "armtimer.h"
#include "base.h"
#include "gpio.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
#include "dispatcher.h"
#define INTERRUPT_CONTROLLER_BASE   ( PERIPHERAL_BASE + 0xB200 )


typedef enum{
    IPC_SEND,
} swi_t;

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
    while( 1 )
    {
        uart_puts("Undefined mode!!!\r\n");
    }
}


/*
    Software interrupt handler. This switches to supervisor mode
*/
void __attribute__((interrupt("SWI"))) 
            software_interrupt_vector(void* arg0, void* arg1, void* arg2, void* arg3){
    uart_puts("SWI handler! : ");
    uart_putc((uint32_t)arg0);
    uart_puts("\r\n");
    get_cpu_mode();
    uart_puts("SWI handler ends! \r\n");
    /*
    if ( (swi_t)arg0 == IPC_SEND){
        pcb_get( (uint32_t)arg3 )->shared_data_ptr = smsg;
        pcb_get(get_current_running()->state = BLOCKED;
        //  generate timer interrupt
        
    }
    */
    return;
}


/*
    Pefetch abort interrupt handler
*/
void __attribute__((interrupt("ABORT"))) prefetch_abort_vector(void){

}


/*
    Data abort interrupt handler
*/
void __attribute__((interrupt("ABORT"))) data_abort_vector(void){

}


/*
    IRQ handler
*/
void interrupt_vector_c(void){
    static int lit = 0;
    char c;
    //if (GetIrqController()->IRQ_basic_pending & ARM_TIMER_IRQ){
    //    GetArmTimer()->IRQClear = 1;
        if( lit )
        {
            GetGpio()->LED_GPSET = (1 << LED_GPIO_BIT);
            lit = 0;
        }
        else
        {
            GetGpio()->LED_GPCLR = (1 << LED_GPIO_BIT);
            lit = 1;
        }
        uart_puts("starting_dispatch\r\n");
        dispatch();
   // }
    /*
    if (GetIrqController()->IRQ_pending_2 & UART_IRQ){
        // do uart stuff
        GetUartController()->ICR = RECEIVE_CLEAR;
        c = uart_getc();
        if (c == '\r'){
            uart_putc('\n');
            uart_putc(c);
        }else{   uart_putc(c);}
        
    }
    */
    uart_puts("irq done\r\n");

    return;
}

/*
    Fast irq handler
*/
void __attribute__((interrupt("FIQ"))) fast_interrupt_vector(void){

}


void _ack_irq(void){
    GetArmTimer()->IRQClear = 1;
    return;
}
