
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "ipc.h"


typedef enum{
    IPC_SEND,
    IPC_RECV,
    YIELD,
    DUMMY,
} system_call_t;

typedef struct ipc_msg{
    process_id_t sender;
    struct ipc_msg* next;
    struct ipc_msg* prev;
    char payload[0];
} ipc_msg_t;

void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);




/*
    send msg rmsg to coid
*/
int ipc_send(process_id_t coid, const void* smsg, int size){
    _SYSTEM_CALL(IPC_SEND,(void*)smsg, (void*)size, (void*)&coid);
   // _SYSTEM_CALL(YIELD, NULL, NULL, NULL);
    return 1;
}

process_id_t ipc_receive(void* rmsg, int size){
    process_id_t sender;
    ipc_msg_t* recv_msg = malloc( sizeof(ipc_msg_t) + size);
    _SYSTEM_CALL(IPC_RECV, recv_msg, (void*)size, 0);
    memcpy(rmsg, recv_msg->payload, size);
    sender = recv_msg->sender;
    free(recv_msg);
    return sender;
}

