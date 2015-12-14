#include "jtag.h"
#include "gpio.h"

void jtag_enable(void){
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
