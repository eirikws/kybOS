#ifndef DRIVERS_H
#define DRIVERS_H

#include "scheduler.h"
#include "pcb.h"

#define DRIVER_NAME_SIZE        20

typedef enum{
    DRIVER_TIMER,
    DRIVER_GPIO,
    DRIVER_UART,
}driver_irq_t;


scheduling_type_t driver_register(process_id_t id, char* name, int* errors);
process_id_t driver_get(char* name);
int driver_remove(process_id_t id);
process_id_t driver_irq_get(driver_irq_t type);
void drivers_init(void);
#endif
