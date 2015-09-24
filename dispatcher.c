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
int32_t static current_running = 0;

void __attribute__((constructor)) init_pri_array(void){
    int i;
    for ( i=0; i<NUM_PRIORITIES; i++){
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
        if (i > -1){
            return retval;
        }
    }
    return -1;
}

static int priority_enqueue(priority_node_t* node, int priority){
    //  check priority is within bounds
    if( priority < 0 || priority > NUM_PRIORITIES){ return -1;}
    //  if empty
    if (priority_array[priority].tail = NULL){
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

int dispatch_enqueue(int32_t id){
    priority_node_t* node =  newNode(id);
    if (node == NULL){ return -1;}
    PCB_t* mypcb = pcb_get(id);
    if (mypcb == NULL){ return -1;}
    return priority_enqueue( node, mypcb->priority );
}


extern _save_prog_context_irq(PCB_t* pcb);
extern _load_program_context(PCB_t* pcb);

void dispatch(void){
    //  save old context
    _save_prog_context_irq(pcb_get(current_running));
    //  put it in priority list
    dispatch_enqueue(current_running);
    //  get the next thread to be run
    current_running = get_highest_priority();
    // load new program context... and decrease stack?
    _load_program_context_irq(pcb_get(current_running));
    // set current running
    
    // return   
}


