
#include <stdint.h>
#include <string.h>
#include "interrupts.h"
#include "pcb.h"
#include "dispatcher.h"
#include "ipc.h"


void extern _SYSTEM_CALL(system_call_t arg0, void* arg1, void* arg2, void* arg3);



/*
    send msg rmsg to coid
*/
int ipc_send(int coid, const void* smsg, int size){
    // signal coid. use pcb
    //memcpy(rmsg, recv_msg.payload, size);
    ipc_msg_t sendmsg = {   .sender = get_current_running(),
                            .payload = smsg};
                       
                    
    _SYSTEM_CALL(IPC_SEND,(void*)&sendmsg, (void*)size, (void*)coid);
    // generate dispatch
    //_SYSTEM_CALL(DISPATCH, (void*)0, (void*)0,(void*)0);
    return 1;
}


int ipc_receive(void* rmsg, int size){
    int success = 0;
    ipc_msg_t recv_msg;
    while(success == 0){
        uart_puts("ipc recv while\r\n");
        _SYSTEM_CALL(IPC_RECV, &recv_msg, (void*)size, &success);
    }
    memcpy(rmsg, recv_msg.payload, size);
    return recv_msg.sender;
}
