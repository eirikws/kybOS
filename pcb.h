#ifndef PCB_H
#define PCB_H

#include <stdint.h>

typedef enum thr_state{
    RUNNING,
    READY,
    BLOCKED,
} thread_state_t;
    

typedef struct Context_Data{
    int32_t reg0to12;
    void* SP;
    void* LR;
    void* PC;
    int32_t CPSR;
} context_data_t;

typedef struct PCB{
    char id[64];
    thread_state_t state;
    int priority;
    context_data_t context_data;
    struct PCB* next;
    struct PCB* prev;
} PCB_t;

PCB_t* pcb_get(char* id);
int pcb_insert(PCB_t pcb);
int pcb_remove(char* id);







#endif
