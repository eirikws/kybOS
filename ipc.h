#ifndef IPC_H
#define IPC_H

#include <stdint.h>
#include <stdlib.h>
#include "drivers.h"
#include "scheduler.h"
#include "pcb.h"

// used by system calls
typedef struct ipc_msg_config{
    process_id_t coid;
    int flags;
    size_t size;
}ipc_msg_config_t;

typedef struct ipc_msg_config_driver{
    char name[DRIVER_NAME_SIZE];
    int flags;
    size_t size;
}ipc_msg_config_driver_t;

/*
 * kernel side of ipc_send
 */
scheduling_type_t system_send(void* payload, ipc_msg_config_t *config);

scheduling_type_t system_send_driver(void* payload, ipc_msg_config_driver_t *config);
/*
 * kernel side of ipc_receive
 */
scheduling_type_t system_receive(ipc_msg_t *recv_msg, size_t buf_size, int* flags);

/*
 * flush the receive queue
 */
void ipc_flush_msg_queue( process_id_t id);

/*
 * send a messege from the kernel to a process
 */
int ipc_kernel_send(void* smsg, size_t size, process_id_t coid);

#endif
