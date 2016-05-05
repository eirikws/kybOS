#include <stdlib.h>
#include "../program_library/system_calls.h"
#include "../program_library/ipc.h"

int main(void){
    int i = 0;
    int flags;
    while(1){
        _SYSTEM_CALL(4, (void*)"Program 2 calling receive\r\n", NULL, NULL);
        flags = 0;
        ipc_receive( &i, sizeof(char), &flags);
        if(flags & BUF_TOO_SMALL){
            _SYSTEM_CALL(4, (void*)"Too small buffer\r\n", NULL, NULL);
        }
        _SYSTEM_CALL(4, (void*)"Program 2 received: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)i, NULL, NULL);
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
        if( i == 10 ){ return 1;}
    }
    return 0;
}

