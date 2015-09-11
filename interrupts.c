
#include <stdint.h>
#include <stdbool.h>

#include "armtimer.h"
#include "base.h"
#include "gpio.h"
#include "interrupts.h"

    //  Put the interupt controller peripheral at it's base address
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

}

/*
    Undefined interrupt handler
*/
void __attribute__((interrupt("UNDEF"))) undefined_instruction_vector(void){
    while( 1 )
    {
        /* Do Nothing! */
    }
}


/*
    Software interrupt handler. This switches to supervisor mode
*/
void __attribute__((interrupt("SWI"))) software_interrupt_vector(void){
    while( 1 )
    {
        /* Do Nothing! */
    }
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

    GetArmTimer()->IRQClear = 1;

    /* Flip the LED */
    if( lit )
    {
        LED_OFF();
        lit = 0;
    }
    else
    {
        LED_ON();
        lit = 1;
    }
}

/*
    Fast irq handler
*/
void __attribute__((interrupt("FIQ"))) fast_interrupt_vector(void){

}
