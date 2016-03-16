#include "jtag.h"
#include "gpio.h"

void jtag_enable(void){
    // configure gpio to be jtag.
    gpio_jtag_enable();
    return;
}
