.section ".text.startup"

.global _start
.global _SYSTEM_CALL
.global _get_stack_pointer

_start:
    // setup stack
   // ldr r0, _start
    //sub r0, r0, #10
    //mov sp, r0
    
    //  zero .bss
    // call main
    bl _cstartup
    b _exit
    
   
_SYSTEM_CALL:
    push {ip, lr}
    swi #0
    pop {ip, pc}
    
        //  used in Cstubs code. SP is returned in r0.
_get_stack_pointer:
    // Return the stack pointer value
    str     sp, [sp]
    ldr     r0, [sp]
    // Return from the function
    mov     pc, lr
