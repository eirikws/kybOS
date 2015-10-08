

#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "uart.h"
#include "pcb.h"


static PCB_t *head = NULL;
static PCB_t *tail = NULL;



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
		pcb_print();
		return 1;
	}
	head->prev = newNode;
	newNode->next = head;
	head = newNode;
	//pcb_print();
    return 1;
}

PCB_t* pcb_get(uint32_t id){
    //pcb_print();
    if (head == NULL) {return NULL;}
    PCB_t* ite = head;
    while( id != ite->id){
        if (ite->next == NULL){ return NULL;}
        ite = ite->next;
    }
    return ite;
}

void pcb_print(void){
    PCB_t* ite = head;
    uart_puts("PCB list contains: ");
    while( ite != NULL){
        uart_put_uint32_t(ite->id, 10);
        uart_puts(", ");
        ite = ite->next;
    }
    uart_puts("\r\n");
}

int pcb_remove(uint32_t id){
    if (head == NULL) {return -1;} // is empty
    PCB_t* ite = head;
    PCB_t* ite2 = head;
    while( id != ite->id){   
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
