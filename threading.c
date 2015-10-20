
#include <stdlib.h>

#include "pcb.h"
#include "dispatcher.h"
#include "threading.h"
#include "armtimer.h"
#include "interrupts.h"
#include "control.h"

extern void _pcb_set_arg(PCB_t* pcb, void* arg);
extern uint32_t _init_thr_stack(uint32_t sp, uint32_t function, uint32_t cpsr);

int threading_init(void){
    //  enable the timer interrupt IRQ
    GetIrqController()->Enable_Basic_IRQs |= ARM_TIMER_IRQ;

    /* Setup the system timer interrupt */
    /* Timer frequency = Clk/256 * LOAD */
    /* Clk = 3000000?, 7 000 000 in config.txt , baud rate = 115200*/
    GetArmTimer()->Load = 0x2;
    /* Setup the ARM Timer */
    GetArmTimer()->Control =
            ARMTIMER_CTRL_23BIT |
            ARMTIMER_CTRL_ENABLE |
            ARMTIMER_CTRL_INT_ENABLE |
            ARMTIMER_CTRL_PRESCALE_256;
}

int thread_register(void (* f)(void), size_t priority,size_t stack_space, uint32_t id){
    // make process controll block
    PCB_t pcb = {   .id = id, .state = READY, .priority = priority};
    // allocate stack pointer and space
    void* stack_pointer = malloc(stack_space);
    if (stack_pointer == NULL){
        uart_puts("stack pointer allocation failed\r\n");
        return -1;
    }
    uart_puts("prog starts at ");
    uart_put_uint32_t((uint32_t)f, 16);
    uart_puts("\r\n");
    pcb.context_data.SP =(uint32_t) stack_pointer + stack_space;
    pcb.state = READY;
    uart_puts("stack pointer is: ");
    uart_put_uint32_t( pcb.context_data.SP, 16);
    uart_puts("\r\n");
    //  need to initialize the stack to the right size
    //  and put the link register in there
    pcb.context_data.SP = _init_thr_stack( pcb.context_data.SP, (uint32_t)f, CPSR_MODE_USER);
    uart_puts("initialized sp is: ");
    uart_put_uint32_t( pcb.context_data.SP, 16);
    uart_puts("\r\n");
    // push it
    pcb_insert(pcb);
    return 1;
}

int thread_start( uint32_t id, void* arg){
    PCB_t* pcb = pcb_get(id);
    if (pcb == NULL){
        uart_puts("pcb NULL\r\n");
        return -1;
    }
    dispatch_enqueue(id);
}
