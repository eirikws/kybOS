#ifndef BASE_H
#define BASE_H

#include <stdint.h>

#define PERIPHERAL_BASE     0x3F000000UL
#define ARM_LOCAL_BASE    0x40000000UL

#define ARM_LOCAL_CONTROL		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x000))
#define ARM_LOCAL_PRESCALER		((volatile uint32_t*)ARM_LOCAL_BASE + 0x008))
#define ARM_LOCAL_GPU_INT_ROUTING	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x00C))
#define ARM_LOCAL_PM_ROUTING_SET	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x010))
#define ARM_LOCAL_PM_ROUTING_CLR	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x014))
#define ARM_LOCAL_TIMER_LS		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x01C))
#define ARM_LOCAL_TIMER_MS		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x020))
#define ARM_LOCAL_INT_ROUTING		((volatile uint32_t*)((ARM_LOCAL_BASE + 0x024))
#define ARM_LOCAL_AXI_COUNT		((volatile uint32_t*(ARM_LOCAL_BASE + 0x02C))
#define ARM_LOCAL_AXI_IRQ		((volatile uint32_t*(ARM_LOCAL_BASE + 0x030))
#define ARM_LOCAL_TIMER_CONTROL		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x034))
#define ARM_LOCAL_TIMER_WRITE		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x038))

#define ARM_LOCAL_TIMER_INT_CONTROL0	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x040))
#define ARM_LOCAL_TIMER_INT_CONTROL1	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x044))
#define ARM_LOCAL_TIMER_INT_CONTROL2	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x048))
#define ARM_LOCAL_TIMER_INT_CONTROL3	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x04C))

#define ARM_LOCAL_MAILBOX_INT_CONTROL0	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x050))
#define ARM_LOCAL_MAILBOX_INT_CONTROL1	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x054))
#define ARM_LOCAL_MAILBOX_INT_CONTROL2	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x058))
#define ARM_LOCAL_MAILBOX_INT_CONTROL3	((volatile uint32_t*)(ARM_LOCAL_BASE + 0x05C))

#define ARM_LOCAL_IRQ_PENDING0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x060))
#define ARM_LOCAL_IRQ_PENDING1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x064))
#define ARM_LOCAL_IRQ_PENDING2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x068))
#define ARM_LOCAL_IRQ_PENDING3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x06C))

#define ARM_LOCAL_FIQ_PENDING0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x070))
#define ARM_LOCAL_FIQ_PENDING1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x074))
#define ARM_LOCAL_FIQ_PENDING2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x078))
#define ARM_LOCAL_FIQ_PENDING3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x07C))

#define ARM_LOCAL_MAILBOX0_SET0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x080))
#define ARM_LOCAL_MAILBOX1_SET0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x084))
#define ARM_LOCAL_MAILBOX2_SET0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x088))
#define ARM_LOCAL_MAILBOX3_SET0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x08C))

#define ARM_LOCAL_MAILBOX0_SET1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x090))
#define ARM_LOCAL_MAILBOX1_SET1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x094))
#define ARM_LOCAL_MAILBOX2_SET1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x098))
#define ARM_LOCAL_MAILBOX3_SET1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x09C))

#define ARM_LOCAL_MAILBOX0_SET2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0A0))
#define ARM_LOCAL_MAILBOX1_SET2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0A4))
#define ARM_LOCAL_MAILBOX2_SET2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0A8))
#define ARM_LOCAL_MAILBOX3_SET2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0AC))

#define ARM_LOCAL_MAILBOX0_SET3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0B0))
#define ARM_LOCAL_MAILBOX1_SET3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0B4))
#define ARM_LOCAL_MAILBOX2_SET3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0B8))
#define ARM_LOCAL_MAILBOX3_SET3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0BC))

#define ARM_LOCAL_MAILBOX0_CLR0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0C0))
#define ARM_LOCAL_MAILBOX1_CLR0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0C4))
#define ARM_LOCAL_MAILBOX2_CLR0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0C8))
#define ARM_LOCAL_MAILBOX3_CLR0		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0CC))

#define ARM_LOCAL_MAILBOX0_CLR1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0D0))
#define ARM_LOCAL_MAILBOX1_CLR1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0D4))
#define ARM_LOCAL_MAILBOX2_CLR1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0D8))
#define ARM_LOCAL_MAILBOX3_CLR1		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0DC))

#define ARM_LOCAL_MAILBOX0_CLR2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0E0))
#define ARM_LOCAL_MAILBOX1_CLR2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0E4))
#define ARM_LOCAL_MAILBOX2_CLR2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0E8))
#define ARM_LOCAL_MAILBOX3_CLR2		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0EC))

#define ARM_LOCAL_MAILBOX0_CLR3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0F0))
#define ARM_LOCAL_MAILBOX1_CLR3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0F4))
#define ARM_LOCAL_MAILBOX2_CLR3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0F8))
#define ARM_LOCAL_MAILBOX3_CLR3		((volatile uint32_t*)(ARM_LOCAL_BASE + 0x0FC))


#endif
