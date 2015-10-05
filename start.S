
.section ".text.startup"

.global _start
.global _get_stack_pointer
.global _exception_table
.global _enable_interrupts
.global _get_cpsr
.global _set_cpu_mode
.global _generate_swi
.global _pcb_set_arg
.global _save_prog_context_irq
.global _load_program_context_irq
.global _init_thr_stack
.global _load_basic
.global _push_stack_pointer
.global _get_user_sp
.global _asm_reload

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
    mov     sp, #(64 * 1024 * 1024)

    //  Setup the c runtime
    bl      _cstartup

    // Should never come here, but if it does, loop forever for debug purpuses
_inf_loop:
    b       _inf_loop
    
    // save and restore all registers on the user stack of active thread

interrupt_vector:
    sub lr, lr, #4
    
    push {r0-r3, lr}
    bl _print_reg
    pop {r0-r3, lr}
    push {r0-r3, lr}
    mov r0, lr
    bl _print_reg
    mov r0, r9
    bl _print_reg
    mrs r0, cpsr
    bl _print_reg
    mrs r0, spsr
    bl _print_reg
    pop {r0-r3, lr}
    
    push {r9}
    mov r9, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r9
    push {r0-r12,lr}
    
    push {r0-r3}
    mov r0, lr
    bl _print_reg
    pop {r0-r3}
    
    
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r1
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r2
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r3
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r4
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r5
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r6
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r7
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r8
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r9
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r10
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, r11
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    
    mov r0, r12
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, sp
    sub r0, r0, #60
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mov r0, lr
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    
    pop {r0-r12,lr}
    mov r9, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r9
    pop {r9}
    
    push {r0-r6} // store stuff temp
    mrs r5, spsr
    mov r6, lr // thread pc
    
    push {r0-r3}
    bl print_line
    pop {r0-r3}
    
    
    mov r4, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r4
    
    push {r0-r3}
    mov r0, lr
    bl _print_reg
    pop {r0, r3}
    
    push {r7-r12, lr}
    
    
    mov r9, r6  // move PC to safety
    mov r8, r5  // move spsr to safety ;)
    mov r4, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r4
    pop {r0-r6}
    mov r7, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r7
    push {r0-r6}
    push {r8, r9}
    /*
    mov r0, sp
    mov r4, r0
    bl _get_stack_top
    add r0, r4, #4
    bl _get_stack_top
    add r0, r4, #8
    bl _get_stack_top
    add r0, r4, #12
    bl _get_stack_top
    add r0, r4, #16
    bl _get_stack_top
    add r0, r4, #20
    bl _get_stack_top
    add r0, r4, #24
    bl _get_stack_top
    add r0, r4, #28
    bl _get_stack_top
    add r0, r4, #32
    bl _get_stack_top
    add r0, r4, #36
    bl _get_stack_top
    add r0, r4, #40
    bl _get_stack_top
    add r0, r4, #44
    bl _get_stack_top
    add r0, r4, #48
    bl _get_stack_top
    add r0, r4, #52
    bl _get_stack_top
    add r0, r4, #56
    bl _get_stack_top
    add r0, r4, #60
    bl _get_stack_top
    */
    
    mov r7, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r7
    bl interrupt_vector_c
    mov r7, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
    msr cpsr_c, r7
    pop {r0-r1}    // pop cpsr, pc that we stored
    mov r7, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
    msr cpsr_c, r7
    msr spsr, r0
    push {r1} // push pc
    mov r7, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
    msr cpsr_c, r7
    pop {r0-r12, lr}
    push {r0-r2}
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
    msr cpsr_c, r0
    push {r3-r12, lr}
    mov r7, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
    msr cpsr_c, r7
    pop {r0-r2}
    mov r7, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
    msr cpsr_c, r7
    push {r0-r2}
    
    
    mrs r0, cpsr
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    mrs r0, spsr
    push {r0-r3}
    bl _print_reg
    pop {r0-r3}
    /*
    mov r0, sp
    mov r4, r0
    bl _get_stack_top
    add r0, r4, #4
    bl _get_stack_top
    add r0, r4, #8
    bl _get_stack_top
    add r0, r4, #12
    bl _get_stack_top
    add r0, r4, #16
    bl _get_stack_top
    add r0, r4, #20
    bl _get_stack_top
    add r0, r4, #24
    bl _get_stack_top
    add r0, r4, #28
    bl _get_stack_top
    add r0, r4, #32
    bl _get_stack_top
    add r0, r4, #36
    bl _get_stack_top
    add r0, r4, #40
    bl _get_stack_top
    add r0, r4, #44
    bl _get_stack_top
    add r0, r4, #48
    bl _get_stack_top
    add r0, r4, #52
    bl _get_stack_top
    add r0, r4, #56
    bl _get_stack_top
    add r0, r4, #60
    bl _get_stack_top
    */
    mrs r0, cpsr
    bl _print_reg
    mrs r0, spsr
    bl _print_reg
    
    ldm sp!, {r0-r12,lr, pc}^

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

_generate_swi:
    swi #0
    mov pc, lr

_get_cpsr:
    mrs r0, cpsr
    mov pc, lr

    // r0 has pointer to pcb, r1 the arg
    // #12 is the offset in PDB_t to r0
_pcb_set_arg:
    str r1, [r2, #12]
    mov pc, lr

    // this function goes to system mode and pushes a pointer to a new stack
_push_stack_pointer:
    /*
    push {r0, lr}
    bl _print_reg
    pop {r0,lr}
    */
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
    push {r1}
    
    mov r1, #42
    push {r1}
    mov r1, #0
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    push {r1}
    //sub sp, #52
    mov r0, #42
    push {r0}
    push {r0}
    push {r2}
    mov r0, sp
    mov sp, r3
    mov pc, lr
    
    
    //r0 with sp
_asm_reload:
    mov sp, r0
    pop {r0}
    msr cpsr, r0
    ldm sp!, {r0-r12, lr,pc}
    
    
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
