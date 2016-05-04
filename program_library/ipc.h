#ifndef IPC_H
#define IPC_H

#include <stdint.h>

typedef struct process_id{
    int id_number;
} process_id_t;




int ipc_send(process_id_t *coid, const void* smsg, int sbytes);
process_id_t ipc_receive(void* rmesg, int rbytes);

#endif
