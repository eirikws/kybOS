#include <stdlib.h>
#include <stdint.h>
#include "uart.h"
#include "pcb.h"
#include "dispatcher.h"

typedef struct priority_node{
    int32_t id;
    struct priority_node* next;
    struct priority_node* prev;
} priority_node_t;

typedef struct priority_list{
    priority_node_t* head;
    priority_node_t* tail;
} priority_list_t;

priority_list_t priority_array[NUM_PRIORITIES];
int32_t static current_running = -1;

void init_pri_array(void){
    uart_puts("init pri array\r\n");
    int i;
    for ( i=0; i<NUM_PRIORITIES; i++){
      //  uart_put_uint32_t(i,10);
       // uart_puts("\r\n");
        priority_array[i].head = NULL;
        priority_array[i].tail = NULL;
    }
}

static priority_node_t* newNode(int32_t id){
    priority_node_t *newNode = malloc(sizeof(priority_node_t));
    if (newNode == NULL){
        uart_puts("Failed to allocate new priority_node!\r\n");
        return newNode;
    }
    newNode->id = id;
    newNode->next = NULL;
    newNode->prev = NULL;
    return newNode;
}

static int priority_pop(int priority){
    //  check priority is within bounds
    if (priority < 0 || priority > NUM_PRIORITIES){ return -1;}
    //  if empty
    else if (priority_array[priority].head == NULL){ return -1;}
    // if one item
    else if (priority_array[priority].head == priority_array[priority].tail){
        priority_node_t* tmp = priority_array[priority].head;
        priority_array[priority].head = priority_array[priority].tail;
        priority_array[priority].tail = priority_array[priority].head;
        int retval = tmp->id;
        free(tmp);
        return retval;
    // if more than one item
    } else {
        priority_node_t* tmp = priority_array[priority].head;
        tmp->next->prev=NULL;
        priority_array[priority].head=priority_array[priority].head->next;
        int retval = tmp->id;
        free(tmp);
        return retval;
    }
        
}

    // iterate through list. return -1 if empty
static int get_highest_priority(void){
    int i, retval;
    for (i = NUM_PRIORITIES-1; i>-1; i--){
        retval = priority_pop(i);
        if (retval > -1){
            uart_puts("highest pri retval: ");
            uart_put_uint32_t(retval, 10);
            uart_puts("\r\n");
            return retval;
        }
    }
    return -1;
}

static int priority_enqueue(priority_node_t* node, int priority){
    //  check priority is within bounds
    if( priority < 0 || priority > NUM_PRIORITIES-1){ 
        uart_puts("priority out of bounds\r\n");
        return -1;
    }
    //  if empty
    if (priority_array[priority].tail == NULL){
        uart_puts("priority enqueue into empty list\r\n");
        priority_array[priority].head = node;
        priority_array[priority].tail = node;
        return 1;
    } else {
        uart_puts("priority enqueue into existing list\r\n");
        priority_node_t* tmp = priority_array[priority].tail;
        tmp->next = node;
        node->prev = tmp;
        priority_array[priority].tail = node;
        return 1;
    }
}

int dispatch_enqueue(int32_t id){
    priority_node_t* node =  newNode(id);
    if (node == NULL){ return -1;}
    PCB_t* mypcb = pcb_get(id);
    if (mypcb == NULL){ return -1;}
    uart_puts("dispatch enqueue id: ");
    uart_put_uint32_t(node->id, 10);
    uart_puts("\r\n");
    return priority_enqueue( node, mypcb->priority );
}


extern uint32_t _get_user_sp(void);

void save_stack_ptr( uint32_t id){
    PCB_t* pcb = pcb_get(id);
    pcb->context_data.SP = _get_user_sp();
    return;
}


extern _save_prog_context_irq(PCB_t* pcb);
extern _load_program_context(PCB_t* pcb);
extern _load_basic(uint32_t lr);
extern _push_stack_pointer(uint32_t sp);

void dispatch(void){
    //  save old context
    uart_puts("dispatch begin \r\n");
    
    //  put it in priority list
    //  and save stack pointer in pcb
    if (current_running != -1){
        uart_puts("requeuing: ");
        uart_put_uint32_t(current_running, 10);
        uart_puts("\r\n");
        dispatch_enqueue(current_running);
        save_stack_ptr(current_running);
    }
    //  get the next thread to be run
    uart_puts("getting new highest priority: ");
    current_running = get_highest_priority();
    uart_put_uint32_t((uint32_t)current_running, 10);
    uart_puts("\r\n");
    // load new program context... and decrease stack?
    uart_puts("loading prog");
    uart_put_uint32_t((uint32_t)current_running, 10);
    uart_puts("\r\n");
    
    //_load_basic(pcb_get(current_running)->context_data.LR);
    
    //_load_program_context_irq(pcb_get(current_running));
    // set current running
    
    _push_stack_pointer(pcb_get(current_running)->context_data.SP);
    get_cpu_mode();
    uart_puts("returning from dispatch\r\n");
    return;
}

void _print_reg(uint32_t reg){
    uart_puts("print reg: ");
    uart_put_uint32_t(reg, 16);
    uart_puts("\r\n");
    return;
}

void _get_stack_top(uint32_t* top){
    uart_puts("top of stack contains: ");
    uart_put_uint32_t(*top, 16);
    uart_puts("\r\n");
}

