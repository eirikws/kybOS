
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
    mov r0, #(64 * 1024 * 1024)     // top of memory
    sub r0, r0, #16*1024            // set some memory for tlb  
    mov sp, r0 

    




    //  Setup the c runtime
    bl      _cstartup

    // Should never come here, but if it does, loop forever for debug purpuses
_inf_loop:
    b       _inf_loop
    
    // save and restore all registers on the user stack of active thread


interrupt_vector:
    sub lr, lr, #4
    
    push {r0-r3, lr}
    mov r0, lr
    bl _print_reg
    
    bl GetIrqController
    ldr r0, [r0, #0x0] // offset to IRQbasic pending
   
    
    cmp r0, #1  // check if arm timer irq pending bit is set
    bne _prep_interrupt_vector  // if not equal, go to ordinary interrupt
    
    // if it is a timer interrupt, determine which mode it came from, 
    // and branch to appropriate handlers
    bl _ack_timer_irq
    pop {r0-r3, lr}
    b dispatch_find_calling_mode
        


dispatch_find_calling_mode:
    mrs r0, spsr
    and r0, r0, #(CPSR_MODE_FILTER)
    cmp r0, #(CPSR_MODE_USER)
    beq dispatch_prepare_user
    
    //  have no code that goes here and is interruptable....but might be in the future!

    cmp r0, #(CPSR_MODE_SYSTEM)
    beq dispatch_prepare_user   // this should be identical to user ;)
    
    cmp r0, #(CPSR_MODE_SVR)
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
    
    // debug
    mov r0, sp
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    // end debug
    
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
    mov r0, sp
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #4
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #8
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #12
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #16
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #20
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #24
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #28
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #32
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #36
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #40
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #44
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #48
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #52
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #56
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #60
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #64
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #68
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #72
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #76
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #80
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #84
    bl _get_stack_top
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
    push {r0-r3, lr}
    mov r0, sp
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #4
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #8
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #12
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #16
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #20
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #24
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #28
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #32
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #36
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #40
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #44
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #48
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #52
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #56
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #60
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #64
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #68
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #72
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #76
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #80
    bl _get_stack_top
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, sp
    add r0, r0, #84
    bl _get_stack_top
    pop {r0-r3, lr}
    */
    
    
    ldm sp!, {r0-r12}
    
    ldm sp!, {pc}^
    

_prep_interrupt_vector:
    bl interrupt_vector_c
    ldm sp!, {r0-r3, pc}^

    //  Called when a user thread wants to generate a dispatch
    //  with a swi call. This branch is called in SVR mode
_generate_dispatch:
    pop	{r0, r1, r2, r3, ip, lr}
    
    /*
    push {r0-r3, lr}
    mov r0, lr
    bl _print_reg
    pop {r0-r3, lr}
    */
    
    push {r0-r2}
    mrs r0, spsr
    mov r1, lr
    mov r2, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r2
    msr spsr, r0
    mov lr, r1
    push {r2}
    mov r2, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r2
    pop {r0-r2}
    mov r2, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r2
    pop {r2}
    push {r0-r3, lr}
    b dispatch_prepare_user

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
    swi #0
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


/*
    r0 is base. sets the translation table base.  
*/
.global _set_tt_base
_set_tt_base:
    mcr p15, 0, r0, c3, c0, 0       // c3 is Domaing acess control register
    mov pc, lr 



.global _mmu_start
_mmu_start:
    mov r2, #0
    mcr p15, 0, r2, c7, c7, 0   // invalidate caches
    mcr p15, 0, r2, c8, c7, 0   // invalidate tlb




//MCR{cond} P15, <Opcode_1>, <Rd>, <CRn>, <CRm>, <Opcode_2>
//MRC{cond} P15, <Opcode_1>, <Rd>, <CRn>, <CRm>, <Opcode_2>

/*
    1 .build translation table in memory. Translation table include
        - virtual to physical translation
        - cachable and bufferable flags
        - domain number
        - access permissions
   
    2. store the location of translation table in CP15 register c2
    
    3. enable caches and enable the MMU by writing to cp15 in register c1
    
*/

.global _mmu_test2
_mmu_test2:
    // test
    mov r0, #0b1000
    mov r1, #0b10000000
    orr r2, r0, r1, lsl #1
    push {r0-r3, lr}
    mov r0, r2
    bl _print_reg
    pop {r0-r3, lr}
    
    
    push {r0-r3, lr}
    mov r0, #(1 << 18)
    bl _print_reg
    pop {r0-r3, lr}

    // build translation table
    ldr r0, =TTB         // set translation table to 3ffc00
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    ldr r1, =0xfff      // set loop counter for 4096
    mov r2,     #0b110000000000 // full access
    orr r2, r2, #0b000111100000 // domain number 15
    orr r2, r2, #0b000000010000 // bit 4 to one
    orr r2, r2, #0b000000000010 // set as 1 MB section
    push {r0-r3, lr}
    mov r0, r2
    bl _print_reg
    pop {r0-r3, lr}
    // r2 is 1101 1111 0010
loop:
    orr r3, r2, r1, lsl #20     // build pattern into empty register
    str r3, [r0, r1, lsl #2]     // use loop counter to create individual table base adresses
    push {r0-r3, lr}
    mov r0, r3
    bl _print_reg
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, r1, lsl #2
    bl _print_reg
    pop {r0-r3, lr}
    subs r1, r1,#1              // decrement loop counter
    bpl loop                    // loop until r1 goes negative
    
    // configure TTBCR
    MRC p15, 0, r0, c2, c0, 2   // read
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    and r0, r0, #0b000          // set TTBCR.N == 0, so that we use TTBR0 as ttb base
    MCR p15, 0, r0, c2, c0, 2 // write back
    
    // set location of table
    ldr r1, =TTB
    mrc p15, 0, r0, c2, c0, 0   // read TTBR0
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    
    orr r0, r1                  // write location of TTB to TTBR0
    mcr p15, 0, r0, c2, c0, 0   // write
    
    
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    
    
    
      
    
    //enable mmu
    MRC p15,0,r0,c1,c0,0          // Read control register
    ORR r0,r0,#0xC00000000        // Set asynchronous clocking mode bits
    ORR r0,r0,#0x1000             // Set enable instruction cache bit
    ORR r0,r0,#0x5                // Set enable data cache and MMU bits
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    MCR p15,0,r0,c1,c0,0          // Write to control register
    mov pc, lr
    //bl loop_forever_and_ever





.global _mmu_test
_mmu_test:
    // disable mmu
    mrc p15, 0, r1, c1, c0, 0 //access c1, system control register
    bic r1, r1, #0x1
    mcr p15, 0, r1, c1, c0, 0
    
    // disable L1 caches
    mrc p15, 0, r1, c1, c0, 0
    bic r1, r1, #(0x1 << 12)
    bic r1, r1, #(0x1 << 2)
    mcr p15, 0, r1, c1, c0, 0
    
    // invalidate caches
    // instruction
    mov r1, #0
    mcr p15, 0, r1, c7, c5, 0
    // get cache size ID
    mrc p15, 1, r0, c0, c0, 0
    
    push {r0-r3, lr}
    bl _print_reg //0000 0000 0111 0000 0000 1111 1110 0000 0001 1010
    pop {r0-r3, lr}
   
    ldr r3, =0x1ff
    and r0, r3, r0, LSR #13 // r0 is num sets -1
    
    push {r0-r3, lr}
    bl _print_reg //0000 0000 0111 0000 0000 1111 1110 0000 0001 1010
    pop {r0-r3, lr}
    
    mov r1, #0
way_loop:
    mov r3, #0
set_loop:
    mov r2, r1, lsl #30
    orr r2, r3, lsl #5           //r2 = set/way cache operation format.
    mcr p15, 0, r2, c7, c6, 2   // invalidate the line described by r2
    add r3, r3, #1              // increment counter
    cmp r0, r3              // check if the last set is reached
    bgt set_loop
    add r1, r1, #1
    cmp r1, #4
    bne way_loop
    
    // invalidate tlb
    mcr p15, 0, r1, c8, c7, 0
    
    // enable branch prediction
    mov r1, #0
    mrc p15, 0, r1, c1, c0, 0 // read control register
    orr r1, r1, #(0x1 << 11)
    mcr p15, 0,r1, c1, c0, 0
    
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    
    
    
    
    // enable L2 D-side prefetch
    mrc p15, 0, r1, c1, c0, 1   // Read auxiliary control register
    orr r1, r1, #(0x1 << 2)     // enable d side prefetc
    mcr p15, 0, r1, c1, c0, 1   // write auxiliary control register
    
    
    // DSB causes completion of all cache maintenance operations appearing in program
    // order before the DSB instruction.
    
    DSB
    
    // An ISB instruction causes the effect of all branch predictor maintenance
    // operations before the ISB instruction to be visible to all instructions
    // after the ISB instruction.
    
    ISB
    
    //Initialize page table
    
    ldr  r0, =0b00000000000000000000110111100010
    // r0 is the non-adress part of descriptor
    ldr r1, =ttb_address
    ldr r3, = 4095          // loop counter
write_pte:
    push {r0-r3, lr}
    mov r0, r3
    bl _print_reg
    pop {r0-r3, lr}
    orr r2, r0, r3, lsl #20     // or together address & default PTE bits
    str r2, [r1, r3, lsl #20]   // write PTE to TTB
    subs r3, r3, #1             // decrement loop counter
    bne write_pte
    
    
    bic r0, r0, #0b1100         // clear CB bits
    orr r0, r0, #0b0100         // inner write-back, write allocate
    bic r0, r0, #0b111000000000000  // clear tex bits
    orr r0, r0, #0b101000000000000  // set tex as write-back, write allocate
    orr r0, r0, #0b10000000000000000 // shareable.
    str r0, [r1]
    
    //initialize mmu
    mov r1, #0x0
    mcr p15, 0, r1, c2, c0, 2   // write translation table base control register
    ldr r1, =ttb_address 
    mcr p15, 0, r1, c2, c0, 0   // write translation table base register 0
    
    ldr r1, = 0x55555555
    mcr p15, 0, r1, c3, c0, 0   // write domain access control register
    
    
    
    push {r0-r3, lr}
    ldr r0, =ttb_address
    bl _print_reg
    pop {r0-r3, lr}
    
    
    
    // enable mmu
    mrc p15, 0, r1, c1, c0, 0   // read control register config data
    orr r1, r1, #0x1            // set bit 0 that is mmu enable
    mcr p15, 0, r1, c1, c0, 0   // write control register config data
    
    push {r0-r3, lr}
    ldr r0, =ttb_address
    bl _print_reg
    pop {r0-r3, lr}
    
    mov pc, lr
    
 
