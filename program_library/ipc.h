#ifndef IPC_H
#define IPC_H

#include <stdlib.h>
#include <stdint.h>

typedef struct process_id{
    int id_number;
} process_id_t;

// ipc receive flag bits
#define BUF_TOO_SMALL           (1 << 1)


int ipc_send(process_id_t *coid, const void* smsg, size_t sbytes);
process_id_t ipc_receive(void* rmesg, size_t buf_size, int* flags );

#endif
