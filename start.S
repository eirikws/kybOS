
.section ".text.startup"

.global _start
.global _get_stack_pointer
.global _exception_table
.global _enable_interrupts
.global _get_cpsr
.global _set_cpu_mode
.global _SYSTEM_CALL
.global _init_thr_stack
.global _push_stack_pointer
.global _get_user_sp
.global _generate_dispatch


//  STATUS/MODE REGISTER
.equ    CPSR_MODE_FILTER,       0x1F 
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
.equ    ttb_address,            (64*1024*1024-16*1024)
.equ    TTB,                    (64*1024*1024-16*1024)
.equ    STACK_SVR,              (64 * 1024 * 1024)
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
    
    // setup Undefined
    mov r0, #(CPSR_MODE_UNDEFINED | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(61 * 1024 * 1024)
    
    //setup Abort
    mov r0, #(CPSR_MODE_ABORT | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(60 * 1024 * 1024)
    
    //  setup the user/system stack pointer. These modes share registers.
    //  switch to system mode because the we are able to switch back!
    mov r0, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(62 * 1024 * 1024)
    //  switch back to supervisor mode and set the stack pointer
    //  towards the end of RAM. The stack will work down, and the heap up.
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0

    //  set the stack pointer at some point in RAM. this is the top(0x80000)!
    mov sp, #(STACK_SVR)     // top of memory



    //  Setup the c runtime
    bl      _cstartup

    // Should never come here, but if it does, loop forever for debug purpuses
_inf_loop:
    b       _inf_loop
    
    // save and restore all registers on the user stack of active thread


