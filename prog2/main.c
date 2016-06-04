#include <stdlib.h>
#include "../program_library/system_calls.h"
#include "../program_library/ipc.h"
#include "../program_library/process.h"

int main(void){
    int i = 0;
    ipc_msg_config_driver_t config  = { "test", WAITING_SEND, 0 };
    volatile int *ptr = (int*)0x5000000;
    spawn_args_t spawn_arg = {.path = "prog3.elf", .id = {.id_number = 5}, .mode = SPAWN_USER, .priority = 10, .flags = 0};
    while(1){
 /*       _SYSTEM_CALL(4, (void*)"Program 2 calling receive\r\n", NULL, NULL);
        flags = 0;
        ipc_receive( &i, sizeof(i), &flags);
        if(flags & BUF_TOO_SMALL){
            _SYSTEM_CALL(4, (void*)"Too small buffer\r\n", NULL, NULL);
        }
        _SYSTEM_CALL(4, (void*)"Program 2 received: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)i, NULL, NULL);
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
        if( i == 10 ){ return 1;}*/
        config.flags = 0;
        _SYSTEM_CALL(4, (void*)"Program 2 sending\r\n", NULL, NULL);
        ipc_send_driver(NULL, &config);
        if( config.flags & COID_NOT_FOUND ){
            _SYSTEM_CALL(4, (void*)"Program 2 coid_not_found\r\n", NULL, NULL);
        }
        _SYSTEM_CALL(4, (void*)"Program 2 finished sending\r\n", NULL, NULL);
        if(++i == 10){
            _SYSTEM_CALL(4, (void*)"Program 2 calling spawn\r\n", NULL, NULL);
            process_spawn( &spawn_arg);
            _SYSTEM_CALL(4, (void*)"Program 2 writing to bad loc\r\n", NULL, NULL);
            *ptr = 14;
        }
    }
    return 0;
}

