#ifndef IPC_H
#define IPC_H

#include <stdint.h>
#include "pcb.h"

int ipc_send(process_id_t* coid, const void* smsg, int sbytes);
process_id_t ipc_receive(void* rmesg, int rbytes);

// used by system calls
void system_send(void* payload, uint32_t size, process_id_t* coid);
void system_receive(ipc_msg_t *recv_msg, uint32_t size, int*success);


#endif
