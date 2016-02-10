
#include <stdlib.h>

#include "pcb.h"
#include "scheduler.h"
#include "threading.h"
#include "control.h"

extern uint32_t _init_thr_stack(uint32_t sp, uint32_t function, uint32_t cpsr);

int thread_register(void (* f)(void), size_t priority,size_t stack_space,
                                     process_id_t id, cpu_mode_t mode){
    // make process controll block
    PCB_t pcb = {   .id = id, .state = READY, .priority = priority};
    // allocate stack pointer and space
    void* stack_pointer = malloc(stack_space);
    if (stack_pointer == NULL){
        uart_puts("stack pointer allocation failed\r\n");
        return -1;
    }
    pcb.context_data.SP =(uint32_t) stack_pointer + stack_space;
    pcb.state = READY;
    //  need to initialize the stack to the right size
    //  and put the link register in there
    pcb.context_data.SP = _init_thr_stack(  pcb.context_data.SP,
                                            (uint32_t)f,
                                            mode);
    pcb_insert(pcb);
    uart_puts("thread allocaded. stack at ");
    uart_put_uint32_t(pcb.context_data.SP, 16);
    uart_puts(" and program start at ");
    uart_put_uint32_t((uint32_t)f, 16);
    uart_puts("\r\n");
    return 1;
}

int thread_start( process_id_t id, void* arg){
    PCB_t* pcb = pcb_get(id);
    if (pcb == NULL){
        uart_puts("pcb NULL\r\n");
        return -1;
    }
    scheduler_enqueue(id);
}
