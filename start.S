.section ".text.startup"

.global _start
.global _get_stack_pointer
.global _enable_interrupts
.global _get_cpsr
.global _set_cpu_mode
.global _SYSTEM_CALL
.global _init_thr_stack
.global _push_stack_pointer
.global _generate_yield
.global _init_branch
.global _gpio_fsel
.global _fpu_enable
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
.equ    STACK_SVR,              (0xf0000) // these adresses are within 
.equ    STACK_UNDEF,            (0x100000)// the first 1 MB block of memory
.equ    STACK_IRQ,              (0xf8000) // because of 1 MB page table!  
.equ    STACK_ABORT,            (0xfc000)
.equ    STACK_INIT,             (0x100000)
.equ    STACK_SYSTEM,           (0xfa000)

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
    ldr     r0, =_start
    mov     r1, #0x0000
    ldmia   r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    stmia   r1!,{r2, r3, r4, r5, r6, r7, r8, r9}
    ldmia   r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    stmia   r1!,{r2, r3, r4, r5, r6, r7, r8, r9}

    //  setup the stack pointer for the interrupt mode
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(STACK_IRQ)
    
    // setup Undefined
    mov r0, #(CPSR_MODE_UNDEFINED | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(STACK_UNDEF)
    
    //setup Abort
    mov r0, #(CPSR_MODE_ABORT | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(STACK_ABORT)
    
    //  setup the user/system stack pointer. These modes share registers.
    //  switch to system mode because the we are able to switch back!
    mov r0, #(CPSR_MODE_SYSTEM | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(STACK_SYSTEM)
    //  switch back to supervisor mode and set the stack pointer
    //  to init stack. The stack will work down, and the heap up.
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0

    //  set the stack pointer at some point in RAM.
    mov sp, #(STACK_INIT)

    //  Setup the c runtime
    bl      _cstartup

    // Should never come here, but if it does, loop forever for debug purpuses
_inf_loop:
    b       _inf_loop
    

interrupt_vector:
    sub lr, lr, #4
    push {r0-r3, ip, lr}
    bl interrupt_vector_c   // returns with 1 in r0 if to perform context switch
    cmp r0, #0          // if r0 is zero, do not perform context switch
    ldmeq sp!, {r0-r3, ip, pc}^
    // if not, branch to context switch with correct mode
    pop {r0-r3, ip, lr}
find_origin_context_switch:
    push {r0}
    mrs r0, spsr
    and r0, r0, #(CPSR_MODE_FILTER)
    cmp r0, #(CPSR_MODE_USER)
    popeq {r0}
    beq build_context_stack_user    // perform context switch from user
    cmp r0, #(CPSR_MODE_SVR)
    popeq {r0}
    beq build_context_stack_svr    //else from supervisor
    // add more as needed. at this point of time interrupts
    // are only enabled in svr and usr mode  


build_context_stack_user:
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
     
    mov r0, sp // save SP so we can use it as parameter in the handler
    
    mov r1, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    
    b context_switch

build_context_stack_svr:
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

    mov r0, sp  // save SP so we can use it as parameter in the handler
    mov r1, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r1
    b context_switch

context_switch:
    bl context_switch_c // givecontext_switchent, returns with a new sp

    mov r1, sp  // irq mode sp
    mov sp, r0  // target sp
    mov r4, r0  // store target sp in r4
    
// determine target mode by pop the cpsr
    pop {r0}
    push {r0}
    mov sp, r1  // move irq sp back
    and r0, r0, #(CPSR_MODE_FILTER)
    cmp r0, #(CPSR_MODE_USER)
    beq pop_return_stack_user
    cmp r0, #(CPSR_MODE_SVR)
    beq pop_return_stack_svr

pop_return_stack_user:
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
    
    
    ldm sp!, {r0-r12, pc}^
    

pop_return_stack_svr:
    // build the return stack
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    
    mov sp, r4
    pop {r0-r2} // spsr, pc, lr
    
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

    ldm sp!, {r0-r12, pc}^
    
    //  Called when a user thread wants to generate a reschedule
    //  with a swi call. This branch is called in SVR mode.
    //  must move SPSR and LR to IRQ mode
software_context_switch:
    push {r0-r2}
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
    mov r3, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r3
    pop {r3}
    b find_origin_context_switch

software_interrupt_vector:
    // use OS svr stack
    push {r4}   // store r4 for extra space
    mov r4, sp  // store current process stack in r4
    mov sp, #(STACK_SVR)

    // call the software interrupt vector in c
    push {ip, lr}
    bl software_interrupt_vector_c
    pop {ip, lr}
    mov sp, r4  // move current process stack back into sp
    pop {r4}    // retrieve r4 that was stored earlier
    // there is now zero stack used
    // check if to context switch
    // software_interrupt_vector_c returns with 1 or 0.
    // 1 means to context switch!
    cmp r0, #0
    bne software_context_switch
    // if not, return
    push {lr}
    ldm sp!,{pc}^


prefetch_abort_vector:
    sub lr, lr, #4
    push {r0-r3, ip, lr}
    mov r0, lr
    mrs r3, cpsr
    mrs r2, spsr
    msr cpsr_c, r2 
    mov r1, sp
    msr cpsr_c, r3
    bl prefetch_abort_vector_c
    // reschedule. dont have to save stack
        
    //b abort_reschedule


    ldm sp!, {r0-r3, ip, pc}^


data_abort_vector:
    sub lr, lr, #8
    push {r0, r1, r2, r3, ip, lr}
    mov r0, lr
    mrs r3, cpsr
    mrs r2, spsr
    msr cpsr_c, r2 
    mov r1, sp
    msr cpsr_c, r3
    bl data_abort_vector_c
    ldm sp!, {r0-r3, ip, pc}^

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
    push {ip, lr}
    swi #0
    pop {ip, pc}

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
     

.global _process_stack_init
    // r0 carries sp, r1 location of code, r2 cpsr
_process_stack_init:
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

_fpu_enable:
    push {r0, r1, r2, r3, lr}
    mrc p15, 0, r0, c1, c1, 2
    orr r0, r0, #0xc00
    mcr p15, 0, r0, c1, c1, 2
    mov r0, #0xf00000
    mcr p15, 0, r0, c1, c0, 2
    mov r3, #0x40000000
    vmsr fpexc, r3
    pop {r0, r1, r2, r3, pc}

.global _get_scr
_get_scr:
    mrc p15, 0, r0, c1, c1, 0
    bx lr

