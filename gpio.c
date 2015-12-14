
#include <stdint.h>

#include "base.h"
#include "gpio.h"


#define GPIO_BASE 	( PERIPHERAL_BASE + 0x00200000 )

static gpio_t* Gpio = (gpio_t*)GPIO_BASE;

gpio_t* get_gpio(void)
{
    return Gpio;
}

void gpio_init(void)
{

}


