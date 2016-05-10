#ifndef IPC_H
#define IPC_H

#include <stdlib.h>
#include <stdint.h>

typedef struct process_id{
    int id_number;
} process_id_t;

// ipc receive flag bits
#define BUF_TOO_SMALL           (1 << 1)

// ipc send flag bits
#define WAITING_SEND            (1 << 0)
#define COID_NOT_FOUND          (1 << 1)
typedef struct ipc_msg_config{
    process_id_t coid;
    int flags;
    size_t size;
}ipc_msg_config_t;

int ipc_send(void* smsg, ipc_msg_config_t *config);
process_id_t ipc_receive(void* rmesg, size_t buf_size, int* flags );

#endif
