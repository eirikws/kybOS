#include <stdlib.h>
#include "../program_library/ipc.h"
#include "../program_library/system_calls.h"
#include "../program_library/memory.h"



int main(void){
    int i = 0;
    ipc_msg_config_t config = (ipc_msg_config_t){.coid = (process_id_t){2}, .flags = WAITING_SEND, .size = sizeof(i)};
    _SYSTEM_CALL(4, (void*)"Program 1 calling mmap, trying to remap 0xb00040\r\n", NULL, NULL);
    void* test = mmap((void*)0xb00040);
    _SYSTEM_CALL(4, (void*)"Program 1 has called mmap, mapped to: ", NULL, NULL);
    _SYSTEM_CALL(5, test, NULL, NULL);
    _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
    while(1){
        
        _SYSTEM_CALL(4, (void*)"Program 1 sending: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)i,NULL, NULL);
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
        ipc_send(  &i, &config);
        if(config.flags & COID_NOT_FOUND){
            _SYSTEM_CALL(4, (void*)"Program 1 send: COID_NOT_FOUND\r\n", NULL, NULL);
        }
        _SYSTEM_CALL(4, (void*)"Program 1 sending complete\r\n", NULL, NULL);
        i++;


    }
    return 0;
}
