
#include <stdlib.h>

#include "pcb.h"
#include "dispatcher.h"
#include "threading.h"
#include "armtimer.h"
#include "interrupts.h"
#include "control.h"

extern _pcb_set_arg(PCB_t* pcb, void* arg);

int threading_init(void){
    //  enable the timer interrupt IRQ
    GetIrqController()->Enable_Basic_IRQs |= ARM_TIMER_IRQ;

    /* Setup the system timer interrupt */
    /* Timer frequency = Clk/256 * LOAD */
    GetArmTimer()->Load = 0x800;
    /* Setup the ARM Timer */
    GetArmTimer()->Control =
            ARMTIMER_CTRL_23BIT |
            ARMTIMER_CTRL_ENABLE |
            ARMTIMER_CTRL_INT_ENABLE |
            ARMTIMER_CTRL_PRESCALE_256;
}

int thread_register(void (* f)(void), size_t priority,size_t stack_space, int32_t id){
    // make process controll block
    PCB_t pcb = {   .id = 1, .state = READY, .priority = priority};
    
    // allocate stack pointer and space
    void* stack_pointer = malloc(stack_space);
    if (stack_pointer == NULL){
        uart_puts("stack pointer allocation failed\r\n");
        return -1;
    }
    
    pcb.context_data.SP =(uint32_t) stack_pointer - stack_space;
    // set lr to point to the program
    pcb.context_data.LR = (uint32_t)f;
    // set cpsr to user mode
    pcb.context_data.CPSR = _get_cpsr();
    pcb.context_data.CPSR |= CPSR_MODE_USER;
    // push it to the data structure
    pcb_insert(pcb);
    return 1;
}

int thread_start( int32_t id, void* arg){
    PCB_t* pcb = pcb_get(id);
    uart_puts("setting args1\r\n");
    if (pcb == NULL){ return -1;}
    uart_puts("setting args2\r\n");
    _pcb_set_arg(pcb,arg);
    dispatch_enqueue(id);
}
