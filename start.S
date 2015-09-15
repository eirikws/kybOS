
.section ".text.startup"

.global _start
.global _get_stack_pointer
.global _exception_table
.global _enable_interrupts
.global _get_cpsr
.global _set_cpu_mode
.global _generate_swi

//  STATUS/MODE REGISTER
.equ    CPSR_MODE_USER,         0x10
.equ    CPSR_MODE_FIQ,          0x11
.equ    CPSR_MODE_IRQ,          0x12
.equ    CPSR_MODE_SVR,          0x13
.equ    CPSR_MODE_ABORT,        0x17
.equ    CPSR_MODE_UNDEFINED,    0x1B
.equ    CPSR_MODE_SYSTEM,       0x1F
.equ    CPSR_IRQ_INHIBIT,       0x80
.equ    CPSR_FIQ_INHIBIT,       0x40
.equ    CPSR_THUMB,             0x20

/*
        Put the vector table in the ram at 0x8000.
        At startup the PC will start at 0x8000, which is the first
        instrucion of _start.
*/
_start:
    ldr pc, _reset_h
    ldr pc, _undefined_instruction_vector_h
    ldr pc, _software_interrupt_vector_h
    ldr pc, _prefetch_abort_vector_h
    ldr pc, _data_abort_vector_h
    ldr pc, _unused_handler_h
    ldr pc, _interrupt_vector_h
    ldr pc, _fast_interrupt_vector_h

/*
    Create a table of constants with an entry for each vector. The compiler
    will keep the labels relative to PC
*/
_reset_h:                           .word   _reset_
_undefined_instruction_vector_h:    .word   undefined_instruction_vector
_software_interrupt_vector_h:       .word   software_interrupt_vector
_prefetch_abort_vector_h:           .word   prefetch_abort_vector
_data_abort_vector_h:               .word   data_abort_vector
_unused_handler_h:                  .word   _reset_
_interrupt_vector_h:                .word   interrupt_vector
_fast_interrupt_vector_h:           .word   fast_interrupt_vector

_reset_:
    // We enter execution in supervisor mode!
    
    // Copy _start and the table from 0x8000 to 0x0000
    mov     r0, #0x8000
    mov     r1, #0x0000
    ldmia   r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    stmia   r1!,{r2, r3, r4, r5, r6, r7, r8, r9}
    ldmia   r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    stmia   r1!,{r2, r3, r4, r5, r6, r7, r8, r9}

    //  setup the stack pointer for the interrupt mode
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(63 * 1024 * 1024)

    //  switch back to supervisor mode and set the stack pointer
    //  towards the end of RAM. The stack will work down, and the heap up.
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0

    //  set the stack pointer at some point in RAM
    mov     sp, #(64 * 1024 * 1024)

    //  Setup the c runtime
    bl      _cstartup

    // Should never come here, but if it does, loop forever for debug purpuses
_inf_loop:
    b       _inf_loop

    //  used in Cstubs code. SP is returned in r0.
_get_stack_pointer:
    // Return the stack pointer value
    str     sp, [sp]
    ldr     r0, [sp]
    // Return from the function
    mov     pc, lr

_generate_swi:
    swi 12
    mov pc, lr

_get_cpsr:
    mrs r0, cpsr
    mov pc, lr

_set_cpu_mode:
//    mrs r1, cpsr
//    and r1, #0xffffffE0  // set previous mode to 0. 0b..1110 0000
//    orr r1, r0          // set MODE bits (CPSR[4..0]) to the new mode
    msr cpsr_c, r0
    mov pc, lr    

_enable_interrupts:
    mrs     r0, cpsr
    bic     r0, r0, #0x80
    msr     cpsr_c, r0
    mov     pc, lr
