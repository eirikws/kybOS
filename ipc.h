#ifndef IPC_H
#define IPC_H

#include <stdint.h>
#include <stdlib.h>
#include "pcb.h"

// used by system calls
void system_send(void* payload, size_t size, process_id_t* coid);
void system_receive(ipc_msg_t *recv_msg, size_t buf_size, int* flags);
void ipc_flush_msg_queue( process_id_t id);

#endif
