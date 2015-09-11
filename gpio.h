
#ifndef GPIO_H
#define GPIO_H

#include "base.h"


#define GPIO_BASE       ( PERIPHERAL_BASE + 0x200000UL )


#define LED_GPFSEL      GPFSEL4
#define LED_GPFBIT      21
#define LED_GPSET       GPSET1
#define LED_GPCLR       GPCLR1
#define LED_GPIO_BIT    15
#define LED_ON()        do { GetGpio()->LED_GPCLR = ( 1 << LED_GPIO_BIT ); } while( 0 )
#define LED_OFF()       do { GetGpio()->LED_GPSET = ( 1 << LED_GPIO_BIT ); } while( 0 )


/***/
#define GPIO_FSEL0_00_INPUT     ( 0 )
#define GPIO_FSEL0_00_OUTPUT    ( 1 )

#define GPIO_FSEL0_01_INPUT     ( 0 << 3 )
#define GPIO_FSEL0_01_OUTPUT    ( 1 << 3 )

#define GPIO_FSEL0_02_INPUT     ( 0 << 6 )
#define GPIO_FSEL0_02_OUTPUT    ( 1 << 6 )

#define GPIO_FSEL0_03_INPUT     ( 0 << 9 )
#define GPIO_FSEL0_03_OUTPUT    ( 1 << 9 )

#define GPIO_FSEL0_04_INPUT     ( 0 << 12 )
#define GPIO_FSEL0_04_OUTPUT    ( 1 << 12 )

#define GPIO_FSEL0_05_INPUT     ( 0 << 15 )
#define GPIO_FSEL0_05_OUTPUT    ( 1 << 15 )

#define GPIO_FSEL0_06_INPUT     ( 0 << 18 )
#define GPIO_FSEL0_06_OUTPUT    ( 1 << 18 )

#define GPIO_FSEL0_07_INPUT     ( 0 << 21 )
#define GPIO_FSEL0_07_OUTPUT    ( 1 << 21 )

#define GPIO_FSEL0_08_INPUT     ( 0 << 24 )
#define GPIO_FSEL0_08_OUTPUT    ( 1 << 24 )

#define GPIO_FSEL0_09_INPUT     ( 0 << 27 )
#define GPIO_FSEL0_09_OUTPUT    ( 1 << 27 )


typedef struct {
    reg_rw_t    GPFSEL0;
    reg_rw_t    GPFSEL1;
    reg_rw_t    GPFSEL2;
    reg_rw_t    GPFSEL3;
    reg_rw_t    GPFSEL4;
    reg_rw_t    GPFSEL5;
    reg_ro_t    Reserved0;
    reg_wo_t    GPSET0;
    reg_wo_t    GPSET1;
    reg_ro_t    Reserved1;
    reg_wo_t    GPCLR0;
    reg_wo_t    GPCLR1;
    reg_ro_t    Reserved2;
    reg_wo_t    GPLEV0;
    reg_wo_t    GPLEV1;
    reg_ro_t    Reserved3;
    reg_wo_t    GPEDS0;
    reg_wo_t    GPEDS1;
    reg_ro_t    Reserved4;
    reg_wo_t    GPREN0;
    reg_wo_t    GPREN1;
    reg_ro_t    Reserved5;
    reg_wo_t    GPFEN0;
    reg_wo_t    GPFEN1;
    reg_ro_t    Reserved6;
    reg_wo_t    GPHEN0;
    reg_wo_t    GPHEN1;
    reg_ro_t    Reserved7;
    reg_wo_t    GPLEN0;
    reg_wo_t    GPLEN1;
    reg_ro_t    Reserved8;
    reg_wo_t    GPAREN0;
    reg_wo_t    GPAREN1;
    reg_ro_t    Reserved9;
    reg_wo_t    GPAFEN0;
    reg_wo_t    GPAFEN1;
    reg_ro_t    Reserved10;
    reg_wo_t    GPPUD;
    reg_wo_t    GPPUDCLK0;
    reg_wo_t    GPPUDCLK1;
    reg_ro_t    Reserved11;
} gpio_t;


extern gpio_t* GetGpio(void);
extern void GpioInit(void);

#endif
