#include <stdlib.h>
#include "../program_library/ipc.h"
#include "../program_library/system_calls.h"
#include "../program_library/memory.h"
#include "../program_library/drivers.h"


int main(void){
    int i = 0;
 //   ipc_msg_config_t config = (ipc_msg_config_t){.coid = (process_id_t){2}, .flags = WAITING_SEND, .size = sizeof(i)};
    _SYSTEM_CALL(4, (void*)"Program 1 calling mmap, trying to remap 0xb00040\r\n", NULL, NULL);
    void* test = mmap((void*)0xb00040);
    _SYSTEM_CALL(4, (void*)"Program 1 has called mmap, mapped to: ", NULL, NULL);
    _SYSTEM_CALL(5, test, NULL, NULL);
    _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);

    _SYSTEM_CALL(4, (void*)"Calling driver_register\r\n", NULL, NULL);
    driver_register("test");
    _SYSTEM_CALL(4, (void*)"Program 1 has called driver_register\r\n ", NULL, NULL);
    while(1){
 /*       
        _SYSTEM_CALL(4, (void*)"Program 1 sending: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)i,NULL, NULL);
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
        ipc_send(  &i, &config);
        if(config.flags & COID_NOT_FOUND){
            _SYSTEM_CALL(4, (void*)"Program 1 send: COID_NOT_FOUND\r\n", NULL, NULL);
        }
        _SYSTEM_CALL(4, (void*)"Program 1 sending complete\r\n", NULL, NULL);
        i++;
        */
        int flags = 0;
        _SYSTEM_CALL(4, (void*)"Calling receive\r\n", NULL, NULL);
        process_id_t sender = ipc_receive( NULL, 0, &flags);
        _SYSTEM_CALL(4, (void*)"got msg from: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)sender.id_number, NULL, NULL);
    }
    return 0;
}
