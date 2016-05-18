#include <stdlib.h>
#include <stdint.h>
#include "mmu.h"
#include "uart.h"
#include "pcb.h"
#include "memory.h"
#include "scheduler.h"

typedef struct priority_node{
    process_id_t id;
    struct priority_node* next;
    struct priority_node* prev;
} priority_node_t;

typedef struct priority_list{
    priority_node_t* head;
    priority_node_t* tail;
} priority_list_t;

static priority_list_t priority_array[NUM_PRIORITIES];
static process_id_t current_running_process = {0};

static priority_node_t* newNode(process_id_t id){
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

static void priority_print(int pri){
    int i = 0;
    priority_node_t* node = priority_array[pri].head;
    if(node == NULL){   return;}
    uart_puts("priority print ");
    uart_put_uint32_t(pri, 10);
    uart_puts(": ");
    while(1){
        uart_put_uint32_t(node->id.id_number, 10);
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
    uart_puts("priority print list:\r\n");
    for(i=NUM_PRIORITIES-1; i>-1; i--){
        priority_print(i);
    }
    return;
}

static process_id_t priority_pop(int priority){
    //  check priority is within bounds
    process_id_t retval;
    retval.id_number = -1;
    if (priority < 0 || priority > NUM_PRIORITIES){ return retval;}
    //  if empty
    else if (priority_array[priority].head == NULL){ return retval;}
    // if one item
    else if (priority_array[priority].head == priority_array[priority].tail){
        priority_node_t* tmp = priority_array[priority].head;
        priority_array[priority].head = NULL;
        priority_array[priority].tail = NULL;
        retval = tmp->id;
        free(tmp);
        return retval;
    // if more than one item
    } else {
        priority_node_t* tmp = priority_array[priority].head;
        tmp->next->prev=NULL;
        priority_array[priority].head = tmp->next;
        retval = tmp->id;
        free(tmp);
        return retval;
    }
        
}

    // iterate through list. return -1 if empty
static process_id_t pop_highest_priority(void){
    process_id_t retval;
    
    int i;
    for (i = NUM_PRIORITIES-1; i>-1; i--){
        retval = priority_pop(i);
        if (retval.id_number > -1){
            return retval;
        }
    }
    retval.id_number = -1;
    uart_puts("KERN ERROR: get highest priority failed\r\n");
    return retval;
}

static int priority_enqueue(priority_node_t* node, int priority){
    //  check priority is within bounds
    if( priority < 0 || priority > NUM_PRIORITIES-1){ 
        uart_puts("priority out of bounds");
        uart_put_uint32_t(priority, 10);
        uart_puts("\r\n");
        return -1;
    }
    //  if empty
    if (priority_array[priority].tail == NULL){
        priority_array[priority].head = node;
        priority_array[priority].tail = node;
        return 1;
    } else {
        priority_node_t* tmp = priority_array[priority].tail;
        tmp->next = node;
        node->prev = tmp;
        priority_array[priority].tail = node;
        return 1;
    }
}

int scheduler_enqueue(process_id_t id){
    priority_node_t* node =  newNode(id);
    PCB_t* mypcb = pcb_get(id);
    if (mypcb == NULL){ 
        return -1;
    }
    if (mypcb->state == READY && !mypcb->is_queued){
        mypcb->is_queued = 1;
        return priority_enqueue( node, mypcb->priority );
    }
    return -1;
}

void reschedule(void){
    // implement some kind of policy
    // this always selects the highest priority
    // and round robin on those with equal priority
    if (!pcb_id_compare( current_running_process, NULL_ID)){
        scheduler_enqueue(current_running_process);
    }
    process_id_t retval;
    while(  retval = pop_highest_priority(), pcb_get(retval) == NULL){ /* do northing*/}
    pcb_get(retval)->is_queued = 0;
    current_running_process = retval;
}

// save old sp, return new sp, do MMU things
uint32_t context_switch_c(uint32_t old_sp){
    process_id_t previous_running_process = get_current_running_process();
    
    reschedule();
    PCB_t* pcb = pcb_get( previous_running_process);
    if(pcb != NULL){
        // if no errors, save old sp
        pcb->context_data.SP = old_sp;
        memory_perform_process_unmapping(previous_running_process);
       // unmap memory of old process
    }

    // load new sp
    pcb = pcb_get( current_running_process);
    if (pcb == NULL){
        uart_puts("KERN Error: Load process context_switch_c\r\n");
        //  if cant load a process stack pointer, return with...
        //  IDK, zero I guess. Something something something...
        return 0;
    }
    memory_perform_process_mapping(current_running_process);
        // if no errors, return the stack pointer!
    return pcb->context_data.SP;
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

process_id_t get_current_running_process(void){
    return current_running_process;
}
