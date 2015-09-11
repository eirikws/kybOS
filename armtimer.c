
#include <stdint.h>
#include "armtimer.h"

#define ARMTIMER_BASE               ( PERIPHERAL_BASE + 0xB400 )

static arm_timer_t* ArmTimer = (arm_timer_t*)ARMTIMER_BASE;

arm_timer_t* GetArmTimer(void)
{
    return ArmTimer;
}

void ArmTimerInit(void)
{

}
