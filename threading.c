
#include <stdlib.h>

#include "pcb.h"
#include "dispatcher.h"
#include "threading.h"

extern _pcb_set_arg(PCB_t* pcb, void* arg);

int thread_register(void*(* program), size_t priority,size_t stack_space, int32_t id){
    // make process controll block
    PCB_t pcb = {   .id = 1, .state = READY, .priority = priority};
    
    // allocate stack pointer and space
    void* stack_pointer = malloc(stack_space);
    if (stack_pointer == NULL){
        uart_puts("stack pointer allocation failed\r\n");
        return -1;
    }
    pcb.context_data.SP=stack_pointer;
    // push it to the data structure
    pcb_insert(pcb);
    return 1;
}

int thread_start( int32_t id, void* arg){
    PCB_t* pcb = pcb_get(id);
    if (pcb == NULL){ return -1;}
    _pcb_set_arg(pcb,arg);
    dispatch_enqueue(id);
}
