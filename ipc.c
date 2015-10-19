
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "interrupts.h"
#include "ipc.h"
#include "dispatcher.h"
#include "pcb.h"



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
    ipc_msg_t* recv_msg = malloc( sizeof(ipc_msg_t) + size);
    while(success == 0){
        _SYSTEM_CALL(IPC_RECV, recv_msg, (void*)size, &success);
        
        if (success == 0){
            _SYSTEM_CALL(DISPATCH,NULL,NULL,NULL);
        }
    }
    memcpy(rmsg, recv_msg->payload, size);
    sender = recv_msg->sender;
    free(recv_msg);
    return sender;
}

void system_send(void* payload, uint32_t size, uint32_t coid){
    //  setup for IPC
        // set shared data ptrs do the message
        // wake up receiving thread
        // block the sending thread            
    
    ipc_msg_t* send_msg = malloc( sizeof(ipc_msg_t) + size );
    send_msg->sender = get_current_running();
    memcpy( &(send_msg->payload), payload, size);
    pcb_get(coid)->shared_data_ptr = send_msg;
    pcb_get(get_current_running())->state = BLOCKED;
    if (pcb_get(coid)->state == BLOCKED){
        pcb_get(coid)->state = READY;
        dispatch_enqueue(coid);
    }
    return;
}

void system_receive(ipc_msg_t *recv_msg, uint32_t size, int* success){
    PCB_t* my_pcb = pcb_get( get_current_running() );
    if ( my_pcb->shared_data_ptr != NULL){
        memcpy(      (void*)recv_msg,
                     my_pcb->shared_data_ptr,
                     sizeof(ipc_msg_t) + size);
        free(my_pcb->shared_data_ptr);
        my_pcb->shared_data_ptr = NULL;
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



