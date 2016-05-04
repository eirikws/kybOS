#ifndef PCB_H
#define PCB_H

#include <stdint.h>

#define NUM_PRIORITIES  64

typedef struct process_id{
    int id_number;
} process_id_t;

typedef enum{
    BLOCKED_SENDING,
    BLOCKED_RECEIVING,
    READY,
} process_state_t;

typedef struct Context_Data{
    uint32_t stack_start;
    uint32_t SP;
    uint32_t virtual_address;
    uint32_t physical_address;
} context_data_t;

    // contains the ID of a process.
    // can contain more, like IP address of the current node.
typedef struct ipc_msg{
    process_id_t sender;
    struct ipc_msg* next;
    struct ipc_msg* prev;
    char payload[0];
} ipc_msg_t;

typedef struct Msg_queue{
    ipc_msg_t* head;
    ipc_msg_t* tail;
} msg_queue_t;


typedef struct PCB{
    process_id_t id;
    process_state_t state;
    uint32_t priority;
    context_data_t context_data;
    struct PCB* next;
    struct PCB* prev;
    int is_queued;
    void* shared_data_ptr;
    msg_queue_t msg_queue[NUM_PRIORITIES];
} PCB_t;

void save_stack_ptr( process_id_t id, uint32_t stack_pointer);
PCB_t* pcb_get(process_id_t id);
int pcb_insert(PCB_t pcb);
int pcb_remove(process_id_t id);
void pcb_print(void);
int pcb_id_compare(process_id_t id1, process_id_t id2);

#endif
