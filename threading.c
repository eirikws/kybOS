
#include <stdlib.h>

#include "threading.h"
#include "pcb.h"


int thread_create(void*(* program), size_t priority,size_t stack_space, char* id){
    // make process controll block
    PCB_t pcb = {   .id = "gaga", .state = READY, .priority = priority};
    
    // allocate stack pointer and space
    void* stack_pointer = malloc(stack_space);
    if (stack_pointer == NULL){
        uart_puts("stack pointer allocation failed\r\n");
        return -1;
    }
    pcb.context_data.SP=stack_pointer;
    // push it to the data structure
    pcb_insert(pcb);
}
