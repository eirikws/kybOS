
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "system_calls.h"
#include "ipc.h"

// ipc receive call flags
#define QUEUE_EMPTY             (1 << 0)

typedef struct ipc_msg{
    process_id_t sender;
    int flags;
    size_t payload_size;
    struct ipc_msg* next;
    struct ipc_msg* prev;
    char payload[0];
} ipc_msg_t;

/*
    send msg rmsg to coid
*/
int ipc_send(void* smsg, ipc_msg_config_t *config){
    _SYSTEM_CALL(IPC_SEND,(void*)smsg, (void*)config, NULL);
    return 1;
}

/*
    send msg rmsg to driver-name
*/
int ipc_send_driver(void* smsg, ipc_msg_config_driver_t *config){
    _SYSTEM_CALL(IPC_SEND_DRIVER,(void*)smsg, (void*)config, NULL);
    return 1;
}

process_id_t ipc_receive(void* rmsg, size_t buf_size, int* flags){
    process_id_t sender;
    ipc_msg_t* recv_msg = malloc( sizeof(ipc_msg_t) + buf_size);
    _SYSTEM_CALL(IPC_RECV, recv_msg, (void*)buf_size, flags );
    if( *flags & QUEUE_EMPTY ){
        _SYSTEM_CALL(YIELD, NULL, NULL, NULL);
        _SYSTEM_CALL(IPC_RECV, recv_msg, (void*)buf_size, flags );
    }
    // clear queue empty, should not be visible to user
    *flags &= ~(QUEUE_EMPTY);
    memcpy(rmsg, recv_msg->payload, buf_size);
    sender = recv_msg->sender;
    free(recv_msg);
    return sender;
}

