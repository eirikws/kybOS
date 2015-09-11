
#include <stdint.h>
#include "gpio.h"

static gpio_t* Gpio = (gpio_t*)GPIO_BASE;

gpio_t* GetGpio(void)
{
    return Gpio;
}

void GpioInit(void)
{

}
