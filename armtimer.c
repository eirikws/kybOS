
#include <stdint.h>
#include "armtimer.h"

static arm_timer_t* ArmTimer = (arm_timer_t*)ARMTIMER_BASE;

arm_timer_t* GetArmTimer(void)
{
    return ArmTimer;
}

void ArmTimerInit(void)
{

}
