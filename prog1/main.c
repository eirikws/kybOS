#include <stdlib.h>
#include "ipc.h"
extern void _SYSTEM_CALL(int , void* );



int main(void){
    int i = 0;
    while(1){
        
        _SYSTEM_CALL(4, (void*)"Program 1 sending: ");
        _SYSTEM_CALL(5, (void*)i);
        _SYSTEM_CALL(4, (void*)"\r\n");
        ipc_send( &((process_id_t){2}) , &i, sizeof(i));
        _SYSTEM_CALL(4, (void*)"Program 1 sending complete\r\n");
        i++;

    }
    return 0;
}

