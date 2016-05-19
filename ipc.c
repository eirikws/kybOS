#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "system_calls.h"
#include "interrupts.h"
#include "scheduler.h"
#include "pcb.h"
#include "uart.h"
#include "ipc.h"

static ipc_msg_t* ipc_new_node(void* payload, uint32_t size, int flags, process_id_t sender){
    ipc_msg_t *newNode = malloc(sizeof(ipc_msg_t) + size);
    if (newNode == NULL){
        uart_puts("Failed to allocate new IPC priority_node!\r\n");
        return newNode;
    }
    newNode->payload_size = size;
    newNode->flags = flags;
    memcpy( &(newNode->payload), payload, size);
    newNode->sender = sender;
    newNode->next = NULL;
    newNode->prev = NULL;
    return newNode;
}

static ipc_msg_t* msg_priority_pop(process_id_t id, int priority){
    PCB_t* my_pcb = pcb_get( id );
    //  check priority is within bounds
    if (priority < 0 || priority > NUM_PRIORITIES){ return NULL;}
    //  if empty
    
    else if ( my_pcb->msg_queue[priority].head == NULL){ return NULL;}
    // if one item
    
    else if ( my_pcb->msg_queue[priority].head == my_pcb->msg_queue[priority].tail){
        ipc_msg_t* tmp = my_pcb->msg_queue[priority].head;
        my_pcb->msg_queue[priority].head = NULL;
        my_pcb->msg_queue[priority].tail = NULL;
        return tmp;
    // if more than one item
    } else {
        ipc_msg_t* tmp = my_pcb->msg_queue[priority].head;
        tmp->next->prev=NULL;
        my_pcb->msg_queue[priority].head = tmp->next;
        return tmp;
    }
}

    // iterate through list. return -1 if empty
static ipc_msg_t* ipc_dequeue(process_id_t id){
    int i;
    ipc_msg_t* retval;
    for (i = NUM_PRIORITIES-1; i>-1; i--){
        retval = msg_priority_pop(id, i);
        if (retval != NULL){
            return retval;
        }
    }
    return NULL;
}

static int ipc_msg_enqueue_priority(ipc_msg_t* node, process_id_t coid){
    PCB_t* coid_pcb = pcb_get(coid);
    int priority = pcb_get( get_current_running_process() )->priority;
    //  check priority is within bounds
    if( priority < 0 || priority > NUM_PRIORITIES-1){ 
        uart_puts("IPC priority out of bounds\r\n");
        return -1;
    }
    //  if empty
    if (coid_pcb->msg_queue[priority].tail == NULL){
        coid_pcb->msg_queue[priority].head = node;
        coid_pcb->msg_queue[priority].tail = node;
        return 1;
    } else {
        ipc_msg_t* tmp = coid_pcb->msg_queue[priority].tail;
        tmp->next = node;
        node->prev = tmp;
        coid_pcb->msg_queue[priority].tail = node;
        return 1;
    }
}

int ipc_msg_enqueue(void* payload, uint32_t size, process_id_t coid, int flags, process_id_t sender){
    ipc_msg_t* node =  ipc_new_node(payload, size, flags, sender);
    if (pcb_get(coid) == NULL){
        return -1;
    }
    return ipc_msg_enqueue_priority( node, coid);
}

// ipc send call flag bits
#define WAITING_SEND        (1 << 0)
#define COID_NOT_FOUND      (1 << 1)
scheduling_type_t system_send(void* payload, ipc_msg_config_t *config){
    if(ipc_msg_enqueue(payload, config->size, config->coid, config->flags, get_current_running_process()) == -1){
        config->flags |= COID_NOT_FOUND;
        return NO_RESCHEDULE;
    }
    if(config->flags & WAITING_SEND){
        pcb_get( get_current_running_process() )->state = BLOCKED_SENDING;

    }
    if (pcb_get(config->coid)->state == BLOCKED_RECEIVING){
        pcb_get(config->coid)->state = READY;
        scheduler_enqueue(config->coid);
    }
    return RESCHEDULE;
}

/*
 *  much the same as system send, except that should not block, and sender is kernel
 */
int ipc_kernel_send(void* payload, size_t size, process_id_t coid){
    if(ipc_msg_enqueue(payload, size, coid, 0, NULL_ID) == -1){
        return 0;
    }
    if (pcb_get(coid)->state == BLOCKED_RECEIVING){
        pcb_get(coid)->state = READY;
        scheduler_enqueue(coid);
    }
    return 1;
}

scheduling_type_t system_send_driver(void* payload, ipc_msg_config_driver_t *config){
    process_id_t coid = driver_get(config->name);
    if(ipc_msg_enqueue(payload, config->size, coid, config->flags, get_current_running_process()) == -1){
        config->flags |= COID_NOT_FOUND;
        return NO_RESCHEDULE;
    }
    if(config->flags & WAITING_SEND){
        pcb_get( get_current_running_process() )->state = BLOCKED_SENDING;
    }
    if (pcb_get(coid)->state == BLOCKED_RECEIVING){
        pcb_get(coid)->state = READY;
        scheduler_enqueue(coid);
    }
    return RESCHEDULE;
}
// ipc receive call flags bits
#define QUEUE_EMPTY         (1 << 0)
#define BUF_TOO_SMALL       (1 << 1)

scheduling_type_t system_receive(ipc_msg_t *recv_msg, size_t buf_size, int* flags){
    int cpy_bytes;
    PCB_t* my_pcb = pcb_get( get_current_running_process() );
    ipc_msg_t* popped_msg = ipc_dequeue(get_current_running_process());
    if ( popped_msg != NULL){
        if( popped_msg->payload_size > buf_size){
            *flags |= BUF_TOO_SMALL;
            cpy_bytes = buf_size;
        }else{
            cpy_bytes = popped_msg->payload_size;
        }
        memcpy(      (void*)recv_msg,
                     (void*)popped_msg,
                     sizeof(ipc_msg_t) + cpy_bytes);
        if( popped_msg->flags & WAITING_SEND ){
            pcb_get(recv_msg->sender)->state=READY;
            scheduler_enqueue(recv_msg->sender);
        }
        free(popped_msg);
    }else{
        my_pcb->state = BLOCKED_RECEIVING;
        *flags |= QUEUE_EMPTY;
    }
    return RESCHEDULE;
}

void ipc_flush_msg_queue( process_id_t id){
    ipc_msg_t *msg;
    while( msg = ipc_dequeue(id), msg != NULL){
        if (pcb_get(msg->sender)->state == BLOCKED_SENDING){
            pcb_get(msg->sender)->state = READY;
            scheduler_enqueue(msg->sender);
        }
        free(msg);
    }
}

