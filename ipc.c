
#include <stdint.h>
#include "interrupts.h"
#include "ipc.h"


static void extern _generate_swi(uint32_t arg0, uint32_t arg1, uint32_t arg2);
/*
    send msg rmsg to coid
*/
int ipc_send(int coid, const void* smsg, int size){
    // signal coid. use pcb
    PCB_t coid_pcb = pcb_get(coid);
    if (coid_pcb == NULL){  return -1;}
    coid_pcb->shared_data_ptr = (uint32_t)smsg;
    _generate_swi(IPC_SEND, smsg, size, coid);
}


int ipc_receive(void* rmsg, int size){
}
