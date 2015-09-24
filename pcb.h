#ifndef PCB_H
#define PCB_H

#include <stdint.h>

typedef enum thr_state{
    RUNNING,
    READY,
    BLOCKED,
} thread_state_t;
    

typedef struct Context_Data{
    uint32_t reg0to11[12];
    uint32_t IP;
    uint32_t SP;
    uint32_t LR;
    uint32_t CPSR;
} context_data_t;

typedef struct PCB{
    int32_t id;
    thread_state_t state;
    int32_t priority;
    context_data_t context_data;
    struct PCB* next;
    struct PCB* prev;
} PCB_t;

PCB_t* pcb_get(int32_t id);
int pcb_insert(PCB_t pcb);
int pcb_remove(int32_t id);







#endif
