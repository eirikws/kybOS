
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "interrupts.h"
#include "ipc.h"


void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);



/*
    send msg rmsg to coid
*/
int ipc_send(int coid, const void* smsg, int size){
    _SYSTEM_CALL(IPC_SEND,(void*)smsg, (void*)size, (void*)coid);
    // generate dispatch

    return 1;
}


int ipc_receive(void* rmsg, int size){
    int success = 0;
    int sender;
    ipc_msg_t* recv_msg = malloc( sizeof(ipc_msg_t) + size);
    while(success == 0){
        uart_puts("ipc recv while\r\n");
        _SYSTEM_CALL(IPC_RECV, recv_msg, (void*)size, &success);
    }
    memcpy(rmsg, recv_msg->payload, size);
    sender = recv_msg->sender;
    free(recv_msg);
    return sender;
}
