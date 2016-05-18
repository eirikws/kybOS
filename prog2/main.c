#include <stdlib.h>
#include "../program_library/system_calls.h"
#include "../program_library/ipc.h"

int main(void){
    int i = 0;
    int flags;
    ipc_msg_config_driver_t config  = { "test", WAITING_SEND, 0 };
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

        _SYSTEM_CALL(4, (void*)"Program 2 sending\r\n", NULL, NULL);
        ipc_send_driver(NULL, &config);
        _SYSTEM_CALL(4, (void*)"Program 2 finised sending\r\n", NULL, NULL);
    }
    return 0;
}