interrupt_vector:
    sub lr, lr, #4
    push {r0-r3, lr}
    
    bl GetIrqController
    ldr r0, [r0, #0x0] // offset to IRQbasic pending
   
    
    cmp r0, #1  // check if arm timer irq pending bit is set
    popne {r0-r3, lr}
    bne _prep_interrupt_vector  // if not equal, go to ordinary interrupt
    
    // if it is a timer interrupt, determine which mode it came from, 
    // and branch to appropriate handlers
    bl _ack_timer_irq
    pop {r0-r3, lr}
    b dispatch_find_calling_mode


dispatch_find_calling_mode:
    push {r0}
    mrs r0, spsr
    and r0, r0, #(CPSR_MODE_FILTER)
    cmp r0, #(CPSR_MODE_USER)
    popeq {r0}
    beq dispatch_prepare_user
    
    //  have no code that goes here and is interruptable....but might be in the future!
    
    cmp r0, #(CPSR_MODE_SYSTEM)
    popeq {r0}
    beq dispatch_prepare_user   // this should be identical to user ;)
    
    cmp r0, #(CPSR_MODE_SVR)
    popeq {r0}
    beq dispatch_prepare_svr
    

dispatch_prepare_user:
    // save r0-r12, lr, pc, cpsr on the stack, in that sequence
    push {r0}
    mov r0, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    push {r1-r12}
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    pop {r0}
    mrs r1, spsr
    mov r2, lr
    mov r3, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r3
    push {r0}
    push {r1,r2, lr}
    
    /*
    mov r0, sp
    push {r0-r3, lr}
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #4
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #8
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #12
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #16
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #20
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #24
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #28
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #32
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #36
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #40
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #44
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #48
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #52
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #56
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #60
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #64
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #68
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #72
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #76
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #80
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #84
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    */
    
    
    
    mov r0, sp // save SP so we can use it as parameter in dispatcher
    
    mov r1, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    b call_and_return_dispatch


dispatch_prepare_svr:
    //pop {r0-r3, lr}
    
    push {r0}
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    push {r1-r12}
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    pop {r0}
    mrs r1, spsr
    mov r2, lr
    
    mov r3, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r3
    push {r0}
    push {r1,r2, lr}

/*
    mov r0, sp
    push {r0-r3, lr}
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #4
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #8
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #12
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #16
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #20
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #24
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #28
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #32
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #36
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #40
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #44
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #48
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #52
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #56
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #60
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #64
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #68
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #72
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #76
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #80
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #84
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
*/
    mov r0, sp  // save SP so we can use it as parameter in dispatcher
    mov r1, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    b call_and_return_dispatch

    // When this label is called, a thread has been saved and the SP is in r0
call_and_return_dispatch:
    // call dispatch with sp in r0
    
    bl dispatch
    // dispatch returns with the new SP in r0
    mov r4, r0
    mov r3, sp
    mov sp, r4   // move process stack pointer into SP
    
    pop {r1}    // pop cpsr
    push {r1}   // dont change size of stack
    
    mov sp, r3  // move IRQ mode stack pointer back into SP
    
    // figure out what mode we should build the return stack for
    and r0, r1, #CPSR_MODE_FILTER
    cmp r0, #(CPSR_MODE_USER)
    beq dispatch_return_user
    
    and r0, r1, #CPSR_MODE_FILTER
    cmp r0, #(CPSR_MODE_SVR)
    beq dispatch_return_svr

dispatch_return_user:
    // build the return stack
    mov r0, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    
    mov sp, r4
    pop {r0-r2}     // spsr, pc, lr
    
    mov lr, r2
    mov r3, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r3
    push {r1} // pc
    msr spsr, r0 // cpsr
    mov r4, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r4
    pop {r0-r12}
    push {r0}
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    push {r1-r12}
    mov r0, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    pop {r0}
    mov r1, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    push {r0}
    
    /*
    mov r0, sp
    push {r0-r3, lr}
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #4
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #8
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #12
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #16
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #20
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #24
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #28
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #32
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #36
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #40
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #44
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #48
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #52
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #56
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #60
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #64
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #68
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #72
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #76
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #80
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #84
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    */
    
    ldm sp!, {r0-r12}
    
    ldm sp!, {pc}^
    

dispatch_return_svr:
    // build the return stack
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    
    mov sp, r4
    pop {r0-r2}// spsr, pc, lr
    
    mov lr, r2
    mov r3, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r3
    push {r1}
    msr spsr, r0
    mov r4, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r4
    pop {r0-r12}
    push {r0}
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    push {r1-r12}
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    pop {r0}
    mov r1, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    push {r0}
    
    
    /*
    mov r0, sp
    push {r0-r3, lr}
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #4
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #8
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #12
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #16
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #20
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #24
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #28
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #32
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #36
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #40
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #44
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #48
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #52
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #56
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #60
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #64
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #68
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #72
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #76
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #80
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    add r0, r0, #84
    bl _get_stack_top
    pop {r0-r3, lr}
    
    */
    
    ldm sp!, {r0-r12}
    
    ldm sp!, {pc}^
    

_prep_interrupt_vector:
    push {r0-r3}
    bl interrupt_vector_c
    ldm sp!, {r0-r3, pc}^


    //  Called when a user thread wants to generate a dispatch
    //  with a swi call. This branch is called in SVR mode.
    //  mush move SPSR and LR to IRQ mode
_generate_dispatch:
    push {r0-r3}
    mrs r0, spsr
    mov r1, lr
    mov r2, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r2
    msr spsr, r0
    mov lr, r1
    push {r3}
    mov r2, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r2
    pop {r0-r2}
    mov r3, r2
    mov r2, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r2
    mov r2, r3
    pop {r3}
    b dispatch_find_calling_mode

    // r0, contains the value of SWI call. 
software_interrupt_vector:
    push {r0-r1, lr}
    mov r1, r0
    bl _get_dispatch_val
    cmp r0, r1                          // check if the call is for a dispatch
    popeq {r0-r1, lr}
    beq _generate_dispatch
    pop {r0-r1, lr}
    
    
    push {r0-r3, lr}
    bl software_interrupt_vector_c
    ldm	sp!, {r0-r3, pc}^
    

    //  used in Cstubs code. SP is returned in r0.
_get_stack_pointer:
    // Return the stack pointer value
    str     sp, [sp]
    ldr     r0, [sp]
    // Return from the function
    mov     pc, lr

    //  return user sp in r0
_get_user_sp:
    push {r4}
    mov r4, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r4
    mov r0, sp
    mov r4, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r4
    pop {r4}
    mov pc, lr

_SYSTEM_CALL:
    push {r0-r3, lr}
    swi #0
    pop {r0-r3, lr}
    mov pc, lr

_get_cpsr:
    mrs r0, cpsr
    mov pc, lr

    // this function goes to system mode and pushes a pointer to a new stack
_push_stack_pointer:
    //  enter system mode to access user registers
    mov r1, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    push {r0}
    //  go back to irq mode
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov pc, lr


    // r0 carries sp, r1 location of code, r2 cpsr
_init_thr_stack:
    mov r3, sp
    mov sp, r0
    mov r0, #42
    push {r0}
    push {r0}
    mov r0, #0
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    push {r0}
    mov r0, #42
    push {r0}
    push {r0} // lr contains nothing
    push {r1} // pc
    push {r2} // cpsr
    mov r0, sp
    mov sp, r3
    mov pc, lr
     
// return stack for scheduling is:
    // cpsr
    // pc
    // lr
    // r0-r12
// location is packaged with in the SP
     
     
     
     
_set_cpu_mode:
    //  store lr in r2, becuase lr is banked for different cpu modes    
    mov r2, lr
    msr cpsr_c, r0
    mov pc, r2

_enable_interrupts:
    mrs     r0, cpsr
    bic     r0, r0, #0x80
    msr     cpsr_c, r0
    mov     pc, lr



 
