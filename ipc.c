
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "interrupts.h"
#include "ipc.h"
#include "dispatcher.h"
#include "pcb.h"

static ipc_msg_t* ipc_new_node(void* payload, uint32_t size){
    ipc_msg_t *newNode = malloc(sizeof(ipc_msg_t) + size);
    if (newNode == NULL){
        uart_puts("Failed to allocate new IPC priority_node!\r\n");
        return newNode;
    }
    memcpy( &(newNode->payload), payload, size);
    newNode->sender = get_current_running();
    newNode->next = NULL;
    newNode->prev = NULL;
    return newNode;
}

static ipc_msg_t* msg_priority_pop(int priority){
    PCB_t* my_pcb = pcb_get( get_current_running() );
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
static ipc_msg_t* ipc_dequeue(void){
    int i;
    ipc_msg_t* retval;
    for (i = NUM_PRIORITIES-1; i>-1; i--){
        retval = msg_priority_pop(i);
        if (retval != NULL){
            return retval;
        }
    }
    return NULL;
}

static int ipc_msg_enqueue_priority(ipc_msg_t* node, uint32_t coid){
    PCB_t* coid_pcb = pcb_get(coid);
    int priority = pcb_get(get_current_running())->priority;
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

int ipc_msg_enqueue(void* payload, uint32_t size,uint32_t coid){
    ipc_msg_t* node =  ipc_new_node(payload, size);
    
    if (pcb_get(coid) == NULL){
        uart_puts("ipc msg enqueue coid_pcb == NULL     coid == ");
        uart_put_uint32_t(coid, 10);
        uart_puts("\r\n");
        return -1;
    }
    return ipc_msg_enqueue_priority( node, coid);
}

void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);

/*
    send msg rmsg to coid
*/
int ipc_send(int coid, const void* smsg, int size){
    _SYSTEM_CALL(IPC_SEND,(void*)smsg, (void*)size, (void*)coid);
    // generate dispatch
    _SYSTEM_CALL(DISPATCH, NULL, NULL, NULL);
    return 1;
}

int ipc_receive(void* rmsg, int size){
    int success = 0;
    int sender;
    uart_puts("entering ipc_receive\r\n");
    ipc_msg_t* recv_msg = malloc( sizeof(ipc_msg_t) + size);
    while(success == 0){
        uart_puts("calling _SYSTEM_CALL IPC RECV\r\n");
        _SYSTEM_CALL(IPC_RECV, recv_msg, (void*)size, &success);
        uart_puts("after _SYSTEM_CALL IPC_RECV\r\n");
        if (success == 0){
            uart_puts("calling _SYSTEM_CALL DISPATCH\r\n");
            _SYSTEM_CALL(DISPATCH,NULL,NULL,NULL);
            uart_puts("after _SYSTEM_CALL DISPATCH\r\n");
        }
    }
    uart_puts("calling memcpy\r\n");
    memcpy(rmsg, recv_msg->payload, size);
    sender = recv_msg->sender;
    free(recv_msg);
    uart_puts("ipc_rcv end\r\n");
    return sender;
}

void system_send(void* payload, uint32_t size, uint32_t coid){
    //  setup for IPC
        // send message
        // wake up receiving thread
        // block the sending thread            
    ipc_msg_enqueue(payload, size, coid);
    pcb_get(get_current_running())->state = BLOCKED;
    if (pcb_get(coid)->state == BLOCKED){
        pcb_get(coid)->state = READY;
        dispatch_enqueue(coid);
    }
    return;
}

void system_receive(ipc_msg_t *recv_msg, uint32_t size, int* success){
    PCB_t* my_pcb = pcb_get( get_current_running() );
    ipc_msg_t* popped_msg = ipc_dequeue();
    
    if ( popped_msg != NULL){
        memcpy(      (void*)recv_msg,
                     (void*)popped_msg,
                     sizeof(ipc_msg_t) + size);
        free(popped_msg);
        pcb_get(recv_msg->sender)->state=READY;
        dispatch_enqueue(recv_msg->sender);
        *success = 1;
    }
    else{
        my_pcb->state = BLOCKED;
        //my_pcb->waiting_msg_from = coid;
        *success = 0;
    }
}

