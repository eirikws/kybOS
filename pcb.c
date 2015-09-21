

#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "pcb.h"





static PCB_t *head;
static PCB_t *tail;

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

int pcb_free(PCB_t* pcb){
    free(pcb);
    return 1;
}

int pcb_insert(PCB_t pcb) {
	PCB_t* newNode = pcb_new(pcb);
    if (newNode == NULL){   return -1;}
	if (head == NULL){
		head = newNode;
		return 1;
	}
	head->prev = newNode;
	newNode->next = head; 
	head = newNode;
    return 1;
}

PCB_t* pcb_get(char* id){
    if (head == NULL) {return NULL;}
    PCB_t* ite = head;
    uart_puts("\r\n");
    while( strcmp(id, ite->id)){
        if (ite->next == NULL){ return NULL;}
        ite = ite->next;
    }
    return ite;
}

int pcb_remove(char* id){
    if (head == NULL) {return -1;} // is empty
    PCB_t* ite = head;
    PCB_t* ite2 = head;
    while(!strcmp(id, ite->id)){   
        if (ite->next == NULL){ return -1;}
        ite = ite->next;
    }
    if (head==tail){ // id is head and tail (the only item in list)
        pcb_free(ite);
        head=NULL;
        tail=NULL;
     }
    else if (head==ite){ // id is head
        ite2=ite->next;
        pcb_free(ite);
        head=ite2;
        ite2->prev=NULL;
    }
    else if (tail==ite){ // id is tail
        ite2=ite->prev;
        pcb_free(ite);
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
