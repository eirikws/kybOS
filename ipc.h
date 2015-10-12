#ifndef IPC_H
#define IPC_H

#include <stdint.h>

int ipc_send(int coid, const void* smsg, int sbytes);

int ipc_receive(void* rmesg, int rbytes);


typedef struct{
    int sender;
    const void* payload;
}ipc_msg_t;





#endif
