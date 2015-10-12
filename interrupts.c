
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
    while( 1 )
    {
        uart_puts("Undefined mode1!!!\r\n");
        uart_puts("Undefined mode2!!!\r\n");
        uart_puts("Undefined mode3!!!\r\n");
    }
}


/*
    Software interrupt handler. This switches to supervisor mode
*/
void __attribute__((interrupt("SWI"))) 
            software_interrupt_vector(void* arg0, void* arg1, void* arg2, void* arg3){
    uart_puts("SWI handler! : ");
    /*
    uart_putc((uint32_t)arg0);
    uart_puts("\r\n");
    get_cpu_mode();
    uart_puts("SWI handler ends! \r\n");
    */
    uint32_t size;
    switch( (system_call_t)arg0) {
        case IPC_SEND:
        uart_puts("SWI send\r\n");
        //  setup for IPC:
            // set shared data ptrs do the message
            // wake up receiving thread
            // block the sending thread            
        void* msg = arg1;
        size = (uint32_t)arg2;
        uint32_t coid = (uint32_t)arg3;
        
        pcb_get(coid)->shared_data_ptr = msg;
        pcb_get(get_current_running())->state = BLOCKED;
        pcb_get(coid)->state = READY;
        _generate_dispatch();
        break;
        /*
        case DISPATCH:
        uart_puts("DISPATCH!\r\n");
        _generate_dispatch();
        uart_puts("After swi dispatch. should never get here...\r\n");
        break;
        */
        case IPC_RECV:
        uart_puts("SWI recv\r\n");
        ipc_msg_t* recv_msg = arg1;
        size = (uint32_t)arg2;
        int *success = (int*)arg3;
        PCB_t* my_pcb = pcb_get( get_current_running() );
        if (my_pcb->shared_data_ptr != NULL){
            memcpy( (void*)recv_msg, my_pcb->shared_data_ptr, size);
            my_pcb->shared_data_ptr=NULL;
            pcb_get(recv_msg->sender)->state=READY;
            *success = 1;
        }
        else{
            my_pcb->state = BLOCKED;
            *success = 0;
            _generate_dispatch();
        }
        break;
        
    }
    
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

}


void _ack_timer_irq(void){
    GetArmTimer()->IRQClear = 1;
    return;
}
