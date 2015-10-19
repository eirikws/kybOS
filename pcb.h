#ifndef PCB_H
#define PCB_H

#include <stdint.h>
#include "dispatcher.h"

#define RUNNING  1
#define READY   2
#define BLOCKED 3

typedef struct ipc_msg{
    int sender;
    struct ipc_msg* next;
    struct ipc_msg* prev;
    char payload[0];
} ipc_msg_t;

typedef struct Msg_queue{
    ipc_msg_t* head;
    ipc_msg_t* tail;
} msg_queue_t;

typedef struct Context_Data{
    uint32_t SP;
} context_data_t;

typedef struct PCB{
    uint32_t id;
    uint32_t state;
    uint32_t priority;
    context_data_t context_data;
    struct PCB* next;
    struct PCB* prev;
    uint32_t waiting_msg_from;
    void* shared_data_ptr;
    msg_queue_t msg_queue[NUM_PRIORITIES];
} PCB_t;

PCB_t* pcb_get(uint32_t id);
int pcb_insert(PCB_t pcb);
int pcb_remove(uint32_t id);
void pcb_print(void);


#endif
