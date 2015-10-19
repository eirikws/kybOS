#ifndef IPC_H
#define IPC_H

#include <stdint.h>
#include "pcb.h"

int ipc_send(int coid, const void* smsg, int sbytes);

int ipc_receive(void* rmesg, int rbytes);

/*
typedef struct{
    int sender;
    char payload[0];
}ipc_msg_t;
*/
// used by system calls
void system_send(void* payload, uint32_t size, uint32_t coid);
void system_receive(ipc_msg_t *recv_msg, uint32_t size, int* success);


#endif
