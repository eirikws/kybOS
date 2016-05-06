#include <stdlib.h>
#include "../program_library/ipc.h"
#include "../program_library/system_calls.h"



int main(void){
    int i = 0;
    ipc_msg_config_t config = (ipc_msg_config_t){.coid = (process_id_t){2}, .flags = WAITING_SEND, .size = sizeof(i)};
    while(1){
        
        _SYSTEM_CALL(4, (void*)"Program 1 sending: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)i,NULL, NULL);
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
        ipc_send(  &i, &config);
        _SYSTEM_CALL(4, (void*)"Program 1 sending complete\r\n", NULL, NULL);
        i++;

    }
    return 0;
}
