.section ".text"

.global _start

_start:
    // setup stack
    ldr r0, _start
    sub r0, r0, #10
    mov sp, r0
    
    //  zero .bss
    // call main
    bl _cstartup
    
   
_SYSTEM_CALL:
    push {ip, lr}
    swi #0
    pop {ip, pc}
