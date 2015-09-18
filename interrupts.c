
#include <stdint.h>
#include <stdbool.h>

#include "armtimer.h"
#include "base.h"
#include "gpio.h"
#include "interrupts.h"
#include "uart.h"
#include "control.h"
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
        uart_puts("Undefined mode!!!\r\n");
    }
}


/*
    Software interrupt handler. This switches to supervisor mode
*/
void __attribute__((interrupt("SWI"))) software_interrupt_vector(void* arg){
    uart_puts("SWI handler!\r\n");
    int swi_arg;
    asm volatile("ldrb %0, [lr, #-2]" : "=r"(swi_arg));
    uart_putc((uint32_t)arg);
    uart_putc(swi_arg);
    if(swi_arg == 77)
        uart_puts("swi arg is 77\r\n");
    get_cpu_mode();
    uart_puts("SWI handler ends! \r\n");
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
void __attribute__((interrupt("IRQ"))) interrupt_vector(void){
    static int lit = 0;
    get_cpu_mode();
    GetArmTimer()->IRQClear = 1;

    /* Flip the LED */
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
}

/*
    Fast irq handler
*/
void __attribute__((interrupt("FIQ"))) fast_interrupt_vector(void){

}
