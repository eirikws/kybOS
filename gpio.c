
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


void gpio_jtag_enable(void){
    // set gpio4 to alt 5
    gpio_t *gpio = get_gpio();
    gpio->GPFSEL0 &= ~(7 << 12);    // zero out gpio4
    gpio->GPFSEL0 |= 2<< 12;    //gpio4 to alt5 = ARM_TDI
    
    // set other gpios
    gpio->GPFSEL2 &= ~(     
                        (7<<6)      //zero gpio22
                       |(7<<12)     // gpio24
                       |(7<<15)     // gpio25
                       |(7<<21));   // gpio27
    
    gpio->GPFSEL2 |=    (3 << 6)    // alt4 ARM TRST
                       |(3 << 12)   // alt4 ARM_TD0
                       |(3 << 15)   // alt4 ARM_TCK
                       |(3 << 21);   // alt4 ARM_TMS

    return;
}

void gpio_emmc_enable(void){
    gpio_t *gpio = get_gpio();
    // set as input
    gpio->GPFSEL4 &= ~(7 << 23);
    
}
