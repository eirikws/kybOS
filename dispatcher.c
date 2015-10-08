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

void priority_print(int pri){
    int i = 0;
    priority_node_t* node = priority_array[pri].head;
    if(node == NULL){   return;}
    uart_puts("priority print ");
    uart_put_uint32_t(pri, 10);
    uart_puts(": ");
    while(1){
        uart_put_uint32_t(node->id, 10);
        uart_puts(", ");
        if (node->next == NULL || i++ >10){
            uart_puts("\r\n");
            return;
        }
        node = node->next;
    }
}

void priority_print_list(void){
    int i;
    for(i=NUM_PRIORITIES-1; i>-1; i--){
        priority_print(i);
    }
    return;
}

static int priority_pop(int priority){
    uart_puts("priority pop: ");
    uart_put_uint32_t(priority, 10);
    uart_puts("\r\n");
    //  check priority is within bounds
    if (priority < 0 || priority > NUM_PRIORITIES){ return -1;}
    //  if empty
    else if (priority_array[priority].head == NULL){ return -1;}
    // if one item
    else if (priority_array[priority].head == priority_array[priority].tail){
        priority_node_t* tmp = priority_array[priority].head;
        priority_array[priority].head = NULL;
        priority_array[priority].tail = NULL;
        int retval = tmp->id;
        free(tmp);
        uart_puts("priority pop: one item: ");
        uart_put_uint32_t(retval, 10);
        uart_puts("\r\n");
        return retval;
    // if more than one item
    } else {
        priority_node_t* tmp = priority_array[priority].head;
        tmp->next->prev=NULL;
        priority_array[priority].head = tmp->next;
        int retval = tmp->id;
        free(tmp);
        uart_puts("priority pop: more than one item: ");
        uart_put_uint32_t(retval, 10);
        uart_puts("\r\n");
        return retval;
    }
        
}

    // iterate through list. return -1 if empty
static int get_highest_priority(void){
    int i, retval;
    for (i = NUM_PRIORITIES-1; i>-1; i--){
        retval = priority_pop(i);
        if (retval > -1){
            uart_puts("get highest pri returns with: ");
            uart_put_uint32_t(retval, 10);
            uart_puts("\r\n");
            return retval;
        }
    }
    uart_puts("get highest pri failed\r\n");
    
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
        uart_puts("priority enqueue into existing list: ");
        uart_put_uint32_t(priority, 10);
        uart_puts("\r\n");
        priority_node_t* tmp = priority_array[priority].tail;
        tmp->next = node;
        node->prev = tmp;
        priority_array[priority].tail = node;
        return 1;
    }
}

int dispatch_enqueue(uint32_t id){
    priority_node_t* node =  newNode(id);
    PCB_t* mypcb = pcb_get(id);
    if (mypcb == NULL){ 
        uart_puts("dispatch enqueue ");
        uart_put_uint32_t(id, 10);
        uart_puts(" mypcb == NULL\r\n");
        return -1;
    
    }
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
    priority_print_list();
    PCB_t* pcb;
    int err = 0;
    
    if (current_running != -1){

        err = dispatch_enqueue(current_running);
        if (err == -1){
            uart_puts("requing error\r\n");
        }
        save_stack_ptr(current_running);
        uart_puts("saved sp: ");
        uart_put_uint32_t(pcb_get(current_running)->context_data.SP, 16);
        uart_puts("\r\n");
    }
    current_running = get_highest_priority();
    
    uart_puts("current running: ");
    uart_put_uint32_t(current_running, 10);
    uart_puts("\r\n");
    
    pcb = pcb_get(current_running);
    uart_puts("loading sp: ");
    uart_put_uint32_t(pcb->context_data.SP, 16);
    uart_puts("\r\n");
    _push_stack_pointer(pcb->context_data.SP);
    priority_print_list();
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

uint32_t get_current_running(void){
    return current_running;
}
