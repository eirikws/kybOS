

#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "uart.h"
#include "pcb.h"


static PCB_t *head = NULL;
static PCB_t *tail = NULL;

void save_stack_ptr( process_id_t id, uint32_t stack_pointer){
    PCB_t* pcb = pcb_get(id);
    if (pcb == NULL){
        uart_puts("save stack ptr process not found\r\n");
        return;
    }
    pcb->stack_pointer = stack_pointer;
    return;
}

int pcb_id_compare(process_id_t id1, process_id_t id2){
    if (id1.id_number == id2.id_number){ return 1; }
    return 0;
}

//Creates a new Node and returns pointer to it. 
static PCB_t* pcb_new(PCB_t pcb) {
	PCB_t* newNode = (PCB_t*)malloc(sizeof(PCB_t));
    if (newNode == NULL){
        uart_puts("pcb_new malloc failed\r\n");
        return NULL;
    }
    *newNode = pcb;
	newNode->prev = NULL;
	newNode->next = NULL;
	return newNode;
}

int pcb_insert(PCB_t pcb) {
	PCB_t* newNode = pcb_new(pcb);
    if (newNode == NULL){   return -1;}
	if (head == NULL){
		head = newNode;
		tail = newNode;
		return 1;
	}
	head->prev = newNode;
	newNode->next = head;
	head = newNode;
    return 1;
}

PCB_t* pcb_get(process_id_t id){
    if (head == NULL) {return NULL;}
    PCB_t* ite = head;
    while( !pcb_id_compare(id, ite->id)){
        if (ite->next == NULL){ 
            return NULL;
        }
        ite = ite->next;
    }
    return ite;
}

void pcb_print(void){
    PCB_t* ite = head;
    uart_puts("PCB list contains: ");
    while( ite != NULL){
        uart_put_uint32_t(ite->id.id_number, 10);
        uart_puts(", ");
        ite = ite->next;
    }
    uart_puts("\r\n");
}

int pcb_remove(process_id_t id){
    if (head == NULL) {return -1;} // is empty
    PCB_t* ite = head;
    PCB_t* ite2 = head;
    while( !pcb_id_compare(id, ite->id)){
        if (ite->next == NULL){ return -1;}
        ite = ite->next;
    }
    if (head==tail){ // id is head and tail (the only item in list)
        free(ite);
        head=NULL;
        tail=NULL;
     }
    else if (head==ite){ // id is head
        ite2=ite->next;
        free(ite);
        head=ite2;
        ite2->prev=NULL;
    }
    else if (tail==ite){ // id is tail
        ite2=ite->prev;
        free(ite);
        tail=ite2;
        ite2->next=NULL;
    }
    else{ // is somewhere in the middle
        ite2=ite->prev;
        ite=ite->next;
        free(ite->prev);
        ite2->next=ite;
        ite->prev=ite2;
    } return 1;
}

