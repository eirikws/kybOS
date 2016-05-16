#ifndef DRIVERS_H
#define DRIVERS_H

#include "pcb.h"

typedef enum{
    DRIVER_TIMER,
    DRIVER_GPIO,
    DRIVER_UART,
}driver_irq_t;


void driver_register(process_id_t id, char* name, int* errors);
process_id_t driver_get(char* name);
int driver_remove(process_id_t id);
process_id_t driver_irq_get(driver_irq_t type);
void drivers_init(void);
#endif
