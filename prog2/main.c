#include <stdlib.h>
#include "ipc.h"
extern void _SYSTEM_CALL(int , void* );



int main(void){
    int i = 0;
    while(1){
        _SYSTEM_CALL(4, (void*)"Program 2 calling receive\r\n");
        ipc_receive( &i, sizeof(i));
        _SYSTEM_CALL(4, (void*)"Program 2 received: ");
        _SYSTEM_CALL(5, (void*)i);
        _SYSTEM_CALL(4, (void*)"\r\n");
    }
    return 0;
}

