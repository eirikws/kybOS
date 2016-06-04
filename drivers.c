#include "string.h"
#include "uart.h"
#include "pcb.h"
#include "drivers.h"



struct driver_irqs{
    process_id_t timer;
    process_id_t gpio;
    process_id_t uart;
    // add more as needed!
};

static struct driver_irqs irq_drivers;

void drivers_init(void){
    irq_drivers.timer = NULL_ID;
    irq_drivers.gpio = NULL_ID;
    irq_drivers.uart = NULL_ID;
}    

typedef struct driver{
    char name[DRIVER_NAME_SIZE];
    process_id_t id;
    struct driver* next;
}driver_t;

driver_t *os_drivers;

process_id_t driver_irq_get(driver_irq_t type){
    switch(type){
        case DRIVER_TIMER:
        return irq_drivers.timer;
        break;
        case DRIVER_GPIO:
        return irq_drivers.gpio;
        break;
        case DRIVER_UART:
        return irq_drivers.uart;
        default:
        return NULL_ID;
    }
}

driver_t* driver_create(process_id_t id, char* name){
    driver_t* node = (driver_t*)malloc(sizeof(driver_t));
    node->id = id;
    strncpy(node->name, name, DRIVER_NAME_SIZE);
    node->name[DRIVER_NAME_SIZE-1] = '\0';    // ensure zero termination
    return node;
}

scheduling_type_t driver_register(process_id_t id, char* name, int* errors){
    // allocate space
    driver_t *node = driver_create(id, name);
    if( node == NULL){
        uart_puts("driver_add: failed to initialize node\r\n");
        *errors = 1;
        return NO_RESCHEDULE;
    }
    uart_puts("driver register: ");
    uart_puts(name);
    uart_puts("\r\n");
    node->next = os_drivers;
    os_drivers = node;
    
    if( strcmp( node->name, "uart" ) == 0){
        irq_drivers.uart = id;
    }else if(strcmp( node->name, "timer") == 0){
        irq_drivers.timer = id;
    }else if(strcmp( node->name, "gpio") == 0){
        irq_drivers.gpio = id;
    }
    *errors = 0;
    return NO_RESCHEDULE;
}

int driver_remove(process_id_t id){
    driver_t **pp = &os_drivers;
    driver_t *del = NULL;
    while(*pp){
        if( pcb_id_compare( (*pp)->id, id) == 1){
            del = *pp;
            *pp = (*pp)->next;
            free(del);
            return 1;
        }
        pp = &(*pp)->next;
    }
    return 0;
}

process_id_t driver_get(char* name){
    driver_t *node = os_drivers;
    while(node){
        uart_puts(node->name);
        uart_puts("\r\n");
        if( strncmp(node->name, name, DRIVER_NAME_SIZE) == 0){
            // has found driver
            return node->id;
        }
        node = node->next;
    }
    // did not find driver
    return NULL_ID;
}

