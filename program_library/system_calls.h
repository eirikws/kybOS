#ifndef SYSTEM_CALLS_H
#define SYSTEM_CALLS_H

typedef enum{
    IPC_SEND,
    IPC_RECV,
    YIELD,
    DUMMY,
    PRINT_STR,
    PRINT_INT,
    EXIT,
    KILL,
    MMAP,
    DRIVER_REGISTER,
    IPC_SEND_DRIVER,
    SPAWN,
} system_call_t;

extern void _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void*arg3);


typedef struct process_id{
    int id_number;
} process_id_t;
#endif
