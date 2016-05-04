#include <stdlib.h>
#include "../program_library/ipc.h"
#include "../program_library/system_calls.h"



int main(void){
    int i = 0;
    while(1){
        
        _SYSTEM_CALL(4, (void*)"Program 1 sending: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)i,NULL, NULL);
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
        ipc_send( &((process_id_t){2}) , &i, sizeof(i));
        _SYSTEM_CALL(4, (void*)"Program 1 sending complete\r\n", NULL, NULL);
        i++;

    }
    return 0;
}
