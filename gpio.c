
#include <stdint.h>

#include "base.h"
#include "gpio.h"


#define GPIO_BASE 	( PERIPHERALS_BASE + 0x00200000 )

static gpio_t* Gpio = (gpio_t*)GPIO_BASE;

gpio_t* GetGpio(void)
{
    return Gpio;
}

void GpioInit(void)
{

}
