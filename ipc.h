#ifndef IPC_H
#define IPC_H

#include <stdint.h>
#include <stdlib.h>
#include "pcb.h"

// used by system calls
typedef struct ipc_msg_config{
    process_id_t coid;
    int flags;
    size_t size;
}ipc_msg_config_t;

void system_send(void* payload, ipc_msg_config_t *config);
void system_receive(ipc_msg_t *recv_msg, size_t buf_size, int* flags);
void ipc_flush_msg_queue( process_id_t id);

#endif
