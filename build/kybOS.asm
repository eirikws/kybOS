
./kybOS:     file format elf32-littlearm


Disassembly of section .text:

00008000 <_start>:
    8000:	e59ff018 	ldr	pc, [pc, #24]	; 8020 <_reset_h>
    8004:	e59ff018 	ldr	pc, [pc, #24]	; 8024 <_undefined_instruction_vector_h>
    8008:	e59ff018 	ldr	pc, [pc, #24]	; 8028 <_software_interrupt_vector_h>
    800c:	e59ff018 	ldr	pc, [pc, #24]	; 802c <_prefetch_abort_vector_h>
    8010:	e59ff018 	ldr	pc, [pc, #24]	; 8030 <_data_abort_vector_h>
    8014:	e59ff018 	ldr	pc, [pc, #24]	; 8034 <_unused_handler_h>
    8018:	e59ff018 	ldr	pc, [pc, #24]	; 8038 <_interrupt_vector_h>
    801c:	e59ff018 	ldr	pc, [pc, #24]	; 803c <_fast_interrupt_vector_h>

00008020 <_reset_h>:
    8020:	00008040 	andeq	r8, r0, r0, asr #32

00008024 <_undefined_instruction_vector_h>:
    8024:	00008320 	andeq	r8, r0, r0, lsr #6

00008028 <_software_interrupt_vector_h>:
    8028:	00008338 	andeq	r8, r0, r8, lsr r3

0000802c <_prefetch_abort_vector_h>:
    802c:	00008350 	andeq	r8, r0, r0, asr r3

00008030 <_data_abort_vector_h>:
    8030:	00008354 	andeq	r8, r0, r4, asr r3

00008034 <_unused_handler_h>:
    8034:	00008040 	andeq	r8, r0, r0, asr #32

00008038 <_interrupt_vector_h>:
    8038:	00008358 	andeq	r8, r0, r8, asr r3

0000803c <_fast_interrupt_vector_h>:
    803c:	000083c0 	andeq	r8, r0, r0, asr #7

00008040 <_reset_>:
    8040:	e3a00902 	mov	r0, #32768	; 0x8000
    8044:	e3a01000 	mov	r1, #0
    8048:	e8b003fc 	ldm	r0!, {r2, r3, r4, r5, r6, r7, r8, r9}
    804c:	e8a103fc 	stmia	r1!, {r2, r3, r4, r5, r6, r7, r8, r9}
    8050:	e8b003fc 	ldm	r0!, {r2, r3, r4, r5, r6, r7, r8, r9}
    8054:	e8a103fc 	stmia	r1!, {r2, r3, r4, r5, r6, r7, r8, r9}
    8058:	e3a000d2 	mov	r0, #210	; 0xd2
    805c:	e121f000 	msr	CPSR_c, r0
    8060:	e3a0d63f 	mov	sp, #66060288	; 0x3f00000
    8064:	e3a000d3 	mov	r0, #211	; 0xd3
    8068:	e121f000 	msr	CPSR_c, r0
    806c:	e3a0d301 	mov	sp, #67108864	; 0x4000000
    8070:	eb00002d 	bl	812c <_cstartup>

00008074 <_inf_loop>:
    8074:	eafffffe 	b	8074 <_inf_loop>

00008078 <_get_stack_pointer>:
    8078:	e58dd000 	str	sp, [sp]
    807c:	e59d0000 	ldr	r0, [sp]
    8080:	e1a0f00e 	mov	pc, lr

00008084 <_generate_swi>:
    8084:	ef00000c 	svc	0x0000000c
    8088:	e1a0f00e 	mov	pc, lr

0000808c <_get_cpsr>:
    808c:	e10f0000 	mrs	r0, CPSR
    8090:	e1a0f00e 	mov	pc, lr

00008094 <_set_cpu_mode>:
    8094:	e121f000 	msr	CPSR_c, r0
    8098:	e1a0f00e 	mov	pc, lr

0000809c <_enable_interrupts>:
    809c:	e10f0000 	mrs	r0, CPSR
    80a0:	e3c00080 	bic	r0, r0, #128	; 0x80
    80a4:	e121f000 	msr	CPSR_c, r0
    80a8:	e1a0f00e 	mov	pc, lr

000080ac <kernel_main>:
    80ac:	e92d4038 	push	{r3, r4, r5, lr}
    80b0:	eb0000c3 	bl	83c4 <uart_init>
    80b4:	e3080eb8 	movw	r0, #36536	; 0x8eb8
    80b8:	e3400000 	movt	r0, #0
    80bc:	eb000103 	bl	84d0 <uart_puts>
    80c0:	eb00008e 	bl	8300 <GetGpio>
    80c4:	e5903010 	ldr	r3, [r0, #16]
    80c8:	e3833015 	orr	r3, r3, #21
    80cc:	e5803010 	str	r3, [r0, #16]
    80d0:	eb00008e 	bl	8310 <GetIrqController>
    80d4:	e3a04001 	mov	r4, #1
    80d8:	e5804018 	str	r4, [r0, #24]
    80dc:	eb000083 	bl	82f0 <GetArmTimer>
    80e0:	e3a03b01 	mov	r3, #1024	; 0x400
    80e4:	e5803000 	str	r3, [r0]
    80e8:	eb000080 	bl	82f0 <GetArmTimer>
    80ec:	e3a030aa 	mov	r3, #170	; 0xaa
    80f0:	e5803008 	str	r3, [r0, #8]
    80f4:	ebffffe8 	bl	809c <_enable_interrupts>
    80f8:	e3080ec8 	movw	r0, #36552	; 0x8ec8
    80fc:	e3400000 	movt	r0, #0
    8100:	eb0000f2 	bl	84d0 <uart_puts>
    8104:	e3a05010 	mov	r5, #16
    8108:	ea000003 	b	811c <kernel_main+0x70>
    810c:	e1a00005 	mov	r0, r5
    8110:	ebffffdf 	bl	8094 <_set_cpu_mode>
    8114:	ebffffda 	bl	8084 <_generate_swi>
    8118:	e2844001 	add	r4, r4, #1
    811c:	eb0000f2 	bl	84ec <get_cpu_mode>
    8120:	e3540002 	cmp	r4, #2
    8124:	dafffffb 	ble	8118 <kernel_main+0x6c>
    8128:	eafffff7 	b	810c <kernel_main+0x60>

0000812c <_cstartup>:
    812c:	e92d4008 	push	{r3, lr}
    8130:	e309c7e4 	movw	ip, #38884	; 0x97e4
    8134:	e340c000 	movt	ip, #0
    8138:	e3093828 	movw	r3, #38952	; 0x9828
    813c:	e3403000 	movt	r3, #0
    8140:	e15c0003 	cmp	ip, r3
    8144:	2a000009 	bcs	8170 <_cstartup+0x44>
    8148:	e24c3004 	sub	r3, ip, #4
    814c:	e59fe024 	ldr	lr, [pc, #36]	; 8178 <_cstartup+0x4c>
    8150:	e063e00e 	rsb	lr, r3, lr
    8154:	e3cee003 	bic	lr, lr, #3
    8158:	e283c004 	add	ip, r3, #4
    815c:	e08ee00c 	add	lr, lr, ip
    8160:	e3a0c000 	mov	ip, #0
    8164:	e5a3c004 	str	ip, [r3, #4]!
    8168:	e153000e 	cmp	r3, lr
    816c:	1afffffc 	bne	8164 <_cstartup+0x38>
    8170:	ebffffcd 	bl	80ac <kernel_main>
    8174:	eafffffe 	b	8174 <_cstartup+0x48>
    8178:	00009823 	andeq	r9, r0, r3, lsr #16

0000817c <_exit>:
    817c:	eafffffe 	b	817c <_exit>

00008180 <close>:
    8180:	e3e00000 	mvn	r0, #0
    8184:	e12fff1e 	bx	lr

00008188 <execve>:
    8188:	e3093824 	movw	r3, #38948	; 0x9824
    818c:	e3403000 	movt	r3, #0
    8190:	e3a0200c 	mov	r2, #12
    8194:	e5832000 	str	r2, [r3]
    8198:	e3e00000 	mvn	r0, #0
    819c:	e12fff1e 	bx	lr

000081a0 <fork>:
    81a0:	e3093824 	movw	r3, #38948	; 0x9824
    81a4:	e3403000 	movt	r3, #0
    81a8:	e3a0200b 	mov	r2, #11
    81ac:	e5832000 	str	r2, [r3]
    81b0:	e3e00000 	mvn	r0, #0
    81b4:	e12fff1e 	bx	lr

000081b8 <fstat>:
    81b8:	e3a03a02 	mov	r3, #8192	; 0x2000
    81bc:	e5813004 	str	r3, [r1, #4]
    81c0:	e3a00000 	mov	r0, #0
    81c4:	e12fff1e 	bx	lr

000081c8 <getpid>:
    81c8:	e3a00001 	mov	r0, #1
    81cc:	e12fff1e 	bx	lr

000081d0 <isatty>:
    81d0:	e3a00001 	mov	r0, #1
    81d4:	e12fff1e 	bx	lr

000081d8 <kill>:
    81d8:	e3093824 	movw	r3, #38948	; 0x9824
    81dc:	e3403000 	movt	r3, #0
    81e0:	e3a02016 	mov	r2, #22
    81e4:	e5832000 	str	r2, [r3]
    81e8:	e3e00000 	mvn	r0, #0
    81ec:	e12fff1e 	bx	lr

000081f0 <link>:
    81f0:	e3093824 	movw	r3, #38948	; 0x9824
    81f4:	e3403000 	movt	r3, #0
    81f8:	e3a0201f 	mov	r2, #31
    81fc:	e5832000 	str	r2, [r3]
    8200:	e3e00000 	mvn	r0, #0
    8204:	e12fff1e 	bx	lr

00008208 <lseek>:
    8208:	e3a00000 	mov	r0, #0
    820c:	e12fff1e 	bx	lr

00008210 <open>:
    8210:	e3e00000 	mvn	r0, #0
    8214:	e12fff1e 	bx	lr

00008218 <read>:
    8218:	e3a00000 	mov	r0, #0
    821c:	e12fff1e 	bx	lr

00008220 <_sbrk>:
    8220:	e92d4070 	push	{r4, r5, r6, lr}
    8224:	e1a05000 	mov	r5, r0
    8228:	e30937e4 	movw	r3, #38884	; 0x97e4
    822c:	e3403000 	movt	r3, #0
    8230:	e5933000 	ldr	r3, [r3]
    8234:	e3530000 	cmp	r3, #0
    8238:	030937e4 	movweq	r3, #38884	; 0x97e4
    823c:	03403000 	movteq	r3, #0
    8240:	03092828 	movweq	r2, #38952	; 0x9828
    8244:	03402000 	movteq	r2, #0
    8248:	05832000 	streq	r2, [r3]
    824c:	e30937e4 	movw	r3, #38884	; 0x97e4
    8250:	e3403000 	movt	r3, #0
    8254:	e5934000 	ldr	r4, [r3]
    8258:	e0846000 	add	r6, r4, r0
    825c:	ebffff85 	bl	8078 <_get_stack_pointer>
    8260:	e1560000 	cmp	r6, r0
    8264:	9a000000 	bls	826c <_sbrk+0x4c>
    8268:	eafffffe 	b	8268 <_sbrk+0x48>
    826c:	e30937e4 	movw	r3, #38884	; 0x97e4
    8270:	e3403000 	movt	r3, #0
    8274:	e5932000 	ldr	r2, [r3]
    8278:	e0825005 	add	r5, r2, r5
    827c:	e5835000 	str	r5, [r3]
    8280:	e1a00004 	mov	r0, r4
    8284:	e8bd8070 	pop	{r4, r5, r6, pc}

00008288 <stat>:
    8288:	e3a03a02 	mov	r3, #8192	; 0x2000
    828c:	e5813004 	str	r3, [r1, #4]
    8290:	e3a00000 	mov	r0, #0
    8294:	e12fff1e 	bx	lr

00008298 <times>:
    8298:	e3e00000 	mvn	r0, #0
    829c:	e12fff1e 	bx	lr

000082a0 <unlink>:
    82a0:	e3093824 	movw	r3, #38948	; 0x9824
    82a4:	e3403000 	movt	r3, #0
    82a8:	e3a02002 	mov	r2, #2
    82ac:	e5832000 	str	r2, [r3]
    82b0:	e3e00000 	mvn	r0, #0
    82b4:	e12fff1e 	bx	lr

000082b8 <wait>:
    82b8:	e3093824 	movw	r3, #38948	; 0x9824
    82bc:	e3403000 	movt	r3, #0
    82c0:	e3a0200a 	mov	r2, #10
    82c4:	e5832000 	str	r2, [r3]
    82c8:	e3e00000 	mvn	r0, #0
    82cc:	e12fff1e 	bx	lr

000082d0 <outbyte>:
    82d0:	e12fff1e 	bx	lr

000082d4 <write>:
    82d4:	e2520000 	subs	r0, r2, #0
    82d8:	d12fff1e 	bxle	lr
    82dc:	e3a03000 	mov	r3, #0
    82e0:	e2833001 	add	r3, r3, #1
    82e4:	e1530000 	cmp	r3, r0
    82e8:	1afffffc 	bne	82e0 <write+0xc>
    82ec:	e12fff1e 	bx	lr

000082f0 <GetArmTimer>:
    82f0:	e3a00b2d 	mov	r0, #46080	; 0xb400
    82f4:	e3430f00 	movt	r0, #16128	; 0x3f00
    82f8:	e12fff1e 	bx	lr

000082fc <ArmTimerInit>:
    82fc:	e12fff1e 	bx	lr

00008300 <GetGpio>:
    8300:	e3a00000 	mov	r0, #0
    8304:	e3430f20 	movt	r0, #16160	; 0x3f20
    8308:	e12fff1e 	bx	lr

0000830c <GpioInit>:
    830c:	e12fff1e 	bx	lr

00008310 <GetIrqController>:
    8310:	e3a00cb2 	mov	r0, #45568	; 0xb200
    8314:	e3430f00 	movt	r0, #16128	; 0x3f00
    8318:	e12fff1e 	bx	lr

0000831c <reset_vector>:
    831c:	e25ef004 	subs	pc, lr, #4

00008320 <undefined_instruction_vector>:
    8320:	e92d503f 	push	{r0, r1, r2, r3, r4, r5, ip, lr}
    8324:	e3084ef0 	movw	r4, #36592	; 0x8ef0
    8328:	e3404000 	movt	r4, #0
    832c:	e1a00004 	mov	r0, r4
    8330:	eb000066 	bl	84d0 <uart_puts>
    8334:	eafffffc 	b	832c <undefined_instruction_vector+0xc>

00008338 <software_interrupt_vector>:
    8338:	e92d500f 	push	{r0, r1, r2, r3, ip, lr}
    833c:	e3080f04 	movw	r0, #36612	; 0x8f04
    8340:	e3400000 	movt	r0, #0
    8344:	eb000061 	bl	84d0 <uart_puts>
    8348:	eb000067 	bl	84ec <get_cpu_mode>
    834c:	eafffffe 	b	834c <software_interrupt_vector+0x14>

00008350 <prefetch_abort_vector>:
    8350:	e25ef004 	subs	pc, lr, #4

00008354 <data_abort_vector>:
    8354:	e25ef004 	subs	pc, lr, #4

00008358 <interrupt_vector>:
    8358:	e24ee004 	sub	lr, lr, #4
    835c:	e92d500f 	push	{r0, r1, r2, r3, ip, lr}
    8360:	ebffffe2 	bl	82f0 <GetArmTimer>
    8364:	e3a03001 	mov	r3, #1
    8368:	e580300c 	str	r3, [r0, #12]
    836c:	e30937ec 	movw	r3, #38892	; 0x97ec
    8370:	e3403000 	movt	r3, #0
    8374:	e5933000 	ldr	r3, [r3]
    8378:	e3530000 	cmp	r3, #0
    837c:	0a000007 	beq	83a0 <interrupt_vector+0x48>
    8380:	ebffffde 	bl	8300 <GetGpio>
    8384:	e3a03902 	mov	r3, #32768	; 0x8000
    8388:	e5803020 	str	r3, [r0, #32]
    838c:	e30937ec 	movw	r3, #38892	; 0x97ec
    8390:	e3403000 	movt	r3, #0
    8394:	e3a02000 	mov	r2, #0
    8398:	e5832000 	str	r2, [r3]
    839c:	e8fd900f 	ldm	sp!, {r0, r1, r2, r3, ip, pc}^
    83a0:	ebffffd6 	bl	8300 <GetGpio>
    83a4:	e3a03902 	mov	r3, #32768	; 0x8000
    83a8:	e580302c 	str	r3, [r0, #44]	; 0x2c
    83ac:	e30937ec 	movw	r3, #38892	; 0x97ec
    83b0:	e3403000 	movt	r3, #0
    83b4:	e3a02001 	mov	r2, #1
    83b8:	e5832000 	str	r2, [r3]
    83bc:	e8fd900f 	ldm	sp!, {r0, r1, r2, r3, ip, pc}^

000083c0 <fast_interrupt_vector>:
    83c0:	e25ef004 	subs	pc, lr, #4

000083c4 <uart_init>:
    83c4:	e92d4010 	push	{r4, lr}
    83c8:	e3a03a01 	mov	r3, #4096	; 0x1000
    83cc:	e3433f20 	movt	r3, #16160	; 0x3f20
    83d0:	e3a04000 	mov	r4, #0
    83d4:	e5834030 	str	r4, [r3, #48]	; 0x30
    83d8:	ebffffc8 	bl	8300 <GetGpio>
    83dc:	e5804094 	str	r4, [r0, #148]	; 0x94
    83e0:	e3a03096 	mov	r3, #150	; 0x96

000083e4 <__delay_13>:
    83e4:	e2533001 	subs	r3, r3, #1
    83e8:	1afffffd 	bne	83e4 <__delay_13>
    83ec:	ebffffc3 	bl	8300 <GetGpio>
    83f0:	e3a03903 	mov	r3, #49152	; 0xc000
    83f4:	e5803098 	str	r3, [r0, #152]	; 0x98
    83f8:	e3a03096 	mov	r3, #150	; 0x96

000083fc <__delay_18>:
    83fc:	e2533001 	subs	r3, r3, #1
    8400:	1afffffd 	bne	83fc <__delay_18>
    8404:	ebffffbd 	bl	8300 <GetGpio>
    8408:	e5804094 	str	r4, [r0, #148]	; 0x94
    840c:	ebffffbb 	bl	8300 <GetGpio>
    8410:	e5804098 	str	r4, [r0, #152]	; 0x98
    8414:	e3a03a01 	mov	r3, #4096	; 0x1000
    8418:	e3433f20 	movt	r3, #16160	; 0x3f20
    841c:	e30027ff 	movw	r2, #2047	; 0x7ff
    8420:	e5832044 	str	r2, [r3, #68]	; 0x44
    8424:	e3a02001 	mov	r2, #1
    8428:	e5832024 	str	r2, [r3, #36]	; 0x24
    842c:	e3a02028 	mov	r2, #40	; 0x28
    8430:	e5832028 	str	r2, [r3, #40]	; 0x28
    8434:	e3a02070 	mov	r2, #112	; 0x70
    8438:	e583202c 	str	r2, [r3, #44]	; 0x2c
    843c:	e30027f2 	movw	r2, #2034	; 0x7f2
    8440:	e5832038 	str	r2, [r3, #56]	; 0x38
    8444:	e3002301 	movw	r2, #769	; 0x301
    8448:	e5832030 	str	r2, [r3, #48]	; 0x30
    844c:	e8bd8010 	pop	{r4, pc}

00008450 <GetUartController>:
    8450:	e3a00a01 	mov	r0, #4096	; 0x1000
    8454:	e3430f20 	movt	r0, #16160	; 0x3f20
    8458:	e12fff1e 	bx	lr

0000845c <uart_putc>:
    845c:	e3a02a01 	mov	r2, #4096	; 0x1000
    8460:	e3432f20 	movt	r2, #16160	; 0x3f20
    8464:	e5923018 	ldr	r3, [r2, #24]
    8468:	e3130020 	tst	r3, #32
    846c:	1afffffc 	bne	8464 <uart_putc+0x8>
    8470:	e3a03a01 	mov	r3, #4096	; 0x1000
    8474:	e3433f20 	movt	r3, #16160	; 0x3f20
    8478:	e5830000 	str	r0, [r3]
    847c:	e12fff1e 	bx	lr

00008480 <uart_getc>:
    8480:	e3a02a01 	mov	r2, #4096	; 0x1000
    8484:	e3432f20 	movt	r2, #16160	; 0x3f20
    8488:	e5923018 	ldr	r3, [r2, #24]
    848c:	e3130010 	tst	r3, #16
    8490:	1afffffc 	bne	8488 <uart_getc+0x8>
    8494:	e3a03a01 	mov	r3, #4096	; 0x1000
    8498:	e3433f20 	movt	r3, #16160	; 0x3f20
    849c:	e5930000 	ldr	r0, [r3]
    84a0:	e6ef0070 	uxtb	r0, r0
    84a4:	e12fff1e 	bx	lr

000084a8 <uart_write>:
    84a8:	e92d4038 	push	{r3, r4, r5, lr}
    84ac:	e3510000 	cmp	r1, #0
    84b0:	08bd8038 	popeq	{r3, r4, r5, pc}
    84b4:	e1a04000 	mov	r4, r0
    84b8:	e0805001 	add	r5, r0, r1
    84bc:	e4d40001 	ldrb	r0, [r4], #1
    84c0:	ebffffe5 	bl	845c <uart_putc>
    84c4:	e1540005 	cmp	r4, r5
    84c8:	1afffffb 	bne	84bc <uart_write+0x14>
    84cc:	e8bd8038 	pop	{r3, r4, r5, pc}

000084d0 <uart_puts>:
    84d0:	e92d4010 	push	{r4, lr}
    84d4:	e1a04000 	mov	r4, r0
    84d8:	fa000069 	blx	8684 <strlen>
    84dc:	e1a01000 	mov	r1, r0
    84e0:	e1a00004 	mov	r0, r4
    84e4:	ebffffef 	bl	84a8 <uart_write>
    84e8:	e8bd8010 	pop	{r4, pc}

000084ec <get_cpu_mode>:
    84ec:	e92d4008 	push	{r3, lr}
    84f0:	ebfffee5 	bl	808c <_get_cpsr>
    84f4:	e200001f 	and	r0, r0, #31
    84f8:	e2400010 	sub	r0, r0, #16
    84fc:	e350000f 	cmp	r0, #15
    8500:	979ff100 	ldrls	pc, [pc, r0, lsl #2]
    8504:	ea000032 	b	85d4 <get_cpu_mode+0xe8>
    8508:	00008548 	andeq	r8, r0, r8, asr #10
    850c:	0000855c 	andeq	r8, r0, ip, asr r5
    8510:	00008570 	andeq	r8, r0, r0, ror r5
    8514:	00008584 	andeq	r8, r0, r4, lsl #11
    8518:	000085d4 	ldrdeq	r8, [r0], -r4
    851c:	000085d4 	ldrdeq	r8, [r0], -r4
    8520:	000085d4 	ldrdeq	r8, [r0], -r4
    8524:	00008598 	muleq	r0, r8, r5
    8528:	000085d4 	ldrdeq	r8, [r0], -r4
    852c:	000085d4 	ldrdeq	r8, [r0], -r4
    8530:	000085d4 	ldrdeq	r8, [r0], -r4
    8534:	000085ac 	andeq	r8, r0, ip, lsr #11
    8538:	000085d4 	ldrdeq	r8, [r0], -r4
    853c:	000085d4 	ldrdeq	r8, [r0], -r4
    8540:	000085d4 	ldrdeq	r8, [r0], -r4
    8544:	000085c0 	andeq	r8, r0, r0, asr #11
    8548:	e3080f14 	movw	r0, #36628	; 0x8f14
    854c:	e3400000 	movt	r0, #0
    8550:	ebffffde 	bl	84d0 <uart_puts>
    8554:	e3a00010 	mov	r0, #16
    8558:	e8bd8008 	pop	{r3, pc}
    855c:	e3080f28 	movw	r0, #36648	; 0x8f28
    8560:	e3400000 	movt	r0, #0
    8564:	ebffffd9 	bl	84d0 <uart_puts>
    8568:	e3a00011 	mov	r0, #17
    856c:	e8bd8008 	pop	{r3, pc}
    8570:	e3080f38 	movw	r0, #36664	; 0x8f38
    8574:	e3400000 	movt	r0, #0
    8578:	ebffffd4 	bl	84d0 <uart_puts>
    857c:	e3a00012 	mov	r0, #18
    8580:	e8bd8008 	pop	{r3, pc}
    8584:	e3080f48 	movw	r0, #36680	; 0x8f48
    8588:	e3400000 	movt	r0, #0
    858c:	ebffffcf 	bl	84d0 <uart_puts>
    8590:	e3a00013 	mov	r0, #19
    8594:	e8bd8008 	pop	{r3, pc}
    8598:	e3080f58 	movw	r0, #36696	; 0x8f58
    859c:	e3400000 	movt	r0, #0
    85a0:	ebffffca 	bl	84d0 <uart_puts>
    85a4:	e3a00017 	mov	r0, #23
    85a8:	e8bd8008 	pop	{r3, pc}
    85ac:	e3080f6c 	movw	r0, #36716	; 0x8f6c
    85b0:	e3400000 	movt	r0, #0
    85b4:	ebffffc5 	bl	84d0 <uart_puts>
    85b8:	e3a0001b 	mov	r0, #27
    85bc:	e8bd8008 	pop	{r3, pc}
    85c0:	e3080f84 	movw	r0, #36740	; 0x8f84
    85c4:	e3400000 	movt	r0, #0
    85c8:	ebffffc0 	bl	84d0 <uart_puts>
    85cc:	e3a0001f 	mov	r0, #31
    85d0:	e8bd8008 	pop	{r3, pc}
    85d4:	e8bd8008 	pop	{r3, pc}

000085d8 <cleanup_glue>:
    85d8:	b538      	push	{r3, r4, r5, lr}
    85da:	460c      	mov	r4, r1
    85dc:	6809      	ldr	r1, [r1, #0]
    85de:	4605      	mov	r5, r0
    85e0:	b109      	cbz	r1, 85e6 <cleanup_glue+0xe>
    85e2:	f7ff fff9 	bl	85d8 <cleanup_glue>
    85e6:	4628      	mov	r0, r5
    85e8:	4621      	mov	r1, r4
    85ea:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
    85ee:	f000 b8cb 	b.w	8788 <_free_r>
    85f2:	bf00      	nop

000085f4 <_reclaim_reent>:
    85f4:	f249 33d0 	movw	r3, #37840	; 0x93d0
    85f8:	f2c0 0300 	movt	r3, #0
    85fc:	b570      	push	{r4, r5, r6, lr}
    85fe:	4605      	mov	r5, r0
    8600:	681b      	ldr	r3, [r3, #0]
    8602:	4298      	cmp	r0, r3
    8604:	d031      	beq.n	866a <_reclaim_reent+0x76>
    8606:	6cc2      	ldr	r2, [r0, #76]	; 0x4c
    8608:	b1aa      	cbz	r2, 8636 <_reclaim_reent+0x42>
    860a:	2300      	movs	r3, #0
    860c:	461e      	mov	r6, r3
    860e:	f852 1023 	ldr.w	r1, [r2, r3, lsl #2]
    8612:	b909      	cbnz	r1, 8618 <_reclaim_reent+0x24>
    8614:	e007      	b.n	8626 <_reclaim_reent+0x32>
    8616:	4621      	mov	r1, r4
    8618:	680c      	ldr	r4, [r1, #0]
    861a:	4628      	mov	r0, r5
    861c:	f000 f8b4 	bl	8788 <_free_r>
    8620:	2c00      	cmp	r4, #0
    8622:	d1f8      	bne.n	8616 <_reclaim_reent+0x22>
    8624:	6cea      	ldr	r2, [r5, #76]	; 0x4c
    8626:	3601      	adds	r6, #1
    8628:	2e20      	cmp	r6, #32
    862a:	4633      	mov	r3, r6
    862c:	d1ef      	bne.n	860e <_reclaim_reent+0x1a>
    862e:	4611      	mov	r1, r2
    8630:	4628      	mov	r0, r5
    8632:	f000 f8a9 	bl	8788 <_free_r>
    8636:	6c29      	ldr	r1, [r5, #64]	; 0x40
    8638:	b111      	cbz	r1, 8640 <_reclaim_reent+0x4c>
    863a:	4628      	mov	r0, r5
    863c:	f000 f8a4 	bl	8788 <_free_r>
    8640:	f8d5 1148 	ldr.w	r1, [r5, #328]	; 0x148
    8644:	b151      	cbz	r1, 865c <_reclaim_reent+0x68>
    8646:	f505 76a6 	add.w	r6, r5, #332	; 0x14c
    864a:	42b1      	cmp	r1, r6
    864c:	d006      	beq.n	865c <_reclaim_reent+0x68>
    864e:	680c      	ldr	r4, [r1, #0]
    8650:	4628      	mov	r0, r5
    8652:	f000 f899 	bl	8788 <_free_r>
    8656:	42a6      	cmp	r6, r4
    8658:	4621      	mov	r1, r4
    865a:	d1f8      	bne.n	864e <_reclaim_reent+0x5a>
    865c:	6d69      	ldr	r1, [r5, #84]	; 0x54
    865e:	b111      	cbz	r1, 8666 <_reclaim_reent+0x72>
    8660:	4628      	mov	r0, r5
    8662:	f000 f891 	bl	8788 <_free_r>
    8666:	6bab      	ldr	r3, [r5, #56]	; 0x38
    8668:	b903      	cbnz	r3, 866c <_reclaim_reent+0x78>
    866a:	bd70      	pop	{r4, r5, r6, pc}
    866c:	6beb      	ldr	r3, [r5, #60]	; 0x3c
    866e:	4628      	mov	r0, r5
    8670:	4798      	blx	r3
    8672:	f8d5 12e0 	ldr.w	r1, [r5, #736]	; 0x2e0
    8676:	2900      	cmp	r1, #0
    8678:	d0f7      	beq.n	866a <_reclaim_reent+0x76>
    867a:	4628      	mov	r0, r5
    867c:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
    8680:	f7ff bfaa 	b.w	85d8 <cleanup_glue>

00008684 <strlen>:
    8684:	f020 0103 	bic.w	r1, r0, #3
    8688:	f010 0003 	ands.w	r0, r0, #3
    868c:	f1c0 0000 	rsb	r0, r0, #0
    8690:	f851 3b04 	ldr.w	r3, [r1], #4
    8694:	f100 0c04 	add.w	ip, r0, #4
    8698:	ea4f 0ccc 	mov.w	ip, ip, lsl #3
    869c:	f06f 0200 	mvn.w	r2, #0
    86a0:	bf1c      	itt	ne
    86a2:	fa22 f20c 	lsrne.w	r2, r2, ip
    86a6:	4313      	orrne	r3, r2
    86a8:	f04f 0c01 	mov.w	ip, #1
    86ac:	ea4c 2c0c 	orr.w	ip, ip, ip, lsl #8
    86b0:	ea4c 4c0c 	orr.w	ip, ip, ip, lsl #16
    86b4:	eba3 020c 	sub.w	r2, r3, ip
    86b8:	ea22 0203 	bic.w	r2, r2, r3
    86bc:	ea12 12cc 	ands.w	r2, r2, ip, lsl #7
    86c0:	bf04      	itt	eq
    86c2:	f851 3b04 	ldreq.w	r3, [r1], #4
    86c6:	3004      	addeq	r0, #4
    86c8:	d0f4      	beq.n	86b4 <strlen+0x30>
    86ca:	f013 0fff 	tst.w	r3, #255	; 0xff
    86ce:	bf1f      	itttt	ne
    86d0:	3001      	addne	r0, #1
    86d2:	f413 4f7f 	tstne.w	r3, #65280	; 0xff00
    86d6:	3001      	addne	r0, #1
    86d8:	f413 0f7f 	tstne.w	r3, #16711680	; 0xff0000
    86dc:	bf18      	it	ne
    86de:	3001      	addne	r0, #1
    86e0:	4770      	bx	lr
    86e2:	bf00      	nop

000086e4 <_malloc_trim_r>:
    86e4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
    86e6:	f249 34d4 	movw	r4, #37844	; 0x93d4
    86ea:	f2c0 0400 	movt	r4, #0
    86ee:	460f      	mov	r7, r1
    86f0:	4605      	mov	r5, r0
    86f2:	f000 fbc9 	bl	8e88 <__malloc_lock>
    86f6:	68a3      	ldr	r3, [r4, #8]
    86f8:	685e      	ldr	r6, [r3, #4]
    86fa:	f026 0603 	bic.w	r6, r6, #3
    86fe:	1bf7      	subs	r7, r6, r7
    8700:	f607 77ef 	addw	r7, r7, #4079	; 0xfef
    8704:	0b3f      	lsrs	r7, r7, #12
    8706:	3f01      	subs	r7, #1
    8708:	033f      	lsls	r7, r7, #12
    870a:	f5b7 5f80 	cmp.w	r7, #4096	; 0x1000
    870e:	db07      	blt.n	8720 <_malloc_trim_r+0x3c>
    8710:	4628      	mov	r0, r5
    8712:	2100      	movs	r1, #0
    8714:	f000 fbbc 	bl	8e90 <_sbrk_r>
    8718:	68a3      	ldr	r3, [r4, #8]
    871a:	4433      	add	r3, r6
    871c:	4298      	cmp	r0, r3
    871e:	d004      	beq.n	872a <_malloc_trim_r+0x46>
    8720:	4628      	mov	r0, r5
    8722:	f000 fbb3 	bl	8e8c <__malloc_unlock>
    8726:	2000      	movs	r0, #0
    8728:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
    872a:	4628      	mov	r0, r5
    872c:	4279      	negs	r1, r7
    872e:	f000 fbaf 	bl	8e90 <_sbrk_r>
    8732:	3001      	adds	r0, #1
    8734:	d010      	beq.n	8758 <_malloc_trim_r+0x74>
    8736:	68a1      	ldr	r1, [r4, #8]
    8738:	f249 73fc 	movw	r3, #38908	; 0x97fc
    873c:	f2c0 0300 	movt	r3, #0
    8740:	1bf6      	subs	r6, r6, r7
    8742:	4628      	mov	r0, r5
    8744:	f046 0601 	orr.w	r6, r6, #1
    8748:	681a      	ldr	r2, [r3, #0]
    874a:	604e      	str	r6, [r1, #4]
    874c:	1bd7      	subs	r7, r2, r7
    874e:	601f      	str	r7, [r3, #0]
    8750:	f000 fb9c 	bl	8e8c <__malloc_unlock>
    8754:	2001      	movs	r0, #1
    8756:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
    8758:	4628      	mov	r0, r5
    875a:	2100      	movs	r1, #0
    875c:	f000 fb98 	bl	8e90 <_sbrk_r>
    8760:	68a3      	ldr	r3, [r4, #8]
    8762:	1ac2      	subs	r2, r0, r3
    8764:	2a0f      	cmp	r2, #15
    8766:	dddb      	ble.n	8720 <_malloc_trim_r+0x3c>
    8768:	f249 74e0 	movw	r4, #38880	; 0x97e0
    876c:	f2c0 0400 	movt	r4, #0
    8770:	f249 71fc 	movw	r1, #38908	; 0x97fc
    8774:	f2c0 0100 	movt	r1, #0
    8778:	6824      	ldr	r4, [r4, #0]
    877a:	f042 0201 	orr.w	r2, r2, #1
    877e:	605a      	str	r2, [r3, #4]
    8780:	1b00      	subs	r0, r0, r4
    8782:	6008      	str	r0, [r1, #0]
    8784:	e7cc      	b.n	8720 <_malloc_trim_r+0x3c>
    8786:	bf00      	nop

00008788 <_free_r>:
    8788:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    878c:	460e      	mov	r6, r1
    878e:	4680      	mov	r8, r0
    8790:	2900      	cmp	r1, #0
    8792:	d05e      	beq.n	8852 <_free_r+0xca>
    8794:	f000 fb78 	bl	8e88 <__malloc_lock>
    8798:	f856 1c04 	ldr.w	r1, [r6, #-4]
    879c:	f249 35d4 	movw	r5, #37844	; 0x93d4
    87a0:	f2c0 0500 	movt	r5, #0
    87a4:	f1a6 0408 	sub.w	r4, r6, #8
    87a8:	f021 0301 	bic.w	r3, r1, #1
    87ac:	18e2      	adds	r2, r4, r3
    87ae:	68af      	ldr	r7, [r5, #8]
    87b0:	6850      	ldr	r0, [r2, #4]
    87b2:	4297      	cmp	r7, r2
    87b4:	f020 0003 	bic.w	r0, r0, #3
    87b8:	d061      	beq.n	887e <_free_r+0xf6>
    87ba:	f011 0101 	ands.w	r1, r1, #1
    87be:	6050      	str	r0, [r2, #4]
    87c0:	bf18      	it	ne
    87c2:	2100      	movne	r1, #0
    87c4:	d10f      	bne.n	87e6 <_free_r+0x5e>
    87c6:	f856 6c08 	ldr.w	r6, [r6, #-8]
    87ca:	f105 0c08 	add.w	ip, r5, #8
    87ce:	1ba4      	subs	r4, r4, r6
    87d0:	4433      	add	r3, r6
    87d2:	68a6      	ldr	r6, [r4, #8]
    87d4:	4566      	cmp	r6, ip
    87d6:	bf17      	itett	ne
    87d8:	f8d4 c00c 	ldrne.w	ip, [r4, #12]
    87dc:	2101      	moveq	r1, #1
    87de:	f8c6 c00c 	strne.w	ip, [r6, #12]
    87e2:	f8cc 6008 	strne.w	r6, [ip, #8]
    87e6:	1816      	adds	r6, r2, r0
    87e8:	6876      	ldr	r6, [r6, #4]
    87ea:	07f6      	lsls	r6, r6, #31
    87ec:	d408      	bmi.n	8800 <_free_r+0x78>
    87ee:	4403      	add	r3, r0
    87f0:	6890      	ldr	r0, [r2, #8]
    87f2:	b911      	cbnz	r1, 87fa <_free_r+0x72>
    87f4:	4e49      	ldr	r6, [pc, #292]	; (891c <_free_r+0x194>)
    87f6:	42b0      	cmp	r0, r6
    87f8:	d060      	beq.n	88bc <_free_r+0x134>
    87fa:	68d2      	ldr	r2, [r2, #12]
    87fc:	60c2      	str	r2, [r0, #12]
    87fe:	6090      	str	r0, [r2, #8]
    8800:	f043 0201 	orr.w	r2, r3, #1
    8804:	6062      	str	r2, [r4, #4]
    8806:	50e3      	str	r3, [r4, r3]
    8808:	b9f1      	cbnz	r1, 8848 <_free_r+0xc0>
    880a:	f5b3 7f00 	cmp.w	r3, #512	; 0x200
    880e:	d322      	bcc.n	8856 <_free_r+0xce>
    8810:	0a5a      	lsrs	r2, r3, #9
    8812:	2a04      	cmp	r2, #4
    8814:	d85b      	bhi.n	88ce <_free_r+0x146>
    8816:	0998      	lsrs	r0, r3, #6
    8818:	3038      	adds	r0, #56	; 0x38
    881a:	0041      	lsls	r1, r0, #1
    881c:	eb05 0581 	add.w	r5, r5, r1, lsl #2
    8820:	f249 31d4 	movw	r1, #37844	; 0x93d4
    8824:	f2c0 0100 	movt	r1, #0
    8828:	68aa      	ldr	r2, [r5, #8]
    882a:	42aa      	cmp	r2, r5
    882c:	d05b      	beq.n	88e6 <_free_r+0x15e>
    882e:	6851      	ldr	r1, [r2, #4]
    8830:	f021 0103 	bic.w	r1, r1, #3
    8834:	428b      	cmp	r3, r1
    8836:	d202      	bcs.n	883e <_free_r+0xb6>
    8838:	6892      	ldr	r2, [r2, #8]
    883a:	4295      	cmp	r5, r2
    883c:	d1f7      	bne.n	882e <_free_r+0xa6>
    883e:	68d3      	ldr	r3, [r2, #12]
    8840:	60e3      	str	r3, [r4, #12]
    8842:	60a2      	str	r2, [r4, #8]
    8844:	609c      	str	r4, [r3, #8]
    8846:	60d4      	str	r4, [r2, #12]
    8848:	4640      	mov	r0, r8
    884a:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
    884e:	f000 bb1d 	b.w	8e8c <__malloc_unlock>
    8852:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    8856:	08db      	lsrs	r3, r3, #3
    8858:	2101      	movs	r1, #1
    885a:	6868      	ldr	r0, [r5, #4]
    885c:	eb05 02c3 	add.w	r2, r5, r3, lsl #3
    8860:	109b      	asrs	r3, r3, #2
    8862:	fa01 f303 	lsl.w	r3, r1, r3
    8866:	6891      	ldr	r1, [r2, #8]
    8868:	4318      	orrs	r0, r3
    886a:	60e2      	str	r2, [r4, #12]
    886c:	6068      	str	r0, [r5, #4]
    886e:	4640      	mov	r0, r8
    8870:	60a1      	str	r1, [r4, #8]
    8872:	6094      	str	r4, [r2, #8]
    8874:	60cc      	str	r4, [r1, #12]
    8876:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
    887a:	f000 bb07 	b.w	8e8c <__malloc_unlock>
    887e:	07cf      	lsls	r7, r1, #31
    8880:	4418      	add	r0, r3
    8882:	d407      	bmi.n	8894 <_free_r+0x10c>
    8884:	f856 3c08 	ldr.w	r3, [r6, #-8]
    8888:	1ae4      	subs	r4, r4, r3
    888a:	4418      	add	r0, r3
    888c:	68a2      	ldr	r2, [r4, #8]
    888e:	68e3      	ldr	r3, [r4, #12]
    8890:	60d3      	str	r3, [r2, #12]
    8892:	609a      	str	r2, [r3, #8]
    8894:	f249 72dc 	movw	r2, #38876	; 0x97dc
    8898:	f2c0 0200 	movt	r2, #0
    889c:	f040 0301 	orr.w	r3, r0, #1
    88a0:	6063      	str	r3, [r4, #4]
    88a2:	6813      	ldr	r3, [r2, #0]
    88a4:	60ac      	str	r4, [r5, #8]
    88a6:	4298      	cmp	r0, r3
    88a8:	d3ce      	bcc.n	8848 <_free_r+0xc0>
    88aa:	f249 73f8 	movw	r3, #38904	; 0x97f8
    88ae:	f2c0 0300 	movt	r3, #0
    88b2:	4640      	mov	r0, r8
    88b4:	6819      	ldr	r1, [r3, #0]
    88b6:	f7ff ff15 	bl	86e4 <_malloc_trim_r>
    88ba:	e7c5      	b.n	8848 <_free_r+0xc0>
    88bc:	616c      	str	r4, [r5, #20]
    88be:	f043 0201 	orr.w	r2, r3, #1
    88c2:	612c      	str	r4, [r5, #16]
    88c4:	60e0      	str	r0, [r4, #12]
    88c6:	60a0      	str	r0, [r4, #8]
    88c8:	6062      	str	r2, [r4, #4]
    88ca:	50e3      	str	r3, [r4, r3]
    88cc:	e7bc      	b.n	8848 <_free_r+0xc0>
    88ce:	2a14      	cmp	r2, #20
    88d0:	bf9c      	itt	ls
    88d2:	f102 005b 	addls.w	r0, r2, #91	; 0x5b
    88d6:	0041      	lslls	r1, r0, #1
    88d8:	d9a0      	bls.n	881c <_free_r+0x94>
    88da:	2a54      	cmp	r2, #84	; 0x54
    88dc:	d80c      	bhi.n	88f8 <_free_r+0x170>
    88de:	0b18      	lsrs	r0, r3, #12
    88e0:	306e      	adds	r0, #110	; 0x6e
    88e2:	0041      	lsls	r1, r0, #1
    88e4:	e79a      	b.n	881c <_free_r+0x94>
    88e6:	2301      	movs	r3, #1
    88e8:	684d      	ldr	r5, [r1, #4]
    88ea:	1080      	asrs	r0, r0, #2
    88ec:	fa03 f000 	lsl.w	r0, r3, r0
    88f0:	4613      	mov	r3, r2
    88f2:	4305      	orrs	r5, r0
    88f4:	604d      	str	r5, [r1, #4]
    88f6:	e7a3      	b.n	8840 <_free_r+0xb8>
    88f8:	f5b2 7faa 	cmp.w	r2, #340	; 0x154
    88fc:	d803      	bhi.n	8906 <_free_r+0x17e>
    88fe:	0bd8      	lsrs	r0, r3, #15
    8900:	3077      	adds	r0, #119	; 0x77
    8902:	0041      	lsls	r1, r0, #1
    8904:	e78a      	b.n	881c <_free_r+0x94>
    8906:	f240 5154 	movw	r1, #1364	; 0x554
    890a:	428a      	cmp	r2, r1
    890c:	bf99      	ittee	ls
    890e:	0c98      	lsrls	r0, r3, #18
    8910:	307c      	addls	r0, #124	; 0x7c
    8912:	21fc      	movhi	r1, #252	; 0xfc
    8914:	207e      	movhi	r0, #126	; 0x7e
    8916:	bf98      	it	ls
    8918:	0041      	lslls	r1, r0, #1
    891a:	e77f      	b.n	881c <_free_r+0x94>
    891c:	000093dc 	ldrdeq	r9, [r0], -ip

00008920 <_malloc_r>:
    8920:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
    8924:	f101 040b 	add.w	r4, r1, #11
    8928:	2c16      	cmp	r4, #22
    892a:	b083      	sub	sp, #12
    892c:	bf88      	it	hi
    892e:	f024 0407 	bichi.w	r4, r4, #7
    8932:	4607      	mov	r7, r0
    8934:	bf9a      	itte	ls
    8936:	2300      	movls	r3, #0
    8938:	2410      	movls	r4, #16
    893a:	0fe3      	lsrhi	r3, r4, #31
    893c:	428c      	cmp	r4, r1
    893e:	bf2c      	ite	cs
    8940:	4619      	movcs	r1, r3
    8942:	f043 0101 	orrcc.w	r1, r3, #1
    8946:	2900      	cmp	r1, #0
    8948:	f040 80b4 	bne.w	8ab4 <_malloc_r+0x194>
    894c:	f000 fa9c 	bl	8e88 <__malloc_lock>
    8950:	f5b4 7ffc 	cmp.w	r4, #504	; 0x1f8
    8954:	d220      	bcs.n	8998 <_malloc_r+0x78>
    8956:	ea4f 0cd4 	mov.w	ip, r4, lsr #3
    895a:	f249 36d4 	movw	r6, #37844	; 0x93d4
    895e:	f2c0 0600 	movt	r6, #0
    8962:	eb06 02cc 	add.w	r2, r6, ip, lsl #3
    8966:	68d3      	ldr	r3, [r2, #12]
    8968:	4293      	cmp	r3, r2
    896a:	f000 81f5 	beq.w	8d58 <_malloc_r+0x438>
    896e:	6859      	ldr	r1, [r3, #4]
    8970:	f103 0508 	add.w	r5, r3, #8
    8974:	68da      	ldr	r2, [r3, #12]
    8976:	4638      	mov	r0, r7
    8978:	f021 0403 	bic.w	r4, r1, #3
    897c:	6899      	ldr	r1, [r3, #8]
    897e:	4423      	add	r3, r4
    8980:	685c      	ldr	r4, [r3, #4]
    8982:	60ca      	str	r2, [r1, #12]
    8984:	f044 0401 	orr.w	r4, r4, #1
    8988:	6091      	str	r1, [r2, #8]
    898a:	605c      	str	r4, [r3, #4]
    898c:	f000 fa7e 	bl	8e8c <__malloc_unlock>
    8990:	4628      	mov	r0, r5
    8992:	b003      	add	sp, #12
    8994:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    8998:	ea5f 2c54 	movs.w	ip, r4, lsr #9
    899c:	bf04      	itt	eq
    899e:	257e      	moveq	r5, #126	; 0x7e
    89a0:	f04f 0c3f 	moveq.w	ip, #63	; 0x3f
    89a4:	f040 808d 	bne.w	8ac2 <_malloc_r+0x1a2>
    89a8:	f249 36d4 	movw	r6, #37844	; 0x93d4
    89ac:	f2c0 0600 	movt	r6, #0
    89b0:	eb06 0585 	add.w	r5, r6, r5, lsl #2
    89b4:	68eb      	ldr	r3, [r5, #12]
    89b6:	429d      	cmp	r5, r3
    89b8:	d106      	bne.n	89c8 <_malloc_r+0xa8>
    89ba:	e00d      	b.n	89d8 <_malloc_r+0xb8>
    89bc:	2a00      	cmp	r2, #0
    89be:	f280 8162 	bge.w	8c86 <_malloc_r+0x366>
    89c2:	68db      	ldr	r3, [r3, #12]
    89c4:	429d      	cmp	r5, r3
    89c6:	d007      	beq.n	89d8 <_malloc_r+0xb8>
    89c8:	6859      	ldr	r1, [r3, #4]
    89ca:	f021 0103 	bic.w	r1, r1, #3
    89ce:	1b0a      	subs	r2, r1, r4
    89d0:	2a0f      	cmp	r2, #15
    89d2:	ddf3      	ble.n	89bc <_malloc_r+0x9c>
    89d4:	f10c 3cff 	add.w	ip, ip, #4294967295	; 0xffffffff
    89d8:	f10c 0c01 	add.w	ip, ip, #1
    89dc:	f249 32d4 	movw	r2, #37844	; 0x93d4
    89e0:	6933      	ldr	r3, [r6, #16]
    89e2:	f2c0 0200 	movt	r2, #0
    89e6:	f102 0e08 	add.w	lr, r2, #8
    89ea:	4573      	cmp	r3, lr
    89ec:	bf08      	it	eq
    89ee:	6851      	ldreq	r1, [r2, #4]
    89f0:	d021      	beq.n	8a36 <_malloc_r+0x116>
    89f2:	6858      	ldr	r0, [r3, #4]
    89f4:	f020 0003 	bic.w	r0, r0, #3
    89f8:	1b01      	subs	r1, r0, r4
    89fa:	290f      	cmp	r1, #15
    89fc:	f300 8190 	bgt.w	8d20 <_malloc_r+0x400>
    8a00:	2900      	cmp	r1, #0
    8a02:	f8c2 e014 	str.w	lr, [r2, #20]
    8a06:	f8c2 e010 	str.w	lr, [r2, #16]
    8a0a:	da65      	bge.n	8ad8 <_malloc_r+0x1b8>
    8a0c:	f5b0 7f00 	cmp.w	r0, #512	; 0x200
    8a10:	f080 815f 	bcs.w	8cd2 <_malloc_r+0x3b2>
    8a14:	08c0      	lsrs	r0, r0, #3
    8a16:	f04f 0801 	mov.w	r8, #1
    8a1a:	6851      	ldr	r1, [r2, #4]
    8a1c:	eb02 05c0 	add.w	r5, r2, r0, lsl #3
    8a20:	1080      	asrs	r0, r0, #2
    8a22:	fa08 f800 	lsl.w	r8, r8, r0
    8a26:	68a8      	ldr	r0, [r5, #8]
    8a28:	ea48 0101 	orr.w	r1, r8, r1
    8a2c:	60dd      	str	r5, [r3, #12]
    8a2e:	6051      	str	r1, [r2, #4]
    8a30:	6098      	str	r0, [r3, #8]
    8a32:	60ab      	str	r3, [r5, #8]
    8a34:	60c3      	str	r3, [r0, #12]
    8a36:	ea4f 03ac 	mov.w	r3, ip, asr #2
    8a3a:	2001      	movs	r0, #1
    8a3c:	4098      	lsls	r0, r3
    8a3e:	4288      	cmp	r0, r1
    8a40:	d858      	bhi.n	8af4 <_malloc_r+0x1d4>
    8a42:	4201      	tst	r1, r0
    8a44:	d106      	bne.n	8a54 <_malloc_r+0x134>
    8a46:	f02c 0c03 	bic.w	ip, ip, #3
    8a4a:	0040      	lsls	r0, r0, #1
    8a4c:	f10c 0c04 	add.w	ip, ip, #4
    8a50:	4201      	tst	r1, r0
    8a52:	d0fa      	beq.n	8a4a <_malloc_r+0x12a>
    8a54:	eb06 08cc 	add.w	r8, r6, ip, lsl #3
    8a58:	46e1      	mov	r9, ip
    8a5a:	4645      	mov	r5, r8
    8a5c:	68ea      	ldr	r2, [r5, #12]
    8a5e:	4295      	cmp	r5, r2
    8a60:	d107      	bne.n	8a72 <_malloc_r+0x152>
    8a62:	e171      	b.n	8d48 <_malloc_r+0x428>
    8a64:	2900      	cmp	r1, #0
    8a66:	f280 8181 	bge.w	8d6c <_malloc_r+0x44c>
    8a6a:	68d2      	ldr	r2, [r2, #12]
    8a6c:	4295      	cmp	r5, r2
    8a6e:	f000 816b 	beq.w	8d48 <_malloc_r+0x428>
    8a72:	6853      	ldr	r3, [r2, #4]
    8a74:	f023 0303 	bic.w	r3, r3, #3
    8a78:	1b19      	subs	r1, r3, r4
    8a7a:	290f      	cmp	r1, #15
    8a7c:	ddf2      	ble.n	8a64 <_malloc_r+0x144>
    8a7e:	4615      	mov	r5, r2
    8a80:	f8d2 c00c 	ldr.w	ip, [r2, #12]
    8a84:	f855 8f08 	ldr.w	r8, [r5, #8]!
    8a88:	1913      	adds	r3, r2, r4
    8a8a:	4638      	mov	r0, r7
    8a8c:	f044 0401 	orr.w	r4, r4, #1
    8a90:	f041 0701 	orr.w	r7, r1, #1
    8a94:	6054      	str	r4, [r2, #4]
    8a96:	f8c8 c00c 	str.w	ip, [r8, #12]
    8a9a:	f8cc 8008 	str.w	r8, [ip, #8]
    8a9e:	6173      	str	r3, [r6, #20]
    8aa0:	6133      	str	r3, [r6, #16]
    8aa2:	f8c3 e00c 	str.w	lr, [r3, #12]
    8aa6:	f8c3 e008 	str.w	lr, [r3, #8]
    8aaa:	605f      	str	r7, [r3, #4]
    8aac:	5059      	str	r1, [r3, r1]
    8aae:	f000 f9ed 	bl	8e8c <__malloc_unlock>
    8ab2:	e76d      	b.n	8990 <_malloc_r+0x70>
    8ab4:	2500      	movs	r5, #0
    8ab6:	230c      	movs	r3, #12
    8ab8:	6003      	str	r3, [r0, #0]
    8aba:	4628      	mov	r0, r5
    8abc:	b003      	add	sp, #12
    8abe:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    8ac2:	f1bc 0f04 	cmp.w	ip, #4
    8ac6:	f200 80f0 	bhi.w	8caa <_malloc_r+0x38a>
    8aca:	ea4f 1c94 	mov.w	ip, r4, lsr #6
    8ace:	f10c 0c38 	add.w	ip, ip, #56	; 0x38
    8ad2:	ea4f 054c 	mov.w	r5, ip, lsl #1
    8ad6:	e767      	b.n	89a8 <_malloc_r+0x88>
    8ad8:	181a      	adds	r2, r3, r0
    8ada:	f103 0508 	add.w	r5, r3, #8
    8ade:	4638      	mov	r0, r7
    8ae0:	6853      	ldr	r3, [r2, #4]
    8ae2:	f043 0301 	orr.w	r3, r3, #1
    8ae6:	6053      	str	r3, [r2, #4]
    8ae8:	f000 f9d0 	bl	8e8c <__malloc_unlock>
    8aec:	4628      	mov	r0, r5
    8aee:	b003      	add	sp, #12
    8af0:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    8af4:	68b5      	ldr	r5, [r6, #8]
    8af6:	686b      	ldr	r3, [r5, #4]
    8af8:	f023 0903 	bic.w	r9, r3, #3
    8afc:	454c      	cmp	r4, r9
    8afe:	d804      	bhi.n	8b0a <_malloc_r+0x1ea>
    8b00:	ebc4 0309 	rsb	r3, r4, r9
    8b04:	2b0f      	cmp	r3, #15
    8b06:	f300 80ae 	bgt.w	8c66 <_malloc_r+0x346>
    8b0a:	f249 73f8 	movw	r3, #38904	; 0x97f8
    8b0e:	f249 7ae0 	movw	sl, #38880	; 0x97e0
    8b12:	f2c0 0300 	movt	r3, #0
    8b16:	f2c0 0a00 	movt	sl, #0
    8b1a:	4638      	mov	r0, r7
    8b1c:	eb05 0209 	add.w	r2, r5, r9
    8b20:	681b      	ldr	r3, [r3, #0]
    8b22:	f8da 1000 	ldr.w	r1, [sl]
    8b26:	4423      	add	r3, r4
    8b28:	3101      	adds	r1, #1
    8b2a:	bf17      	itett	ne
    8b2c:	f503 5380 	addne.w	r3, r3, #4096	; 0x1000
    8b30:	f103 0c10 	addeq.w	ip, r3, #16
    8b34:	330f      	addne	r3, #15
    8b36:	f423 637f 	bicne.w	r3, r3, #4080	; 0xff0
    8b3a:	bf18      	it	ne
    8b3c:	f023 0c0f 	bicne.w	ip, r3, #15
    8b40:	e88d 1004 	stmia.w	sp, {r2, ip}
    8b44:	4661      	mov	r1, ip
    8b46:	f000 f9a3 	bl	8e90 <_sbrk_r>
    8b4a:	e89d 1004 	ldmia.w	sp, {r2, ip}
    8b4e:	f1b0 3fff 	cmp.w	r0, #4294967295	; 0xffffffff
    8b52:	4680      	mov	r8, r0
    8b54:	f000 8120 	beq.w	8d98 <_malloc_r+0x478>
    8b58:	4282      	cmp	r2, r0
    8b5a:	f200 811a 	bhi.w	8d92 <_malloc_r+0x472>
    8b5e:	f249 7bfc 	movw	fp, #38908	; 0x97fc
    8b62:	f2c0 0b00 	movt	fp, #0
    8b66:	4542      	cmp	r2, r8
    8b68:	f8db 3000 	ldr.w	r3, [fp]
    8b6c:	4463      	add	r3, ip
    8b6e:	f8cb 3000 	str.w	r3, [fp]
    8b72:	f000 815f 	beq.w	8e34 <_malloc_r+0x514>
    8b76:	f8da 0000 	ldr.w	r0, [sl]
    8b7a:	f249 71e0 	movw	r1, #38880	; 0x97e0
    8b7e:	f2c0 0100 	movt	r1, #0
    8b82:	3001      	adds	r0, #1
    8b84:	4638      	mov	r0, r7
    8b86:	bf17      	itett	ne
    8b88:	ebc2 0208 	rsbne	r2, r2, r8
    8b8c:	f8c1 8000 	streq.w	r8, [r1]
    8b90:	189b      	addne	r3, r3, r2
    8b92:	f8cb 3000 	strne.w	r3, [fp]
    8b96:	f018 0307 	ands.w	r3, r8, #7
    8b9a:	bf1f      	itttt	ne
    8b9c:	f1c3 0208 	rsbne	r2, r3, #8
    8ba0:	f5c3 5380 	rsbne	r3, r3, #4096	; 0x1000
    8ba4:	4490      	addne	r8, r2
    8ba6:	f103 0a08 	addne.w	sl, r3, #8
    8baa:	eb08 030c 	add.w	r3, r8, ip
    8bae:	bf08      	it	eq
    8bb0:	f44f 5a80 	moveq.w	sl, #4096	; 0x1000
    8bb4:	f3c3 030b 	ubfx	r3, r3, #0, #12
    8bb8:	ebc3 0a0a 	rsb	sl, r3, sl
    8bbc:	4651      	mov	r1, sl
    8bbe:	f000 f967 	bl	8e90 <_sbrk_r>
    8bc2:	f249 72fc 	movw	r2, #38908	; 0x97fc
    8bc6:	f8c6 8008 	str.w	r8, [r6, #8]
    8bca:	f2c0 0200 	movt	r2, #0
    8bce:	1c43      	adds	r3, r0, #1
    8bd0:	f8db 3000 	ldr.w	r3, [fp]
    8bd4:	bf1b      	ittet	ne
    8bd6:	ebc8 0100 	rsbne	r1, r8, r0
    8bda:	4451      	addne	r1, sl
    8bdc:	2101      	moveq	r1, #1
    8bde:	f041 0101 	orrne.w	r1, r1, #1
    8be2:	bf08      	it	eq
    8be4:	f04f 0a00 	moveq.w	sl, #0
    8be8:	42b5      	cmp	r5, r6
    8bea:	4453      	add	r3, sl
    8bec:	f8c8 1004 	str.w	r1, [r8, #4]
    8bf0:	f8cb 3000 	str.w	r3, [fp]
    8bf4:	d018      	beq.n	8c28 <_malloc_r+0x308>
    8bf6:	f1b9 0f0f 	cmp.w	r9, #15
    8bfa:	f240 80fc 	bls.w	8df6 <_malloc_r+0x4d6>
    8bfe:	f1a9 010c 	sub.w	r1, r9, #12
    8c02:	6868      	ldr	r0, [r5, #4]
    8c04:	f021 0107 	bic.w	r1, r1, #7
    8c08:	f04f 0c05 	mov.w	ip, #5
    8c0c:	eb05 0e01 	add.w	lr, r5, r1
    8c10:	290f      	cmp	r1, #15
    8c12:	f000 0001 	and.w	r0, r0, #1
    8c16:	ea41 0000 	orr.w	r0, r1, r0
    8c1a:	6068      	str	r0, [r5, #4]
    8c1c:	f8ce c004 	str.w	ip, [lr, #4]
    8c20:	f8ce c008 	str.w	ip, [lr, #8]
    8c24:	f200 8112 	bhi.w	8e4c <_malloc_r+0x52c>
    8c28:	f249 72f4 	movw	r2, #38900	; 0x97f4
    8c2c:	f2c0 0200 	movt	r2, #0
    8c30:	68b5      	ldr	r5, [r6, #8]
    8c32:	6811      	ldr	r1, [r2, #0]
    8c34:	428b      	cmp	r3, r1
    8c36:	bf88      	it	hi
    8c38:	6013      	strhi	r3, [r2, #0]
    8c3a:	f249 72f0 	movw	r2, #38896	; 0x97f0
    8c3e:	f2c0 0200 	movt	r2, #0
    8c42:	6811      	ldr	r1, [r2, #0]
    8c44:	428b      	cmp	r3, r1
    8c46:	bf88      	it	hi
    8c48:	6013      	strhi	r3, [r2, #0]
    8c4a:	686a      	ldr	r2, [r5, #4]
    8c4c:	f022 0203 	bic.w	r2, r2, #3
    8c50:	4294      	cmp	r4, r2
    8c52:	ebc4 0302 	rsb	r3, r4, r2
    8c56:	d801      	bhi.n	8c5c <_malloc_r+0x33c>
    8c58:	2b0f      	cmp	r3, #15
    8c5a:	dc04      	bgt.n	8c66 <_malloc_r+0x346>
    8c5c:	4638      	mov	r0, r7
    8c5e:	2500      	movs	r5, #0
    8c60:	f000 f914 	bl	8e8c <__malloc_unlock>
    8c64:	e694      	b.n	8990 <_malloc_r+0x70>
    8c66:	192a      	adds	r2, r5, r4
    8c68:	f043 0301 	orr.w	r3, r3, #1
    8c6c:	4638      	mov	r0, r7
    8c6e:	f044 0401 	orr.w	r4, r4, #1
    8c72:	606c      	str	r4, [r5, #4]
    8c74:	3508      	adds	r5, #8
    8c76:	60b2      	str	r2, [r6, #8]
    8c78:	6053      	str	r3, [r2, #4]
    8c7a:	f000 f907 	bl	8e8c <__malloc_unlock>
    8c7e:	4628      	mov	r0, r5
    8c80:	b003      	add	sp, #12
    8c82:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    8c86:	4419      	add	r1, r3
    8c88:	68da      	ldr	r2, [r3, #12]
    8c8a:	689c      	ldr	r4, [r3, #8]
    8c8c:	4638      	mov	r0, r7
    8c8e:	684e      	ldr	r6, [r1, #4]
    8c90:	f103 0508 	add.w	r5, r3, #8
    8c94:	60e2      	str	r2, [r4, #12]
    8c96:	f046 0601 	orr.w	r6, r6, #1
    8c9a:	6094      	str	r4, [r2, #8]
    8c9c:	604e      	str	r6, [r1, #4]
    8c9e:	f000 f8f5 	bl	8e8c <__malloc_unlock>
    8ca2:	4628      	mov	r0, r5
    8ca4:	b003      	add	sp, #12
    8ca6:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    8caa:	f1bc 0f14 	cmp.w	ip, #20
    8cae:	bf9c      	itt	ls
    8cb0:	f10c 0c5b 	addls.w	ip, ip, #91	; 0x5b
    8cb4:	ea4f 054c 	movls.w	r5, ip, lsl #1
    8cb8:	f67f ae76 	bls.w	89a8 <_malloc_r+0x88>
    8cbc:	f1bc 0f54 	cmp.w	ip, #84	; 0x54
    8cc0:	f200 808f 	bhi.w	8de2 <_malloc_r+0x4c2>
    8cc4:	ea4f 3c14 	mov.w	ip, r4, lsr #12
    8cc8:	f10c 0c6e 	add.w	ip, ip, #110	; 0x6e
    8ccc:	ea4f 054c 	mov.w	r5, ip, lsl #1
    8cd0:	e66a      	b.n	89a8 <_malloc_r+0x88>
    8cd2:	0a42      	lsrs	r2, r0, #9
    8cd4:	2a04      	cmp	r2, #4
    8cd6:	d958      	bls.n	8d8a <_malloc_r+0x46a>
    8cd8:	2a14      	cmp	r2, #20
    8cda:	bf9c      	itt	ls
    8cdc:	f102 015b 	addls.w	r1, r2, #91	; 0x5b
    8ce0:	004d      	lslls	r5, r1, #1
    8ce2:	d905      	bls.n	8cf0 <_malloc_r+0x3d0>
    8ce4:	2a54      	cmp	r2, #84	; 0x54
    8ce6:	f200 80ba 	bhi.w	8e5e <_malloc_r+0x53e>
    8cea:	0b01      	lsrs	r1, r0, #12
    8cec:	316e      	adds	r1, #110	; 0x6e
    8cee:	004d      	lsls	r5, r1, #1
    8cf0:	eb06 0585 	add.w	r5, r6, r5, lsl #2
    8cf4:	f249 38d4 	movw	r8, #37844	; 0x93d4
    8cf8:	f2c0 0800 	movt	r8, #0
    8cfc:	68aa      	ldr	r2, [r5, #8]
    8cfe:	42aa      	cmp	r2, r5
    8d00:	d07f      	beq.n	8e02 <_malloc_r+0x4e2>
    8d02:	6851      	ldr	r1, [r2, #4]
    8d04:	f021 0103 	bic.w	r1, r1, #3
    8d08:	4288      	cmp	r0, r1
    8d0a:	d202      	bcs.n	8d12 <_malloc_r+0x3f2>
    8d0c:	6892      	ldr	r2, [r2, #8]
    8d0e:	4295      	cmp	r5, r2
    8d10:	d1f7      	bne.n	8d02 <_malloc_r+0x3e2>
    8d12:	68d0      	ldr	r0, [r2, #12]
    8d14:	6871      	ldr	r1, [r6, #4]
    8d16:	60d8      	str	r0, [r3, #12]
    8d18:	609a      	str	r2, [r3, #8]
    8d1a:	6083      	str	r3, [r0, #8]
    8d1c:	60d3      	str	r3, [r2, #12]
    8d1e:	e68a      	b.n	8a36 <_malloc_r+0x116>
    8d20:	191e      	adds	r6, r3, r4
    8d22:	4638      	mov	r0, r7
    8d24:	f044 0401 	orr.w	r4, r4, #1
    8d28:	f041 0701 	orr.w	r7, r1, #1
    8d2c:	605c      	str	r4, [r3, #4]
    8d2e:	f103 0508 	add.w	r5, r3, #8
    8d32:	6156      	str	r6, [r2, #20]
    8d34:	6116      	str	r6, [r2, #16]
    8d36:	f8c6 e00c 	str.w	lr, [r6, #12]
    8d3a:	f8c6 e008 	str.w	lr, [r6, #8]
    8d3e:	6077      	str	r7, [r6, #4]
    8d40:	5071      	str	r1, [r6, r1]
    8d42:	f000 f8a3 	bl	8e8c <__malloc_unlock>
    8d46:	e623      	b.n	8990 <_malloc_r+0x70>
    8d48:	f109 0901 	add.w	r9, r9, #1
    8d4c:	3508      	adds	r5, #8
    8d4e:	f019 0f03 	tst.w	r9, #3
    8d52:	f47f ae83 	bne.w	8a5c <_malloc_r+0x13c>
    8d56:	e028      	b.n	8daa <_malloc_r+0x48a>
    8d58:	f103 0208 	add.w	r2, r3, #8
    8d5c:	695b      	ldr	r3, [r3, #20]
    8d5e:	429a      	cmp	r2, r3
    8d60:	bf08      	it	eq
    8d62:	f10c 0c02 	addeq.w	ip, ip, #2
    8d66:	f43f ae39 	beq.w	89dc <_malloc_r+0xbc>
    8d6a:	e600      	b.n	896e <_malloc_r+0x4e>
    8d6c:	4413      	add	r3, r2
    8d6e:	4615      	mov	r5, r2
    8d70:	f855 1f08 	ldr.w	r1, [r5, #8]!
    8d74:	4638      	mov	r0, r7
    8d76:	68d2      	ldr	r2, [r2, #12]
    8d78:	685c      	ldr	r4, [r3, #4]
    8d7a:	f044 0401 	orr.w	r4, r4, #1
    8d7e:	605c      	str	r4, [r3, #4]
    8d80:	60ca      	str	r2, [r1, #12]
    8d82:	6091      	str	r1, [r2, #8]
    8d84:	f000 f882 	bl	8e8c <__malloc_unlock>
    8d88:	e602      	b.n	8990 <_malloc_r+0x70>
    8d8a:	0981      	lsrs	r1, r0, #6
    8d8c:	3138      	adds	r1, #56	; 0x38
    8d8e:	004d      	lsls	r5, r1, #1
    8d90:	e7ae      	b.n	8cf0 <_malloc_r+0x3d0>
    8d92:	42b5      	cmp	r5, r6
    8d94:	f43f aee3 	beq.w	8b5e <_malloc_r+0x23e>
    8d98:	68b5      	ldr	r5, [r6, #8]
    8d9a:	686a      	ldr	r2, [r5, #4]
    8d9c:	f022 0203 	bic.w	r2, r2, #3
    8da0:	e756      	b.n	8c50 <_malloc_r+0x330>
    8da2:	f8d8 8000 	ldr.w	r8, [r8]
    8da6:	4598      	cmp	r8, r3
    8da8:	d16b      	bne.n	8e82 <_malloc_r+0x562>
    8daa:	f01c 0f03 	tst.w	ip, #3
    8dae:	f1a8 0308 	sub.w	r3, r8, #8
    8db2:	f10c 3cff 	add.w	ip, ip, #4294967295	; 0xffffffff
    8db6:	d1f4      	bne.n	8da2 <_malloc_r+0x482>
    8db8:	6873      	ldr	r3, [r6, #4]
    8dba:	ea23 0300 	bic.w	r3, r3, r0
    8dbe:	6073      	str	r3, [r6, #4]
    8dc0:	0040      	lsls	r0, r0, #1
    8dc2:	4298      	cmp	r0, r3
    8dc4:	f63f ae96 	bhi.w	8af4 <_malloc_r+0x1d4>
    8dc8:	2800      	cmp	r0, #0
    8dca:	f43f ae93 	beq.w	8af4 <_malloc_r+0x1d4>
    8dce:	4203      	tst	r3, r0
    8dd0:	46cc      	mov	ip, r9
    8dd2:	f47f ae3f 	bne.w	8a54 <_malloc_r+0x134>
    8dd6:	0040      	lsls	r0, r0, #1
    8dd8:	f10c 0c04 	add.w	ip, ip, #4
    8ddc:	4203      	tst	r3, r0
    8dde:	d0fa      	beq.n	8dd6 <_malloc_r+0x4b6>
    8de0:	e638      	b.n	8a54 <_malloc_r+0x134>
    8de2:	f5bc 7faa 	cmp.w	ip, #340	; 0x154
    8de6:	d816      	bhi.n	8e16 <_malloc_r+0x4f6>
    8de8:	ea4f 3cd4 	mov.w	ip, r4, lsr #15
    8dec:	f10c 0c77 	add.w	ip, ip, #119	; 0x77
    8df0:	ea4f 054c 	mov.w	r5, ip, lsl #1
    8df4:	e5d8      	b.n	89a8 <_malloc_r+0x88>
    8df6:	2301      	movs	r3, #1
    8df8:	4645      	mov	r5, r8
    8dfa:	f8c8 3004 	str.w	r3, [r8, #4]
    8dfe:	2200      	movs	r2, #0
    8e00:	e726      	b.n	8c50 <_malloc_r+0x330>
    8e02:	1088      	asrs	r0, r1, #2
    8e04:	2501      	movs	r5, #1
    8e06:	f8d8 1004 	ldr.w	r1, [r8, #4]
    8e0a:	4085      	lsls	r5, r0
    8e0c:	4610      	mov	r0, r2
    8e0e:	4329      	orrs	r1, r5
    8e10:	f8c8 1004 	str.w	r1, [r8, #4]
    8e14:	e77f      	b.n	8d16 <_malloc_r+0x3f6>
    8e16:	f240 5354 	movw	r3, #1364	; 0x554
    8e1a:	459c      	cmp	ip, r3
    8e1c:	bf99      	ittee	ls
    8e1e:	ea4f 4c94 	movls.w	ip, r4, lsr #18
    8e22:	f10c 0c7c 	addls.w	ip, ip, #124	; 0x7c
    8e26:	25fc      	movhi	r5, #252	; 0xfc
    8e28:	f04f 0c7e 	movhi.w	ip, #126	; 0x7e
    8e2c:	bf98      	it	ls
    8e2e:	ea4f 054c 	movls.w	r5, ip, lsl #1
    8e32:	e5b9      	b.n	89a8 <_malloc_r+0x88>
    8e34:	f3c2 010b 	ubfx	r1, r2, #0, #12
    8e38:	2900      	cmp	r1, #0
    8e3a:	f47f ae9c 	bne.w	8b76 <_malloc_r+0x256>
    8e3e:	68b2      	ldr	r2, [r6, #8]
    8e40:	eb0c 0109 	add.w	r1, ip, r9
    8e44:	f041 0101 	orr.w	r1, r1, #1
    8e48:	6051      	str	r1, [r2, #4]
    8e4a:	e6ed      	b.n	8c28 <_malloc_r+0x308>
    8e4c:	f105 0108 	add.w	r1, r5, #8
    8e50:	4638      	mov	r0, r7
    8e52:	9200      	str	r2, [sp, #0]
    8e54:	f7ff fc98 	bl	8788 <_free_r>
    8e58:	9a00      	ldr	r2, [sp, #0]
    8e5a:	6813      	ldr	r3, [r2, #0]
    8e5c:	e6e4      	b.n	8c28 <_malloc_r+0x308>
    8e5e:	f5b2 7faa 	cmp.w	r2, #340	; 0x154
    8e62:	d803      	bhi.n	8e6c <_malloc_r+0x54c>
    8e64:	0bc1      	lsrs	r1, r0, #15
    8e66:	3177      	adds	r1, #119	; 0x77
    8e68:	004d      	lsls	r5, r1, #1
    8e6a:	e741      	b.n	8cf0 <_malloc_r+0x3d0>
    8e6c:	f240 5154 	movw	r1, #1364	; 0x554
    8e70:	428a      	cmp	r2, r1
    8e72:	bf99      	ittee	ls
    8e74:	0c81      	lsrls	r1, r0, #18
    8e76:	317c      	addls	r1, #124	; 0x7c
    8e78:	25fc      	movhi	r5, #252	; 0xfc
    8e7a:	217e      	movhi	r1, #126	; 0x7e
    8e7c:	bf98      	it	ls
    8e7e:	004d      	lslls	r5, r1, #1
    8e80:	e736      	b.n	8cf0 <_malloc_r+0x3d0>
    8e82:	6873      	ldr	r3, [r6, #4]
    8e84:	e79c      	b.n	8dc0 <_malloc_r+0x4a0>
    8e86:	bf00      	nop

00008e88 <__malloc_lock>:
    8e88:	4770      	bx	lr
    8e8a:	bf00      	nop

00008e8c <__malloc_unlock>:
    8e8c:	4770      	bx	lr
    8e8e:	bf00      	nop

00008e90 <_sbrk_r>:
    8e90:	b538      	push	{r3, r4, r5, lr}
    8e92:	f649 0424 	movw	r4, #38948	; 0x9824
    8e96:	f2c0 0400 	movt	r4, #0
    8e9a:	4605      	mov	r5, r0
    8e9c:	4608      	mov	r0, r1
    8e9e:	2300      	movs	r3, #0
    8ea0:	6023      	str	r3, [r4, #0]
    8ea2:	f7ff e9be 	blx	8220 <_sbrk>
    8ea6:	1c43      	adds	r3, r0, #1
    8ea8:	d000      	beq.n	8eac <_sbrk_r+0x1c>
    8eaa:	bd38      	pop	{r3, r4, r5, pc}
    8eac:	6823      	ldr	r3, [r4, #0]
    8eae:	2b00      	cmp	r3, #0
    8eb0:	d0fb      	beq.n	8eaa <_sbrk_r+0x1a>
    8eb2:	602b      	str	r3, [r5, #0]
    8eb4:	bd38      	pop	{r3, r4, r5, pc}
    8eb6:	bf00      	nop

Disassembly of section .rodata:

00008eb8 <_global_impure_ptr-0xe4>:
    8eb8:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    8ebc:	57202c6f 	strpl	r2, [r0, -pc, ror #24]!
    8ec0:	646c726f 	strbtvs	r7, [ip], #-623	; 0x26f
    8ec4:	00000a0d 	andeq	r0, r0, sp, lsl #20
    8ec8:	74696e49 	strbtvc	r6, [r9], #-3657	; 0xe49
    8ecc:	6e6f6420 	cdpvs	4, 6, cr6, cr15, cr0, {1}
    8ed0:	6c202c65 	stcvs	12, cr2, [r0], #-404	; 0xfffffe6c
    8ed4:	73206465 	teqvc	r0, #1694498816	; 0x65000000
    8ed8:	6c756f68 	ldclvs	15, cr6, [r5], #-416	; 0xfffffe60
    8edc:	65622064 	strbvs	r2, [r2, #-100]!	; 0x64
    8ee0:	696c6220 	stmdbvs	ip!, {r5, r9, sp, lr}^
    8ee4:	6e696b6e 	vnmulvs.f64	d22, d9, d30
    8ee8:	0a0d2167 	beq	35148c <_stack+0x2d148c>
    8eec:	00000000 	andeq	r0, r0, r0
    8ef0:	65646e55 	strbvs	r6, [r4, #-3669]!	; 0xe55
    8ef4:	656e6966 	strbvs	r6, [lr, #-2406]!	; 0x966
    8ef8:	6f6d2064 	svcvs	0x006d2064
    8efc:	21216564 	teqcs	r1, r4, ror #10
    8f00:	000a0d21 	andeq	r0, sl, r1, lsr #26
    8f04:	20495753 	subcs	r5, r9, r3, asr r7
    8f08:	646e6168 	strbtvs	r6, [lr], #-360	; 0x168
    8f0c:	2172656c 	cmncs	r2, ip, ror #10
    8f10:	00000a0d 	andeq	r0, r0, sp, lsl #20
    8f14:	52535043 	subspl	r5, r3, #67	; 0x43
    8f18:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f20 <_sbrk_r+0x90>
    8f1c:	53555f45 	cmppl	r5, #276	; 0x114
    8f20:	0a0d5245 	beq	35d83c <_stack+0x2dd83c>
    8f24:	00000000 	andeq	r0, r0, r0
    8f28:	52535043 	subspl	r5, r3, #67	; 0x43
    8f2c:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f34 <_sbrk_r+0xa4>
    8f30:	49465f45 	stmdbmi	r6, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
    8f34:	000a0d51 	andeq	r0, sl, r1, asr sp
    8f38:	52535043 	subspl	r5, r3, #67	; 0x43
    8f3c:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f44 <_sbrk_r+0xb4>
    8f40:	52495f45 	subpl	r5, r9, #276	; 0x114
    8f44:	000a0d51 	andeq	r0, sl, r1, asr sp
    8f48:	52535043 	subspl	r5, r3, #67	; 0x43
    8f4c:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f54 <_sbrk_r+0xc4>
    8f50:	56535f45 	ldrbpl	r5, [r3], -r5, asr #30
    8f54:	000a0d52 	andeq	r0, sl, r2, asr sp
    8f58:	52535043 	subspl	r5, r3, #67	; 0x43
    8f5c:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f64 <_sbrk_r+0xd4>
    8f60:	42415f45 	submi	r5, r1, #276	; 0x114
    8f64:	0d54524f 	lfmeq	f5, 2, [r4, #-316]	; 0xfffffec4
    8f68:	0000000a 	andeq	r0, r0, sl
    8f6c:	52535043 	subspl	r5, r3, #67	; 0x43
    8f70:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f78 <_sbrk_r+0xe8>
    8f74:	4e555f45 	cdpmi	15, 5, cr5, cr5, cr5, {2}
    8f78:	49464544 	stmdbmi	r6, {r2, r6, r8, sl, lr}^
    8f7c:	0d44454e 	cfstr64eq	mvdx4, [r4, #-312]	; 0xfffffec8
    8f80:	0000000a 	andeq	r0, r0, sl
    8f84:	52535043 	subspl	r5, r3, #67	; 0x43
    8f88:	444f4d5f 	strbmi	r4, [pc], #-3423	; 8f90 <_sbrk_r+0x100>
    8f8c:	59535f45 	ldmdbpl	r3, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
    8f90:	4d455453 	cfstrdmi	mvd5, [r5, #-332]	; 0xfffffeb4
    8f94:	00000a0d 	andeq	r0, r0, sp, lsl #20
    8f98:	00000043 	andeq	r0, r0, r3, asr #32

00008f9c <_global_impure_ptr>:
    8f9c:	00008fa8 	andeq	r8, r0, r8, lsr #31

Disassembly of section .data:

00008fa0 <__data_start>:
    8fa0:	000097e8 	andeq	r9, r0, r8, ror #15
    8fa4:	00000000 	andeq	r0, r0, r0

00008fa8 <impure_data>:
    8fa8:	00000000 	andeq	r0, r0, r0
    8fac:	00009294 	muleq	r0, r4, r2
    8fb0:	000092fc 	strdeq	r9, [r0], -ip
    8fb4:	00009364 	andeq	r9, r0, r4, ror #6
	...
    8fdc:	00008f98 	muleq	r0, r8, pc	; <UNPREDICTABLE>
	...
    9050:	00000001 	andeq	r0, r0, r1
    9054:	00000000 	andeq	r0, r0, r0
    9058:	abcd330e 	blge	ff355c98 <_stack+0xff2d5c98>
    905c:	e66d1234 			; <UNDEFINED> instruction: 0xe66d1234
    9060:	0005deec 	andeq	sp, r5, ip, ror #29
    9064:	0000000b 	andeq	r0, r0, fp
	...

000093d0 <_impure_ptr>:
    93d0:	00008fa8 	andeq	r8, r0, r8, lsr #31

000093d4 <__malloc_av_>:
	...
    93dc:	000093d4 	ldrdeq	r9, [r0], -r4
    93e0:	000093d4 	ldrdeq	r9, [r0], -r4
    93e4:	000093dc 	ldrdeq	r9, [r0], -ip
    93e8:	000093dc 	ldrdeq	r9, [r0], -ip
    93ec:	000093e4 	andeq	r9, r0, r4, ror #7
    93f0:	000093e4 	andeq	r9, r0, r4, ror #7
    93f4:	000093ec 	andeq	r9, r0, ip, ror #7
    93f8:	000093ec 	andeq	r9, r0, ip, ror #7
    93fc:	000093f4 	strdeq	r9, [r0], -r4
    9400:	000093f4 	strdeq	r9, [r0], -r4
    9404:	000093fc 	strdeq	r9, [r0], -ip
    9408:	000093fc 	strdeq	r9, [r0], -ip
    940c:	00009404 	andeq	r9, r0, r4, lsl #8
    9410:	00009404 	andeq	r9, r0, r4, lsl #8
    9414:	0000940c 	andeq	r9, r0, ip, lsl #8
    9418:	0000940c 	andeq	r9, r0, ip, lsl #8
    941c:	00009414 	andeq	r9, r0, r4, lsl r4
    9420:	00009414 	andeq	r9, r0, r4, lsl r4
    9424:	0000941c 	andeq	r9, r0, ip, lsl r4
    9428:	0000941c 	andeq	r9, r0, ip, lsl r4
    942c:	00009424 	andeq	r9, r0, r4, lsr #8
    9430:	00009424 	andeq	r9, r0, r4, lsr #8
    9434:	0000942c 	andeq	r9, r0, ip, lsr #8
    9438:	0000942c 	andeq	r9, r0, ip, lsr #8
    943c:	00009434 	andeq	r9, r0, r4, lsr r4
    9440:	00009434 	andeq	r9, r0, r4, lsr r4
    9444:	0000943c 	andeq	r9, r0, ip, lsr r4
    9448:	0000943c 	andeq	r9, r0, ip, lsr r4
    944c:	00009444 	andeq	r9, r0, r4, asr #8
    9450:	00009444 	andeq	r9, r0, r4, asr #8
    9454:	0000944c 	andeq	r9, r0, ip, asr #8
    9458:	0000944c 	andeq	r9, r0, ip, asr #8
    945c:	00009454 	andeq	r9, r0, r4, asr r4
    9460:	00009454 	andeq	r9, r0, r4, asr r4
    9464:	0000945c 	andeq	r9, r0, ip, asr r4
    9468:	0000945c 	andeq	r9, r0, ip, asr r4
    946c:	00009464 	andeq	r9, r0, r4, ror #8
    9470:	00009464 	andeq	r9, r0, r4, ror #8
    9474:	0000946c 	andeq	r9, r0, ip, ror #8
    9478:	0000946c 	andeq	r9, r0, ip, ror #8
    947c:	00009474 	andeq	r9, r0, r4, ror r4
    9480:	00009474 	andeq	r9, r0, r4, ror r4
    9484:	0000947c 	andeq	r9, r0, ip, ror r4
    9488:	0000947c 	andeq	r9, r0, ip, ror r4
    948c:	00009484 	andeq	r9, r0, r4, lsl #9
    9490:	00009484 	andeq	r9, r0, r4, lsl #9
    9494:	0000948c 	andeq	r9, r0, ip, lsl #9
    9498:	0000948c 	andeq	r9, r0, ip, lsl #9
    949c:	00009494 	muleq	r0, r4, r4
    94a0:	00009494 	muleq	r0, r4, r4
    94a4:	0000949c 	muleq	r0, ip, r4
    94a8:	0000949c 	muleq	r0, ip, r4
    94ac:	000094a4 	andeq	r9, r0, r4, lsr #9
    94b0:	000094a4 	andeq	r9, r0, r4, lsr #9
    94b4:	000094ac 	andeq	r9, r0, ip, lsr #9
    94b8:	000094ac 	andeq	r9, r0, ip, lsr #9
    94bc:	000094b4 			; <UNDEFINED> instruction: 0x000094b4
    94c0:	000094b4 			; <UNDEFINED> instruction: 0x000094b4
    94c4:	000094bc 			; <UNDEFINED> instruction: 0x000094bc
    94c8:	000094bc 			; <UNDEFINED> instruction: 0x000094bc
    94cc:	000094c4 	andeq	r9, r0, r4, asr #9
    94d0:	000094c4 	andeq	r9, r0, r4, asr #9
    94d4:	000094cc 	andeq	r9, r0, ip, asr #9
    94d8:	000094cc 	andeq	r9, r0, ip, asr #9
    94dc:	000094d4 	ldrdeq	r9, [r0], -r4
    94e0:	000094d4 	ldrdeq	r9, [r0], -r4
    94e4:	000094dc 	ldrdeq	r9, [r0], -ip
    94e8:	000094dc 	ldrdeq	r9, [r0], -ip
    94ec:	000094e4 	andeq	r9, r0, r4, ror #9
    94f0:	000094e4 	andeq	r9, r0, r4, ror #9
    94f4:	000094ec 	andeq	r9, r0, ip, ror #9
    94f8:	000094ec 	andeq	r9, r0, ip, ror #9
    94fc:	000094f4 	strdeq	r9, [r0], -r4
    9500:	000094f4 	strdeq	r9, [r0], -r4
    9504:	000094fc 	strdeq	r9, [r0], -ip
    9508:	000094fc 	strdeq	r9, [r0], -ip
    950c:	00009504 	andeq	r9, r0, r4, lsl #10
    9510:	00009504 	andeq	r9, r0, r4, lsl #10
    9514:	0000950c 	andeq	r9, r0, ip, lsl #10
    9518:	0000950c 	andeq	r9, r0, ip, lsl #10
    951c:	00009514 	andeq	r9, r0, r4, lsl r5
    9520:	00009514 	andeq	r9, r0, r4, lsl r5
    9524:	0000951c 	andeq	r9, r0, ip, lsl r5
    9528:	0000951c 	andeq	r9, r0, ip, lsl r5
    952c:	00009524 	andeq	r9, r0, r4, lsr #10
    9530:	00009524 	andeq	r9, r0, r4, lsr #10
    9534:	0000952c 	andeq	r9, r0, ip, lsr #10
    9538:	0000952c 	andeq	r9, r0, ip, lsr #10
    953c:	00009534 	andeq	r9, r0, r4, lsr r5
    9540:	00009534 	andeq	r9, r0, r4, lsr r5
    9544:	0000953c 	andeq	r9, r0, ip, lsr r5
    9548:	0000953c 	andeq	r9, r0, ip, lsr r5
    954c:	00009544 	andeq	r9, r0, r4, asr #10
    9550:	00009544 	andeq	r9, r0, r4, asr #10
    9554:	0000954c 	andeq	r9, r0, ip, asr #10
    9558:	0000954c 	andeq	r9, r0, ip, asr #10
    955c:	00009554 	andeq	r9, r0, r4, asr r5
    9560:	00009554 	andeq	r9, r0, r4, asr r5
    9564:	0000955c 	andeq	r9, r0, ip, asr r5
    9568:	0000955c 	andeq	r9, r0, ip, asr r5
    956c:	00009564 	andeq	r9, r0, r4, ror #10
    9570:	00009564 	andeq	r9, r0, r4, ror #10
    9574:	0000956c 	andeq	r9, r0, ip, ror #10
    9578:	0000956c 	andeq	r9, r0, ip, ror #10
    957c:	00009574 	andeq	r9, r0, r4, ror r5
    9580:	00009574 	andeq	r9, r0, r4, ror r5
    9584:	0000957c 	andeq	r9, r0, ip, ror r5
    9588:	0000957c 	andeq	r9, r0, ip, ror r5
    958c:	00009584 	andeq	r9, r0, r4, lsl #11
    9590:	00009584 	andeq	r9, r0, r4, lsl #11
    9594:	0000958c 	andeq	r9, r0, ip, lsl #11
    9598:	0000958c 	andeq	r9, r0, ip, lsl #11
    959c:	00009594 	muleq	r0, r4, r5
    95a0:	00009594 	muleq	r0, r4, r5
    95a4:	0000959c 	muleq	r0, ip, r5
    95a8:	0000959c 	muleq	r0, ip, r5
    95ac:	000095a4 	andeq	r9, r0, r4, lsr #11
    95b0:	000095a4 	andeq	r9, r0, r4, lsr #11
    95b4:	000095ac 	andeq	r9, r0, ip, lsr #11
    95b8:	000095ac 	andeq	r9, r0, ip, lsr #11
    95bc:	000095b4 			; <UNDEFINED> instruction: 0x000095b4
    95c0:	000095b4 			; <UNDEFINED> instruction: 0x000095b4
    95c4:	000095bc 			; <UNDEFINED> instruction: 0x000095bc
    95c8:	000095bc 			; <UNDEFINED> instruction: 0x000095bc
    95cc:	000095c4 	andeq	r9, r0, r4, asr #11
    95d0:	000095c4 	andeq	r9, r0, r4, asr #11
    95d4:	000095cc 	andeq	r9, r0, ip, asr #11
    95d8:	000095cc 	andeq	r9, r0, ip, asr #11
    95dc:	000095d4 	ldrdeq	r9, [r0], -r4
    95e0:	000095d4 	ldrdeq	r9, [r0], -r4
    95e4:	000095dc 	ldrdeq	r9, [r0], -ip
    95e8:	000095dc 	ldrdeq	r9, [r0], -ip
    95ec:	000095e4 	andeq	r9, r0, r4, ror #11
    95f0:	000095e4 	andeq	r9, r0, r4, ror #11
    95f4:	000095ec 	andeq	r9, r0, ip, ror #11
    95f8:	000095ec 	andeq	r9, r0, ip, ror #11
    95fc:	000095f4 	strdeq	r9, [r0], -r4
    9600:	000095f4 	strdeq	r9, [r0], -r4
    9604:	000095fc 	strdeq	r9, [r0], -ip
    9608:	000095fc 	strdeq	r9, [r0], -ip
    960c:	00009604 	andeq	r9, r0, r4, lsl #12
    9610:	00009604 	andeq	r9, r0, r4, lsl #12
    9614:	0000960c 	andeq	r9, r0, ip, lsl #12
    9618:	0000960c 	andeq	r9, r0, ip, lsl #12
    961c:	00009614 	andeq	r9, r0, r4, lsl r6
    9620:	00009614 	andeq	r9, r0, r4, lsl r6
    9624:	0000961c 	andeq	r9, r0, ip, lsl r6
    9628:	0000961c 	andeq	r9, r0, ip, lsl r6
    962c:	00009624 	andeq	r9, r0, r4, lsr #12
    9630:	00009624 	andeq	r9, r0, r4, lsr #12
    9634:	0000962c 	andeq	r9, r0, ip, lsr #12
    9638:	0000962c 	andeq	r9, r0, ip, lsr #12
    963c:	00009634 	andeq	r9, r0, r4, lsr r6
    9640:	00009634 	andeq	r9, r0, r4, lsr r6
    9644:	0000963c 	andeq	r9, r0, ip, lsr r6
    9648:	0000963c 	andeq	r9, r0, ip, lsr r6
    964c:	00009644 	andeq	r9, r0, r4, asr #12
    9650:	00009644 	andeq	r9, r0, r4, asr #12
    9654:	0000964c 	andeq	r9, r0, ip, asr #12
    9658:	0000964c 	andeq	r9, r0, ip, asr #12
    965c:	00009654 	andeq	r9, r0, r4, asr r6
    9660:	00009654 	andeq	r9, r0, r4, asr r6
    9664:	0000965c 	andeq	r9, r0, ip, asr r6
    9668:	0000965c 	andeq	r9, r0, ip, asr r6
    966c:	00009664 	andeq	r9, r0, r4, ror #12
    9670:	00009664 	andeq	r9, r0, r4, ror #12
    9674:	0000966c 	andeq	r9, r0, ip, ror #12
    9678:	0000966c 	andeq	r9, r0, ip, ror #12
    967c:	00009674 	andeq	r9, r0, r4, ror r6
    9680:	00009674 	andeq	r9, r0, r4, ror r6
    9684:	0000967c 	andeq	r9, r0, ip, ror r6
    9688:	0000967c 	andeq	r9, r0, ip, ror r6
    968c:	00009684 	andeq	r9, r0, r4, lsl #13
    9690:	00009684 	andeq	r9, r0, r4, lsl #13
    9694:	0000968c 	andeq	r9, r0, ip, lsl #13
    9698:	0000968c 	andeq	r9, r0, ip, lsl #13
    969c:	00009694 	muleq	r0, r4, r6
    96a0:	00009694 	muleq	r0, r4, r6
    96a4:	0000969c 	muleq	r0, ip, r6
    96a8:	0000969c 	muleq	r0, ip, r6
    96ac:	000096a4 	andeq	r9, r0, r4, lsr #13
    96b0:	000096a4 	andeq	r9, r0, r4, lsr #13
    96b4:	000096ac 	andeq	r9, r0, ip, lsr #13
    96b8:	000096ac 	andeq	r9, r0, ip, lsr #13
    96bc:	000096b4 			; <UNDEFINED> instruction: 0x000096b4
    96c0:	000096b4 			; <UNDEFINED> instruction: 0x000096b4
    96c4:	000096bc 			; <UNDEFINED> instruction: 0x000096bc
    96c8:	000096bc 			; <UNDEFINED> instruction: 0x000096bc
    96cc:	000096c4 	andeq	r9, r0, r4, asr #13
    96d0:	000096c4 	andeq	r9, r0, r4, asr #13
    96d4:	000096cc 	andeq	r9, r0, ip, asr #13
    96d8:	000096cc 	andeq	r9, r0, ip, asr #13
    96dc:	000096d4 	ldrdeq	r9, [r0], -r4
    96e0:	000096d4 	ldrdeq	r9, [r0], -r4
    96e4:	000096dc 	ldrdeq	r9, [r0], -ip
    96e8:	000096dc 	ldrdeq	r9, [r0], -ip
    96ec:	000096e4 	andeq	r9, r0, r4, ror #13
    96f0:	000096e4 	andeq	r9, r0, r4, ror #13
    96f4:	000096ec 	andeq	r9, r0, ip, ror #13
    96f8:	000096ec 	andeq	r9, r0, ip, ror #13
    96fc:	000096f4 	strdeq	r9, [r0], -r4
    9700:	000096f4 	strdeq	r9, [r0], -r4
    9704:	000096fc 	strdeq	r9, [r0], -ip
    9708:	000096fc 	strdeq	r9, [r0], -ip
    970c:	00009704 	andeq	r9, r0, r4, lsl #14
    9710:	00009704 	andeq	r9, r0, r4, lsl #14
    9714:	0000970c 	andeq	r9, r0, ip, lsl #14
    9718:	0000970c 	andeq	r9, r0, ip, lsl #14
    971c:	00009714 	andeq	r9, r0, r4, lsl r7
    9720:	00009714 	andeq	r9, r0, r4, lsl r7
    9724:	0000971c 	andeq	r9, r0, ip, lsl r7
    9728:	0000971c 	andeq	r9, r0, ip, lsl r7
    972c:	00009724 	andeq	r9, r0, r4, lsr #14
    9730:	00009724 	andeq	r9, r0, r4, lsr #14
    9734:	0000972c 	andeq	r9, r0, ip, lsr #14
    9738:	0000972c 	andeq	r9, r0, ip, lsr #14
    973c:	00009734 	andeq	r9, r0, r4, lsr r7
    9740:	00009734 	andeq	r9, r0, r4, lsr r7
    9744:	0000973c 	andeq	r9, r0, ip, lsr r7
    9748:	0000973c 	andeq	r9, r0, ip, lsr r7
    974c:	00009744 	andeq	r9, r0, r4, asr #14
    9750:	00009744 	andeq	r9, r0, r4, asr #14
    9754:	0000974c 	andeq	r9, r0, ip, asr #14
    9758:	0000974c 	andeq	r9, r0, ip, asr #14
    975c:	00009754 	andeq	r9, r0, r4, asr r7
    9760:	00009754 	andeq	r9, r0, r4, asr r7
    9764:	0000975c 	andeq	r9, r0, ip, asr r7
    9768:	0000975c 	andeq	r9, r0, ip, asr r7
    976c:	00009764 	andeq	r9, r0, r4, ror #14
    9770:	00009764 	andeq	r9, r0, r4, ror #14
    9774:	0000976c 	andeq	r9, r0, ip, ror #14
    9778:	0000976c 	andeq	r9, r0, ip, ror #14
    977c:	00009774 	andeq	r9, r0, r4, ror r7
    9780:	00009774 	andeq	r9, r0, r4, ror r7
    9784:	0000977c 	andeq	r9, r0, ip, ror r7
    9788:	0000977c 	andeq	r9, r0, ip, ror r7
    978c:	00009784 	andeq	r9, r0, r4, lsl #15
    9790:	00009784 	andeq	r9, r0, r4, lsl #15
    9794:	0000978c 	andeq	r9, r0, ip, lsl #15
    9798:	0000978c 	andeq	r9, r0, ip, lsl #15
    979c:	00009794 	muleq	r0, r4, r7
    97a0:	00009794 	muleq	r0, r4, r7
    97a4:	0000979c 	muleq	r0, ip, r7
    97a8:	0000979c 	muleq	r0, ip, r7
    97ac:	000097a4 	andeq	r9, r0, r4, lsr #15
    97b0:	000097a4 	andeq	r9, r0, r4, lsr #15
    97b4:	000097ac 	andeq	r9, r0, ip, lsr #15
    97b8:	000097ac 	andeq	r9, r0, ip, lsr #15
    97bc:	000097b4 			; <UNDEFINED> instruction: 0x000097b4
    97c0:	000097b4 			; <UNDEFINED> instruction: 0x000097b4
    97c4:	000097bc 			; <UNDEFINED> instruction: 0x000097bc
    97c8:	000097bc 			; <UNDEFINED> instruction: 0x000097bc
    97cc:	000097c4 	andeq	r9, r0, r4, asr #15
    97d0:	000097c4 	andeq	r9, r0, r4, asr #15
    97d4:	000097cc 	andeq	r9, r0, ip, asr #15
    97d8:	000097cc 	andeq	r9, r0, ip, asr #15

000097dc <__malloc_trim_threshold>:
    97dc:	00020000 	andeq	r0, r2, r0

000097e0 <__malloc_sbrk_base>:
    97e0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

Disassembly of section .bss:

000097e4 <heap_end.5342>:
    97e4:	00000000 	andeq	r0, r0, r0

000097e8 <__env>:
    97e8:	00000000 	andeq	r0, r0, r0

000097ec <lit.5118>:
    97ec:	00000000 	andeq	r0, r0, r0

000097f0 <__malloc_max_total_mem>:
    97f0:	00000000 	andeq	r0, r0, r0

000097f4 <__malloc_max_sbrked_mem>:
    97f4:	00000000 	andeq	r0, r0, r0

000097f8 <__malloc_top_pad>:
    97f8:	00000000 	andeq	r0, r0, r0

000097fc <__malloc_current_mallinfo>:
	...

00009824 <errno>:
    9824:	00000000 	andeq	r0, r0, r0

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <_stack+0x1050d24>
   4:	2e342820 	cdpcs	8, 3, cr2, cr4, cr0, {1}
   8:	2d322e38 	ldccs	14, cr2, [r2, #-224]!	; 0xffffff20
   c:	62753431 	rsbsvs	r3, r5, #822083584	; 0x31000000
  10:	75746e75 	ldrbvc	r6, [r4, #-3701]!	; 0xe75
  14:	29362b31 	ldmdbcs	r6!, {r0, r4, r5, r8, r9, fp, sp}
  18:	382e3420 	stmdacc	lr!, {r5, sl, ip, sp}
  1c:	Address 0x000000000000001c is out of bounds.


Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	00000024 	andeq	r0, r0, r4, lsr #32
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	000085d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
  14:	0000001a 	andeq	r0, r0, sl, lsl r0
  18:	000085f4 	strdeq	r8, [r0], -r4
  1c:	00000090 	muleq	r0, r0, r0
	...
  28:	0000001c 	andeq	r0, r0, ip, lsl r0
  2c:	09fb0002 	ldmibeq	fp!, {r1}^
  30:	00040000 	andeq	r0, r4, r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008684 	andeq	r8, r0, r4, lsl #13
  3c:	0000005e 	andeq	r0, r0, lr, asr r0
	...
  48:	00000024 	andeq	r0, r0, r4, lsr #32
  4c:	0ab00002 	beq	fec0005c <_stack+0xfeb8005c>
  50:	00040000 	andeq	r0, r4, r0
  54:	00000000 	andeq	r0, r0, r0
  58:	000086e4 	andeq	r8, r0, r4, ror #13
  5c:	000000a2 	andeq	r0, r0, r2, lsr #1
  60:	00008788 	andeq	r8, r0, r8, lsl #15
  64:	00000198 	muleq	r0, r8, r1
	...
  70:	00000014 	andeq	r0, r0, r4, lsl r0
  74:	16cc0002 	strbne	r0, [ip], r2
  78:	00040000 	andeq	r0, r4, r0
	...
  88:	0000001c 	andeq	r0, r0, ip, lsl r0
  8c:	1f600002 	svcne	0x00600002
  90:	00040000 	andeq	r0, r4, r0
  94:	00000000 	andeq	r0, r0, r0
  98:	00008920 	andeq	r8, r0, r0, lsr #18
  9c:	00000566 	andeq	r0, r0, r6, ror #10
	...
  a8:	00000024 	andeq	r0, r0, r4, lsr #32
  ac:	2cdd0002 	ldclcs	0, cr0, [sp], {2}
  b0:	00040000 	andeq	r0, r4, r0
  b4:	00000000 	andeq	r0, r0, r0
  b8:	00008e88 	andeq	r8, r0, r8, lsl #29
  bc:	00000002 	andeq	r0, r0, r2
  c0:	00008e8c 	andeq	r8, r0, ip, lsl #29
  c4:	00000002 	andeq	r0, r0, r2
	...
  d0:	0000001c 	andeq	r0, r0, ip, lsl r0
  d4:	35910002 	ldrcc	r0, [r1, #2]
  d8:	00040000 	andeq	r0, r4, r0
  dc:	00000000 	andeq	r0, r0, r0
  e0:	00008e90 	muleq	r0, r0, lr
  e4:	00000026 	andeq	r0, r0, r6, lsr #32
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	000009f7 	strdeq	r0, [r0], -r7
       4:	00000004 	andeq	r0, r0, r4
       8:	01040000 	mrseq	r0, (UNDEF: 4)
       c:	000003ce 	andeq	r0, r0, lr, asr #7
      10:	00025701 	andeq	r5, r2, r1, lsl #14
      14:	0002c300 	andeq	ip, r2, r0, lsl #6
      18:	00001800 	andeq	r1, r0, r0, lsl #16
	...
      24:	07040200 	streq	r0, [r4, -r0, lsl #4]
      28:	0000022b 	andeq	r0, r0, fp, lsr #4
      2c:	69050403 	stmdbvs	r5, {r0, r1, sl}
      30:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
      34:	01f90601 	mvnseq	r0, r1, lsl #12
      38:	01020000 	mrseq	r0, (UNDEF: 2)
      3c:	0001f708 	andeq	pc, r1, r8, lsl #14
      40:	05020200 	streq	r0, [r2, #-512]	; 0x200
      44:	00000057 	andeq	r0, r0, r7, asr r0
      48:	a0070202 	andge	r0, r7, r2, lsl #4
      4c:	02000002 	andeq	r0, r0, #2
      50:	017c0504 	cmneq	ip, r4, lsl #10
      54:	04020000 	streq	r0, [r2], #-0
      58:	00022607 	andeq	r2, r2, r7, lsl #12
      5c:	05080200 	streq	r0, [r8, #-512]	; 0x200
      60:	00000177 	andeq	r0, r0, r7, ror r1
      64:	21070802 	tstcs	r7, r2, lsl #16
      68:	04000002 	streq	r0, [r0], #-2
      6c:	0000010c 	andeq	r0, r0, ip, lsl #2
      70:	002c0702 	eoreq	r0, ip, r2, lsl #14
      74:	2a040000 	bcs	10007c <_stack+0x8007c>
      78:	03000000 	movweq	r0, #0
      7c:	00004f10 	andeq	r4, r0, r0, lsl pc
      80:	01bf0400 			; <UNDEFINED> instruction: 0x01bf0400
      84:	27030000 	strcs	r0, [r3, -r0]
      88:	0000004f 	andeq	r0, r0, pc, asr #32
      8c:	00035905 	andeq	r5, r3, r5, lsl #18
      90:	01610400 	cmneq	r1, r0, lsl #8
      94:	00000025 	andeq	r0, r0, r5, lsr #32
      98:	4a030406 	bmi	c10b8 <_stack+0x410b8>
      9c:	000000b7 	strheq	r0, [r0], -r7
      a0:	00003107 	andeq	r3, r0, r7, lsl #2
      a4:	8c4c0300 	mcrrhi	3, 0, r0, ip, cr0
      a8:	07000000 	streq	r0, [r0, -r0]
      ac:	0000021a 	andeq	r0, r0, sl, lsl r2
      b0:	00b74d03 	adcseq	r4, r7, r3, lsl #26
      b4:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
      b8:	0000003a 	andeq	r0, r0, sl, lsr r0
      bc:	000000c7 	andeq	r0, r0, r7, asr #1
      c0:	0000c709 	andeq	ip, r0, r9, lsl #14
      c4:	02000300 	andeq	r0, r0, #0, 6
      c8:	006b0704 	rsbeq	r0, fp, r4, lsl #14
      cc:	080a0000 	stmdaeq	sl, {}	; <UNPREDICTABLE>
      d0:	00ef4703 	rsceq	r4, pc, r3, lsl #14
      d4:	bb0b0000 	bllt	2c00dc <_stack+0x2400dc>
      d8:	03000000 	movweq	r0, #0
      dc:	00002c49 	andeq	r2, r0, r9, asr #24
      e0:	400b0000 	andmi	r0, fp, r0
      e4:	03000000 	movweq	r0, #0
      e8:	0000984e 	andeq	r9, r0, lr, asr #16
      ec:	04000400 	streq	r0, [r0], #-1024	; 0x400
      f0:	000003a9 	andeq	r0, r0, r9, lsr #7
      f4:	00ce4f03 	sbceq	r4, lr, r3, lsl #30
      f8:	ce040000 	cdpgt	0, 0, cr0, cr4, cr0, {0}
      fc:	03000001 	movweq	r0, #1
     100:	00006b53 	andeq	r6, r0, r3, asr fp
     104:	04040c00 	streq	r0, [r4], #-3072	; 0xc00
     108:	000004b5 			; <UNDEFINED> instruction: 0x000004b5
     10c:	00561605 	subseq	r1, r6, r5, lsl #12
     110:	b40d0000 	strlt	r0, [sp], #-0
     114:	18000003 	stmdane	r0, {r0, r1}
     118:	01652d05 	cmneq	r5, r5, lsl #26
     11c:	0d0b0000 	stceq	0, cr0, [fp, #-0]
     120:	05000005 	streq	r0, [r0, #-5]
     124:	0001652f 	andeq	r6, r1, pc, lsr #10
     128:	5f0e0000 	svcpl	0x000e0000
     12c:	3005006b 	andcc	r0, r5, fp, rrx
     130:	0000002c 	andeq	r0, r0, ip, lsr #32
     134:	03bc0b04 			; <UNDEFINED> instruction: 0x03bc0b04
     138:	30050000 	andcc	r0, r5, r0
     13c:	0000002c 	andeq	r0, r0, ip, lsr #32
     140:	05020b08 	streq	r0, [r2, #-2824]	; 0xb08
     144:	30050000 	andcc	r0, r5, r0
     148:	0000002c 	andeq	r0, r0, ip, lsr #32
     14c:	03390b0c 	teqeq	r9, #12, 22	; 0x3000
     150:	30050000 	andcc	r0, r5, r0
     154:	0000002c 	andeq	r0, r0, ip, lsr #32
     158:	785f0e10 	ldmdavc	pc, {r4, r9, sl, fp}^	; <UNPREDICTABLE>
     15c:	6b310500 	blvs	c41564 <_stack+0xbc1564>
     160:	14000001 	strne	r0, [r0], #-1
     164:	12040f00 	andne	r0, r4, #0, 30
     168:	08000001 	stmdaeq	r0, {r0}
     16c:	00000107 	andeq	r0, r0, r7, lsl #2
     170:	0000017b 	andeq	r0, r0, fp, ror r1
     174:	0000c709 	andeq	ip, r0, r9, lsl #14
     178:	0d000000 	stceq	0, cr0, [r0, #-0]
     17c:	0000033e 	andeq	r0, r0, lr, lsr r3
     180:	f4350524 			; <UNDEFINED> instruction: 0xf4350524
     184:	0b000001 	bleq	190 <CPSR_IRQ_INHIBIT+0x110>
     188:	000001e4 	andeq	r0, r0, r4, ror #3
     18c:	002c3705 	eoreq	r3, ip, r5, lsl #14
     190:	0b000000 	bleq	198 <CPSR_IRQ_INHIBIT+0x118>
     194:	00000139 	andeq	r0, r0, r9, lsr r1
     198:	002c3805 	eoreq	r3, ip, r5, lsl #16
     19c:	0b040000 	bleq	1001a4 <_stack+0x801a4>
     1a0:	000001ed 	andeq	r0, r0, sp, ror #3
     1a4:	002c3905 	eoreq	r3, ip, r5, lsl #18
     1a8:	0b080000 	bleq	2001b0 <_stack+0x1801b0>
     1ac:	000000c3 	andeq	r0, r0, r3, asr #1
     1b0:	002c3a05 	eoreq	r3, ip, r5, lsl #20
     1b4:	0b0c0000 	bleq	3001bc <_stack+0x2801bc>
     1b8:	000004cb 	andeq	r0, r0, fp, asr #9
     1bc:	002c3b05 	eoreq	r3, ip, r5, lsl #22
     1c0:	0b100000 	bleq	4001c8 <_stack+0x3801c8>
     1c4:	000003c4 	andeq	r0, r0, r4, asr #7
     1c8:	002c3c05 	eoreq	r3, ip, r5, lsl #24
     1cc:	0b140000 	bleq	5001d4 <_stack+0x4801d4>
     1d0:	0000016d 	andeq	r0, r0, sp, ror #2
     1d4:	002c3d05 	eoreq	r3, ip, r5, lsl #26
     1d8:	0b180000 	bleq	6001e0 <_stack+0x5801e0>
     1dc:	000004ab 	andeq	r0, r0, fp, lsr #9
     1e0:	002c3e05 	eoreq	r3, ip, r5, lsl #28
     1e4:	0b1c0000 	bleq	7001ec <_stack+0x6801ec>
     1e8:	00000199 	muleq	r0, r9, r1
     1ec:	002c3f05 	eoreq	r3, ip, r5, lsl #30
     1f0:	00200000 	eoreq	r0, r0, r0
     1f4:	00024910 	andeq	r4, r2, r0, lsl r9
     1f8:	05010800 	streq	r0, [r1, #-2048]	; 0x800
     1fc:	00023448 	andeq	r3, r2, r8, asr #8
     200:	01850b00 	orreq	r0, r5, r0, lsl #22
     204:	49050000 	stmdbmi	r5, {}	; <UNPREDICTABLE>
     208:	00000234 	andeq	r0, r0, r4, lsr r2
     20c:	04f10b00 	ldrbteq	r0, [r1], #2816	; 0xb00
     210:	4a050000 	bmi	140218 <_stack+0xc0218>
     214:	00000234 	andeq	r0, r0, r4, lsr r2
     218:	01b61180 			; <UNDEFINED> instruction: 0x01b61180
     21c:	4c050000 	stcmi	0, cr0, [r5], {-0}
     220:	00000107 	andeq	r0, r0, r7, lsl #2
     224:	80110100 	andshi	r0, r1, r0, lsl #2
     228:	05000003 	streq	r0, [r0, #-3]
     22c:	0001074f 	andeq	r0, r1, pc, asr #14
     230:	00010400 	andeq	r0, r1, r0, lsl #8
     234:	00010508 	andeq	r0, r1, r8, lsl #10
     238:	00024400 	andeq	r4, r2, r0, lsl #8
     23c:	00c70900 	sbceq	r0, r7, r0, lsl #18
     240:	001f0000 	andseq	r0, pc, r0
     244:	0000eb10 	andeq	lr, r0, r0, lsl fp
     248:	05019000 	streq	r9, [r1, #-0]
     24c:	0002825b 	andeq	r8, r2, fp, asr r2
     250:	050d0b00 	streq	r0, [sp, #-2816]	; 0xb00
     254:	5c050000 	stcpl	0, cr0, [r5], {-0}
     258:	00000282 	andeq	r0, r0, r2, lsl #5
     25c:	04de0b00 	ldrbeq	r0, [lr], #2816	; 0xb00
     260:	5d050000 	stcpl	0, cr0, [r5, #-0]
     264:	0000002c 	andeq	r0, r0, ip, lsr #32
     268:	015f0b04 	cmpeq	pc, r4, lsl #22
     26c:	5f050000 	svcpl	0x00050000
     270:	00000288 	andeq	r0, r0, r8, lsl #5
     274:	02490b08 	subeq	r0, r9, #8, 22	; 0x2000
     278:	60050000 	andvs	r0, r5, r0
     27c:	000001f4 	strdeq	r0, [r0], -r4
     280:	040f0088 	streq	r0, [pc], #-136	; 288 <CPSR_IRQ_INHIBIT+0x208>
     284:	00000244 	andeq	r0, r0, r4, asr #4
     288:	00029808 	andeq	r9, r2, r8, lsl #16
     28c:	00029800 	andeq	r9, r2, r0, lsl #16
     290:	00c70900 	sbceq	r0, r7, r0, lsl #18
     294:	001f0000 	andseq	r0, pc, r0
     298:	029e040f 	addseq	r0, lr, #251658240	; 0xf000000
     29c:	0d120000 	ldceq	0, cr0, [r2, #-0]
     2a0:	00000050 	andeq	r0, r0, r0, asr r0
     2a4:	c4730508 	ldrbtgt	r0, [r3], #-1288	; 0x508
     2a8:	0b000002 	bleq	2b8 <CPSR_IRQ_INHIBIT+0x238>
     2ac:	000007c1 	andeq	r0, r0, r1, asr #15
     2b0:	02c47405 	sbceq	r7, r4, #83886080	; 0x5000000
     2b4:	0b000000 	bleq	2bc <CPSR_IRQ_INHIBIT+0x23c>
     2b8:	0000087b 	andeq	r0, r0, fp, ror r8
     2bc:	002c7505 	eoreq	r7, ip, r5, lsl #10
     2c0:	00040000 	andeq	r0, r4, r0
     2c4:	003a040f 	eorseq	r0, sl, pc, lsl #8
     2c8:	4c0d0000 	stcmi	0, cr0, [sp], {-0}
     2cc:	68000005 	stmdavs	r0, {r0, r2}
     2d0:	03f4b305 	mvnseq	fp, #335544320	; 0x14000000
     2d4:	5f0e0000 	svcpl	0x000e0000
     2d8:	b4050070 	strlt	r0, [r5], #-112	; 0x70
     2dc:	000002c4 	andeq	r0, r0, r4, asr #5
     2e0:	725f0e00 	subsvc	r0, pc, #0, 28
     2e4:	2cb50500 	cfldr32cs	mvfx0, [r5]
     2e8:	04000000 	streq	r0, [r0], #-0
     2ec:	00775f0e 	rsbseq	r5, r7, lr, lsl #30
     2f0:	002cb605 	eoreq	fp, ip, r5, lsl #12
     2f4:	0b080000 	bleq	2002fc <_stack+0x1802fc>
     2f8:	0000009e 	muleq	r0, lr, r0
     2fc:	0041b705 	subeq	fp, r1, r5, lsl #14
     300:	0b0c0000 	bleq	300308 <_stack+0x280308>
     304:	00000317 	andeq	r0, r0, r7, lsl r3
     308:	0041b805 	subeq	fp, r1, r5, lsl #16
     30c:	0e0e0000 	cdpeq	0, 0, cr0, cr14, cr0, {0}
     310:	0066625f 	rsbeq	r6, r6, pc, asr r2
     314:	029fb905 	addseq	fp, pc, #81920	; 0x14000
     318:	0b100000 	bleq	400320 <_stack+0x380320>
     31c:	00000037 	andeq	r0, r0, r7, lsr r0
     320:	002cba05 	eoreq	fp, ip, r5, lsl #20
     324:	0b180000 	bleq	60032c <_stack+0x58032c>
     328:	000002bb 			; <UNDEFINED> instruction: 0x000002bb
     32c:	0105c105 	tsteq	r5, r5, lsl #2
     330:	0b1c0000 	bleq	700338 <_stack+0x680338>
     334:	00000205 	andeq	r0, r0, r5, lsl #4
     338:	0557c305 	ldrbeq	ip, [r7, #-773]	; 0x305
     33c:	0b200000 	bleq	800344 <_stack+0x780344>
     340:	000000a5 	andeq	r0, r0, r5, lsr #1
     344:	0586c505 	streq	ip, [r6, #1285]	; 0x505
     348:	0b240000 	bleq	900350 <_stack+0x880350>
     34c:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
     350:	05aac805 	streq	ip, [sl, #2053]!	; 0x805
     354:	0b280000 	bleq	a0035c <_stack+0x98035c>
     358:	000001c7 	andeq	r0, r0, r7, asr #3
     35c:	05c4c905 	strbeq	ip, [r4, #2309]	; 0x905
     360:	0e2c0000 	cdpeq	0, 2, cr0, cr12, cr0, {0}
     364:	0062755f 	rsbeq	r7, r2, pc, asr r5
     368:	029fcc05 	addseq	ip, pc, #1280	; 0x500
     36c:	0e300000 	cdpeq	0, 3, cr0, cr0, cr0, {0}
     370:	0070755f 	rsbseq	r7, r0, pc, asr r5
     374:	02c4cd05 	sbceq	ip, r4, #320	; 0x140
     378:	0e380000 	cdpeq	0, 3, cr0, cr8, cr0, {0}
     37c:	0072755f 	rsbseq	r7, r2, pc, asr r5
     380:	002cce05 	eoreq	ip, ip, r5, lsl #28
     384:	0b3c0000 	bleq	f0038c <_stack+0xe8038c>
     388:	00000539 	andeq	r0, r0, r9, lsr r5
     38c:	05cad105 	strbeq	sp, [sl, #261]	; 0x105
     390:	0b400000 	bleq	1000398 <_stack+0xf80398>
     394:	00000106 	andeq	r0, r0, r6, lsl #2
     398:	05dad205 	ldrbeq	sp, [sl, #517]	; 0x205
     39c:	0e430000 	cdpeq	0, 4, cr0, cr3, cr0, {0}
     3a0:	00626c5f 	rsbeq	r6, r2, pc, asr ip
     3a4:	029fd505 	addseq	sp, pc, #20971520	; 0x1400000
     3a8:	0b440000 	bleq	11003b0 <_stack+0x10803b0>
     3ac:	000001ad 	andeq	r0, r0, sp, lsr #3
     3b0:	002cd805 	eoreq	sp, ip, r5, lsl #16
     3b4:	0b4c0000 	bleq	13003bc <_stack+0x12803bc>
     3b8:	00000074 	andeq	r0, r0, r4, ror r0
     3bc:	0076d905 	rsbseq	sp, r6, r5, lsl #18
     3c0:	0b500000 	bleq	14003c8 <_stack+0x13803c8>
     3c4:	000007d4 	ldrdeq	r0, [r0], -r4
     3c8:	0412dc05 	ldreq	sp, [r2], #-3077	; 0xc05
     3cc:	0b540000 	bleq	15003d4 <_stack+0x14803d4>
     3d0:	000006b0 			; <UNDEFINED> instruction: 0x000006b0
     3d4:	00fae005 	rscseq	lr, sl, r5
     3d8:	0b580000 	bleq	16003e0 <_stack+0x15803e0>
     3dc:	00000164 	andeq	r0, r0, r4, ror #2
     3e0:	00efe205 	rsceq	lr, pc, r5, lsl #4
     3e4:	0b5c0000 	bleq	17003ec <_stack+0x16803ec>
     3e8:	0000000b 	andeq	r0, r0, fp
     3ec:	002ce305 	eoreq	lr, ip, r5, lsl #6
     3f0:	00640000 	rsbeq	r0, r4, r0
     3f4:	00002c13 	andeq	r2, r0, r3, lsl ip
     3f8:	00041200 	andeq	r1, r4, r0, lsl #4
     3fc:	04121400 	ldreq	r1, [r2], #-1024	; 0x400
     400:	05140000 	ldreq	r0, [r4, #-0]
     404:	14000001 	strne	r0, [r0], #-1
     408:	0000054a 	andeq	r0, r0, sl, asr #10
     40c:	00002c14 	andeq	r2, r0, r4, lsl ip
     410:	040f0000 	streq	r0, [pc], #-0	; 418 <CPSR_IRQ_INHIBIT+0x398>
     414:	00000418 	andeq	r0, r0, r8, lsl r4
     418:	0003a215 	andeq	sl, r3, r5, lsl r2
     41c:	05042800 	streq	r2, [r4, #-2048]	; 0x800
     420:	054a0239 	strbeq	r0, [sl, #-569]	; 0x239
     424:	3a160000 	bcc	58042c <_stack+0x50042c>
     428:	05000002 	streq	r0, [r0, #-2]
     42c:	002c023b 	eoreq	r0, ip, fp, lsr r2
     430:	16000000 	strne	r0, [r0], -r0
     434:	00000513 	andeq	r0, r0, r3, lsl r5
     438:	31024005 	tstcc	r2, r5
     43c:	04000006 	streq	r0, [r0], #-6
     440:	0000e316 	andeq	lr, r0, r6, lsl r3
     444:	02400500 	subeq	r0, r0, #0, 10
     448:	00000631 	andeq	r0, r0, r1, lsr r6
     44c:	02121608 	andseq	r1, r2, #8, 12	; 0x800000
     450:	40050000 	andmi	r0, r5, r0
     454:	00063102 	andeq	r3, r6, r2, lsl #2
     458:	d9160c00 	ldmdble	r6, {sl, fp}
     45c:	05000004 	streq	r0, [r0, #-4]
     460:	002c0242 	eoreq	r0, ip, r2, asr #4
     464:	16100000 	ldrne	r0, [r0], -r0
     468:	000000f3 	strdeq	r0, [r0], -r3
     46c:	13024305 	movwne	r4, #8965	; 0x2305
     470:	14000008 	strne	r0, [r0], #-8
     474:	00036e16 	andeq	r6, r3, r6, lsl lr
     478:	02450500 	subeq	r0, r5, #0, 10
     47c:	0000002c 	andeq	r0, r0, ip, lsr #32
     480:	051a1630 	ldreq	r1, [sl, #-1584]	; 0x630
     484:	46050000 	strmi	r0, [r5], -r0
     488:	00057b02 	andeq	r7, r5, r2, lsl #22
     48c:	00163400 	andseq	r3, r6, r0, lsl #8
     490:	05000000 	streq	r0, [r0, #-0]
     494:	002c0248 	eoreq	r0, ip, r8, asr #4
     498:	16380000 	ldrtne	r0, [r8], -r0
     49c:	00000388 	andeq	r0, r0, r8, lsl #7
     4a0:	2e024a05 	vmlacs.f32	s8, s4, s10
     4a4:	3c000008 	stccc	0, cr0, [r0], {8}
     4a8:	0004c316 	andeq	ip, r4, r6, lsl r3
     4ac:	024d0500 	subeq	r0, sp, #0, 10
     4b0:	00000165 	andeq	r0, r0, r5, ror #2
     4b4:	00611640 	rsbeq	r1, r1, r0, asr #12
     4b8:	4e050000 	cdpmi	0, 0, cr0, cr5, cr0, {0}
     4bc:	00002c02 	andeq	r2, r0, r2, lsl #24
     4c0:	fd164400 	ldc2	4, cr4, [r6, #-0]
     4c4:	05000004 	streq	r0, [r0, #-4]
     4c8:	0165024f 	cmneq	r5, pc, asr #4
     4cc:	16480000 	strbne	r0, [r8], -r0
     4d0:	00000155 	andeq	r0, r0, r5, asr r1
     4d4:	34025005 	strcc	r5, [r2], #-5
     4d8:	4c000008 	stcmi	0, cr0, [r0], {8}
     4dc:	0000fe16 	andeq	pc, r0, r6, lsl lr	; <UNPREDICTABLE>
     4e0:	02530500 	subseq	r0, r3, #0, 10
     4e4:	0000002c 	andeq	r0, r0, ip, lsr #32
     4e8:	02b31650 	adcseq	r1, r3, #80, 12	; 0x5000000
     4ec:	54050000 	strpl	r0, [r5], #-0
     4f0:	00054a02 	andeq	r4, r5, r2, lsl #20
     4f4:	54165400 	ldrpl	r5, [r6], #-1024	; 0x400
     4f8:	05000005 	streq	r0, [r0, #-5]
     4fc:	07f10277 			; <UNDEFINED> instruction: 0x07f10277
     500:	17580000 	ldrbne	r0, [r8, -r0]
     504:	000000eb 	andeq	r0, r0, fp, ror #1
     508:	82027b05 	andhi	r7, r2, #5120	; 0x1400
     50c:	48000002 	stmdami	r0, {r1}
     510:	01a41701 			; <UNDEFINED> instruction: 0x01a41701
     514:	7c050000 	stcvc	0, cr0, [r5], {-0}
     518:	00024402 	andeq	r4, r2, r2, lsl #8
     51c:	17014c00 	strne	r4, [r1, -r0, lsl #24]
     520:	00000142 	andeq	r0, r0, r2, asr #2
     524:	45028005 	strmi	r8, [r2, #-5]
     528:	dc000008 	stcle	0, cr0, [r0], {8}
     52c:	02411702 	subeq	r1, r1, #524288	; 0x80000
     530:	85050000 	strhi	r0, [r5, #-0]
     534:	0005f602 	andeq	pc, r5, r2, lsl #12
     538:	1702e000 	strne	lr, [r2, -r0]
     53c:	0000007c 	andeq	r0, r0, ip, ror r0
     540:	51028605 	tstpl	r2, r5, lsl #12
     544:	ec000008 	stc	0, cr0, [r0], {8}
     548:	040f0002 	streq	r0, [pc], #-2	; 550 <CPSR_IRQ_INHIBIT+0x4d0>
     54c:	00000550 	andeq	r0, r0, r0, asr r5
     550:	00080102 	andeq	r0, r8, r2, lsl #2
     554:	0f000002 	svceq	0x00000002
     558:	0003f404 	andeq	pc, r3, r4, lsl #8
     55c:	002c1300 	eoreq	r1, ip, r0, lsl #6
     560:	057b0000 	ldrbeq	r0, [fp, #-0]!
     564:	12140000 	andsne	r0, r4, #0
     568:	14000004 	strne	r0, [r0], #-4
     56c:	00000105 	andeq	r0, r0, r5, lsl #2
     570:	00057b14 	andeq	r7, r5, r4, lsl fp
     574:	002c1400 	eoreq	r1, ip, r0, lsl #8
     578:	0f000000 	svceq	0x00000000
     57c:	00058104 	andeq	r8, r5, r4, lsl #2
     580:	05501800 	ldrbeq	r1, [r0, #-2048]	; 0x800
     584:	040f0000 	streq	r0, [pc], #-0	; 58c <CPSR_IRQ_INHIBIT+0x50c>
     588:	0000055d 	andeq	r0, r0, sp, asr r5
     58c:	00008113 	andeq	r8, r0, r3, lsl r1
     590:	0005aa00 	andeq	sl, r5, r0, lsl #20
     594:	04121400 	ldreq	r1, [r2], #-1024	; 0x400
     598:	05140000 	ldreq	r0, [r4, #-0]
     59c:	14000001 	strne	r0, [r0], #-1
     5a0:	00000081 	andeq	r0, r0, r1, lsl #1
     5a4:	00002c14 	andeq	r2, r0, r4, lsl ip
     5a8:	040f0000 	streq	r0, [pc], #-0	; 5b0 <CPSR_IRQ_INHIBIT+0x530>
     5ac:	0000058c 	andeq	r0, r0, ip, lsl #11
     5b0:	00002c13 	andeq	r2, r0, r3, lsl ip
     5b4:	0005c400 	andeq	ip, r5, r0, lsl #8
     5b8:	04121400 	ldreq	r1, [r2], #-1024	; 0x400
     5bc:	05140000 	ldreq	r0, [r4, #-0]
     5c0:	00000001 	andeq	r0, r0, r1
     5c4:	05b0040f 	ldreq	r0, [r0, #1039]!	; 0x40f
     5c8:	3a080000 	bcc	2005d0 <_stack+0x1805d0>
     5cc:	da000000 	ble	5d4 <CPSR_IRQ_INHIBIT+0x554>
     5d0:	09000005 	stmdbeq	r0, {r0, r2}
     5d4:	000000c7 	andeq	r0, r0, r7, asr #1
     5d8:	3a080002 	bcc	2005e8 <_stack+0x1805e8>
     5dc:	ea000000 	b	5e4 <CPSR_IRQ_INHIBIT+0x564>
     5e0:	09000005 	stmdbeq	r0, {r0, r2}
     5e4:	000000c7 	andeq	r0, r0, r7, asr #1
     5e8:	25050000 	strcs	r0, [r5, #-0]
     5ec:	05000001 	streq	r0, [r0, #-1]
     5f0:	02ca011d 	sbceq	r0, sl, #1073741831	; 0x40000007
     5f4:	de190000 	cdple	0, 1, cr0, cr9, cr0, {0}
     5f8:	0c000001 	stceq	0, cr0, [r0], {1}
     5fc:	2b012105 	blcs	48a18 <__bss_end__+0x3f1f0>
     600:	16000006 	strne	r0, [r0], -r6
     604:	0000050d 	andeq	r0, r0, sp, lsl #10
     608:	2b012305 	blcs	49224 <__bss_end__+0x3f9fc>
     60c:	00000006 	andeq	r0, r0, r6
     610:	00011e16 	andeq	r1, r1, r6, lsl lr
     614:	01240500 	teqeq	r4, r0, lsl #10
     618:	0000002c 	andeq	r0, r0, ip, lsr #32
     61c:	018d1604 	orreq	r1, sp, r4, lsl #12
     620:	25050000 	strcs	r0, [r5, #-0]
     624:	00063101 	andeq	r3, r6, r1, lsl #2
     628:	0f000800 	svceq	0x00000800
     62c:	0005f604 	andeq	pc, r5, r4, lsl #12
     630:	ea040f00 	b	104238 <_stack+0x84238>
     634:	19000005 	stmdbne	r0, {r0, r2}
     638:	000004a3 	andeq	r0, r0, r3, lsr #9
     63c:	013d050e 	teqeq	sp, lr, lsl #10
     640:	0000066c 	andeq	r0, r0, ip, ror #12
     644:	00049d16 	andeq	r9, r4, r6, lsl sp
     648:	013e0500 	teqeq	lr, r0, lsl #10
     64c:	0000066c 	andeq	r0, r0, ip, ror #12
     650:	01931600 	orrseq	r1, r3, r0, lsl #12
     654:	3f050000 	svccc	0x00050000
     658:	00066c01 	andeq	r6, r6, r1, lsl #24
     65c:	d4160600 	ldrle	r0, [r6], #-1536	; 0x600
     660:	05000004 	streq	r0, [r0, #-4]
     664:	00480140 	subeq	r0, r8, r0, asr #2
     668:	000c0000 	andeq	r0, ip, r0
     66c:	00004808 	andeq	r4, r0, r8, lsl #16
     670:	00067c00 	andeq	r7, r6, r0, lsl #24
     674:	00c70900 	sbceq	r0, r7, r0, lsl #18
     678:	00020000 	andeq	r0, r2, r0
     67c:	5805d01a 	stmdapl	r5, {r1, r3, r4, ip, lr, pc}
     680:	00077d02 	andeq	r7, r7, r2, lsl #26
     684:	032c1600 	teqeq	ip, #0, 12
     688:	5a050000 	bpl	140690 <_stack+0xc0690>
     68c:	00002502 	andeq	r2, r0, r2, lsl #10
     690:	90160000 	andsls	r0, r6, r0
     694:	05000004 	streq	r0, [r0, #-4]
     698:	054a025b 	strbeq	r0, [sl, #-603]	; 0x25b
     69c:	16040000 	strne	r0, [r4], -r0
     6a0:	0000053f 	andeq	r0, r0, pc, lsr r5
     6a4:	7d025c05 	stcvc	12, cr5, [r2, #-20]	; 0xffffffec
     6a8:	08000007 	stmdaeq	r0, {r0, r1, r2}
     6ac:	0000ac16 	andeq	sl, r0, r6, lsl ip
     6b0:	025d0500 	subseq	r0, sp, #0, 10
     6b4:	0000017b 	andeq	r0, r0, fp, ror r1
     6b8:	031d1624 	tsteq	sp, #36, 12	; 0x2400000
     6bc:	5e050000 	cdppl	0, 0, cr0, cr5, cr0, {0}
     6c0:	00002c02 	andeq	r2, r0, r2, lsl #24
     6c4:	08164800 	ldmdaeq	r6, {fp, lr}
     6c8:	05000005 	streq	r0, [r0, #-5]
     6cc:	0064025f 	rsbeq	r0, r4, pc, asr r2
     6d0:	16500000 	ldrbne	r0, [r0], -r0
     6d4:	000000de 	ldrdeq	r0, [r0], -lr
     6d8:	37026005 	strcc	r6, [r2, -r5]
     6dc:	58000006 	stmdapl	r0, {r1, r2}
     6e0:	00001316 	andeq	r1, r0, r6, lsl r3
     6e4:	02610500 	rsbeq	r0, r1, #0, 10
     6e8:	000000ef 	andeq	r0, r0, pc, ror #1
     6ec:	034b1668 	movteq	r1, #46696	; 0xb668
     6f0:	62050000 	andvs	r0, r5, #0
     6f4:	0000ef02 	andeq	lr, r0, r2, lsl #30
     6f8:	e3167000 	tst	r6, #0
     6fc:	05000004 	streq	r0, [r0, #-4]
     700:	00ef0263 	rsceq	r0, pc, r3, ror #4
     704:	16780000 	ldrbtne	r0, [r8], -r0
     708:	00000020 	andeq	r0, r0, r0, lsr #32
     70c:	8d026405 	cfstrshi	mvf6, [r2, #-20]	; 0xffffffec
     710:	80000007 	andhi	r0, r0, r7
     714:	00008116 	andeq	r8, r0, r6, lsl r1
     718:	02650500 	rsbeq	r0, r5, #0, 10
     71c:	0000079d 	muleq	r0, sp, r7
     720:	012c1688 	smlawbeq	ip, r8, r6, r1
     724:	66050000 	strvs	r0, [r5], -r0
     728:	00002c02 	andeq	r2, r0, r2, lsl #24
     72c:	6016a000 	andsvs	sl, r6, r0
     730:	05000003 	streq	r0, [r0, #-3]
     734:	00ef0267 	rsceq	r0, pc, r7, ror #4
     738:	16a40000 	strtne	r0, [r4], r0
     73c:	00000289 	andeq	r0, r0, r9, lsl #5
     740:	ef026805 	svc	0x00026805
     744:	ac000000 	stcge	0, cr0, [r0], {-0}
     748:	0000cd16 	andeq	ip, r0, r6, lsl sp
     74c:	02690500 	rsbeq	r0, r9, #0, 10
     750:	000000ef 	andeq	r0, r0, pc, ror #1
     754:	052a16b4 	streq	r1, [sl, #-1716]!	; 0x6b4
     758:	6a050000 	bvs	140760 <_stack+0xc0760>
     75c:	0000ef02 	andeq	lr, r0, r2, lsl #30
     760:	8d16bc00 	ldchi	12, cr11, [r6, #-0]
     764:	05000000 	streq	r0, [r0, #-0]
     768:	00ef026b 	rsceq	r0, pc, fp, ror #4
     76c:	16c40000 	strbne	r0, [r4], r0
     770:	00000238 	andeq	r0, r0, r8, lsr r2
     774:	2c026c05 	stccs	12, cr6, [r2], {5}
     778:	cc000000 	stcgt	0, cr0, [r0], {-0}
     77c:	05500800 	ldrbeq	r0, [r0, #-2048]	; 0x800
     780:	078d0000 	streq	r0, [sp, r0]
     784:	c7090000 	strgt	r0, [r9, -r0]
     788:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
     78c:	05500800 	ldrbeq	r0, [r0, #-2048]	; 0x800
     790:	079d0000 	ldreq	r0, [sp, r0]
     794:	c7090000 	strgt	r0, [r9, -r0]
     798:	07000000 	streq	r0, [r0, -r0]
     79c:	05500800 	ldrbeq	r0, [r0, #-2048]	; 0x800
     7a0:	07ad0000 	streq	r0, [sp, r0]!
     7a4:	c7090000 	strgt	r0, [r9, -r0]
     7a8:	17000000 	strne	r0, [r0, -r0]
     7ac:	05f01a00 	ldrbeq	r1, [r0, #2560]!	; 0xa00
     7b0:	07d10271 			; <UNDEFINED> instruction: 0x07d10271
     7b4:	0b160000 	bleq	5807bc <_stack+0x5007bc>
     7b8:	05000002 	streq	r0, [r0, #-2]
     7bc:	07d10274 			; <UNDEFINED> instruction: 0x07d10274
     7c0:	16000000 	strne	r0, [r0], -r0
     7c4:	0000014c 	andeq	r0, r0, ip, asr #2
     7c8:	e1027505 	tst	r2, r5, lsl #10
     7cc:	78000007 	stmdavc	r0, {r0, r1, r2}
     7d0:	02c40800 	sbceq	r0, r4, #0, 16
     7d4:	07e10000 	strbeq	r0, [r1, r0]!
     7d8:	c7090000 	strgt	r0, [r9, -r0]
     7dc:	1d000000 	stcne	0, cr0, [r0, #-0]
     7e0:	00250800 	eoreq	r0, r5, r0, lsl #16
     7e4:	07f10000 	ldrbeq	r0, [r1, r0]!
     7e8:	c7090000 	strgt	r0, [r9, -r0]
     7ec:	1d000000 	stcne	0, cr0, [r0, #-0]
     7f0:	05f01b00 	ldrbeq	r1, [r0, #2816]!	; 0xb00
     7f4:	08130256 	ldmdaeq	r3, {r1, r2, r4, r6, r9}
     7f8:	a21c0000 	andsge	r0, ip, #0
     7fc:	05000003 	streq	r0, [r0, #-3]
     800:	067c026d 	ldrbteq	r0, [ip], -sp, ror #4
     804:	431c0000 	tstmi	ip, #0
     808:	05000003 	streq	r0, [r0, #-3]
     80c:	07ad0276 			; <UNDEFINED> instruction: 0x07ad0276
     810:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     814:	00000550 	andeq	r0, r0, r0, asr r5
     818:	00000823 	andeq	r0, r0, r3, lsr #16
     81c:	0000c709 	andeq	ip, r0, r9, lsl #14
     820:	1d001800 	stcne	8, cr1, [r0, #-0]
     824:	0000082e 	andeq	r0, r0, lr, lsr #16
     828:	00041214 	andeq	r1, r4, r4, lsl r2
     82c:	040f0000 	streq	r0, [pc], #-0	; 834 <CPSR_IRQ_INHIBIT+0x7b4>
     830:	00000823 	andeq	r0, r0, r3, lsr #16
     834:	0165040f 	cmneq	r5, pc, lsl #8
     838:	451d0000 	ldrmi	r0, [sp, #-0]
     83c:	14000008 	strne	r0, [r0], #-8
     840:	0000002c 	andeq	r0, r0, ip, lsr #32
     844:	4b040f00 	blmi	10444c <_stack+0x8444c>
     848:	0f000008 	svceq	0x00000008
     84c:	00083a04 	andeq	r3, r8, r4, lsl #20
     850:	05ea0800 	strbeq	r0, [sl, #2048]!	; 0x800
     854:	08610000 	stmdaeq	r1!, {}^	; <UNPREDICTABLE>
     858:	c7090000 	strgt	r0, [r9, -r0]
     85c:	02000000 	andeq	r0, r0, #0
     860:	01d71e00 	bicseq	r1, r7, r0, lsl #28
     864:	21010000 	mrscs	r0, (UNDEF: 1)
     868:	000085d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
     86c:	0000001a 	andeq	r0, r0, sl, lsl r0
     870:	08c19c01 	stmiaeq	r1, {r0, sl, fp, ip, pc}^
     874:	701f0000 	andsvc	r0, pc, r0
     878:	01007274 	tsteq	r0, r4, ror r2
     87c:	00041221 	andeq	r1, r4, r1, lsr #4
     880:	00000000 	andeq	r0, r0, r0
     884:	01df2000 	bicseq	r2, pc, r0
     888:	21010000 	mrscs	r0, (UNDEF: 1)
     88c:	0000062b 	andeq	r0, r0, fp, lsr #12
     890:	00000037 	andeq	r0, r0, r7, lsr r0
     894:	0085e621 	addeq	lr, r5, r1, lsr #12
     898:	00086100 	andeq	r6, r8, r0, lsl #2
     89c:	0008a800 	andeq	sl, r8, r0, lsl #16
     8a0:	50012200 	andpl	r2, r1, r0, lsl #4
     8a4:	00007502 	andeq	r7, r0, r2, lsl #10
     8a8:	0085f223 	addeq	pc, r5, r3, lsr #4
     8ac:	0009e800 	andeq	lr, r9, r0, lsl #16
     8b0:	51012200 	mrspl	r2, R9_usr
     8b4:	5101f303 	tstpl	r1, r3, lsl #6
     8b8:	03500122 	cmpeq	r0, #-2147483640	; 0x80000008
     8bc:	005001f3 	ldrsheq	r0, [r0], #-19	; 0xffffffed
     8c0:	039a2400 	orrseq	r2, sl, #0, 8
     8c4:	fd050000 	stc2	0, cr0, [r5, #-0]
     8c8:	0085f402 	addeq	pc, r5, r2, lsl #8
     8cc:	00009000 	andeq	r9, r0, r0
     8d0:	cb9c0100 	blgt	fe700cd8 <_stack+0xfe680cd8>
     8d4:	1f000009 	svcne	0x00000009
     8d8:	00727470 	rsbseq	r7, r2, r0, ror r4
     8dc:	04122d01 	ldreq	r2, [r2], #-3329	; 0xd01
     8e0:	006e0000 	rsbeq	r0, lr, r0
     8e4:	00250000 	eoreq	r0, r5, r0
     8e8:	49000000 	stmdbmi	r0, {}	; <UNPREDICTABLE>
     8ec:	26000009 	strcs	r0, [r0], -r9
     8f0:	39010069 	stmdbcc	r1, {r0, r3, r5, r6}
     8f4:	0000002c 	andeq	r0, r0, ip, lsr #32
     8f8:	000000a5 	andeq	r0, r0, r5, lsr #1
     8fc:	00860e27 	addeq	r0, r6, r7, lsr #28
     900:	00001800 	andeq	r1, r0, r0, lsl #16
     904:	00093800 	andeq	r3, r9, r0, lsl #16
     908:	03922800 	orrseq	r2, r2, #0, 16
     90c:	3c010000 	stccc	0, cr0, [r1], {-0}
     910:	00000165 	andeq	r0, r0, r5, ror #2
     914:	000000b8 	strheq	r0, [r0], -r8
     918:	00004828 	andeq	r4, r0, r8, lsr #16
     91c:	653c0100 	ldrvs	r0, [ip, #-256]!	; 0x100
     920:	cb000001 	blgt	92c <CPSR_IRQ_INHIBIT+0x8ac>
     924:	29000000 	stmdbcs	r0, {}	; <UNPREDICTABLE>
     928:	00008620 	andeq	r8, r0, r0, lsr #12
     92c:	000009e8 	andeq	r0, r0, r8, ror #19
     930:	02500122 	subseq	r0, r0, #-2147483640	; 0x80000008
     934:	00000075 	andeq	r0, r0, r5, ror r0
     938:	00863629 	addeq	r3, r6, r9, lsr #12
     93c:	0009e800 	andeq	lr, r9, r0, lsl #16
     940:	50012200 	andpl	r2, r1, r0, lsl #4
     944:	00007502 	andeq	r7, r0, r2, lsl #10
     948:	864e2700 	strbhi	r2, [lr], -r0, lsl #14
     94c:	000e0000 	andeq	r0, lr, r0
     950:	09810000 	stmibeq	r1, {}	; <UNPREDICTABLE>
     954:	70260000 	eorvc	r0, r6, r0
     958:	82680100 	rsbhi	r0, r8, #0, 2
     95c:	ff000002 			; <UNDEFINED> instruction: 0xff000002
     960:	26000000 	strcs	r0, [r0], -r0
     964:	68010071 	stmdavs	r1, {r0, r4, r5, r6}
     968:	00000282 	andeq	r0, r0, r2, lsl #5
     96c:	0000011d 	andeq	r0, r0, sp, lsl r1
     970:	00865629 	addeq	r5, r6, r9, lsr #12
     974:	0009e800 	andeq	lr, r9, r0, lsl #16
     978:	50012200 	andpl	r2, r1, r0, lsl #4
     97c:	00007502 	andeq	r7, r0, r2, lsl #10
     980:	86402100 	strbhi	r2, [r0], -r0, lsl #2
     984:	09e80000 	stmibeq	r8!, {}^	; <UNPREDICTABLE>
     988:	09950000 	ldmibeq	r5, {}	; <UNPREDICTABLE>
     98c:	01220000 	teqeq	r2, r0
     990:	00750250 	rsbseq	r0, r5, r0, asr r2
     994:	86662100 	strbthi	r2, [r6], -r0, lsl #2
     998:	09e80000 	stmibeq	r8!, {}^	; <UNPREDICTABLE>
     99c:	09a90000 	stmibeq	r9!, {}	; <UNPREDICTABLE>
     9a0:	01220000 	teqeq	r2, r0
     9a4:	00750250 	rsbseq	r0, r5, r0, asr r2
     9a8:	86722a00 	ldrbthi	r2, [r2], -r0, lsl #20
     9ac:	09b90000 	ldmibeq	r9!, {}	; <UNPREDICTABLE>
     9b0:	01220000 	teqeq	r2, r0
     9b4:	00750250 	rsbseq	r0, r5, r0, asr r2
     9b8:	86842300 	strhi	r2, [r4], r0, lsl #6
     9bc:	08610000 	stmdaeq	r1!, {}^	; <UNPREDICTABLE>
     9c0:	01220000 	teqeq	r2, r0
     9c4:	01f30350 	mvnseq	r0, r0, asr r3
     9c8:	2b000050 	blcs	b10 <CPSR_IRQ_INHIBIT+0xa90>
     9cc:	00000814 	andeq	r0, r0, r4, lsl r8
     9d0:	1202fa05 	andne	pc, r2, #20480	; 0x5000
     9d4:	2c000004 	stccs	0, cr0, [r0], {4}
     9d8:	0000023b 	andeq	r0, r0, fp, lsr r2
     9dc:	002c1a01 	eoreq	r1, ip, r1, lsl #20
     9e0:	03050000 	movweq	r0, #20480	; 0x5000
     9e4:	00009824 	andeq	r9, r0, r4, lsr #16
     9e8:	0002982d 	andeq	r9, r2, sp, lsr #16
     9ec:	14e10600 	strbtne	r0, [r1], #1536	; 0x600
     9f0:	00000412 	andeq	r0, r0, r2, lsl r4
     9f4:	00010514 	andeq	r0, r1, r4, lsl r5
     9f8:	b1000000 	mrslt	r0, (UNDEF: 0)
     9fc:	04000000 	streq	r0, [r0], #-0
     a00:	00025800 	andeq	r5, r2, r0, lsl #16
     a04:	ce010400 	cfcpysgt	mvf0, mvf1
     a08:	01000003 	tsteq	r0, r3
     a0c:	000005c1 	andeq	r0, r0, r1, asr #11
     a10:	00000560 	andeq	r0, r0, r0, ror #10
     a14:	00000030 	andeq	r0, r0, r0, lsr r0
     a18:	00000000 	andeq	r0, r0, r0
     a1c:	00000169 	andeq	r0, r0, r9, ror #2
     a20:	69050402 	stmdbvs	r5, {r1, sl}
     a24:	0300746e 	movweq	r7, #1134	; 0x46e
     a28:	00000559 	andeq	r0, r0, r9, asr r5
     a2c:	0037d402 	eorseq	sp, r7, r2, lsl #8
     a30:	04040000 	streq	r0, [r4], #-0
     a34:	00022b07 	andeq	r2, r2, r7, lsl #22
     a38:	06010400 	streq	r0, [r1], -r0, lsl #8
     a3c:	000001f9 	strdeq	r0, [r0], -r9
     a40:	f7080104 			; <UNDEFINED> instruction: 0xf7080104
     a44:	04000001 	streq	r0, [r0], #-1
     a48:	00570502 	subseq	r0, r7, r2, lsl #10
     a4c:	02040000 	andeq	r0, r4, #0
     a50:	0002a007 	andeq	sl, r2, r7
     a54:	05040400 	streq	r0, [r4, #-1024]	; 0x400
     a58:	0000017c 	andeq	r0, r0, ip, ror r1
     a5c:	26070404 	strcs	r0, [r7], -r4, lsl #8
     a60:	04000002 	streq	r0, [r0], #-2
     a64:	01770508 	cmneq	r7, r8, lsl #10
     a68:	08040000 	stmdaeq	r4, {}	; <UNPREDICTABLE>
     a6c:	00022107 	andeq	r2, r2, r7, lsl #2
     a70:	07040400 	streq	r0, [r4, -r0, lsl #8]
     a74:	0000006b 	andeq	r0, r0, fp, rrx
     a78:	00080104 	andeq	r0, r8, r4, lsl #2
     a7c:	05000002 	streq	r0, [r0, #-2]
     a80:	00008a04 	andeq	r8, r0, r4, lsl #20
     a84:	007d0600 	rsbseq	r0, sp, r0, lsl #12
     a88:	ba070000 	blt	1c0a90 <_stack+0x140a90>
     a8c:	03000005 	movweq	r0, #5
     a90:	00002c21 	andeq	r2, r0, r1, lsr #24
     a94:	00868400 	addeq	r8, r6, r0, lsl #8
     a98:	00005e00 	andeq	r5, r0, r0, lsl #28
     a9c:	089c0100 	ldmeq	ip, {r8}
     aa0:	00727473 	rsbseq	r7, r2, r3, ror r4
     aa4:	00844201 	addeq	r4, r4, r1, lsl #4
     aa8:	01300000 	teqeq	r0, r0
     aac:	00000000 	andeq	r0, r0, r0
     ab0:	00000c18 	andeq	r0, r0, r8, lsl ip
     ab4:	02c80004 	sbceq	r0, r8, #4
     ab8:	01040000 	mrseq	r0, (UNDEF: 4)
     abc:	000003ce 	andeq	r0, r0, lr, asr #7
     ac0:	00076401 	andeq	r6, r7, r1, lsl #8
     ac4:	00064400 	andeq	r4, r6, r0, lsl #8
     ac8:	00004000 	andeq	r4, r0, r0
     acc:	00000000 	andeq	r0, r0, r0
     ad0:	00024600 	andeq	r4, r2, r0, lsl #12
     ad4:	06b60200 	ldrteq	r0, [r6], r0, lsl #4
     ad8:	93020000 	movwls	r0, #8192	; 0x2000
     adc:	00000030 	andeq	r0, r0, r0, lsr r0
     ae0:	69050403 	stmdbvs	r5, {r0, r1, sl}
     ae4:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     ae8:	00000559 	andeq	r0, r0, r9, asr r5
     aec:	0042d402 	subeq	sp, r2, r2, lsl #8
     af0:	04040000 	streq	r0, [r4], #-0
     af4:	00022b07 	andeq	r2, r2, r7, lsl #22
     af8:	04040500 	streq	r0, [r4], #-1280	; 0x500
     afc:	01f90601 	mvnseq	r0, r1, lsl #12
     b00:	01040000 	mrseq	r0, (UNDEF: 4)
     b04:	0001f708 	andeq	pc, r1, r8, lsl #14
     b08:	05020400 	streq	r0, [r2, #-1024]	; 0x400
     b0c:	00000057 	andeq	r0, r0, r7, asr r0
     b10:	a0070204 	andge	r0, r7, r4, lsl #4
     b14:	04000002 	streq	r0, [r0], #-2
     b18:	017c0504 	cmneq	ip, r4, lsl #10
     b1c:	04040000 	streq	r0, [r4], #-0
     b20:	00022607 	andeq	r2, r2, r7, lsl #12
     b24:	05080400 	streq	r0, [r8, #-1024]	; 0x400
     b28:	00000177 	andeq	r0, r0, r7, ror r1
     b2c:	21070804 	tstcs	r7, r4, lsl #16
     b30:	02000002 	andeq	r0, r0, #2
     b34:	0000010c 	andeq	r0, r0, ip, lsl #2
     b38:	00300703 	eorseq	r0, r0, r3, lsl #14
     b3c:	2a020000 	bcs	80b44 <_stack+0xb44>
     b40:	04000000 	streq	r0, [r0], #-0
     b44:	00006710 	andeq	r6, r0, r0, lsl r7
     b48:	01bf0200 			; <UNDEFINED> instruction: 0x01bf0200
     b4c:	27040000 	strcs	r0, [r4, -r0]
     b50:	00000067 	andeq	r0, r0, r7, rrx
     b54:	00035906 	andeq	r5, r3, r6, lsl #18
     b58:	01610200 	cmneq	r1, r0, lsl #4
     b5c:	00000042 	andeq	r0, r0, r2, asr #32
     b60:	4a040407 	bmi	101b84 <_stack+0x81b84>
     b64:	000000cf 	andeq	r0, r0, pc, asr #1
     b68:	00003108 	andeq	r3, r0, r8, lsl #2
     b6c:	a44c0400 	strbge	r0, [ip], #-1024	; 0x400
     b70:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     b74:	0000021a 	andeq	r0, r0, sl, lsl r2
     b78:	00cf4d04 	sbceq	r4, pc, r4, lsl #26
     b7c:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     b80:	00000052 	andeq	r0, r0, r2, asr r0
     b84:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     b88:	0000df0a 	andeq	sp, r0, sl, lsl #30
     b8c:	04000300 	streq	r0, [r0], #-768	; 0x300
     b90:	006b0704 	rsbeq	r0, fp, r4, lsl #14
     b94:	080b0000 	stmdaeq	fp, {}	; <UNPREDICTABLE>
     b98:	01074704 	tsteq	r7, r4, lsl #14
     b9c:	bb0c0000 	bllt	300ba4 <_stack+0x280ba4>
     ba0:	04000000 	streq	r0, [r0], #-0
     ba4:	00003049 	andeq	r3, r0, r9, asr #32
     ba8:	400c0000 	andmi	r0, ip, r0
     bac:	04000000 	streq	r0, [r0], #-0
     bb0:	0000b04e 	andeq	fp, r0, lr, asr #32
     bb4:	02000400 	andeq	r0, r0, #0, 8
     bb8:	000003a9 	andeq	r0, r0, r9, lsr #7
     bbc:	00e64f04 	rsceq	r4, r6, r4, lsl #30
     bc0:	ce020000 	cdpgt	0, 0, cr0, cr2, cr0, {0}
     bc4:	04000001 	streq	r0, [r0], #-1
     bc8:	00008353 	andeq	r8, r0, r3, asr r3
     bcc:	04b50200 	ldrteq	r0, [r5], #512	; 0x200
     bd0:	16050000 	strne	r0, [r5], -r0
     bd4:	0000006e 	andeq	r0, r0, lr, rrx
     bd8:	0003b40d 	andeq	fp, r3, sp, lsl #8
     bdc:	2d051800 	stccs	8, cr1, [r5, #-0]
     be0:	0000017b 	andeq	r0, r0, fp, ror r1
     be4:	00050d0c 	andeq	r0, r5, ip, lsl #26
     be8:	7b2f0500 	blvc	bc1ff0 <_stack+0xb41ff0>
     bec:	00000001 	andeq	r0, r0, r1
     bf0:	006b5f0e 	rsbeq	r5, fp, lr, lsl #30
     bf4:	00303005 	eorseq	r3, r0, r5
     bf8:	0c040000 	stceq	0, cr0, [r4], {-0}
     bfc:	000003bc 			; <UNDEFINED> instruction: 0x000003bc
     c00:	00303005 	eorseq	r3, r0, r5
     c04:	0c080000 	stceq	0, cr0, [r8], {-0}
     c08:	00000502 	andeq	r0, r0, r2, lsl #10
     c0c:	00303005 	eorseq	r3, r0, r5
     c10:	0c0c0000 	stceq	0, cr0, [ip], {-0}
     c14:	00000339 	andeq	r0, r0, r9, lsr r3
     c18:	00303005 	eorseq	r3, r0, r5
     c1c:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     c20:	0500785f 	streq	r7, [r0, #-2143]	; 0x85f
     c24:	00018131 	andeq	r8, r1, r1, lsr r1
     c28:	0f001400 	svceq	0x00001400
     c2c:	00012804 	andeq	r2, r1, r4, lsl #16
     c30:	011d0900 	tsteq	sp, r0, lsl #18
     c34:	01910000 	orrseq	r0, r1, r0
     c38:	df0a0000 	svcle	0x000a0000
     c3c:	00000000 	andeq	r0, r0, r0
     c40:	033e0d00 	teqeq	lr, #0, 26
     c44:	05240000 	streq	r0, [r4, #-0]!
     c48:	00020a35 	andeq	r0, r2, r5, lsr sl
     c4c:	01e40c00 	mvneq	r0, r0, lsl #24
     c50:	37050000 	strcc	r0, [r5, -r0]
     c54:	00000030 	andeq	r0, r0, r0, lsr r0
     c58:	01390c00 	teqeq	r9, r0, lsl #24
     c5c:	38050000 	stmdacc	r5, {}	; <UNPREDICTABLE>
     c60:	00000030 	andeq	r0, r0, r0, lsr r0
     c64:	01ed0c04 	mvneq	r0, r4, lsl #24
     c68:	39050000 	stmdbcc	r5, {}	; <UNPREDICTABLE>
     c6c:	00000030 	andeq	r0, r0, r0, lsr r0
     c70:	00c30c08 	sbceq	r0, r3, r8, lsl #24
     c74:	3a050000 	bcc	140c7c <_stack+0xc0c7c>
     c78:	00000030 	andeq	r0, r0, r0, lsr r0
     c7c:	04cb0c0c 	strbeq	r0, [fp], #3084	; 0xc0c
     c80:	3b050000 	blcc	140c88 <_stack+0xc0c88>
     c84:	00000030 	andeq	r0, r0, r0, lsr r0
     c88:	03c40c10 	biceq	r0, r4, #16, 24	; 0x1000
     c8c:	3c050000 	stccc	0, cr0, [r5], {-0}
     c90:	00000030 	andeq	r0, r0, r0, lsr r0
     c94:	016d0c14 	cmneq	sp, r4, lsl ip
     c98:	3d050000 	stccc	0, cr0, [r5, #-0]
     c9c:	00000030 	andeq	r0, r0, r0, lsr r0
     ca0:	04ab0c18 	strteq	r0, [fp], #3096	; 0xc18
     ca4:	3e050000 	cdpcc	0, 0, cr0, cr5, cr0, {0}
     ca8:	00000030 	andeq	r0, r0, r0, lsr r0
     cac:	01990c1c 	orrseq	r0, r9, ip, lsl ip
     cb0:	3f050000 	svccc	0x00050000
     cb4:	00000030 	andeq	r0, r0, r0, lsr r0
     cb8:	49100020 	ldmdbmi	r0, {r5}
     cbc:	08000002 	stmdaeq	r0, {r1}
     cc0:	4a480501 	bmi	12020cc <_stack+0x11820cc>
     cc4:	0c000002 	stceq	0, cr0, [r0], {2}
     cc8:	00000185 	andeq	r0, r0, r5, lsl #3
     ccc:	024a4905 	subeq	r4, sl, #81920	; 0x14000
     cd0:	0c000000 	stceq	0, cr0, [r0], {-0}
     cd4:	000004f1 	strdeq	r0, [r0], -r1
     cd8:	024a4a05 	subeq	r4, sl, #20480	; 0x5000
     cdc:	11800000 	orrne	r0, r0, r0
     ce0:	000001b6 			; <UNDEFINED> instruction: 0x000001b6
     ce4:	011d4c05 	tsteq	sp, r5, lsl #24
     ce8:	01000000 	mrseq	r0, (UNDEF: 0)
     cec:	00038011 	andeq	r8, r3, r1, lsl r0
     cf0:	1d4f0500 	cfstr64ne	mvdx0, [pc, #-0]	; cf8 <CPSR_IRQ_INHIBIT+0xc78>
     cf4:	04000001 	streq	r0, [r0], #-1
     cf8:	49090001 	stmdbmi	r9, {r0}
     cfc:	5a000000 	bpl	d04 <CPSR_IRQ_INHIBIT+0xc84>
     d00:	0a000002 	beq	d10 <CPSR_IRQ_INHIBIT+0xc90>
     d04:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     d08:	eb10001f 	bl	400d8c <_stack+0x380d8c>
     d0c:	90000000 	andls	r0, r0, r0
     d10:	985b0501 	ldmdals	fp, {r0, r8, sl}^
     d14:	0c000002 	stceq	0, cr0, [r0], {2}
     d18:	0000050d 	andeq	r0, r0, sp, lsl #10
     d1c:	02985c05 	addseq	r5, r8, #1280	; 0x500
     d20:	0c000000 	stceq	0, cr0, [r0], {-0}
     d24:	000004de 	ldrdeq	r0, [r0], -lr
     d28:	00305d05 	eorseq	r5, r0, r5, lsl #26
     d2c:	0c040000 	stceq	0, cr0, [r4], {-0}
     d30:	0000015f 	andeq	r0, r0, pc, asr r1
     d34:	029e5f05 	addseq	r5, lr, #5, 30
     d38:	0c080000 	stceq	0, cr0, [r8], {-0}
     d3c:	00000249 	andeq	r0, r0, r9, asr #4
     d40:	020a6005 	andeq	r6, sl, #5
     d44:	00880000 	addeq	r0, r8, r0
     d48:	025a040f 	subseq	r0, sl, #251658240	; 0xf000000
     d4c:	ae090000 	cdpge	0, 0, cr0, cr9, cr0, {0}
     d50:	ae000002 	cdpge	0, 0, cr0, cr0, cr2, {0}
     d54:	0a000002 	beq	d64 <CPSR_IRQ_INHIBIT+0xce4>
     d58:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     d5c:	040f001f 	streq	r0, [pc], #-31	; d64 <CPSR_IRQ_INHIBIT+0xce4>
     d60:	000002b4 			; <UNDEFINED> instruction: 0x000002b4
     d64:	00500d12 	subseq	r0, r0, r2, lsl sp
     d68:	05080000 	streq	r0, [r8, #-0]
     d6c:	0002da73 	andeq	sp, r2, r3, ror sl
     d70:	07c10c00 	strbeq	r0, [r1, r0, lsl #24]
     d74:	74050000 	strvc	r0, [r5], #-0
     d78:	000002da 	ldrdeq	r0, [r0], -sl
     d7c:	087b0c00 	ldmdaeq	fp!, {sl, fp}^
     d80:	75050000 	strvc	r0, [r5, #-0]
     d84:	00000030 	andeq	r0, r0, r0, lsr r0
     d88:	040f0004 	streq	r0, [pc], #-4	; d90 <CPSR_IRQ_INHIBIT+0xd10>
     d8c:	00000052 	andeq	r0, r0, r2, asr r0
     d90:	00054c0d 	andeq	r4, r5, sp, lsl #24
     d94:	b3056800 	movwlt	r6, #22528	; 0x5800
     d98:	0000040a 	andeq	r0, r0, sl, lsl #8
     d9c:	00705f0e 	rsbseq	r5, r0, lr, lsl #30
     da0:	02dab405 	sbcseq	fp, sl, #83886080	; 0x5000000
     da4:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     da8:	0500725f 	streq	r7, [r0, #-607]	; 0x25f
     dac:	000030b5 	strheq	r3, [r0], -r5
     db0:	5f0e0400 	svcpl	0x000e0400
     db4:	b6050077 			; <UNDEFINED> instruction: 0xb6050077
     db8:	00000030 	andeq	r0, r0, r0, lsr r0
     dbc:	009e0c08 	addseq	r0, lr, r8, lsl #24
     dc0:	b7050000 	strlt	r0, [r5, -r0]
     dc4:	00000059 	andeq	r0, r0, r9, asr r0
     dc8:	03170c0c 	tsteq	r7, #12, 24	; 0xc00
     dcc:	b8050000 	stmdalt	r5, {}	; <UNPREDICTABLE>
     dd0:	00000059 	andeq	r0, r0, r9, asr r0
     dd4:	625f0e0e 	subsvs	r0, pc, #14, 28	; 0xe0
     dd8:	b9050066 	stmdblt	r5, {r1, r2, r5, r6}
     ddc:	000002b5 			; <UNDEFINED> instruction: 0x000002b5
     de0:	00370c10 	eorseq	r0, r7, r0, lsl ip
     de4:	ba050000 	blt	140dec <_stack+0xc0dec>
     de8:	00000030 	andeq	r0, r0, r0, lsr r0
     dec:	02bb0c18 	adcseq	r0, fp, #24, 24	; 0x1800
     df0:	c1050000 	mrsgt	r0, (UNDEF: 5)
     df4:	00000049 	andeq	r0, r0, r9, asr #32
     df8:	02050c1c 	andeq	r0, r5, #28, 24	; 0x1c00
     dfc:	c3050000 	movwgt	r0, #20480	; 0x5000
     e00:	0000056d 	andeq	r0, r0, sp, ror #10
     e04:	00a50c20 	adceq	r0, r5, r0, lsr #24
     e08:	c5050000 	strgt	r0, [r5, #-0]
     e0c:	0000059c 	muleq	r0, ip, r5
     e10:	04bd0c24 	ldrteq	r0, [sp], #3108	; 0xc24
     e14:	c8050000 	stmdagt	r5, {}	; <UNPREDICTABLE>
     e18:	000005c0 	andeq	r0, r0, r0, asr #11
     e1c:	01c70c28 	biceq	r0, r7, r8, lsr #24
     e20:	c9050000 	stmdbgt	r5, {}	; <UNPREDICTABLE>
     e24:	000005da 	ldrdeq	r0, [r0], -sl
     e28:	755f0e2c 	ldrbvc	r0, [pc, #-3628]	; 4 <CPSR_MODE_USER-0xc>
     e2c:	cc050062 	stcgt	0, cr0, [r5], {98}	; 0x62
     e30:	000002b5 			; <UNDEFINED> instruction: 0x000002b5
     e34:	755f0e30 	ldrbvc	r0, [pc, #-3632]	; c <CPSR_MODE_USER-0x4>
     e38:	cd050070 	stcgt	0, cr0, [r5, #-448]	; 0xfffffe40
     e3c:	000002da 	ldrdeq	r0, [r0], -sl
     e40:	755f0e38 	ldrbvc	r0, [pc, #-3640]	; 10 <CPSR_MODE_USER>
     e44:	ce050072 	mcrgt	0, 0, r0, cr5, cr2, {3}
     e48:	00000030 	andeq	r0, r0, r0, lsr r0
     e4c:	05390c3c 	ldreq	r0, [r9, #-3132]!	; 0xc3c
     e50:	d1050000 	mrsle	r0, (UNDEF: 5)
     e54:	000005e0 	andeq	r0, r0, r0, ror #11
     e58:	01060c40 	tsteq	r6, r0, asr #24
     e5c:	d2050000 	andle	r0, r5, #0
     e60:	000005f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     e64:	6c5f0e43 	mrrcvs	14, 4, r0, pc, cr3	; <UNPREDICTABLE>
     e68:	d5050062 	strle	r0, [r5, #-98]	; 0x62
     e6c:	000002b5 			; <UNDEFINED> instruction: 0x000002b5
     e70:	01ad0c44 			; <UNDEFINED> instruction: 0x01ad0c44
     e74:	d8050000 	stmdale	r5, {}	; <UNPREDICTABLE>
     e78:	00000030 	andeq	r0, r0, r0, lsr r0
     e7c:	00740c4c 	rsbseq	r0, r4, ip, asr #24
     e80:	d9050000 	stmdble	r5, {}	; <UNPREDICTABLE>
     e84:	0000008e 	andeq	r0, r0, lr, lsl #1
     e88:	07d40c50 			; <UNDEFINED> instruction: 0x07d40c50
     e8c:	dc050000 	stcle	0, cr0, [r5], {-0}
     e90:	00000428 	andeq	r0, r0, r8, lsr #8
     e94:	06b00c54 	ssateq	r0, #17, r4, asr #24
     e98:	e0050000 	and	r0, r5, r0
     e9c:	00000112 	andeq	r0, r0, r2, lsl r1
     ea0:	01640c58 	cmneq	r4, r8, asr ip
     ea4:	e2050000 	and	r0, r5, #0
     ea8:	00000107 	andeq	r0, r0, r7, lsl #2
     eac:	000b0c5c 	andeq	r0, fp, ip, asr ip
     eb0:	e3050000 	movw	r0, #20480	; 0x5000
     eb4:	00000030 	andeq	r0, r0, r0, lsr r0
     eb8:	30130064 	andscc	r0, r3, r4, rrx
     ebc:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     ec0:	14000004 	strne	r0, [r0], #-4
     ec4:	00000428 	andeq	r0, r0, r8, lsr #8
     ec8:	00004914 	andeq	r4, r0, r4, lsl r9
     ecc:	05601400 	strbeq	r1, [r0, #-1024]!	; 0x400
     ed0:	30140000 	andscc	r0, r4, r0
     ed4:	00000000 	andeq	r0, r0, r0
     ed8:	042e040f 	strteq	r0, [lr], #-1039	; 0x40f
     edc:	a2150000 	andsge	r0, r5, #0
     ee0:	28000003 	stmdacs	r0, {r0, r1}
     ee4:	02390504 	eorseq	r0, r9, #4, 10	; 0x1000000
     ee8:	00000560 	andeq	r0, r0, r0, ror #10
     eec:	00023a16 	andeq	r3, r2, r6, lsl sl
     ef0:	023b0500 	eorseq	r0, fp, #0, 10
     ef4:	00000030 	andeq	r0, r0, r0, lsr r0
     ef8:	05131600 	ldreq	r1, [r3, #-1536]	; 0x600
     efc:	40050000 	andmi	r0, r5, r0
     f00:	00064702 	andeq	r4, r6, r2, lsl #14
     f04:	e3160400 	tst	r6, #0, 8
     f08:	05000000 	streq	r0, [r0, #-0]
     f0c:	06470240 	strbeq	r0, [r7], -r0, asr #4
     f10:	16080000 	strne	r0, [r8], -r0
     f14:	00000212 	andeq	r0, r0, r2, lsl r2
     f18:	47024005 	strmi	r4, [r2, -r5]
     f1c:	0c000006 	stceq	0, cr0, [r0], {6}
     f20:	0004d916 	andeq	sp, r4, r6, lsl r9
     f24:	02420500 	subeq	r0, r2, #0, 10
     f28:	00000030 	andeq	r0, r0, r0, lsr r0
     f2c:	00f31610 	rscseq	r1, r3, r0, lsl r6
     f30:	43050000 	movwmi	r0, #20480	; 0x5000
     f34:	00082902 	andeq	r2, r8, r2, lsl #18
     f38:	6e161400 	cfmulsvs	mvf1, mvf6, mvf0
     f3c:	05000003 	streq	r0, [r0, #-3]
     f40:	00300245 	eorseq	r0, r0, r5, asr #4
     f44:	16300000 	ldrtne	r0, [r0], -r0
     f48:	0000051a 	andeq	r0, r0, sl, lsl r5
     f4c:	91024605 	tstls	r2, r5, lsl #12
     f50:	34000005 	strcc	r0, [r0], #-5
     f54:	00000016 	andeq	r0, r0, r6, lsl r0
     f58:	02480500 	subeq	r0, r8, #0, 10
     f5c:	00000030 	andeq	r0, r0, r0, lsr r0
     f60:	03881638 	orreq	r1, r8, #56, 12	; 0x3800000
     f64:	4a050000 	bmi	140f6c <_stack+0xc0f6c>
     f68:	00084402 	andeq	r4, r8, r2, lsl #8
     f6c:	c3163c00 	tstgt	r6, #0, 24
     f70:	05000004 	streq	r0, [r0, #-4]
     f74:	017b024d 	cmneq	fp, sp, asr #4
     f78:	16400000 	strbne	r0, [r0], -r0
     f7c:	00000061 	andeq	r0, r0, r1, rrx
     f80:	30024e05 	andcc	r4, r2, r5, lsl #28
     f84:	44000000 	strmi	r0, [r0], #-0
     f88:	0004fd16 	andeq	pc, r4, r6, lsl sp	; <UNPREDICTABLE>
     f8c:	024f0500 	subeq	r0, pc, #0, 10
     f90:	0000017b 	andeq	r0, r0, fp, ror r1
     f94:	01551648 	cmpeq	r5, r8, asr #12
     f98:	50050000 	andpl	r0, r5, r0
     f9c:	00084a02 	andeq	r4, r8, r2, lsl #20
     fa0:	fe164c00 	cdp2	12, 1, cr4, cr6, cr0, {0}
     fa4:	05000000 	streq	r0, [r0, #-0]
     fa8:	00300253 	eorseq	r0, r0, r3, asr r2
     fac:	16500000 	ldrbne	r0, [r0], -r0
     fb0:	000002b3 			; <UNDEFINED> instruction: 0x000002b3
     fb4:	60025405 	andvs	r5, r2, r5, lsl #8
     fb8:	54000005 	strpl	r0, [r0], #-5
     fbc:	00055416 	andeq	r5, r5, r6, lsl r4
     fc0:	02770500 	rsbseq	r0, r7, #0, 10
     fc4:	00000807 	andeq	r0, r0, r7, lsl #16
     fc8:	00eb1758 	rsceq	r1, fp, r8, asr r7
     fcc:	7b050000 	blvc	140fd4 <_stack+0xc0fd4>
     fd0:	00029802 	andeq	r9, r2, r2, lsl #16
     fd4:	17014800 	strne	r4, [r1, -r0, lsl #16]
     fd8:	000001a4 	andeq	r0, r0, r4, lsr #3
     fdc:	5a027c05 	bpl	9fff8 <_stack+0x1fff8>
     fe0:	4c000002 	stcmi	0, cr0, [r0], {2}
     fe4:	01421701 	cmpeq	r2, r1, lsl #14
     fe8:	80050000 	andhi	r0, r5, r0
     fec:	00085b02 	andeq	r5, r8, r2, lsl #22
     ff0:	1702dc00 	strne	sp, [r2, -r0, lsl #24]
     ff4:	00000241 	andeq	r0, r0, r1, asr #4
     ff8:	0c028505 	cfstr32eq	mvfx8, [r2], {5}
     ffc:	e0000006 	and	r0, r0, r6
    1000:	007c1702 	rsbseq	r1, ip, r2, lsl #14
    1004:	86050000 	strhi	r0, [r5], -r0
    1008:	00086702 	andeq	r6, r8, r2, lsl #14
    100c:	0002ec00 	andeq	lr, r2, r0, lsl #24
    1010:	0566040f 	strbeq	r0, [r6, #-1039]!	; 0x40f
    1014:	01040000 	mrseq	r0, (UNDEF: 4)
    1018:	00020008 	andeq	r0, r2, r8
    101c:	0a040f00 	beq	104c24 <_stack+0x84c24>
    1020:	13000004 	movwne	r0, #4
    1024:	00000030 	andeq	r0, r0, r0, lsr r0
    1028:	00000591 	muleq	r0, r1, r5
    102c:	00042814 	andeq	r2, r4, r4, lsl r8
    1030:	00491400 	subeq	r1, r9, r0, lsl #8
    1034:	91140000 	tstls	r4, r0
    1038:	14000005 	strne	r0, [r0], #-5
    103c:	00000030 	andeq	r0, r0, r0, lsr r0
    1040:	97040f00 	strls	r0, [r4, -r0, lsl #30]
    1044:	18000005 	stmdane	r0, {r0, r2}
    1048:	00000566 	andeq	r0, r0, r6, ror #10
    104c:	0573040f 	ldrbeq	r0, [r3, #-1039]!	; 0x40f
    1050:	99130000 	ldmdbls	r3, {}	; <UNPREDICTABLE>
    1054:	c0000000 	andgt	r0, r0, r0
    1058:	14000005 	strne	r0, [r0], #-5
    105c:	00000428 	andeq	r0, r0, r8, lsr #8
    1060:	00004914 	andeq	r4, r0, r4, lsl r9
    1064:	00991400 	addseq	r1, r9, r0, lsl #8
    1068:	30140000 	andscc	r0, r4, r0
    106c:	00000000 	andeq	r0, r0, r0
    1070:	05a2040f 	streq	r0, [r2, #1039]!	; 0x40f
    1074:	30130000 	andscc	r0, r3, r0
    1078:	da000000 	ble	1080 <CPSR_IRQ_INHIBIT+0x1000>
    107c:	14000005 	strne	r0, [r0], #-5
    1080:	00000428 	andeq	r0, r0, r8, lsr #8
    1084:	00004914 	andeq	r4, r0, r4, lsl r9
    1088:	040f0000 	streq	r0, [pc], #-0	; 1090 <CPSR_IRQ_INHIBIT+0x1010>
    108c:	000005c6 	andeq	r0, r0, r6, asr #11
    1090:	00005209 	andeq	r5, r0, r9, lsl #4
    1094:	0005f000 	andeq	pc, r5, r0
    1098:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    109c:	00020000 	andeq	r0, r2, r0
    10a0:	00005209 	andeq	r5, r0, r9, lsl #4
    10a4:	00060000 	andeq	r0, r6, r0
    10a8:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    10ac:	00000000 	andeq	r0, r0, r0
    10b0:	00012506 	andeq	r2, r1, r6, lsl #10
    10b4:	011d0500 	tsteq	sp, r0, lsl #10
    10b8:	000002e0 	andeq	r0, r0, r0, ror #5
    10bc:	0001de19 	andeq	sp, r1, r9, lsl lr
    10c0:	21050c00 	tstcs	r5, r0, lsl #24
    10c4:	00064101 	andeq	r4, r6, r1, lsl #2
    10c8:	050d1600 	streq	r1, [sp, #-1536]	; 0x600
    10cc:	23050000 	movwcs	r0, #20480	; 0x5000
    10d0:	00064101 	andeq	r4, r6, r1, lsl #2
    10d4:	1e160000 	cdpne	0, 1, cr0, cr6, cr0, {0}
    10d8:	05000001 	streq	r0, [r0, #-1]
    10dc:	00300124 	eorseq	r0, r0, r4, lsr #2
    10e0:	16040000 	strne	r0, [r4], -r0
    10e4:	0000018d 	andeq	r0, r0, sp, lsl #3
    10e8:	47012505 	strmi	r2, [r1, -r5, lsl #10]
    10ec:	08000006 	stmdaeq	r0, {r1, r2}
    10f0:	0c040f00 	stceq	15, cr0, [r4], {-0}
    10f4:	0f000006 	svceq	0x00000006
    10f8:	00060004 	andeq	r0, r6, r4
    10fc:	04a31900 	strteq	r1, [r3], #2304	; 0x900
    1100:	050e0000 	streq	r0, [lr, #-0]
    1104:	0682013d 			; <UNDEFINED> instruction: 0x0682013d
    1108:	9d160000 	ldcls	0, cr0, [r6, #-0]
    110c:	05000004 	streq	r0, [r0, #-4]
    1110:	0682013e 			; <UNDEFINED> instruction: 0x0682013e
    1114:	16000000 	strne	r0, [r0], -r0
    1118:	00000193 	muleq	r0, r3, r1
    111c:	82013f05 	andhi	r3, r1, #5, 30
    1120:	06000006 	streq	r0, [r0], -r6
    1124:	0004d416 	andeq	sp, r4, r6, lsl r4
    1128:	01400500 	cmpeq	r0, r0, lsl #10
    112c:	00000060 	andeq	r0, r0, r0, rrx
    1130:	6009000c 	andvs	r0, r9, ip
    1134:	92000000 	andls	r0, r0, #0
    1138:	0a000006 	beq	1158 <CPSR_IRQ_INHIBIT+0x10d8>
    113c:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1140:	d01a0002 	andsle	r0, sl, r2
    1144:	93025805 	movwls	r5, #10245	; 0x2805
    1148:	16000007 	strne	r0, [r0], -r7
    114c:	0000032c 	andeq	r0, r0, ip, lsr #6
    1150:	42025a05 	andmi	r5, r2, #20480	; 0x5000
    1154:	00000000 	andeq	r0, r0, r0
    1158:	00049016 	andeq	r9, r4, r6, lsl r0
    115c:	025b0500 	subseq	r0, fp, #0, 10
    1160:	00000560 	andeq	r0, r0, r0, ror #10
    1164:	053f1604 	ldreq	r1, [pc, #-1540]!	; b68 <CPSR_IRQ_INHIBIT+0xae8>
    1168:	5c050000 	stcpl	0, cr0, [r5], {-0}
    116c:	00079302 	andeq	r9, r7, r2, lsl #6
    1170:	ac160800 	ldcge	8, cr0, [r6], {-0}
    1174:	05000000 	streq	r0, [r0, #-0]
    1178:	0191025d 	orrseq	r0, r1, sp, asr r2
    117c:	16240000 	strtne	r0, [r4], -r0
    1180:	0000031d 	andeq	r0, r0, sp, lsl r3
    1184:	30025e05 	andcc	r5, r2, r5, lsl #28
    1188:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
    118c:	00050816 	andeq	r0, r5, r6, lsl r8
    1190:	025f0500 	subseq	r0, pc, #0, 10
    1194:	0000007c 	andeq	r0, r0, ip, ror r0
    1198:	00de1650 	sbcseq	r1, lr, r0, asr r6
    119c:	60050000 	andvs	r0, r5, r0
    11a0:	00064d02 	andeq	r4, r6, r2, lsl #26
    11a4:	13165800 	tstne	r6, #0, 16
    11a8:	05000000 	streq	r0, [r0, #-0]
    11ac:	01070261 	tsteq	r7, r1, ror #4
    11b0:	16680000 	strbtne	r0, [r8], -r0
    11b4:	0000034b 	andeq	r0, r0, fp, asr #6
    11b8:	07026205 	streq	r6, [r2, -r5, lsl #4]
    11bc:	70000001 	andvc	r0, r0, r1
    11c0:	0004e316 	andeq	lr, r4, r6, lsl r3
    11c4:	02630500 	rsbeq	r0, r3, #0, 10
    11c8:	00000107 	andeq	r0, r0, r7, lsl #2
    11cc:	00201678 	eoreq	r1, r0, r8, ror r6
    11d0:	64050000 	strvs	r0, [r5], #-0
    11d4:	0007a302 	andeq	sl, r7, r2, lsl #6
    11d8:	81168000 	tsthi	r6, r0
    11dc:	05000000 	streq	r0, [r0, #-0]
    11e0:	07b30265 	ldreq	r0, [r3, r5, ror #4]!
    11e4:	16880000 	strne	r0, [r8], r0
    11e8:	0000012c 	andeq	r0, r0, ip, lsr #2
    11ec:	30026605 	andcc	r6, r2, r5, lsl #12
    11f0:	a0000000 	andge	r0, r0, r0
    11f4:	00036016 	andeq	r6, r3, r6, lsl r0
    11f8:	02670500 	rsbeq	r0, r7, #0, 10
    11fc:	00000107 	andeq	r0, r0, r7, lsl #2
    1200:	028916a4 	addeq	r1, r9, #164, 12	; 0xa400000
    1204:	68050000 	stmdavs	r5, {}	; <UNPREDICTABLE>
    1208:	00010702 	andeq	r0, r1, r2, lsl #14
    120c:	cd16ac00 	ldcgt	12, cr10, [r6, #-0]
    1210:	05000000 	streq	r0, [r0, #-0]
    1214:	01070269 	tsteq	r7, r9, ror #4
    1218:	16b40000 	ldrtne	r0, [r4], r0
    121c:	0000052a 	andeq	r0, r0, sl, lsr #10
    1220:	07026a05 	streq	r6, [r2, -r5, lsl #20]
    1224:	bc000001 	stclt	0, cr0, [r0], {1}
    1228:	00008d16 	andeq	r8, r0, r6, lsl sp
    122c:	026b0500 	rsbeq	r0, fp, #0, 10
    1230:	00000107 	andeq	r0, r0, r7, lsl #2
    1234:	023816c4 	eorseq	r1, r8, #196, 12	; 0xc400000
    1238:	6c050000 	stcvs	0, cr0, [r5], {-0}
    123c:	00003002 	andeq	r3, r0, r2
    1240:	0900cc00 	stmdbeq	r0, {sl, fp, lr, pc}
    1244:	00000566 	andeq	r0, r0, r6, ror #10
    1248:	000007a3 	andeq	r0, r0, r3, lsr #15
    124c:	0000df0a 	andeq	sp, r0, sl, lsl #30
    1250:	09001900 	stmdbeq	r0, {r8, fp, ip}
    1254:	00000566 	andeq	r0, r0, r6, ror #10
    1258:	000007b3 			; <UNDEFINED> instruction: 0x000007b3
    125c:	0000df0a 	andeq	sp, r0, sl, lsl #30
    1260:	09000700 	stmdbeq	r0, {r8, r9, sl}
    1264:	00000566 	andeq	r0, r0, r6, ror #10
    1268:	000007c3 	andeq	r0, r0, r3, asr #15
    126c:	0000df0a 	andeq	sp, r0, sl, lsl #30
    1270:	1a001700 	bne	6e78 <CPSR_IRQ_INHIBIT+0x6df8>
    1274:	027105f0 	rsbseq	r0, r1, #240, 10	; 0x3c000000
    1278:	000007e7 	andeq	r0, r0, r7, ror #15
    127c:	00020b16 	andeq	r0, r2, r6, lsl fp
    1280:	02740500 	rsbseq	r0, r4, #0, 10
    1284:	000007e7 	andeq	r0, r0, r7, ror #15
    1288:	014c1600 	cmpeq	ip, r0, lsl #12
    128c:	75050000 	strvc	r0, [r5, #-0]
    1290:	0007f702 	andeq	pc, r7, r2, lsl #14
    1294:	09007800 	stmdbeq	r0, {fp, ip, sp, lr}
    1298:	000002da 	ldrdeq	r0, [r0], -sl
    129c:	000007f7 	strdeq	r0, [r0], -r7
    12a0:	0000df0a 	andeq	sp, r0, sl, lsl #30
    12a4:	09001d00 	stmdbeq	r0, {r8, sl, fp, ip}
    12a8:	00000042 	andeq	r0, r0, r2, asr #32
    12ac:	00000807 	andeq	r0, r0, r7, lsl #16
    12b0:	0000df0a 	andeq	sp, r0, sl, lsl #30
    12b4:	1b001d00 	blne	86bc <strlen+0x38>
    12b8:	025605f0 	subseq	r0, r6, #240, 10	; 0x3c000000
    12bc:	00000829 	andeq	r0, r0, r9, lsr #16
    12c0:	0003a21c 	andeq	sl, r3, ip, lsl r2
    12c4:	026d0500 	rsbeq	r0, sp, #0, 10
    12c8:	00000692 	muleq	r0, r2, r6
    12cc:	0003431c 	andeq	r4, r3, ip, lsl r3
    12d0:	02760500 	rsbseq	r0, r6, #0, 10
    12d4:	000007c3 	andeq	r0, r0, r3, asr #15
    12d8:	05660900 	strbeq	r0, [r6, #-2304]!	; 0x900
    12dc:	08390000 	ldmdaeq	r9!, {}	; <UNPREDICTABLE>
    12e0:	df0a0000 	svcle	0x000a0000
    12e4:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    12e8:	08441d00 	stmdaeq	r4, {r8, sl, fp, ip}^
    12ec:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
    12f0:	00000004 	andeq	r0, r0, r4
    12f4:	0839040f 	ldmdaeq	r9!, {r0, r1, r2, r3, sl}
    12f8:	040f0000 	streq	r0, [pc], #-0	; 1300 <CPSR_IRQ_INHIBIT+0x1280>
    12fc:	0000017b 	andeq	r0, r0, fp, ror r1
    1300:	00085b1d 	andeq	r5, r8, sp, lsl fp
    1304:	00301400 	eorseq	r1, r0, r0, lsl #8
    1308:	0f000000 	svceq	0x00000000
    130c:	00086104 	andeq	r6, r8, r4, lsl #2
    1310:	50040f00 	andpl	r0, r4, r0, lsl #30
    1314:	09000008 	stmdbeq	r0, {r3}
    1318:	00000600 	andeq	r0, r0, r0, lsl #12
    131c:	00000877 	andeq	r0, r0, r7, ror r8
    1320:	0000df0a 	andeq	sp, r0, sl, lsl #30
    1324:	19000200 	stmdbne	r0, {r9}
    1328:	00000727 	andeq	r0, r0, r7, lsr #14
    132c:	02d80128 	sbcseq	r0, r8, #40, 2
    1330:	00000907 	andeq	r0, r0, r7, lsl #18
    1334:	00061e16 	andeq	r1, r6, r6, lsl lr
    1338:	02d90100 	sbcseq	r0, r9, #0, 2
    133c:	00000030 	andeq	r0, r0, r0, lsr r0
    1340:	069a1600 	ldreq	r1, [sl], r0, lsl #12
    1344:	da010000 	ble	4134c <__bss_end__+0x37b24>
    1348:	00003002 	andeq	r3, r0, r2
    134c:	ca160400 	bgt	582354 <_stack+0x502354>
    1350:	01000006 	tsteq	r0, r6
    1354:	003002db 	ldrsbteq	r0, [r0], -fp
    1358:	16080000 	strne	r0, [r8], -r0
    135c:	00000618 	andeq	r0, r0, r8, lsl r6
    1360:	3002dc01 	andcc	sp, r2, r1, lsl #24
    1364:	0c000000 	stceq	0, cr0, [r0], {-0}
    1368:	0007c716 	andeq	ip, r7, r6, lsl r7
    136c:	02dd0100 	sbcseq	r0, sp, #0, 2
    1370:	00000030 	andeq	r0, r0, r0, lsr r0
    1374:	06f61610 	usateq	r1, #22, r0, lsl #12
    1378:	de010000 	cdple	0, 0, cr0, cr1, cr0, {0}
    137c:	00003002 	andeq	r3, r0, r2
    1380:	c9161400 	ldmdbgt	r6, {sl, ip}
    1384:	01000006 	tsteq	r0, r6
    1388:	003002df 	ldrsbteq	r0, [r0], -pc
    138c:	16180000 	ldrne	r0, [r8], -r0
    1390:	000006c0 	andeq	r0, r0, r0, asr #13
    1394:	3002e001 	andcc	lr, r2, r1
    1398:	1c000000 	stcne	0, cr0, [r0], {-0}
    139c:	00069916 	andeq	r9, r6, r6, lsl r9
    13a0:	02e10100 	rsceq	r0, r1, #0, 2
    13a4:	00000030 	andeq	r0, r0, r0, lsr r0
    13a8:	07ab1620 	streq	r1, [fp, r0, lsr #12]!
    13ac:	e2010000 	and	r0, r1, #0
    13b0:	00003002 	andeq	r3, r0, r2
    13b4:	19002400 	stmdbne	r0, {sl, sp}
    13b8:	000006d1 	ldrdeq	r0, [r0], -r1
    13bc:	04e90110 	strbteq	r0, [r9], #272	; 0x110
    13c0:	00000947 	andeq	r0, r0, r7, asr #18
    13c4:	0005fd16 	andeq	pc, r5, r6, lsl sp	; <UNPREDICTABLE>
    13c8:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
    13cc:	00000037 	andeq	r0, r0, r7, lsr r0
    13d0:	087c1600 	ldmdaeq	ip!, {r9, sl, ip}^
    13d4:	ec010000 	stc	0, cr0, [r1], {-0}
    13d8:	00003704 	andeq	r3, r0, r4, lsl #14
    13dc:	661e0400 	ldrvs	r0, [lr], -r0, lsl #8
    13e0:	ed010064 	stc	0, cr0, [r1, #-400]	; 0xfffffe70
    13e4:	00094704 	andeq	r4, r9, r4, lsl #14
    13e8:	621e0800 	andsvs	r0, lr, #0, 16
    13ec:	ee01006b 	cdp	0, 0, cr0, cr1, cr11, {3}
    13f0:	00094704 	andeq	r4, r9, r4, lsl #14
    13f4:	0f000c00 	svceq	0x00000c00
    13f8:	00090704 	andeq	r0, r9, r4, lsl #14
    13fc:	07a10600 	streq	r0, [r1, r0, lsl #12]!
    1400:	f1010000 	setend	le
    1404:	00094704 	andeq	r4, r9, r4, lsl #14
    1408:	06340600 	ldrteq	r0, [r4], -r0, lsl #12
    140c:	1d010000 	stcne	0, cr0, [r1, #-0]
    1410:	00094706 	andeq	r4, r9, r6, lsl #14
    1414:	07551f00 	ldrbeq	r1, [r5, -r0, lsl #30]
    1418:	e9010000 	stmdb	r1, {}	; <UNPREDICTABLE>
    141c:	0000300c 	andeq	r3, r0, ip
    1420:	0086e400 	addeq	lr, r6, r0, lsl #8
    1424:	0000a200 	andeq	sl, r0, r0, lsl #4
    1428:	739c0100 	orrsvc	r0, ip, #0, 2
    142c:	2000000a 	andcs	r0, r0, sl
    1430:	0000074b 	andeq	r0, r0, fp, asr #14
    1434:	280ce901 	stmdacs	ip, {r0, r8, fp, sp, lr, pc}
    1438:	51000004 	tstpl	r0, r4
    143c:	21000001 	tstcs	r0, r1
    1440:	00646170 	rsbeq	r6, r4, r0, ror r1
    1444:	370ce901 	strcc	lr, [ip, -r1, lsl #18]
    1448:	6f000000 	svcvs	0x00000000
    144c:	22000001 	andcs	r0, r0, #1
    1450:	000008fb 	strdeq	r0, [r0], -fp
    1454:	670cee01 	strvs	lr, [ip, -r1, lsl #28]
    1458:	9b000000 	blls	1460 <CPSR_IRQ_INHIBIT+0x13e0>
    145c:	22000001 	andcs	r0, r0, #1
    1460:	000006a2 	andeq	r0, r0, r2, lsr #13
    1464:	670cef01 	strvs	lr, [ip, -r1, lsl #30]
    1468:	df000000 	svcle	0x00000000
    146c:	22000001 	andcs	r0, r0, #1
    1470:	0000070a 	andeq	r0, r0, sl, lsl #14
    1474:	600cf001 	andvs	pc, ip, r1
    1478:	fd000005 	stc2	0, cr0, [r0, #-20]	; 0xffffffec
    147c:	22000001 	andcs	r0, r0, #1
    1480:	0000063c 	andeq	r0, r0, ip, lsr r6
    1484:	600cf101 	andvs	pc, ip, r1, lsl #2
    1488:	26000005 	strcs	r0, [r0], -r5
    148c:	23000002 	movwcs	r0, #2
    1490:	00000703 	andeq	r0, r0, r3, lsl #14
    1494:	6e0cf301 	cdpvs	3, 0, cr15, cr12, cr1, {0}
    1498:	00000000 	andeq	r0, r0, r0
    149c:	86f62410 	usathi	r2, #22, r0, lsl #8
    14a0:	0be10000 	bleq	ff8414a8 <_stack+0xff7c14a8>
    14a4:	0a010000 	beq	414ac <__bss_end__+0x37c84>
    14a8:	01250000 	teqeq	r5, r0
    14ac:	00750250 	rsbseq	r0, r5, r0, asr r2
    14b0:	87182400 	ldrhi	r2, [r8, -r0, lsl #8]
    14b4:	0bf30000 	bleq	ffcc14bc <_stack+0xffc414bc>
    14b8:	0a1a0000 	beq	6814c0 <_stack+0x6014c0>
    14bc:	01250000 	teqeq	r5, r0
    14c0:	25300151 	ldrcs	r0, [r0, #-337]!	; 0x151
    14c4:	75025001 	strvc	r5, [r2, #-1]
    14c8:	26240000 	strtcs	r0, [r4], -r0
    14cc:	0d000087 	stceq	0, cr0, [r0, #-540]	; 0xfffffde4
    14d0:	2e00000c 	cdpcs	0, 0, cr0, cr0, cr12, {0}
    14d4:	2500000a 	strcs	r0, [r0, #-10]
    14d8:	75025001 	strvc	r5, [r2, #-1]
    14dc:	32240000 	eorcc	r0, r4, #0
    14e0:	f3000087 	vhadd.u8	d0, d16, d7
    14e4:	4900000b 	stmdbmi	r0, {r0, r1, r3}
    14e8:	2500000a 	strcs	r0, [r0, #-10]
    14ec:	77035101 	strvc	r5, [r3, -r1, lsl #2]
    14f0:	01251f00 	teqeq	r5, r0, lsl #30
    14f4:	00750250 	rsbseq	r0, r5, r0, asr r2
    14f8:	87542400 	ldrbhi	r2, [r4, -r0, lsl #8]
    14fc:	0c0d0000 	stceq	0, cr0, [sp], {-0}
    1500:	0a5d0000 	beq	1741508 <_stack+0x16c1508>
    1504:	01250000 	teqeq	r5, r0
    1508:	00750250 	rsbseq	r0, r5, r0, asr r2
    150c:	87602600 	strbhi	r2, [r0, -r0, lsl #12]!
    1510:	0bf30000 	bleq	ffcc1518 <_stack+0xffc41518>
    1514:	01250000 	teqeq	r5, r0
    1518:	25300151 	ldrcs	r0, [r0, #-337]!	; 0x151
    151c:	75025001 	strvc	r5, [r2, #-1]
    1520:	27000000 	strcs	r0, [r0, -r0]
    1524:	00000298 	muleq	r0, r8, r2
    1528:	880a3e01 	stmdahi	sl, {r0, r9, sl, fp, ip, sp}
    152c:	98000087 	stmdals	r0, {r0, r1, r2, r7}
    1530:	01000001 	tsteq	r0, r1
    1534:	000b949c 	muleq	fp, ip, r4
    1538:	074b2000 	strbeq	r2, [fp, -r0]
    153c:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
    1540:	0004280a 	andeq	r2, r4, sl, lsl #16
    1544:	00025300 	andeq	r5, r2, r0, lsl #6
    1548:	656d2100 	strbvs	r2, [sp, #-256]!	; 0x100
    154c:	3e01006d 	cdpcc	0, 0, cr0, cr1, cr13, {3}
    1550:	0000490a 	andeq	r4, r0, sl, lsl #18
    1554:	0002c400 	andeq	ip, r2, r0, lsl #8
    1558:	00702800 	rsbseq	r2, r0, r0, lsl #16
    155c:	4d0a4901 	stcmi	9, cr4, [sl, #-4]
    1560:	2f000009 	svccs	0x00000009
    1564:	28000003 	stmdacs	r0, {r0, r1}
    1568:	01006468 	tsteq	r0, r8, ror #8
    156c:	00370a4a 	eorseq	r0, r7, sl, asr #20
    1570:	03640000 	cmneq	r4, #0
    1574:	73280000 	teqvc	r8, #0
    1578:	4b01007a 	blmi	41768 <__bss_end__+0x37f40>
    157c:	0000370a 	andeq	r3, r0, sl, lsl #14
    1580:	00038e00 	andeq	r8, r3, r0, lsl #28
    1584:	64692800 	strbtvs	r2, [r9], #-2048	; 0x800
    1588:	4c010078 	stcmi	0, cr0, [r1], {120}	; 0x78
    158c:	0000300a 	andeq	r3, r0, sl
    1590:	0003d800 	andeq	sp, r3, r0, lsl #16
    1594:	050e2200 	streq	r2, [lr, #-512]	; 0x200
    1598:	4d010000 	stcmi	0, cr0, [r1, #-0]
    159c:	00094d0a 	andeq	r4, r9, sl, lsl #26
    15a0:	00040100 	andeq	r0, r4, r0, lsl #2
    15a4:	07302200 	ldreq	r2, [r0, -r0, lsl #4]!
    15a8:	4e010000 	cdpmi	0, 0, cr0, cr1, cr0, {0}
    15ac:	0000370a 	andeq	r3, r0, sl, lsl #14
    15b0:	00043f00 	andeq	r3, r4, r0, lsl #30
    15b4:	07442200 	strbeq	r2, [r4, -r0, lsl #4]
    15b8:	4f010000 	svcmi	0x00010000
    15bc:	0000370a 	andeq	r3, r0, sl, lsl #14
    15c0:	00049f00 	andeq	r9, r4, r0, lsl #30
    15c4:	63622800 	cmnvs	r2, #0, 16
    15c8:	5001006b 	andpl	r0, r1, fp, rrx
    15cc:	00094d0a 	andeq	r4, r9, sl, lsl #26
    15d0:	0004d800 	andeq	sp, r4, r0, lsl #16
    15d4:	77662800 	strbvc	r2, [r6, -r0, lsl #16]!
    15d8:	51010064 	tstpl	r1, r4, rrx
    15dc:	00094d0a 	andeq	r4, r9, sl, lsl #26
    15e0:	00052d00 	andeq	r2, r5, r0, lsl #26
    15e4:	06fe2200 	ldrbteq	r2, [lr], r0, lsl #4
    15e8:	52010000 	andpl	r0, r1, #0
    15ec:	0000300a 	andeq	r3, r0, sl
    15f0:	00057700 	andeq	r7, r5, r0, lsl #14
    15f4:	87982400 	ldrhi	r2, [r8, r0, lsl #8]
    15f8:	0be10000 	bleq	ff841600 <_stack+0xff7c1600>
    15fc:	0b590000 	bleq	1641604 <_stack+0x15c1604>
    1600:	01250000 	teqeq	r5, r0
    1604:	00780250 	rsbseq	r0, r8, r0, asr r2
    1608:	88522900 	ldmdahi	r2, {r8, fp, sp}^
    160c:	0c0d0000 	stceq	0, cr0, [sp], {-0}
    1610:	0b6e0000 	bleq	1b81618 <_stack+0x1b01618>
    1614:	01250000 	teqeq	r5, r0
    1618:	01f30350 	mvnseq	r0, r0, asr r3
    161c:	7e290050 	mcrvc	0, 1, r0, cr9, cr0, {2}
    1620:	0d000088 	stceq	0, cr0, [r0, #-544]	; 0xfffffde0
    1624:	8300000c 	movwhi	r0, #12
    1628:	2500000b 	strcs	r0, [r0, #-11]
    162c:	f3035001 	vhadd.u8	d5, d3, d1
    1630:	26005001 	strcs	r5, [r0], -r1
    1634:	000088ba 			; <UNDEFINED> instruction: 0x000088ba
    1638:	00000965 	andeq	r0, r0, r5, ror #18
    163c:	02500125 	subseq	r0, r0, #1073741833	; 0x40000009
    1640:	00000078 	andeq	r0, r0, r8, ror r0
    1644:	00095909 	andeq	r5, r9, r9, lsl #18
    1648:	000ba500 	andeq	sl, fp, r0, lsl #10
    164c:	00df2a00 	sbcseq	r2, pc, r0, lsl #20
    1650:	01010000 	mrseq	r0, (UNDEF: 1)
    1654:	07372b00 	ldreq	r2, [r7, -r0, lsl #22]!
    1658:	51010000 	mrspl	r0, (UNDEF: 1)
    165c:	000b9406 	andeq	r9, fp, r6, lsl #8
    1660:	06de2b00 	ldrbeq	r2, [lr], r0, lsl #22
    1664:	c8010000 	stmdagt	r1, {}	; <UNPREDICTABLE>
    1668:	00006e06 	andeq	r6, r0, r6, lsl #28
    166c:	06072b00 	streq	r2, [r7], -r0, lsl #22
    1670:	c9010000 	stmdbgt	r1, {}	; <UNPREDICTABLE>
    1674:	00006e06 	andeq	r6, r0, r6, lsl #28
    1678:	07b42b00 	ldreq	r2, [r4, r0, lsl #22]!
    167c:	ce010000 	cdpgt	0, 0, cr0, cr1, cr0, {0}
    1680:	00056006 	andeq	r6, r5, r6
    1684:	07162b00 	ldreq	r2, [r6, -r0, lsl #22]
    1688:	d1010000 	mrsle	r0, (UNDEF: 1)
    168c:	00087706 	andeq	r7, r8, r6, lsl #14
    1690:	06a82c00 	strteq	r2, [r8], r0, lsl #24
    1694:	48010000 	stmdami	r1, {}	; <UNPREDICTABLE>
    1698:	000bf301 	andeq	pc, fp, r1, lsl #6
    169c:	04281400 	strteq	r1, [r8], #-1024	; 0x400
    16a0:	2d000000 	stccs	0, cr0, [r0, #-0]
    16a4:	00000799 	muleq	r0, r9, r7
    16a8:	00499a06 	subeq	r9, r9, r6, lsl #20
    16ac:	0c0d0000 	stceq	0, cr0, [sp], {-0}
    16b0:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
    16b4:	14000004 	strne	r0, [r0], #-4
    16b8:	00000025 	andeq	r0, r0, r5, lsr #32
    16bc:	06242e00 	strteq	r2, [r4], -r0, lsl #28
    16c0:	49010000 	stmdbmi	r1, {}	; <UNPREDICTABLE>
    16c4:	04281401 	strteq	r1, [r8], #-1025	; 0x401
    16c8:	00000000 	andeq	r0, r0, r0
    16cc:	00000890 	muleq	r0, r0, r8
    16d0:	05430004 	strbeq	r0, [r3, #-4]
    16d4:	01040000 	mrseq	r0, (UNDEF: 4)
    16d8:	000003ce 	andeq	r0, r0, lr, asr #7
    16dc:	0007da01 	andeq	sp, r7, r1, lsl #20
    16e0:	0002c300 	andeq	ip, r2, r0, lsl #6
    16e4:	00046b00 	andeq	r6, r4, r0, lsl #22
    16e8:	05040200 	streq	r0, [r4, #-512]	; 0x200
    16ec:	00746e69 	rsbseq	r6, r4, r9, ror #28
    16f0:	2b070403 	blcs	1c2704 <_stack+0x142704>
    16f4:	03000002 	movweq	r0, #2
    16f8:	01f90601 	mvnseq	r0, r1, lsl #12
    16fc:	01030000 	mrseq	r0, (UNDEF: 3)
    1700:	0001f708 	andeq	pc, r1, r8, lsl #14
    1704:	05020300 	streq	r0, [r2, #-768]	; 0x300
    1708:	00000057 	andeq	r0, r0, r7, asr r0
    170c:	a0070203 	andge	r0, r7, r3, lsl #4
    1710:	03000002 	movweq	r0, #2
    1714:	017c0504 	cmneq	ip, r4, lsl #10
    1718:	04030000 	streq	r0, [r3], #-0
    171c:	00022607 	andeq	r2, r2, r7, lsl #12
    1720:	05080300 	streq	r0, [r8, #-768]	; 0x300
    1724:	00000177 	andeq	r0, r0, r7, ror r1
    1728:	21070803 	tstcs	r7, r3, lsl #16
    172c:	04000002 	streq	r0, [r0], #-2
    1730:	0000010c 	andeq	r0, r0, ip, lsl #2
    1734:	001d0701 	andseq	r0, sp, r1, lsl #14
    1738:	2a040000 	bcs	101740 <_stack+0x81740>
    173c:	02000000 	andeq	r0, r0, #0
    1740:	00004710 	andeq	r4, r0, r0, lsl r7
    1744:	01bf0400 			; <UNDEFINED> instruction: 0x01bf0400
    1748:	27020000 	strcs	r0, [r2, -r0]
    174c:	00000047 	andeq	r0, r0, r7, asr #32
    1750:	00035905 	andeq	r5, r3, r5, lsl #18
    1754:	01610300 	cmneq	r1, r0, lsl #6
    1758:	00000024 	andeq	r0, r0, r4, lsr #32
    175c:	4a020406 	bmi	8277c <_stack+0x277c>
    1760:	000000af 	andeq	r0, r0, pc, lsr #1
    1764:	00003107 	andeq	r3, r0, r7, lsl #2
    1768:	844c0200 	strbhi	r0, [ip], #-512	; 0x200
    176c:	07000000 	streq	r0, [r0, -r0]
    1770:	0000021a 	andeq	r0, r0, sl, lsl r2
    1774:	00af4d02 	adceq	r4, pc, r2, lsl #26
    1778:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    177c:	00000032 	andeq	r0, r0, r2, lsr r0
    1780:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    1784:	0000bf09 	andeq	fp, r0, r9, lsl #30
    1788:	03000300 	movweq	r0, #768	; 0x300
    178c:	006b0704 	rsbeq	r0, fp, r4, lsl #14
    1790:	080a0000 	stmdaeq	sl, {}	; <UNPREDICTABLE>
    1794:	00e74702 	rsceq	r4, r7, r2, lsl #14
    1798:	bb0b0000 	bllt	2c17a0 <_stack+0x2417a0>
    179c:	02000000 	andeq	r0, r0, #0
    17a0:	00001d49 	andeq	r1, r0, r9, asr #26
    17a4:	400b0000 	andmi	r0, fp, r0
    17a8:	02000000 	andeq	r0, r0, #0
    17ac:	0000904e 	andeq	r9, r0, lr, asr #32
    17b0:	04000400 	streq	r0, [r0], #-1024	; 0x400
    17b4:	000003a9 	andeq	r0, r0, r9, lsr #7
    17b8:	00c64f02 	sbceq	r4, r6, r2, lsl #30
    17bc:	ce040000 	cdpgt	0, 0, cr0, cr4, cr0, {0}
    17c0:	02000001 	andeq	r0, r0, #1
    17c4:	00006353 	andeq	r6, r0, r3, asr r3
    17c8:	04040c00 	streq	r0, [r4], #-3072	; 0xc00
    17cc:	000004b5 			; <UNDEFINED> instruction: 0x000004b5
    17d0:	004e1604 	subeq	r1, lr, r4, lsl #12
    17d4:	b40d0000 	strlt	r0, [sp], #-0
    17d8:	18000003 	stmdane	r0, {r0, r1}
    17dc:	015d2d04 	cmpeq	sp, r4, lsl #26
    17e0:	0d0b0000 	stceq	0, cr0, [fp, #-0]
    17e4:	04000005 	streq	r0, [r0], #-5
    17e8:	00015d2f 	andeq	r5, r1, pc, lsr #26
    17ec:	5f0e0000 	svcpl	0x000e0000
    17f0:	3004006b 	andcc	r0, r4, fp, rrx
    17f4:	0000001d 	andeq	r0, r0, sp, lsl r0
    17f8:	03bc0b04 			; <UNDEFINED> instruction: 0x03bc0b04
    17fc:	30040000 	andcc	r0, r4, r0
    1800:	0000001d 	andeq	r0, r0, sp, lsl r0
    1804:	05020b08 	streq	r0, [r2, #-2824]	; 0xb08
    1808:	30040000 	andcc	r0, r4, r0
    180c:	0000001d 	andeq	r0, r0, sp, lsl r0
    1810:	03390b0c 	teqeq	r9, #12, 22	; 0x3000
    1814:	30040000 	andcc	r0, r4, r0
    1818:	0000001d 	andeq	r0, r0, sp, lsl r0
    181c:	785f0e10 	ldmdavc	pc, {r4, r9, sl, fp}^	; <UNPREDICTABLE>
    1820:	63310400 	teqvs	r1, #0, 8
    1824:	14000001 	strne	r0, [r0], #-1
    1828:	0a040f00 	beq	105430 <_stack+0x85430>
    182c:	08000001 	stmdaeq	r0, {r0}
    1830:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1834:	00000173 	andeq	r0, r0, r3, ror r1
    1838:	0000bf09 	andeq	fp, r0, r9, lsl #30
    183c:	0d000000 	stceq	0, cr0, [r0, #-0]
    1840:	0000033e 	andeq	r0, r0, lr, lsr r3
    1844:	ec350424 	cfldrs	mvf0, [r5], #-144	; 0xffffff70
    1848:	0b000001 	bleq	1854 <CPSR_IRQ_INHIBIT+0x17d4>
    184c:	000001e4 	andeq	r0, r0, r4, ror #3
    1850:	001d3704 	andseq	r3, sp, r4, lsl #14
    1854:	0b000000 	bleq	185c <CPSR_IRQ_INHIBIT+0x17dc>
    1858:	00000139 	andeq	r0, r0, r9, lsr r1
    185c:	001d3804 	andseq	r3, sp, r4, lsl #16
    1860:	0b040000 	bleq	101868 <_stack+0x81868>
    1864:	000001ed 	andeq	r0, r0, sp, ror #3
    1868:	001d3904 	andseq	r3, sp, r4, lsl #18
    186c:	0b080000 	bleq	201874 <_stack+0x181874>
    1870:	000000c3 	andeq	r0, r0, r3, asr #1
    1874:	001d3a04 	andseq	r3, sp, r4, lsl #20
    1878:	0b0c0000 	bleq	301880 <_stack+0x281880>
    187c:	000004cb 	andeq	r0, r0, fp, asr #9
    1880:	001d3b04 	andseq	r3, sp, r4, lsl #22
    1884:	0b100000 	bleq	40188c <_stack+0x38188c>
    1888:	000003c4 	andeq	r0, r0, r4, asr #7
    188c:	001d3c04 	andseq	r3, sp, r4, lsl #24
    1890:	0b140000 	bleq	501898 <_stack+0x481898>
    1894:	0000016d 	andeq	r0, r0, sp, ror #2
    1898:	001d3d04 	andseq	r3, sp, r4, lsl #26
    189c:	0b180000 	bleq	6018a4 <_stack+0x5818a4>
    18a0:	000004ab 	andeq	r0, r0, fp, lsr #9
    18a4:	001d3e04 	andseq	r3, sp, r4, lsl #28
    18a8:	0b1c0000 	bleq	7018b0 <_stack+0x6818b0>
    18ac:	00000199 	muleq	r0, r9, r1
    18b0:	001d3f04 	andseq	r3, sp, r4, lsl #30
    18b4:	00200000 	eoreq	r0, r0, r0
    18b8:	00024910 	andeq	r4, r2, r0, lsl r9
    18bc:	04010800 	streq	r0, [r1], #-2048	; 0x800
    18c0:	00022c48 	andeq	r2, r2, r8, asr #24
    18c4:	01850b00 	orreq	r0, r5, r0, lsl #22
    18c8:	49040000 	stmdbmi	r4, {}	; <UNPREDICTABLE>
    18cc:	0000022c 	andeq	r0, r0, ip, lsr #4
    18d0:	04f10b00 	ldrbteq	r0, [r1], #2816	; 0xb00
    18d4:	4a040000 	bmi	1018dc <_stack+0x818dc>
    18d8:	0000022c 	andeq	r0, r0, ip, lsr #4
    18dc:	01b61180 			; <UNDEFINED> instruction: 0x01b61180
    18e0:	4c040000 	stcmi	0, cr0, [r4], {-0}
    18e4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    18e8:	80110100 	andshi	r0, r1, r0, lsl #2
    18ec:	04000003 	streq	r0, [r0], #-3
    18f0:	0000ff4f 	andeq	pc, r0, pc, asr #30
    18f4:	00010400 	andeq	r0, r1, r0, lsl #8
    18f8:	0000fd08 	andeq	pc, r0, r8, lsl #26
    18fc:	00023c00 	andeq	r3, r2, r0, lsl #24
    1900:	00bf0900 	adcseq	r0, pc, r0, lsl #18
    1904:	001f0000 	andseq	r0, pc, r0
    1908:	0000eb10 	andeq	lr, r0, r0, lsl fp
    190c:	04019000 	streq	r9, [r1], #-0
    1910:	00027a5b 	andeq	r7, r2, fp, asr sl
    1914:	050d0b00 	streq	r0, [sp, #-2816]	; 0xb00
    1918:	5c040000 	stcpl	0, cr0, [r4], {-0}
    191c:	0000027a 	andeq	r0, r0, sl, ror r2
    1920:	04de0b00 	ldrbeq	r0, [lr], #2816	; 0xb00
    1924:	5d040000 	stcpl	0, cr0, [r4, #-0]
    1928:	0000001d 	andeq	r0, r0, sp, lsl r0
    192c:	015f0b04 	cmpeq	pc, r4, lsl #22
    1930:	5f040000 	svcpl	0x00040000
    1934:	00000280 	andeq	r0, r0, r0, lsl #5
    1938:	02490b08 	subeq	r0, r9, #8, 22	; 0x2000
    193c:	60040000 	andvs	r0, r4, r0
    1940:	000001ec 	andeq	r0, r0, ip, ror #3
    1944:	040f0088 	streq	r0, [pc], #-136	; 194c <CPSR_IRQ_INHIBIT+0x18cc>
    1948:	0000023c 	andeq	r0, r0, ip, lsr r2
    194c:	00029008 	andeq	r9, r2, r8
    1950:	00029000 	andeq	r9, r2, r0
    1954:	00bf0900 	adcseq	r0, pc, r0, lsl #18
    1958:	001f0000 	andseq	r0, pc, r0
    195c:	0296040f 	addseq	r0, r6, #251658240	; 0xf000000
    1960:	0d120000 	ldceq	0, cr0, [r2, #-0]
    1964:	00000050 	andeq	r0, r0, r0, asr r0
    1968:	bc730408 	cfldrdlt	mvd0, [r3], #-32	; 0xffffffe0
    196c:	0b000002 	bleq	197c <CPSR_IRQ_INHIBIT+0x18fc>
    1970:	000007c1 	andeq	r0, r0, r1, asr #15
    1974:	02bc7404 	adcseq	r7, ip, #4, 8	; 0x4000000
    1978:	0b000000 	bleq	1980 <CPSR_IRQ_INHIBIT+0x1900>
    197c:	0000087b 	andeq	r0, r0, fp, ror r8
    1980:	001d7504 	andseq	r7, sp, r4, lsl #10
    1984:	00040000 	andeq	r0, r4, r0
    1988:	0032040f 	eorseq	r0, r2, pc, lsl #8
    198c:	4c0d0000 	stcmi	0, cr0, [sp], {-0}
    1990:	68000005 	stmdavs	r0, {r0, r2}
    1994:	03ecb304 	mvneq	fp, #4, 6	; 0x10000000
    1998:	5f0e0000 	svcpl	0x000e0000
    199c:	b4040070 	strlt	r0, [r4], #-112	; 0x70
    19a0:	000002bc 			; <UNDEFINED> instruction: 0x000002bc
    19a4:	725f0e00 	subsvc	r0, pc, #0, 28
    19a8:	1db50400 	cfldrsne	mvf0, [r5]
    19ac:	04000000 	streq	r0, [r0], #-0
    19b0:	00775f0e 	rsbseq	r5, r7, lr, lsl #30
    19b4:	001db604 	andseq	fp, sp, r4, lsl #12
    19b8:	0b080000 	bleq	2019c0 <_stack+0x1819c0>
    19bc:	0000009e 	muleq	r0, lr, r0
    19c0:	0039b704 	eorseq	fp, r9, r4, lsl #14
    19c4:	0b0c0000 	bleq	3019cc <_stack+0x2819cc>
    19c8:	00000317 	andeq	r0, r0, r7, lsl r3
    19cc:	0039b804 	eorseq	fp, r9, r4, lsl #16
    19d0:	0e0e0000 	cdpeq	0, 0, cr0, cr14, cr0, {0}
    19d4:	0066625f 	rsbeq	r6, r6, pc, asr r2
    19d8:	0297b904 	addseq	fp, r7, #4, 18	; 0x10000
    19dc:	0b100000 	bleq	4019e4 <_stack+0x3819e4>
    19e0:	00000037 	andeq	r0, r0, r7, lsr r0
    19e4:	001dba04 	andseq	fp, sp, r4, lsl #20
    19e8:	0b180000 	bleq	6019f0 <_stack+0x5819f0>
    19ec:	000002bb 			; <UNDEFINED> instruction: 0x000002bb
    19f0:	00fdc104 	rscseq	ip, sp, r4, lsl #2
    19f4:	0b1c0000 	bleq	7019fc <_stack+0x6819fc>
    19f8:	00000205 	andeq	r0, r0, r5, lsl #4
    19fc:	054fc304 	strbeq	ip, [pc, #-772]	; 1700 <CPSR_IRQ_INHIBIT+0x1680>
    1a00:	0b200000 	bleq	801a08 <_stack+0x781a08>
    1a04:	000000a5 	andeq	r0, r0, r5, lsr #1
    1a08:	057ec504 	ldrbeq	ip, [lr, #-1284]!	; 0x504
    1a0c:	0b240000 	bleq	901a14 <_stack+0x881a14>
    1a10:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
    1a14:	05a2c804 	streq	ip, [r2, #2052]!	; 0x804
    1a18:	0b280000 	bleq	a01a20 <_stack+0x981a20>
    1a1c:	000001c7 	andeq	r0, r0, r7, asr #3
    1a20:	05bcc904 	ldreq	ip, [ip, #2308]!	; 0x904
    1a24:	0e2c0000 	cdpeq	0, 2, cr0, cr12, cr0, {0}
    1a28:	0062755f 	rsbeq	r7, r2, pc, asr r5
    1a2c:	0297cc04 	addseq	ip, r7, #4, 24	; 0x400
    1a30:	0e300000 	cdpeq	0, 3, cr0, cr0, cr0, {0}
    1a34:	0070755f 	rsbseq	r7, r0, pc, asr r5
    1a38:	02bccd04 	adcseq	ip, ip, #4, 26	; 0x100
    1a3c:	0e380000 	cdpeq	0, 3, cr0, cr8, cr0, {0}
    1a40:	0072755f 	rsbseq	r7, r2, pc, asr r5
    1a44:	001dce04 	andseq	ip, sp, r4, lsl #28
    1a48:	0b3c0000 	bleq	f01a50 <_stack+0xe81a50>
    1a4c:	00000539 	andeq	r0, r0, r9, lsr r5
    1a50:	05c2d104 	strbeq	sp, [r2, #260]	; 0x104
    1a54:	0b400000 	bleq	1001a5c <_stack+0xf81a5c>
    1a58:	00000106 	andeq	r0, r0, r6, lsl #2
    1a5c:	05d2d204 	ldrbeq	sp, [r2, #516]	; 0x204
    1a60:	0e430000 	cdpeq	0, 4, cr0, cr3, cr0, {0}
    1a64:	00626c5f 	rsbeq	r6, r2, pc, asr ip
    1a68:	0297d504 	addseq	sp, r7, #4, 10	; 0x1000000
    1a6c:	0b440000 	bleq	1101a74 <_stack+0x1081a74>
    1a70:	000001ad 	andeq	r0, r0, sp, lsr #3
    1a74:	001dd804 	andseq	sp, sp, r4, lsl #16
    1a78:	0b4c0000 	bleq	1301a80 <_stack+0x1281a80>
    1a7c:	00000074 	andeq	r0, r0, r4, ror r0
    1a80:	006ed904 	rsbeq	sp, lr, r4, lsl #18
    1a84:	0b500000 	bleq	1401a8c <_stack+0x1381a8c>
    1a88:	000007d4 	ldrdeq	r0, [r0], -r4
    1a8c:	040adc04 	streq	sp, [sl], #-3076	; 0xc04
    1a90:	0b540000 	bleq	1501a98 <_stack+0x1481a98>
    1a94:	000006b0 			; <UNDEFINED> instruction: 0x000006b0
    1a98:	00f2e004 	rscseq	lr, r2, r4
    1a9c:	0b580000 	bleq	1601aa4 <_stack+0x1581aa4>
    1aa0:	00000164 	andeq	r0, r0, r4, ror #2
    1aa4:	00e7e204 	rsceq	lr, r7, r4, lsl #4
    1aa8:	0b5c0000 	bleq	1701ab0 <_stack+0x1681ab0>
    1aac:	0000000b 	andeq	r0, r0, fp
    1ab0:	001de304 	andseq	lr, sp, r4, lsl #6
    1ab4:	00640000 	rsbeq	r0, r4, r0
    1ab8:	00001d13 	andeq	r1, r0, r3, lsl sp
    1abc:	00040a00 	andeq	r0, r4, r0, lsl #20
    1ac0:	040a1400 	streq	r1, [sl], #-1024	; 0x400
    1ac4:	fd140000 	ldc2	0, cr0, [r4, #-0]
    1ac8:	14000000 	strne	r0, [r0], #-0
    1acc:	00000542 	andeq	r0, r0, r2, asr #10
    1ad0:	00001d14 	andeq	r1, r0, r4, lsl sp
    1ad4:	040f0000 	streq	r0, [pc], #-0	; 1adc <CPSR_IRQ_INHIBIT+0x1a5c>
    1ad8:	00000410 	andeq	r0, r0, r0, lsl r4
    1adc:	0003a215 	andeq	sl, r3, r5, lsl r2
    1ae0:	04042800 	streq	r2, [r4], #-2048	; 0x800
    1ae4:	05420239 	strbeq	r0, [r2, #-569]	; 0x239
    1ae8:	3a160000 	bcc	581af0 <_stack+0x501af0>
    1aec:	04000002 	streq	r0, [r0], #-2
    1af0:	001d023b 	andseq	r0, sp, fp, lsr r2
    1af4:	16000000 	strne	r0, [r0], -r0
    1af8:	00000513 	andeq	r0, r0, r3, lsl r5
    1afc:	29024004 	stmdbcs	r2, {r2, lr}
    1b00:	04000006 	streq	r0, [r0], #-6
    1b04:	0000e316 	andeq	lr, r0, r6, lsl r3
    1b08:	02400400 	subeq	r0, r0, #0, 8
    1b0c:	00000629 	andeq	r0, r0, r9, lsr #12
    1b10:	02121608 	andseq	r1, r2, #8, 12	; 0x800000
    1b14:	40040000 	andmi	r0, r4, r0
    1b18:	00062902 	andeq	r2, r6, r2, lsl #18
    1b1c:	d9160c00 	ldmdble	r6, {sl, fp}
    1b20:	04000004 	streq	r0, [r0], #-4
    1b24:	001d0242 	andseq	r0, sp, r2, asr #4
    1b28:	16100000 	ldrne	r0, [r0], -r0
    1b2c:	000000f3 	strdeq	r0, [r0], -r3
    1b30:	0b024304 	bleq	92748 <_stack+0x12748>
    1b34:	14000008 	strne	r0, [r0], #-8
    1b38:	00036e16 	andeq	r6, r3, r6, lsl lr
    1b3c:	02450400 	subeq	r0, r5, #0, 8
    1b40:	0000001d 	andeq	r0, r0, sp, lsl r0
    1b44:	051a1630 	ldreq	r1, [sl, #-1584]	; 0x630
    1b48:	46040000 	strmi	r0, [r4], -r0
    1b4c:	00057302 	andeq	r7, r5, r2, lsl #6
    1b50:	00163400 	andseq	r3, r6, r0, lsl #8
    1b54:	04000000 	streq	r0, [r0], #-0
    1b58:	001d0248 	andseq	r0, sp, r8, asr #4
    1b5c:	16380000 	ldrtne	r0, [r8], -r0
    1b60:	00000388 	andeq	r0, r0, r8, lsl #7
    1b64:	26024a04 	strcs	r4, [r2], -r4, lsl #20
    1b68:	3c000008 	stccc	0, cr0, [r0], {8}
    1b6c:	0004c316 	andeq	ip, r4, r6, lsl r3
    1b70:	024d0400 	subeq	r0, sp, #0, 8
    1b74:	0000015d 	andeq	r0, r0, sp, asr r1
    1b78:	00611640 	rsbeq	r1, r1, r0, asr #12
    1b7c:	4e040000 	cdpmi	0, 0, cr0, cr4, cr0, {0}
    1b80:	00001d02 	andeq	r1, r0, r2, lsl #26
    1b84:	fd164400 	ldc2	4, cr4, [r6, #-0]
    1b88:	04000004 	streq	r0, [r0], #-4
    1b8c:	015d024f 	cmpeq	sp, pc, asr #4
    1b90:	16480000 	strbne	r0, [r8], -r0
    1b94:	00000155 	andeq	r0, r0, r5, asr r1
    1b98:	2c025004 	stccs	0, cr5, [r2], {4}
    1b9c:	4c000008 	stcmi	0, cr0, [r0], {8}
    1ba0:	0000fe16 	andeq	pc, r0, r6, lsl lr	; <UNPREDICTABLE>
    1ba4:	02530400 	subseq	r0, r3, #0, 8
    1ba8:	0000001d 	andeq	r0, r0, sp, lsl r0
    1bac:	02b31650 	adcseq	r1, r3, #80, 12	; 0x5000000
    1bb0:	54040000 	strpl	r0, [r4], #-0
    1bb4:	00054202 	andeq	r4, r5, r2, lsl #4
    1bb8:	54165400 	ldrpl	r5, [r6], #-1024	; 0x400
    1bbc:	04000005 	streq	r0, [r0], #-5
    1bc0:	07e90277 			; <UNDEFINED> instruction: 0x07e90277
    1bc4:	17580000 	ldrbne	r0, [r8, -r0]
    1bc8:	000000eb 	andeq	r0, r0, fp, ror #1
    1bcc:	7a027b04 	bvc	a07e4 <_stack+0x207e4>
    1bd0:	48000002 	stmdami	r0, {r1}
    1bd4:	01a41701 			; <UNDEFINED> instruction: 0x01a41701
    1bd8:	7c040000 	stcvc	0, cr0, [r4], {-0}
    1bdc:	00023c02 	andeq	r3, r2, r2, lsl #24
    1be0:	17014c00 	strne	r4, [r1, -r0, lsl #24]
    1be4:	00000142 	andeq	r0, r0, r2, asr #2
    1be8:	3d028004 	stccc	0, cr8, [r2, #-16]
    1bec:	dc000008 	stcle	0, cr0, [r0], {8}
    1bf0:	02411702 	subeq	r1, r1, #524288	; 0x80000
    1bf4:	85040000 	strhi	r0, [r4, #-0]
    1bf8:	0005ee02 	andeq	lr, r5, r2, lsl #28
    1bfc:	1702e000 	strne	lr, [r2, -r0]
    1c00:	0000007c 	andeq	r0, r0, ip, ror r0
    1c04:	49028604 	stmdbmi	r2, {r2, r9, sl, pc}
    1c08:	ec000008 	stc	0, cr0, [r0], {8}
    1c0c:	040f0002 	streq	r0, [pc], #-2	; 1c14 <CPSR_IRQ_INHIBIT+0x1b94>
    1c10:	00000548 	andeq	r0, r0, r8, asr #10
    1c14:	00080103 	andeq	r0, r8, r3, lsl #2
    1c18:	0f000002 	svceq	0x00000002
    1c1c:	0003ec04 	andeq	lr, r3, r4, lsl #24
    1c20:	001d1300 	andseq	r1, sp, r0, lsl #6
    1c24:	05730000 	ldrbeq	r0, [r3, #-0]!
    1c28:	0a140000 	beq	501c30 <_stack+0x481c30>
    1c2c:	14000004 	strne	r0, [r0], #-4
    1c30:	000000fd 	strdeq	r0, [r0], -sp
    1c34:	00057314 	andeq	r7, r5, r4, lsl r3
    1c38:	001d1400 	andseq	r1, sp, r0, lsl #8
    1c3c:	0f000000 	svceq	0x00000000
    1c40:	00057904 	andeq	r7, r5, r4, lsl #18
    1c44:	05481800 	strbeq	r1, [r8, #-2048]	; 0x800
    1c48:	040f0000 	streq	r0, [pc], #-0	; 1c50 <CPSR_IRQ_INHIBIT+0x1bd0>
    1c4c:	00000555 	andeq	r0, r0, r5, asr r5
    1c50:	00007913 	andeq	r7, r0, r3, lsl r9
    1c54:	0005a200 	andeq	sl, r5, r0, lsl #4
    1c58:	040a1400 	streq	r1, [sl], #-1024	; 0x400
    1c5c:	fd140000 	ldc2	0, cr0, [r4, #-0]
    1c60:	14000000 	strne	r0, [r0], #-0
    1c64:	00000079 	andeq	r0, r0, r9, ror r0
    1c68:	00001d14 	andeq	r1, r0, r4, lsl sp
    1c6c:	040f0000 	streq	r0, [pc], #-0	; 1c74 <CPSR_IRQ_INHIBIT+0x1bf4>
    1c70:	00000584 	andeq	r0, r0, r4, lsl #11
    1c74:	00001d13 	andeq	r1, r0, r3, lsl sp
    1c78:	0005bc00 	andeq	fp, r5, r0, lsl #24
    1c7c:	040a1400 	streq	r1, [sl], #-1024	; 0x400
    1c80:	fd140000 	ldc2	0, cr0, [r4, #-0]
    1c84:	00000000 	andeq	r0, r0, r0
    1c88:	05a8040f 	streq	r0, [r8, #1039]!	; 0x40f
    1c8c:	32080000 	andcc	r0, r8, #0
    1c90:	d2000000 	andle	r0, r0, #0
    1c94:	09000005 	stmdbeq	r0, {r0, r2}
    1c98:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    1c9c:	32080002 	andcc	r0, r8, #2
    1ca0:	e2000000 	and	r0, r0, #0
    1ca4:	09000005 	stmdbeq	r0, {r0, r2}
    1ca8:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    1cac:	25050000 	strcs	r0, [r5, #-0]
    1cb0:	04000001 	streq	r0, [r0], #-1
    1cb4:	02c2011d 	sbceq	r0, r2, #1073741831	; 0x40000007
    1cb8:	de190000 	cdple	0, 1, cr0, cr9, cr0, {0}
    1cbc:	0c000001 	stceq	0, cr0, [r0], {1}
    1cc0:	23012104 	movwcs	r2, #4356	; 0x1104
    1cc4:	16000006 	strne	r0, [r0], -r6
    1cc8:	0000050d 	andeq	r0, r0, sp, lsl #10
    1ccc:	23012304 	movwcs	r2, #4868	; 0x1304
    1cd0:	00000006 	andeq	r0, r0, r6
    1cd4:	00011e16 	andeq	r1, r1, r6, lsl lr
    1cd8:	01240400 	teqeq	r4, r0, lsl #8
    1cdc:	0000001d 	andeq	r0, r0, sp, lsl r0
    1ce0:	018d1604 	orreq	r1, sp, r4, lsl #12
    1ce4:	25040000 	strcs	r0, [r4, #-0]
    1ce8:	00062901 	andeq	r2, r6, r1, lsl #18
    1cec:	0f000800 	svceq	0x00000800
    1cf0:	0005ee04 	andeq	lr, r5, r4, lsl #28
    1cf4:	e2040f00 	and	r0, r4, #0, 30
    1cf8:	19000005 	stmdbne	r0, {r0, r2}
    1cfc:	000004a3 	andeq	r0, r0, r3, lsr #9
    1d00:	013d040e 	teqeq	sp, lr, lsl #8
    1d04:	00000664 	andeq	r0, r0, r4, ror #12
    1d08:	00049d16 	andeq	r9, r4, r6, lsl sp
    1d0c:	013e0400 	teqeq	lr, r0, lsl #8
    1d10:	00000664 	andeq	r0, r0, r4, ror #12
    1d14:	01931600 	orrseq	r1, r3, r0, lsl #12
    1d18:	3f040000 	svccc	0x00040000
    1d1c:	00066401 	andeq	r6, r6, r1, lsl #8
    1d20:	d4160600 	ldrle	r0, [r6], #-1536	; 0x600
    1d24:	04000004 	streq	r0, [r0], #-4
    1d28:	00400140 	subeq	r0, r0, r0, asr #2
    1d2c:	000c0000 	andeq	r0, ip, r0
    1d30:	00004008 	andeq	r4, r0, r8
    1d34:	00067400 	andeq	r7, r6, r0, lsl #8
    1d38:	00bf0900 	adcseq	r0, pc, r0, lsl #18
    1d3c:	00020000 	andeq	r0, r2, r0
    1d40:	5804d01a 	stmdapl	r4, {r1, r3, r4, ip, lr, pc}
    1d44:	00077502 	andeq	r7, r7, r2, lsl #10
    1d48:	032c1600 	teqeq	ip, #0, 12
    1d4c:	5a040000 	bpl	101d54 <_stack+0x81d54>
    1d50:	00002402 	andeq	r2, r0, r2, lsl #8
    1d54:	90160000 	andsls	r0, r6, r0
    1d58:	04000004 	streq	r0, [r0], #-4
    1d5c:	0542025b 	strbeq	r0, [r2, #-603]	; 0x25b
    1d60:	16040000 	strne	r0, [r4], -r0
    1d64:	0000053f 	andeq	r0, r0, pc, lsr r5
    1d68:	75025c04 	strvc	r5, [r2, #-3076]	; 0xc04
    1d6c:	08000007 	stmdaeq	r0, {r0, r1, r2}
    1d70:	0000ac16 	andeq	sl, r0, r6, lsl ip
    1d74:	025d0400 	subseq	r0, sp, #0, 8
    1d78:	00000173 	andeq	r0, r0, r3, ror r1
    1d7c:	031d1624 	tsteq	sp, #36, 12	; 0x2400000
    1d80:	5e040000 	cdppl	0, 0, cr0, cr4, cr0, {0}
    1d84:	00001d02 	andeq	r1, r0, r2, lsl #26
    1d88:	08164800 	ldmdaeq	r6, {fp, lr}
    1d8c:	04000005 	streq	r0, [r0], #-5
    1d90:	005c025f 	subseq	r0, ip, pc, asr r2
    1d94:	16500000 	ldrbne	r0, [r0], -r0
    1d98:	000000de 	ldrdeq	r0, [r0], -lr
    1d9c:	2f026004 	svccs	0x00026004
    1da0:	58000006 	stmdapl	r0, {r1, r2}
    1da4:	00001316 	andeq	r1, r0, r6, lsl r3
    1da8:	02610400 	rsbeq	r0, r1, #0, 8
    1dac:	000000e7 	andeq	r0, r0, r7, ror #1
    1db0:	034b1668 	movteq	r1, #46696	; 0xb668
    1db4:	62040000 	andvs	r0, r4, #0
    1db8:	0000e702 	andeq	lr, r0, r2, lsl #14
    1dbc:	e3167000 	tst	r6, #0
    1dc0:	04000004 	streq	r0, [r0], #-4
    1dc4:	00e70263 	rsceq	r0, r7, r3, ror #4
    1dc8:	16780000 	ldrbtne	r0, [r8], -r0
    1dcc:	00000020 	andeq	r0, r0, r0, lsr #32
    1dd0:	85026404 	strhi	r6, [r2, #-1028]	; 0x404
    1dd4:	80000007 	andhi	r0, r0, r7
    1dd8:	00008116 	andeq	r8, r0, r6, lsl r1
    1ddc:	02650400 	rsbeq	r0, r5, #0, 8
    1de0:	00000795 	muleq	r0, r5, r7
    1de4:	012c1688 	smlawbeq	ip, r8, r6, r1
    1de8:	66040000 	strvs	r0, [r4], -r0
    1dec:	00001d02 	andeq	r1, r0, r2, lsl #26
    1df0:	6016a000 	andsvs	sl, r6, r0
    1df4:	04000003 	streq	r0, [r0], #-3
    1df8:	00e70267 	rsceq	r0, r7, r7, ror #4
    1dfc:	16a40000 	strtne	r0, [r4], r0
    1e00:	00000289 	andeq	r0, r0, r9, lsl #5
    1e04:	e7026804 	str	r6, [r2, -r4, lsl #16]
    1e08:	ac000000 	stcge	0, cr0, [r0], {-0}
    1e0c:	0000cd16 	andeq	ip, r0, r6, lsl sp
    1e10:	02690400 	rsbeq	r0, r9, #0, 8
    1e14:	000000e7 	andeq	r0, r0, r7, ror #1
    1e18:	052a16b4 	streq	r1, [sl, #-1716]!	; 0x6b4
    1e1c:	6a040000 	bvs	101e24 <_stack+0x81e24>
    1e20:	0000e702 	andeq	lr, r0, r2, lsl #14
    1e24:	8d16bc00 	ldchi	12, cr11, [r6, #-0]
    1e28:	04000000 	streq	r0, [r0], #-0
    1e2c:	00e7026b 	rsceq	r0, r7, fp, ror #4
    1e30:	16c40000 	strbne	r0, [r4], r0
    1e34:	00000238 	andeq	r0, r0, r8, lsr r2
    1e38:	1d026c04 	stcne	12, cr6, [r2, #-16]
    1e3c:	cc000000 	stcgt	0, cr0, [r0], {-0}
    1e40:	05480800 	strbeq	r0, [r8, #-2048]	; 0x800
    1e44:	07850000 	streq	r0, [r5, r0]
    1e48:	bf090000 	svclt	0x00090000
    1e4c:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    1e50:	05480800 	strbeq	r0, [r8, #-2048]	; 0x800
    1e54:	07950000 	ldreq	r0, [r5, r0]
    1e58:	bf090000 	svclt	0x00090000
    1e5c:	07000000 	streq	r0, [r0, -r0]
    1e60:	05480800 	strbeq	r0, [r8, #-2048]	; 0x800
    1e64:	07a50000 	streq	r0, [r5, r0]!
    1e68:	bf090000 	svclt	0x00090000
    1e6c:	17000000 	strne	r0, [r0, -r0]
    1e70:	04f01a00 	ldrbteq	r1, [r0], #2560	; 0xa00
    1e74:	07c90271 			; <UNDEFINED> instruction: 0x07c90271
    1e78:	0b160000 	bleq	581e80 <_stack+0x501e80>
    1e7c:	04000002 	streq	r0, [r0], #-2
    1e80:	07c90274 			; <UNDEFINED> instruction: 0x07c90274
    1e84:	16000000 	strne	r0, [r0], -r0
    1e88:	0000014c 	andeq	r0, r0, ip, asr #2
    1e8c:	d9027504 	stmdble	r2, {r2, r8, sl, ip, sp, lr}
    1e90:	78000007 	stmdavc	r0, {r0, r1, r2}
    1e94:	02bc0800 	adcseq	r0, ip, #0, 16
    1e98:	07d90000 	ldrbeq	r0, [r9, r0]
    1e9c:	bf090000 	svclt	0x00090000
    1ea0:	1d000000 	stcne	0, cr0, [r0, #-0]
    1ea4:	00240800 	eoreq	r0, r4, r0, lsl #16
    1ea8:	07e90000 	strbeq	r0, [r9, r0]!
    1eac:	bf090000 	svclt	0x00090000
    1eb0:	1d000000 	stcne	0, cr0, [r0, #-0]
    1eb4:	04f01b00 	ldrbteq	r1, [r0], #2816	; 0xb00
    1eb8:	080b0256 	stmdaeq	fp, {r1, r2, r4, r6, r9}
    1ebc:	a21c0000 	andsge	r0, ip, #0
    1ec0:	04000003 	streq	r0, [r0], #-3
    1ec4:	0674026d 	ldrbteq	r0, [r4], -sp, ror #4
    1ec8:	431c0000 	tstmi	ip, #0
    1ecc:	04000003 	streq	r0, [r0], #-3
    1ed0:	07a50276 			; <UNDEFINED> instruction: 0x07a50276
    1ed4:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    1ed8:	00000548 	andeq	r0, r0, r8, asr #10
    1edc:	0000081b 	andeq	r0, r0, fp, lsl r8
    1ee0:	0000bf09 	andeq	fp, r0, r9, lsl #30
    1ee4:	1d001800 	stcne	8, cr1, [r0, #-0]
    1ee8:	00000826 	andeq	r0, r0, r6, lsr #16
    1eec:	00040a14 	andeq	r0, r4, r4, lsl sl
    1ef0:	040f0000 	streq	r0, [pc], #-0	; 1ef8 <CPSR_IRQ_INHIBIT+0x1e78>
    1ef4:	0000081b 	andeq	r0, r0, fp, lsl r8
    1ef8:	015d040f 	cmpeq	sp, pc, lsl #8
    1efc:	3d1d0000 	ldccc	0, cr0, [sp, #-0]
    1f00:	14000008 	strne	r0, [r0], #-8
    1f04:	0000001d 	andeq	r0, r0, sp, lsl r0
    1f08:	43040f00 	movwmi	r0, #20224	; 0x4f00
    1f0c:	0f000008 	svceq	0x00000008
    1f10:	00083204 	andeq	r3, r8, r4, lsl #4
    1f14:	05e20800 	strbeq	r0, [r2, #2048]!	; 0x800
    1f18:	08590000 	ldmdaeq	r9, {}^	; <UNPREDICTABLE>
    1f1c:	bf090000 	svclt	0x00090000
    1f20:	02000000 	andeq	r0, r0, #0
    1f24:	07ce1e00 	strbeq	r1, [lr, r0, lsl #28]
    1f28:	17050000 	strne	r0, [r5, -r0]
    1f2c:	00000410 	andeq	r0, r0, r0, lsl r4
    1f30:	8fa80305 	svchi	0x00a80305
    1f34:	141f0000 	ldrne	r0, [pc], #-0	; 1f3c <CPSR_IRQ_INHIBIT+0x1ebc>
    1f38:	04000008 	streq	r0, [r0], #-8
    1f3c:	040a02fa 	streq	r0, [sl], #-762	; 0x2fa
    1f40:	03050000 	movweq	r0, #20480	; 0x5000
    1f44:	000093d0 	ldrdeq	r9, [r0], -r0
    1f48:	00080d1f 	andeq	r0, r8, pc, lsl sp
    1f4c:	02fb0400 	rscseq	r0, fp, #0, 8
    1f50:	0000088e 	andeq	r0, r0, lr, lsl #17
    1f54:	8f9c0305 	svchi	0x009c0305
    1f58:	0a180000 	beq	601f60 <_stack+0x581f60>
    1f5c:	00000004 	andeq	r0, r0, r4
    1f60:	00000d79 	andeq	r0, r0, r9, ror sp
    1f64:	06c30004 	strbeq	r0, [r3], r4
    1f68:	01040000 	mrseq	r0, (UNDEF: 4)
    1f6c:	000003ce 	andeq	r0, r0, lr, asr #7
    1f70:	00076401 	andeq	r6, r7, r1, lsl #8
    1f74:	00064400 	andeq	r4, r6, r0, lsl #8
    1f78:	00008000 	andeq	r8, r0, r0
    1f7c:	00000000 	andeq	r0, r0, r0
    1f80:	00054700 	andeq	r4, r5, r0, lsl #14
    1f84:	06b60200 	ldrteq	r0, [r6], r0, lsl #4
    1f88:	93020000 	movwls	r0, #8192	; 0x2000
    1f8c:	00000030 	andeq	r0, r0, r0, lsr r0
    1f90:	69050403 	stmdbvs	r5, {r0, r1, sl}
    1f94:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
    1f98:	00000559 	andeq	r0, r0, r9, asr r5
    1f9c:	0042d402 	subeq	sp, r2, r2, lsl #8
    1fa0:	04040000 	streq	r0, [r4], #-0
    1fa4:	00022b07 	andeq	r2, r2, r7, lsl #22
    1fa8:	04040500 	streq	r0, [r4], #-1280	; 0x500
    1fac:	01f90601 	mvnseq	r0, r1, lsl #12
    1fb0:	01040000 	mrseq	r0, (UNDEF: 4)
    1fb4:	0001f708 	andeq	pc, r1, r8, lsl #14
    1fb8:	05020400 	streq	r0, [r2, #-1024]	; 0x400
    1fbc:	00000057 	andeq	r0, r0, r7, asr r0
    1fc0:	a0070204 	andge	r0, r7, r4, lsl #4
    1fc4:	04000002 	streq	r0, [r0], #-2
    1fc8:	017c0504 	cmneq	ip, r4, lsl #10
    1fcc:	04040000 	streq	r0, [r4], #-0
    1fd0:	00022607 	andeq	r2, r2, r7, lsl #12
    1fd4:	05080400 	streq	r0, [r8, #-1024]	; 0x400
    1fd8:	00000177 	andeq	r0, r0, r7, ror r1
    1fdc:	21070804 	tstcs	r7, r4, lsl #16
    1fe0:	02000002 	andeq	r0, r0, #2
    1fe4:	0000010c 	andeq	r0, r0, ip, lsl #2
    1fe8:	00300703 	eorseq	r0, r0, r3, lsl #14
    1fec:	2a020000 	bcs	81ff4 <_stack+0x1ff4>
    1ff0:	04000000 	streq	r0, [r0], #-0
    1ff4:	00006710 	andeq	r6, r0, r0, lsl r7
    1ff8:	01bf0200 			; <UNDEFINED> instruction: 0x01bf0200
    1ffc:	27040000 	strcs	r0, [r4, -r0]
    2000:	00000067 	andeq	r0, r0, r7, rrx
    2004:	00035906 	andeq	r5, r3, r6, lsl #18
    2008:	01610200 	cmneq	r1, r0, lsl #4
    200c:	00000042 	andeq	r0, r0, r2, asr #32
    2010:	4a040407 	bmi	103034 <_stack+0x83034>
    2014:	000000cf 	andeq	r0, r0, pc, asr #1
    2018:	00003108 	andeq	r3, r0, r8, lsl #2
    201c:	a44c0400 	strbge	r0, [ip], #-1024	; 0x400
    2020:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    2024:	0000021a 	andeq	r0, r0, sl, lsl r2
    2028:	00cf4d04 	sbceq	r4, pc, r4, lsl #26
    202c:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    2030:	00000052 	andeq	r0, r0, r2, asr r0
    2034:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    2038:	0000df0a 	andeq	sp, r0, sl, lsl #30
    203c:	04000300 	streq	r0, [r0], #-768	; 0x300
    2040:	006b0704 	rsbeq	r0, fp, r4, lsl #14
    2044:	080b0000 	stmdaeq	fp, {}	; <UNPREDICTABLE>
    2048:	01074704 	tsteq	r7, r4, lsl #14
    204c:	bb0c0000 	bllt	302054 <_stack+0x282054>
    2050:	04000000 	streq	r0, [r0], #-0
    2054:	00003049 	andeq	r3, r0, r9, asr #32
    2058:	400c0000 	andmi	r0, ip, r0
    205c:	04000000 	streq	r0, [r0], #-0
    2060:	0000b04e 	andeq	fp, r0, lr, asr #32
    2064:	02000400 	andeq	r0, r0, #0, 8
    2068:	000003a9 	andeq	r0, r0, r9, lsr #7
    206c:	00e64f04 	rsceq	r4, r6, r4, lsl #30
    2070:	ce020000 	cdpgt	0, 0, cr0, cr2, cr0, {0}
    2074:	04000001 	streq	r0, [r0], #-1
    2078:	00008353 	andeq	r8, r0, r3, asr r3
    207c:	04b50200 	ldrteq	r0, [r5], #512	; 0x200
    2080:	16050000 	strne	r0, [r5], -r0
    2084:	0000006e 	andeq	r0, r0, lr, rrx
    2088:	0003b40d 	andeq	fp, r3, sp, lsl #8
    208c:	2d051800 	stccs	8, cr1, [r5, #-0]
    2090:	0000017b 	andeq	r0, r0, fp, ror r1
    2094:	00050d0c 	andeq	r0, r5, ip, lsl #26
    2098:	7b2f0500 	blvc	bc34a0 <_stack+0xb434a0>
    209c:	00000001 	andeq	r0, r0, r1
    20a0:	006b5f0e 	rsbeq	r5, fp, lr, lsl #30
    20a4:	00303005 	eorseq	r3, r0, r5
    20a8:	0c040000 	stceq	0, cr0, [r4], {-0}
    20ac:	000003bc 			; <UNDEFINED> instruction: 0x000003bc
    20b0:	00303005 	eorseq	r3, r0, r5
    20b4:	0c080000 	stceq	0, cr0, [r8], {-0}
    20b8:	00000502 	andeq	r0, r0, r2, lsl #10
    20bc:	00303005 	eorseq	r3, r0, r5
    20c0:	0c0c0000 	stceq	0, cr0, [ip], {-0}
    20c4:	00000339 	andeq	r0, r0, r9, lsr r3
    20c8:	00303005 	eorseq	r3, r0, r5
    20cc:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
    20d0:	0500785f 	streq	r7, [r0, #-2143]	; 0x85f
    20d4:	00018131 	andeq	r8, r1, r1, lsr r1
    20d8:	0f001400 	svceq	0x00001400
    20dc:	00012804 	andeq	r2, r1, r4, lsl #16
    20e0:	011d0900 	tsteq	sp, r0, lsl #18
    20e4:	01910000 	orrseq	r0, r1, r0
    20e8:	df0a0000 	svcle	0x000a0000
    20ec:	00000000 	andeq	r0, r0, r0
    20f0:	033e0d00 	teqeq	lr, #0, 26
    20f4:	05240000 	streq	r0, [r4, #-0]!
    20f8:	00020a35 	andeq	r0, r2, r5, lsr sl
    20fc:	01e40c00 	mvneq	r0, r0, lsl #24
    2100:	37050000 	strcc	r0, [r5, -r0]
    2104:	00000030 	andeq	r0, r0, r0, lsr r0
    2108:	01390c00 	teqeq	r9, r0, lsl #24
    210c:	38050000 	stmdacc	r5, {}	; <UNPREDICTABLE>
    2110:	00000030 	andeq	r0, r0, r0, lsr r0
    2114:	01ed0c04 	mvneq	r0, r4, lsl #24
    2118:	39050000 	stmdbcc	r5, {}	; <UNPREDICTABLE>
    211c:	00000030 	andeq	r0, r0, r0, lsr r0
    2120:	00c30c08 	sbceq	r0, r3, r8, lsl #24
    2124:	3a050000 	bcc	14212c <_stack+0xc212c>
    2128:	00000030 	andeq	r0, r0, r0, lsr r0
    212c:	04cb0c0c 	strbeq	r0, [fp], #3084	; 0xc0c
    2130:	3b050000 	blcc	142138 <_stack+0xc2138>
    2134:	00000030 	andeq	r0, r0, r0, lsr r0
    2138:	03c40c10 	biceq	r0, r4, #16, 24	; 0x1000
    213c:	3c050000 	stccc	0, cr0, [r5], {-0}
    2140:	00000030 	andeq	r0, r0, r0, lsr r0
    2144:	016d0c14 	cmneq	sp, r4, lsl ip
    2148:	3d050000 	stccc	0, cr0, [r5, #-0]
    214c:	00000030 	andeq	r0, r0, r0, lsr r0
    2150:	04ab0c18 	strteq	r0, [fp], #3096	; 0xc18
    2154:	3e050000 	cdpcc	0, 0, cr0, cr5, cr0, {0}
    2158:	00000030 	andeq	r0, r0, r0, lsr r0
    215c:	01990c1c 	orrseq	r0, r9, ip, lsl ip
    2160:	3f050000 	svccc	0x00050000
    2164:	00000030 	andeq	r0, r0, r0, lsr r0
    2168:	49100020 	ldmdbmi	r0, {r5}
    216c:	08000002 	stmdaeq	r0, {r1}
    2170:	4a480501 	bmi	120357c <_stack+0x118357c>
    2174:	0c000002 	stceq	0, cr0, [r0], {2}
    2178:	00000185 	andeq	r0, r0, r5, lsl #3
    217c:	024a4905 	subeq	r4, sl, #81920	; 0x14000
    2180:	0c000000 	stceq	0, cr0, [r0], {-0}
    2184:	000004f1 	strdeq	r0, [r0], -r1
    2188:	024a4a05 	subeq	r4, sl, #20480	; 0x5000
    218c:	11800000 	orrne	r0, r0, r0
    2190:	000001b6 			; <UNDEFINED> instruction: 0x000001b6
    2194:	011d4c05 	tsteq	sp, r5, lsl #24
    2198:	01000000 	mrseq	r0, (UNDEF: 0)
    219c:	00038011 	andeq	r8, r3, r1, lsl r0
    21a0:	1d4f0500 	cfstr64ne	mvdx0, [pc, #-0]	; 21a8 <CPSR_IRQ_INHIBIT+0x2128>
    21a4:	04000001 	streq	r0, [r0], #-1
    21a8:	49090001 	stmdbmi	r9, {r0}
    21ac:	5a000000 	bpl	21b4 <CPSR_IRQ_INHIBIT+0x2134>
    21b0:	0a000002 	beq	21c0 <CPSR_IRQ_INHIBIT+0x2140>
    21b4:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    21b8:	eb10001f 	bl	40223c <_stack+0x38223c>
    21bc:	90000000 	andls	r0, r0, r0
    21c0:	985b0501 	ldmdals	fp, {r0, r8, sl}^
    21c4:	0c000002 	stceq	0, cr0, [r0], {2}
    21c8:	0000050d 	andeq	r0, r0, sp, lsl #10
    21cc:	02985c05 	addseq	r5, r8, #1280	; 0x500
    21d0:	0c000000 	stceq	0, cr0, [r0], {-0}
    21d4:	000004de 	ldrdeq	r0, [r0], -lr
    21d8:	00305d05 	eorseq	r5, r0, r5, lsl #26
    21dc:	0c040000 	stceq	0, cr0, [r4], {-0}
    21e0:	0000015f 	andeq	r0, r0, pc, asr r1
    21e4:	029e5f05 	addseq	r5, lr, #5, 30
    21e8:	0c080000 	stceq	0, cr0, [r8], {-0}
    21ec:	00000249 	andeq	r0, r0, r9, asr #4
    21f0:	020a6005 	andeq	r6, sl, #5
    21f4:	00880000 	addeq	r0, r8, r0
    21f8:	025a040f 	subseq	r0, sl, #251658240	; 0xf000000
    21fc:	ae090000 	cdpge	0, 0, cr0, cr9, cr0, {0}
    2200:	ae000002 	cdpge	0, 0, cr0, cr0, cr2, {0}
    2204:	0a000002 	beq	2214 <CPSR_IRQ_INHIBIT+0x2194>
    2208:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    220c:	040f001f 	streq	r0, [pc], #-31	; 2214 <CPSR_IRQ_INHIBIT+0x2194>
    2210:	000002b4 			; <UNDEFINED> instruction: 0x000002b4
    2214:	00500d12 	subseq	r0, r0, r2, lsl sp
    2218:	05080000 	streq	r0, [r8, #-0]
    221c:	0002da73 	andeq	sp, r2, r3, ror sl
    2220:	07c10c00 	strbeq	r0, [r1, r0, lsl #24]
    2224:	74050000 	strvc	r0, [r5], #-0
    2228:	000002da 	ldrdeq	r0, [r0], -sl
    222c:	087b0c00 	ldmdaeq	fp!, {sl, fp}^
    2230:	75050000 	strvc	r0, [r5, #-0]
    2234:	00000030 	andeq	r0, r0, r0, lsr r0
    2238:	040f0004 	streq	r0, [pc], #-4	; 2240 <CPSR_IRQ_INHIBIT+0x21c0>
    223c:	00000052 	andeq	r0, r0, r2, asr r0
    2240:	00054c0d 	andeq	r4, r5, sp, lsl #24
    2244:	b3056800 	movwlt	r6, #22528	; 0x5800
    2248:	0000040a 	andeq	r0, r0, sl, lsl #8
    224c:	00705f0e 	rsbseq	r5, r0, lr, lsl #30
    2250:	02dab405 	sbcseq	fp, sl, #83886080	; 0x5000000
    2254:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    2258:	0500725f 	streq	r7, [r0, #-607]	; 0x25f
    225c:	000030b5 	strheq	r3, [r0], -r5
    2260:	5f0e0400 	svcpl	0x000e0400
    2264:	b6050077 			; <UNDEFINED> instruction: 0xb6050077
    2268:	00000030 	andeq	r0, r0, r0, lsr r0
    226c:	009e0c08 	addseq	r0, lr, r8, lsl #24
    2270:	b7050000 	strlt	r0, [r5, -r0]
    2274:	00000059 	andeq	r0, r0, r9, asr r0
    2278:	03170c0c 	tsteq	r7, #12, 24	; 0xc00
    227c:	b8050000 	stmdalt	r5, {}	; <UNPREDICTABLE>
    2280:	00000059 	andeq	r0, r0, r9, asr r0
    2284:	625f0e0e 	subsvs	r0, pc, #14, 28	; 0xe0
    2288:	b9050066 	stmdblt	r5, {r1, r2, r5, r6}
    228c:	000002b5 			; <UNDEFINED> instruction: 0x000002b5
    2290:	00370c10 	eorseq	r0, r7, r0, lsl ip
    2294:	ba050000 	blt	14229c <_stack+0xc229c>
    2298:	00000030 	andeq	r0, r0, r0, lsr r0
    229c:	02bb0c18 	adcseq	r0, fp, #24, 24	; 0x1800
    22a0:	c1050000 	mrsgt	r0, (UNDEF: 5)
    22a4:	00000049 	andeq	r0, r0, r9, asr #32
    22a8:	02050c1c 	andeq	r0, r5, #28, 24	; 0x1c00
    22ac:	c3050000 	movwgt	r0, #20480	; 0x5000
    22b0:	0000056d 	andeq	r0, r0, sp, ror #10
    22b4:	00a50c20 	adceq	r0, r5, r0, lsr #24
    22b8:	c5050000 	strgt	r0, [r5, #-0]
    22bc:	0000059c 	muleq	r0, ip, r5
    22c0:	04bd0c24 	ldrteq	r0, [sp], #3108	; 0xc24
    22c4:	c8050000 	stmdagt	r5, {}	; <UNPREDICTABLE>
    22c8:	000005c0 	andeq	r0, r0, r0, asr #11
    22cc:	01c70c28 	biceq	r0, r7, r8, lsr #24
    22d0:	c9050000 	stmdbgt	r5, {}	; <UNPREDICTABLE>
    22d4:	000005da 	ldrdeq	r0, [r0], -sl
    22d8:	755f0e2c 	ldrbvc	r0, [pc, #-3628]	; 14b4 <CPSR_IRQ_INHIBIT+0x1434>
    22dc:	cc050062 	stcgt	0, cr0, [r5], {98}	; 0x62
    22e0:	000002b5 			; <UNDEFINED> instruction: 0x000002b5
    22e4:	755f0e30 	ldrbvc	r0, [pc, #-3632]	; 14bc <CPSR_IRQ_INHIBIT+0x143c>
    22e8:	cd050070 	stcgt	0, cr0, [r5, #-448]	; 0xfffffe40
    22ec:	000002da 	ldrdeq	r0, [r0], -sl
    22f0:	755f0e38 	ldrbvc	r0, [pc, #-3640]	; 14c0 <CPSR_IRQ_INHIBIT+0x1440>
    22f4:	ce050072 	mcrgt	0, 0, r0, cr5, cr2, {3}
    22f8:	00000030 	andeq	r0, r0, r0, lsr r0
    22fc:	05390c3c 	ldreq	r0, [r9, #-3132]!	; 0xc3c
    2300:	d1050000 	mrsle	r0, (UNDEF: 5)
    2304:	000005e0 	andeq	r0, r0, r0, ror #11
    2308:	01060c40 	tsteq	r6, r0, asr #24
    230c:	d2050000 	andle	r0, r5, #0
    2310:	000005f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    2314:	6c5f0e43 	mrrcvs	14, 4, r0, pc, cr3	; <UNPREDICTABLE>
    2318:	d5050062 	strle	r0, [r5, #-98]	; 0x62
    231c:	000002b5 			; <UNDEFINED> instruction: 0x000002b5
    2320:	01ad0c44 			; <UNDEFINED> instruction: 0x01ad0c44
    2324:	d8050000 	stmdale	r5, {}	; <UNPREDICTABLE>
    2328:	00000030 	andeq	r0, r0, r0, lsr r0
    232c:	00740c4c 	rsbseq	r0, r4, ip, asr #24
    2330:	d9050000 	stmdble	r5, {}	; <UNPREDICTABLE>
    2334:	0000008e 	andeq	r0, r0, lr, lsl #1
    2338:	07d40c50 			; <UNDEFINED> instruction: 0x07d40c50
    233c:	dc050000 	stcle	0, cr0, [r5], {-0}
    2340:	00000428 	andeq	r0, r0, r8, lsr #8
    2344:	06b00c54 	ssateq	r0, #17, r4, asr #24
    2348:	e0050000 	and	r0, r5, r0
    234c:	00000112 	andeq	r0, r0, r2, lsl r1
    2350:	01640c58 	cmneq	r4, r8, asr ip
    2354:	e2050000 	and	r0, r5, #0
    2358:	00000107 	andeq	r0, r0, r7, lsl #2
    235c:	000b0c5c 	andeq	r0, fp, ip, asr ip
    2360:	e3050000 	movw	r0, #20480	; 0x5000
    2364:	00000030 	andeq	r0, r0, r0, lsr r0
    2368:	30130064 	andscc	r0, r3, r4, rrx
    236c:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
    2370:	14000004 	strne	r0, [r0], #-4
    2374:	00000428 	andeq	r0, r0, r8, lsr #8
    2378:	00004914 	andeq	r4, r0, r4, lsl r9
    237c:	05601400 	strbeq	r1, [r0, #-1024]!	; 0x400
    2380:	30140000 	andscc	r0, r4, r0
    2384:	00000000 	andeq	r0, r0, r0
    2388:	042e040f 	strteq	r0, [lr], #-1039	; 0x40f
    238c:	a2150000 	andsge	r0, r5, #0
    2390:	28000003 	stmdacs	r0, {r0, r1}
    2394:	02390504 	eorseq	r0, r9, #4, 10	; 0x1000000
    2398:	00000560 	andeq	r0, r0, r0, ror #10
    239c:	00023a16 	andeq	r3, r2, r6, lsl sl
    23a0:	023b0500 	eorseq	r0, fp, #0, 10
    23a4:	00000030 	andeq	r0, r0, r0, lsr r0
    23a8:	05131600 	ldreq	r1, [r3, #-1536]	; 0x600
    23ac:	40050000 	andmi	r0, r5, r0
    23b0:	00064702 	andeq	r4, r6, r2, lsl #14
    23b4:	e3160400 	tst	r6, #0, 8
    23b8:	05000000 	streq	r0, [r0, #-0]
    23bc:	06470240 	strbeq	r0, [r7], -r0, asr #4
    23c0:	16080000 	strne	r0, [r8], -r0
    23c4:	00000212 	andeq	r0, r0, r2, lsl r2
    23c8:	47024005 	strmi	r4, [r2, -r5]
    23cc:	0c000006 	stceq	0, cr0, [r0], {6}
    23d0:	0004d916 	andeq	sp, r4, r6, lsl r9
    23d4:	02420500 	subeq	r0, r2, #0, 10
    23d8:	00000030 	andeq	r0, r0, r0, lsr r0
    23dc:	00f31610 	rscseq	r1, r3, r0, lsl r6
    23e0:	43050000 	movwmi	r0, #20480	; 0x5000
    23e4:	00082902 	andeq	r2, r8, r2, lsl #18
    23e8:	6e161400 	cfmulsvs	mvf1, mvf6, mvf0
    23ec:	05000003 	streq	r0, [r0, #-3]
    23f0:	00300245 	eorseq	r0, r0, r5, asr #4
    23f4:	16300000 	ldrtne	r0, [r0], -r0
    23f8:	0000051a 	andeq	r0, r0, sl, lsl r5
    23fc:	91024605 	tstls	r2, r5, lsl #12
    2400:	34000005 	strcc	r0, [r0], #-5
    2404:	00000016 	andeq	r0, r0, r6, lsl r0
    2408:	02480500 	subeq	r0, r8, #0, 10
    240c:	00000030 	andeq	r0, r0, r0, lsr r0
    2410:	03881638 	orreq	r1, r8, #56, 12	; 0x3800000
    2414:	4a050000 	bmi	14241c <_stack+0xc241c>
    2418:	00084402 	andeq	r4, r8, r2, lsl #8
    241c:	c3163c00 	tstgt	r6, #0, 24
    2420:	05000004 	streq	r0, [r0, #-4]
    2424:	017b024d 	cmneq	fp, sp, asr #4
    2428:	16400000 	strbne	r0, [r0], -r0
    242c:	00000061 	andeq	r0, r0, r1, rrx
    2430:	30024e05 	andcc	r4, r2, r5, lsl #28
    2434:	44000000 	strmi	r0, [r0], #-0
    2438:	0004fd16 	andeq	pc, r4, r6, lsl sp	; <UNPREDICTABLE>
    243c:	024f0500 	subeq	r0, pc, #0, 10
    2440:	0000017b 	andeq	r0, r0, fp, ror r1
    2444:	01551648 	cmpeq	r5, r8, asr #12
    2448:	50050000 	andpl	r0, r5, r0
    244c:	00084a02 	andeq	r4, r8, r2, lsl #20
    2450:	fe164c00 	cdp2	12, 1, cr4, cr6, cr0, {0}
    2454:	05000000 	streq	r0, [r0, #-0]
    2458:	00300253 	eorseq	r0, r0, r3, asr r2
    245c:	16500000 	ldrbne	r0, [r0], -r0
    2460:	000002b3 			; <UNDEFINED> instruction: 0x000002b3
    2464:	60025405 	andvs	r5, r2, r5, lsl #8
    2468:	54000005 	strpl	r0, [r0], #-5
    246c:	00055416 	andeq	r5, r5, r6, lsl r4
    2470:	02770500 	rsbseq	r0, r7, #0, 10
    2474:	00000807 	andeq	r0, r0, r7, lsl #16
    2478:	00eb1758 	rsceq	r1, fp, r8, asr r7
    247c:	7b050000 	blvc	142484 <_stack+0xc2484>
    2480:	00029802 	andeq	r9, r2, r2, lsl #16
    2484:	17014800 	strne	r4, [r1, -r0, lsl #16]
    2488:	000001a4 	andeq	r0, r0, r4, lsr #3
    248c:	5a027c05 	bpl	a14a8 <_stack+0x214a8>
    2490:	4c000002 	stcmi	0, cr0, [r0], {2}
    2494:	01421701 	cmpeq	r2, r1, lsl #14
    2498:	80050000 	andhi	r0, r5, r0
    249c:	00085b02 	andeq	r5, r8, r2, lsl #22
    24a0:	1702dc00 	strne	sp, [r2, -r0, lsl #24]
    24a4:	00000241 	andeq	r0, r0, r1, asr #4
    24a8:	0c028505 	cfstr32eq	mvfx8, [r2], {5}
    24ac:	e0000006 	and	r0, r0, r6
    24b0:	007c1702 	rsbseq	r1, ip, r2, lsl #14
    24b4:	86050000 	strhi	r0, [r5], -r0
    24b8:	00086702 	andeq	r6, r8, r2, lsl #14
    24bc:	0002ec00 	andeq	lr, r2, r0, lsl #24
    24c0:	0566040f 	strbeq	r0, [r6, #-1039]!	; 0x40f
    24c4:	01040000 	mrseq	r0, (UNDEF: 4)
    24c8:	00020008 	andeq	r0, r2, r8
    24cc:	0a040f00 	beq	1060d4 <_stack+0x860d4>
    24d0:	13000004 	movwne	r0, #4
    24d4:	00000030 	andeq	r0, r0, r0, lsr r0
    24d8:	00000591 	muleq	r0, r1, r5
    24dc:	00042814 	andeq	r2, r4, r4, lsl r8
    24e0:	00491400 	subeq	r1, r9, r0, lsl #8
    24e4:	91140000 	tstls	r4, r0
    24e8:	14000005 	strne	r0, [r0], #-5
    24ec:	00000030 	andeq	r0, r0, r0, lsr r0
    24f0:	97040f00 	strls	r0, [r4, -r0, lsl #30]
    24f4:	18000005 	stmdane	r0, {r0, r2}
    24f8:	00000566 	andeq	r0, r0, r6, ror #10
    24fc:	0573040f 	ldrbeq	r0, [r3, #-1039]!	; 0x40f
    2500:	99130000 	ldmdbls	r3, {}	; <UNPREDICTABLE>
    2504:	c0000000 	andgt	r0, r0, r0
    2508:	14000005 	strne	r0, [r0], #-5
    250c:	00000428 	andeq	r0, r0, r8, lsr #8
    2510:	00004914 	andeq	r4, r0, r4, lsl r9
    2514:	00991400 	addseq	r1, r9, r0, lsl #8
    2518:	30140000 	andscc	r0, r4, r0
    251c:	00000000 	andeq	r0, r0, r0
    2520:	05a2040f 	streq	r0, [r2, #1039]!	; 0x40f
    2524:	30130000 	andscc	r0, r3, r0
    2528:	da000000 	ble	2530 <CPSR_IRQ_INHIBIT+0x24b0>
    252c:	14000005 	strne	r0, [r0], #-5
    2530:	00000428 	andeq	r0, r0, r8, lsr #8
    2534:	00004914 	andeq	r4, r0, r4, lsl r9
    2538:	040f0000 	streq	r0, [pc], #-0	; 2540 <CPSR_IRQ_INHIBIT+0x24c0>
    253c:	000005c6 	andeq	r0, r0, r6, asr #11
    2540:	00005209 	andeq	r5, r0, r9, lsl #4
    2544:	0005f000 	andeq	pc, r5, r0
    2548:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    254c:	00020000 	andeq	r0, r2, r0
    2550:	00005209 	andeq	r5, r0, r9, lsl #4
    2554:	00060000 	andeq	r0, r6, r0
    2558:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    255c:	00000000 	andeq	r0, r0, r0
    2560:	00012506 	andeq	r2, r1, r6, lsl #10
    2564:	011d0500 	tsteq	sp, r0, lsl #10
    2568:	000002e0 	andeq	r0, r0, r0, ror #5
    256c:	0001de19 	andeq	sp, r1, r9, lsl lr
    2570:	21050c00 	tstcs	r5, r0, lsl #24
    2574:	00064101 	andeq	r4, r6, r1, lsl #2
    2578:	050d1600 	streq	r1, [sp, #-1536]	; 0x600
    257c:	23050000 	movwcs	r0, #20480	; 0x5000
    2580:	00064101 	andeq	r4, r6, r1, lsl #2
    2584:	1e160000 	cdpne	0, 1, cr0, cr6, cr0, {0}
    2588:	05000001 	streq	r0, [r0, #-1]
    258c:	00300124 	eorseq	r0, r0, r4, lsr #2
    2590:	16040000 	strne	r0, [r4], -r0
    2594:	0000018d 	andeq	r0, r0, sp, lsl #3
    2598:	47012505 	strmi	r2, [r1, -r5, lsl #10]
    259c:	08000006 	stmdaeq	r0, {r1, r2}
    25a0:	0c040f00 	stceq	15, cr0, [r4], {-0}
    25a4:	0f000006 	svceq	0x00000006
    25a8:	00060004 	andeq	r0, r6, r4
    25ac:	04a31900 	strteq	r1, [r3], #2304	; 0x900
    25b0:	050e0000 	streq	r0, [lr, #-0]
    25b4:	0682013d 			; <UNDEFINED> instruction: 0x0682013d
    25b8:	9d160000 	ldcls	0, cr0, [r6, #-0]
    25bc:	05000004 	streq	r0, [r0, #-4]
    25c0:	0682013e 			; <UNDEFINED> instruction: 0x0682013e
    25c4:	16000000 	strne	r0, [r0], -r0
    25c8:	00000193 	muleq	r0, r3, r1
    25cc:	82013f05 	andhi	r3, r1, #5, 30
    25d0:	06000006 	streq	r0, [r0], -r6
    25d4:	0004d416 	andeq	sp, r4, r6, lsl r4
    25d8:	01400500 	cmpeq	r0, r0, lsl #10
    25dc:	00000060 	andeq	r0, r0, r0, rrx
    25e0:	6009000c 	andvs	r0, r9, ip
    25e4:	92000000 	andls	r0, r0, #0
    25e8:	0a000006 	beq	2608 <CPSR_IRQ_INHIBIT+0x2588>
    25ec:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    25f0:	d01a0002 	andsle	r0, sl, r2
    25f4:	93025805 	movwls	r5, #10245	; 0x2805
    25f8:	16000007 	strne	r0, [r0], -r7
    25fc:	0000032c 	andeq	r0, r0, ip, lsr #6
    2600:	42025a05 	andmi	r5, r2, #20480	; 0x5000
    2604:	00000000 	andeq	r0, r0, r0
    2608:	00049016 	andeq	r9, r4, r6, lsl r0
    260c:	025b0500 	subseq	r0, fp, #0, 10
    2610:	00000560 	andeq	r0, r0, r0, ror #10
    2614:	053f1604 	ldreq	r1, [pc, #-1540]!	; 2018 <CPSR_IRQ_INHIBIT+0x1f98>
    2618:	5c050000 	stcpl	0, cr0, [r5], {-0}
    261c:	00079302 	andeq	r9, r7, r2, lsl #6
    2620:	ac160800 	ldcge	8, cr0, [r6], {-0}
    2624:	05000000 	streq	r0, [r0, #-0]
    2628:	0191025d 	orrseq	r0, r1, sp, asr r2
    262c:	16240000 	strtne	r0, [r4], -r0
    2630:	0000031d 	andeq	r0, r0, sp, lsl r3
    2634:	30025e05 	andcc	r5, r2, r5, lsl #28
    2638:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
    263c:	00050816 	andeq	r0, r5, r6, lsl r8
    2640:	025f0500 	subseq	r0, pc, #0, 10
    2644:	0000007c 	andeq	r0, r0, ip, ror r0
    2648:	00de1650 	sbcseq	r1, lr, r0, asr r6
    264c:	60050000 	andvs	r0, r5, r0
    2650:	00064d02 	andeq	r4, r6, r2, lsl #26
    2654:	13165800 	tstne	r6, #0, 16
    2658:	05000000 	streq	r0, [r0, #-0]
    265c:	01070261 	tsteq	r7, r1, ror #4
    2660:	16680000 	strbtne	r0, [r8], -r0
    2664:	0000034b 	andeq	r0, r0, fp, asr #6
    2668:	07026205 	streq	r6, [r2, -r5, lsl #4]
    266c:	70000001 	andvc	r0, r0, r1
    2670:	0004e316 	andeq	lr, r4, r6, lsl r3
    2674:	02630500 	rsbeq	r0, r3, #0, 10
    2678:	00000107 	andeq	r0, r0, r7, lsl #2
    267c:	00201678 	eoreq	r1, r0, r8, ror r6
    2680:	64050000 	strvs	r0, [r5], #-0
    2684:	0007a302 	andeq	sl, r7, r2, lsl #6
    2688:	81168000 	tsthi	r6, r0
    268c:	05000000 	streq	r0, [r0, #-0]
    2690:	07b30265 	ldreq	r0, [r3, r5, ror #4]!
    2694:	16880000 	strne	r0, [r8], r0
    2698:	0000012c 	andeq	r0, r0, ip, lsr #2
    269c:	30026605 	andcc	r6, r2, r5, lsl #12
    26a0:	a0000000 	andge	r0, r0, r0
    26a4:	00036016 	andeq	r6, r3, r6, lsl r0
    26a8:	02670500 	rsbeq	r0, r7, #0, 10
    26ac:	00000107 	andeq	r0, r0, r7, lsl #2
    26b0:	028916a4 	addeq	r1, r9, #164, 12	; 0xa400000
    26b4:	68050000 	stmdavs	r5, {}	; <UNPREDICTABLE>
    26b8:	00010702 	andeq	r0, r1, r2, lsl #14
    26bc:	cd16ac00 	ldcgt	12, cr10, [r6, #-0]
    26c0:	05000000 	streq	r0, [r0, #-0]
    26c4:	01070269 	tsteq	r7, r9, ror #4
    26c8:	16b40000 	ldrtne	r0, [r4], r0
    26cc:	0000052a 	andeq	r0, r0, sl, lsr #10
    26d0:	07026a05 	streq	r6, [r2, -r5, lsl #20]
    26d4:	bc000001 	stclt	0, cr0, [r0], {1}
    26d8:	00008d16 	andeq	r8, r0, r6, lsl sp
    26dc:	026b0500 	rsbeq	r0, fp, #0, 10
    26e0:	00000107 	andeq	r0, r0, r7, lsl #2
    26e4:	023816c4 	eorseq	r1, r8, #196, 12	; 0xc400000
    26e8:	6c050000 	stcvs	0, cr0, [r5], {-0}
    26ec:	00003002 	andeq	r3, r0, r2
    26f0:	0900cc00 	stmdbeq	r0, {sl, fp, lr, pc}
    26f4:	00000566 	andeq	r0, r0, r6, ror #10
    26f8:	000007a3 	andeq	r0, r0, r3, lsr #15
    26fc:	0000df0a 	andeq	sp, r0, sl, lsl #30
    2700:	09001900 	stmdbeq	r0, {r8, fp, ip}
    2704:	00000566 	andeq	r0, r0, r6, ror #10
    2708:	000007b3 			; <UNDEFINED> instruction: 0x000007b3
    270c:	0000df0a 	andeq	sp, r0, sl, lsl #30
    2710:	09000700 	stmdbeq	r0, {r8, r9, sl}
    2714:	00000566 	andeq	r0, r0, r6, ror #10
    2718:	000007c3 	andeq	r0, r0, r3, asr #15
    271c:	0000df0a 	andeq	sp, r0, sl, lsl #30
    2720:	1a001700 	bne	8328 <undefined_instruction_vector+0x8>
    2724:	027105f0 	rsbseq	r0, r1, #240, 10	; 0x3c000000
    2728:	000007e7 	andeq	r0, r0, r7, ror #15
    272c:	00020b16 	andeq	r0, r2, r6, lsl fp
    2730:	02740500 	rsbseq	r0, r4, #0, 10
    2734:	000007e7 	andeq	r0, r0, r7, ror #15
    2738:	014c1600 	cmpeq	ip, r0, lsl #12
    273c:	75050000 	strvc	r0, [r5, #-0]
    2740:	0007f702 	andeq	pc, r7, r2, lsl #14
    2744:	09007800 	stmdbeq	r0, {fp, ip, sp, lr}
    2748:	000002da 	ldrdeq	r0, [r0], -sl
    274c:	000007f7 	strdeq	r0, [r0], -r7
    2750:	0000df0a 	andeq	sp, r0, sl, lsl #30
    2754:	09001d00 	stmdbeq	r0, {r8, sl, fp, ip}
    2758:	00000042 	andeq	r0, r0, r2, asr #32
    275c:	00000807 	andeq	r0, r0, r7, lsl #16
    2760:	0000df0a 	andeq	sp, r0, sl, lsl #30
    2764:	1b001d00 	blne	9b6c <__bss_end__+0x344>
    2768:	025605f0 	subseq	r0, r6, #240, 10	; 0x3c000000
    276c:	00000829 	andeq	r0, r0, r9, lsr #16
    2770:	0003a21c 	andeq	sl, r3, ip, lsl r2
    2774:	026d0500 	rsbeq	r0, sp, #0, 10
    2778:	00000692 	muleq	r0, r2, r6
    277c:	0003431c 	andeq	r4, r3, ip, lsl r3
    2780:	02760500 	rsbseq	r0, r6, #0, 10
    2784:	000007c3 	andeq	r0, r0, r3, asr #15
    2788:	05660900 	strbeq	r0, [r6, #-2304]!	; 0x900
    278c:	08390000 	ldmdaeq	r9!, {}	; <UNPREDICTABLE>
    2790:	df0a0000 	svcle	0x000a0000
    2794:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    2798:	08441d00 	stmdaeq	r4, {r8, sl, fp, ip}^
    279c:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
    27a0:	00000004 	andeq	r0, r0, r4
    27a4:	0839040f 	ldmdaeq	r9!, {r0, r1, r2, r3, sl}
    27a8:	040f0000 	streq	r0, [pc], #-0	; 27b0 <CPSR_IRQ_INHIBIT+0x2730>
    27ac:	0000017b 	andeq	r0, r0, fp, ror r1
    27b0:	00085b1d 	andeq	r5, r8, sp, lsl fp
    27b4:	00301400 	eorseq	r1, r0, r0, lsl #8
    27b8:	0f000000 	svceq	0x00000000
    27bc:	00086104 	andeq	r6, r8, r4, lsl #2
    27c0:	50040f00 	andpl	r0, r4, r0, lsl #30
    27c4:	09000008 	stmdbeq	r0, {r3}
    27c8:	00000600 	andeq	r0, r0, r0, lsl #12
    27cc:	00000877 	andeq	r0, r0, r7, ror r8
    27d0:	0000df0a 	andeq	sp, r0, sl, lsl #30
    27d4:	19000200 	stmdbne	r0, {r9}
    27d8:	00000727 	andeq	r0, r0, r7, lsr #14
    27dc:	02d80128 	sbcseq	r0, r8, #40, 2
    27e0:	00000907 	andeq	r0, r0, r7, lsl #18
    27e4:	00061e16 	andeq	r1, r6, r6, lsl lr
    27e8:	02d90100 	sbcseq	r0, r9, #0, 2
    27ec:	00000030 	andeq	r0, r0, r0, lsr r0
    27f0:	069a1600 	ldreq	r1, [sl], r0, lsl #12
    27f4:	da010000 	ble	427fc <__bss_end__+0x38fd4>
    27f8:	00003002 	andeq	r3, r0, r2
    27fc:	ca160400 	bgt	583804 <_stack+0x503804>
    2800:	01000006 	tsteq	r0, r6
    2804:	003002db 	ldrsbteq	r0, [r0], -fp
    2808:	16080000 	strne	r0, [r8], -r0
    280c:	00000618 	andeq	r0, r0, r8, lsl r6
    2810:	3002dc01 	andcc	sp, r2, r1, lsl #24
    2814:	0c000000 	stceq	0, cr0, [r0], {-0}
    2818:	0007c716 	andeq	ip, r7, r6, lsl r7
    281c:	02dd0100 	sbcseq	r0, sp, #0, 2
    2820:	00000030 	andeq	r0, r0, r0, lsr r0
    2824:	06f61610 	usateq	r1, #22, r0, lsl #12
    2828:	de010000 	cdple	0, 0, cr0, cr1, cr0, {0}
    282c:	00003002 	andeq	r3, r0, r2
    2830:	c9161400 	ldmdbgt	r6, {sl, ip}
    2834:	01000006 	tsteq	r0, r6
    2838:	003002df 	ldrsbteq	r0, [r0], -pc
    283c:	16180000 	ldrne	r0, [r8], -r0
    2840:	000006c0 	andeq	r0, r0, r0, asr #13
    2844:	3002e001 	andcc	lr, r2, r1
    2848:	1c000000 	stcne	0, cr0, [r0], {-0}
    284c:	00069916 	andeq	r9, r6, r6, lsl r9
    2850:	02e10100 	rsceq	r0, r1, #0, 2
    2854:	00000030 	andeq	r0, r0, r0, lsr r0
    2858:	07ab1620 	streq	r1, [fp, r0, lsr #12]!
    285c:	e2010000 	and	r0, r1, #0
    2860:	00003002 	andeq	r3, r0, r2
    2864:	19002400 	stmdbne	r0, {sl, sp}
    2868:	000006d1 	ldrdeq	r0, [r0], -r1
    286c:	04e90110 	strbteq	r0, [r9], #272	; 0x110
    2870:	00000947 	andeq	r0, r0, r7, asr #18
    2874:	0005fd16 	andeq	pc, r5, r6, lsl sp	; <UNPREDICTABLE>
    2878:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
    287c:	00000037 	andeq	r0, r0, r7, lsr r0
    2880:	087c1600 	ldmdaeq	ip!, {r9, sl, ip}^
    2884:	ec010000 	stc	0, cr0, [r1], {-0}
    2888:	00003704 	andeq	r3, r0, r4, lsl #14
    288c:	661e0400 	ldrvs	r0, [lr], -r0, lsl #8
    2890:	ed010064 	stc	0, cr0, [r1, #-400]	; 0xfffffe70
    2894:	00094704 	andeq	r4, r9, r4, lsl #14
    2898:	621e0800 	andsvs	r0, lr, #0, 16
    289c:	ee01006b 	cdp	0, 0, cr0, cr1, cr11, {3}
    28a0:	00094704 	andeq	r4, r9, r4, lsl #14
    28a4:	0f000c00 	svceq	0x00000c00
    28a8:	00090704 	andeq	r0, r9, r4, lsl #14
    28ac:	07a10600 	streq	r0, [r1, r0, lsl #12]!
    28b0:	f1010000 	setend	le
    28b4:	00094704 	andeq	r4, r9, r4, lsl #14
    28b8:	06340600 	ldrteq	r0, [r4], -r0, lsl #12
    28bc:	1d010000 	stcne	0, cr0, [r1, #-0]
    28c0:	00094706 	andeq	r4, r9, r6, lsl #14
    28c4:	08561f00 	ldmdaeq	r6, {r8, r9, sl, fp, ip}^
    28c8:	59010000 	stmdbpl	r1, {}	; <UNPREDICTABLE>
    28cc:	0a0e0108 	beq	382cf4 <_stack+0x302cf4>
    28d0:	4b200000 	blmi	8028d8 <_stack+0x7828d8>
    28d4:	01000007 	tsteq	r0, r7
    28d8:	04280859 	strteq	r0, [r8], #-2137	; 0x859
    28dc:	6e210000 	cdpvs	0, 2, cr0, cr1, cr0, {0}
    28e0:	59010062 	stmdbpl	r1, {r1, r5, r6}
    28e4:	00003708 	andeq	r3, r0, r8, lsl #14
    28e8:	72622200 	rsbvc	r2, r2, #0, 4
    28ec:	5e01006b 	cdppl	0, 0, cr0, cr1, cr11, {3}
    28f0:	00056008 	andeq	r6, r5, r8
    28f4:	08682300 	stmdaeq	r8!, {r8, r9, sp}^
    28f8:	5f010000 	svcpl	0x00010000
    28fc:	00003708 	andeq	r3, r0, r8, lsl #14
    2900:	09042300 	stmdbeq	r4, {r8, r9, sp}
    2904:	60010000 	andvs	r0, r1, r0
    2908:	00003708 	andeq	r3, r0, r8, lsl #14
    290c:	08e52300 	stmiaeq	r5!, {r8, r9, sp}^
    2910:	61010000 	mrsvs	r0, (UNDEF: 1)
    2914:	00003008 	andeq	r3, r0, r8
    2918:	063c2300 	ldrteq	r2, [ip], -r0, lsl #6
    291c:	62010000 	andvs	r0, r1, #0
    2920:	00056008 	andeq	r6, r5, r8
    2924:	08fb2300 	ldmeq	fp!, {r8, r9, sp}^
    2928:	63010000 	movwvs	r0, #4096	; 0x1000
    292c:	00003708 	andeq	r3, r0, r8, lsl #14
    2930:	08c52300 	stmiaeq	r5, {r8, r9, sp}^
    2934:	65010000 	strvs	r0, [r1, #-0]
    2938:	00094d08 	andeq	r4, r9, r8, lsl #26
    293c:	08f72300 	ldmeq	r7!, {r8, r9, sp}^
    2940:	66010000 	strvs	r0, [r1], -r0
    2944:	00003708 	andeq	r3, r0, r8, lsl #14
    2948:	083c2300 	ldmdaeq	ip!, {r8, r9, sp}
    294c:	67010000 	strvs	r0, [r1, -r0]
    2950:	00056008 	andeq	r6, r5, r8
    2954:	08772300 	ldmdaeq	r7!, {r8, r9, sp}^
    2958:	6b010000 	blvs	42960 <__bss_end__+0x39138>
    295c:	00003708 	andeq	r3, r0, r8, lsl #14
    2960:	07032300 	streq	r2, [r3, -r0, lsl #6]
    2964:	6c010000 	stcvs	0, cr0, [r1], {-0}
    2968:	00006e08 	andeq	r6, r0, r8, lsl #28
    296c:	b1240000 	teqlt	r4, r0
    2970:	01000008 	tsteq	r0, r8
    2974:	00490914 	subeq	r0, r9, r4, lsl r9
    2978:	89200000 	stmdbhi	r0!, {}	; <UNPREDICTABLE>
    297c:	05660000 	strbeq	r0, [r6, #-0]!
    2980:	9c010000 	stcls	0, cr0, [r1], {-0}
    2984:	00000c9c 	muleq	r0, ip, ip
    2988:	00074b25 	andeq	r4, r7, r5, lsr #22
    298c:	09140100 	ldmdbeq	r4, {r8}
    2990:	00000428 	andeq	r0, r0, r8, lsr #8
    2994:	000005b8 			; <UNDEFINED> instruction: 0x000005b8
    2998:	00082725 	andeq	r2, r8, r5, lsr #14
    299c:	09140100 	ldmdbeq	r4, {r8}
    29a0:	00000037 	andeq	r0, r0, r7, lsr r0
    29a4:	00000642 	andeq	r0, r0, r2, asr #12
    29a8:	00082026 	andeq	r2, r8, r6, lsr #32
    29ac:	091f0100 	ldmdbeq	pc, {r8}	; <UNPREDICTABLE>
    29b0:	0000094d 	andeq	r0, r0, sp, asr #18
    29b4:	00000663 	andeq	r0, r0, r3, ror #12
    29b8:	00084a26 	andeq	r4, r8, r6, lsr #20
    29bc:	09200100 	stmdbeq	r0!, {r8}
    29c0:	00000037 	andeq	r0, r0, r7, lsr r0
    29c4:	0000077a 	andeq	r0, r0, sl, ror r7
    29c8:	78646927 	stmdavc	r4!, {r0, r1, r2, r5, r8, fp, sp, lr}^
    29cc:	09210100 	stmdbeq	r1!, {r8}
    29d0:	00000030 	andeq	r0, r0, r0, lsr r0
    29d4:	000008dd 	ldrdeq	r0, [r0], -sp
    29d8:	6e696227 	cdpvs	2, 6, cr6, cr9, cr7, {1}
    29dc:	09220100 	stmdbeq	r2!, {r8}
    29e0:	00000959 	andeq	r0, r0, r9, asr r9
    29e4:	00000a0e 	andeq	r0, r0, lr, lsl #20
    29e8:	0008bb26 	andeq	fp, r8, r6, lsr #22
    29ec:	09230100 	stmdbeq	r3!, {r8}
    29f0:	0000094d 	andeq	r0, r0, sp, asr #18
    29f4:	00000a6e 	andeq	r0, r0, lr, ror #20
    29f8:	00082d26 	andeq	r2, r8, r6, lsr #26
    29fc:	09240100 	stmdbeq	r4!, {r8}
    2a00:	00000067 	andeq	r0, r0, r7, rrx
    2a04:	00000ad2 	ldrdeq	r0, [r0], -r2
    2a08:	00088126 	andeq	r8, r8, r6, lsr #2
    2a0c:	09250100 	stmdbeq	r5!, {r8}
    2a10:	00000030 	andeq	r0, r0, r0, lsr r0
    2a14:	00000d0c 	andeq	r0, r0, ip, lsl #26
    2a18:	00084426 	andeq	r4, r8, r6, lsr #8
    2a1c:	09260100 	stmdbeq	r6!, {r8}
    2a20:	0000006e 	andeq	r0, r0, lr, rrx
    2a24:	00000d48 	andeq	r0, r0, r8, asr #26
    2a28:	0008a826 	andeq	sl, r8, r6, lsr #16
    2a2c:	09270100 	stmdbeq	r7!, {r8}
    2a30:	00000030 	andeq	r0, r0, r0, lsr r0
    2a34:	00000da8 	andeq	r0, r0, r8, lsr #27
    2a38:	64776627 	ldrbtvs	r6, [r7], #-1575	; 0x627
    2a3c:	09280100 	stmdbeq	r8!, {r8}
    2a40:	0000094d 	andeq	r0, r0, sp, asr #18
    2a44:	00000de7 	andeq	r0, r0, r7, ror #27
    2a48:	6b636227 	blvs	18db2ec <_stack+0x185b2ec>
    2a4c:	09290100 	stmdbeq	r9!, {r8}
    2a50:	0000094d 	andeq	r0, r0, sp, asr #18
    2a54:	00000e3c 	andeq	r0, r0, ip, lsr lr
    2a58:	01007127 	tsteq	r0, r7, lsr #2
    2a5c:	0959092a 	ldmdbeq	r9, {r1, r3, r5, r8, fp}^
    2a60:	0e9c0000 	cdpeq	0, 9, cr0, cr12, cr0, {0}
    2a64:	6e270000 	cdpvs	0, 2, cr0, cr7, cr0, {0}
    2a68:	2c010062 	stccs	0, cr0, [r1], {98}	; 0x62
    2a6c:	00003709 	andeq	r3, r0, r9, lsl #14
    2a70:	000f1400 	andeq	r1, pc, r0, lsl #8
    2a74:	09652800 	stmdbeq	r5!, {fp, sp}^
    2a78:	8b0a0000 	blhi	282a80 <_stack+0x202a80>
    2a7c:	00580000 	subseq	r0, r8, r0
    2a80:	0f010000 	svceq	0x00010000
    2a84:	000be90a 	andeq	lr, fp, sl, lsl #18
    2a88:	097e2900 	ldmdbeq	lr!, {r8, fp, sp}^
    2a8c:	10ef0000 	rscne	r0, pc, r0
    2a90:	72290000 	eorvc	r0, r9, #0
    2a94:	23000009 	movwcs	r0, #9
    2a98:	2a000011 	bcs	2ae4 <CPSR_IRQ_INHIBIT+0x2a64>
    2a9c:	00000058 	andeq	r0, r0, r8, asr r0
    2aa0:	0009892b 	andeq	r8, r9, fp, lsr #18
    2aa4:	00115700 	andseq	r5, r1, r0, lsl #14
    2aa8:	09952b00 	ldmibeq	r5, {r8, r9, fp, sp}
    2aac:	11a10000 			; <UNDEFINED> instruction: 0x11a10000
    2ab0:	a12b0000 	teqge	fp, r0
    2ab4:	e1000009 	tst	r0, r9
    2ab8:	2b000011 	blcs	2b04 <CPSR_IRQ_INHIBIT+0x2a84>
    2abc:	000009ad 	andeq	r0, r0, sp, lsr #19
    2ac0:	0000122a 	andeq	r1, r0, sl, lsr #4
    2ac4:	0009b92b 	andeq	fp, r9, fp, lsr #18
    2ac8:	00126200 	andseq	r6, r2, r0, lsl #4
    2acc:	09c52b00 	stmibeq	r5, {r8, r9, fp, sp}^
    2ad0:	12750000 	rsbsne	r0, r5, #0
    2ad4:	d12b0000 	teqle	fp, r0
    2ad8:	a8000009 	stmdage	r0, {r0, r3}
    2adc:	2b000012 	blcs	2b2c <CPSR_IRQ_INHIBIT+0x2aac>
    2ae0:	000009dd 	ldrdeq	r0, [r0], -sp
    2ae4:	000012dc 	ldrdeq	r1, [r0], -ip
    2ae8:	0009e92b 	andeq	lr, r9, fp, lsr #18
    2aec:	00133600 	andseq	r3, r3, r0, lsl #12
    2af0:	09f52b00 	ldmibeq	r5!, {r8, r9, fp, sp}^
    2af4:	13890000 	orrne	r0, r9, #0
    2af8:	012b0000 	teqeq	fp, r0
    2afc:	bf00000a 	svclt	0x0000000a
    2b00:	2c000013 	stccs	0, cr0, [r0], {19}
    2b04:	00008b4a 	andeq	r8, r0, sl, asr #22
    2b08:	00000d2b 	andeq	r0, r0, fp, lsr #26
    2b0c:	00000bb7 			; <UNDEFINED> instruction: 0x00000bb7
    2b10:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    2b14:	2c000077 	stccs	0, cr0, [r0], {119}	; 0x77
    2b18:	00008bc2 	andeq	r8, r0, r2, asr #23
    2b1c:	00000d2b 	andeq	r0, r0, fp, lsr #26
    2b20:	00000bd1 	ldrdeq	r0, [r0], -r1
    2b24:	0251012d 	subseq	r0, r1, #1073741835	; 0x4000000b
    2b28:	012d007a 	teqeq	sp, sl, ror r0
    2b2c:	00770250 	rsbseq	r0, r7, r0, asr r2
    2b30:	8e582e00 	cdphi	14, 5, cr2, cr8, cr0, {0}
    2b34:	0d450000 	stcleq	0, cr0, [r5, #-0]
    2b38:	012d0000 	teqeq	sp, r0
    2b3c:	08750251 	ldmdaeq	r5!, {r0, r4, r6, r9}^
    2b40:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    2b44:	00000077 	andeq	r0, r0, r7, ror r0
    2b48:	89502c00 	ldmdbhi	r0, {sl, fp, sp}^
    2b4c:	0d5c0000 	ldcleq	0, cr0, [ip, #-0]
    2b50:	0bfd0000 	bleq	fff42b58 <_stack+0xffec2b58>
    2b54:	012d0000 	teqeq	sp, r0
    2b58:	00770250 	rsbseq	r0, r7, r0, asr r2
    2b5c:	89902c00 	ldmibhi	r0, {sl, fp, sp}
    2b60:	0d6e0000 	stcleq	0, cr0, [lr, #-0]
    2b64:	0c110000 	ldceq	0, cr0, [r1], {-0}
    2b68:	012d0000 	teqeq	sp, r0
    2b6c:	00770250 	rsbseq	r0, r7, r0, asr r2
    2b70:	8ab22c00 	bhi	fec8db78 <_stack+0xfec0db78>
    2b74:	0d6e0000 	stcleq	0, cr0, [lr, #-0]
    2b78:	0c260000 	stceq	0, cr0, [r6], #-0
    2b7c:	012d0000 	teqeq	sp, r0
    2b80:	01f30350 	mvnseq	r0, r0, asr r3
    2b84:	ec2c0050 	stc	0, cr0, [ip], #-320	; 0xfffffec0
    2b88:	6e00008a 	cdpvs	0, 0, cr0, cr0, cr10, {4}
    2b8c:	3a00000d 	bcc	2bc8 <CPSR_IRQ_INHIBIT+0x2b48>
    2b90:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    2b94:	77025001 	strvc	r5, [r2, -r1]
    2b98:	642c0000 	strtvs	r0, [ip], #-0
    2b9c:	6e00008c 	cdpvs	0, 0, cr0, cr0, cr12, {4}
    2ba0:	4e00000d 	cdpmi	0, 0, cr0, cr0, cr13, {0}
    2ba4:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    2ba8:	77025001 	strvc	r5, [r2, -r1]
    2bac:	7e2c0000 	cdpvc	0, 2, cr0, cr12, cr0, {0}
    2bb0:	6e00008c 	cdpvs	0, 0, cr0, cr0, cr12, {4}
    2bb4:	6200000d 	andvs	r0, r0, #13
    2bb8:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    2bbc:	77025001 	strvc	r5, [r2, -r1]
    2bc0:	a22c0000 	eorge	r0, ip, #0
    2bc4:	6e00008c 	cdpvs	0, 0, cr0, cr0, cr12, {4}
    2bc8:	7600000d 	strvc	r0, [r0], -sp
    2bcc:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    2bd0:	77025001 	strvc	r5, [r2, -r1]
    2bd4:	462c0000 	strtmi	r0, [ip], -r0
    2bd8:	6e00008d 	cdpvs	0, 0, cr0, cr0, cr13, {4}
    2bdc:	8b00000d 	blhi	2c18 <CPSR_IRQ_INHIBIT+0x2b98>
    2be0:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    2be4:	f3035001 	vhadd.u8	d5, d3, d1
    2be8:	2e005001 	cdpcs	0, 0, cr5, cr0, cr1, {0}
    2bec:	00008d88 	andeq	r8, r0, r8, lsl #27
    2bf0:	00000d6e 	andeq	r0, r0, lr, ror #26
    2bf4:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    2bf8:	00000077 	andeq	r0, r0, r7, ror r0
    2bfc:	00095909 	andeq	r5, r9, r9, lsl #18
    2c00:	000cad00 	andeq	sl, ip, r0, lsl #26
    2c04:	00df2f00 	sbcseq	r2, pc, r0, lsl #30
    2c08:	01010000 	mrseq	r0, (UNDEF: 1)
    2c0c:	07373000 	ldreq	r3, [r7, -r0]!
    2c10:	3d010000 	stccc	0, cr0, [r1, #-0]
    2c14:	000c9c06 	andeq	r9, ip, r6, lsl #24
    2c18:	d4030500 	strle	r0, [r3], #-1280	; 0x500
    2c1c:	30000093 	mulcc	r0, r3, r0
    2c20:	000006de 	ldrdeq	r0, [r0], -lr
    2c24:	6e06a801 	cdpvs	8, 0, cr10, cr6, cr1, {0}
    2c28:	05000000 	streq	r0, [r0, #-0]
    2c2c:	0097dc03 	addseq	sp, r7, r3, lsl #24
    2c30:	06073000 	streq	r3, [r7], -r0
    2c34:	a9010000 	stmdbge	r1, {}	; <UNPREDICTABLE>
    2c38:	00006e06 	andeq	r6, r0, r6, lsl #28
    2c3c:	f8030500 			; <UNDEFINED> instruction: 0xf8030500
    2c40:	30000097 	mulcc	r0, r7, r0
    2c44:	000007b4 			; <UNDEFINED> instruction: 0x000007b4
    2c48:	6006b001 	andvs	fp, r6, r1
    2c4c:	05000005 	streq	r0, [r0, #-5]
    2c50:	0097e003 	addseq	lr, r7, r3
    2c54:	08cd3000 	stmiaeq	sp, {ip, sp}^
    2c58:	b3010000 	movwlt	r0, #4096	; 0x1000
    2c5c:	00006e06 	andeq	r6, r0, r6, lsl #28
    2c60:	f4030500 	vst3.8	{d0,d2,d4}, [r3], r0
    2c64:	30000097 	mulcc	r0, r7, r0
    2c68:	00000891 	muleq	r0, r1, r8
    2c6c:	6e06b601 	cfmadd32vs	mvax0, mvfx11, mvfx6, mvfx1
    2c70:	05000000 	streq	r0, [r0, #-0]
    2c74:	0097f003 	addseq	pc, r7, r3
    2c78:	07163000 	ldreq	r3, [r6, -r0]
    2c7c:	b9010000 	stmdblt	r1, {}	; <UNPREDICTABLE>
    2c80:	00087706 	andeq	r7, r8, r6, lsl #14
    2c84:	fc030500 	stc2	5, cr0, [r3], {-0}
    2c88:	31000097 	swpcc	r0, r7, [r0]	; <UNPREDICTABLE>
    2c8c:	00000799 	muleq	r0, r9, r7
    2c90:	00499a06 	subeq	r9, r9, r6, lsl #20
    2c94:	0d450000 	stcleq	0, cr0, [r5, #-0]
    2c98:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
    2c9c:	14000004 	strne	r0, [r0], #-4
    2ca0:	00000025 	andeq	r0, r0, r5, lsr #32
    2ca4:	02983200 	addseq	r3, r8, #0, 4
    2ca8:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    2cac:	000d5c04 	andeq	r5, sp, r4, lsl #24
    2cb0:	04281400 	strteq	r1, [r8], #-1024	; 0x400
    2cb4:	49140000 	ldmdbmi	r4, {}	; <UNPREDICTABLE>
    2cb8:	00000000 	andeq	r0, r0, r0
    2cbc:	0006a832 	andeq	sl, r6, r2, lsr r8
    2cc0:	01480100 	mrseq	r0, (UNDEF: 88)
    2cc4:	00000d6e 	andeq	r0, r0, lr, ror #26
    2cc8:	00042814 	andeq	r2, r4, r4, lsl r8
    2ccc:	24330000 	ldrtcs	r0, [r3], #-0
    2cd0:	01000006 	tsteq	r0, r6
    2cd4:	28140149 	ldmdacs	r4, {r0, r3, r6, r8}
    2cd8:	00000004 	andeq	r0, r0, r4
    2cdc:	0008b000 	andeq	fp, r8, r0
    2ce0:	65000400 	strvs	r0, [r0, #-1024]	; 0x400
    2ce4:	04000009 	streq	r0, [r0], #-9
    2ce8:	0003ce01 	andeq	ip, r3, r1, lsl #28
    2cec:	09240100 	stmdbeq	r4!, {r8}
    2cf0:	06440000 	strbeq	r0, [r4], -r0
    2cf4:	00900000 	addseq	r0, r0, r0
    2cf8:	00000000 	andeq	r0, r0, r0
    2cfc:	08830000 	stmeq	r3, {}	; <UNPREDICTABLE>
    2d00:	04020000 	streq	r0, [r2], #-0
    2d04:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
    2d08:	07040300 	streq	r0, [r4, -r0, lsl #6]
    2d0c:	0000022b 	andeq	r0, r0, fp, lsr #4
    2d10:	f9060103 			; <UNDEFINED> instruction: 0xf9060103
    2d14:	03000001 	movweq	r0, #1
    2d18:	01f70801 	mvnseq	r0, r1, lsl #16
    2d1c:	02030000 	andeq	r0, r3, #0
    2d20:	00005705 	andeq	r5, r0, r5, lsl #14
    2d24:	07020300 	streq	r0, [r2, -r0, lsl #6]
    2d28:	000002a0 	andeq	r0, r0, r0, lsr #5
    2d2c:	7c050403 	cfstrsvc	mvf0, [r5], {3}
    2d30:	03000001 	movweq	r0, #1
    2d34:	02260704 	eoreq	r0, r6, #4, 14	; 0x100000
    2d38:	08030000 	stmdaeq	r3, {}	; <UNPREDICTABLE>
    2d3c:	00017705 	andeq	r7, r1, r5, lsl #14
    2d40:	07080300 	streq	r0, [r8, -r0, lsl #6]
    2d44:	00000221 	andeq	r0, r0, r1, lsr #4
    2d48:	00010c04 	andeq	r0, r1, r4, lsl #24
    2d4c:	25070200 	strcs	r0, [r7, #-512]	; 0x200
    2d50:	04000000 	streq	r0, [r0], #-0
    2d54:	0000002a 	andeq	r0, r0, sl, lsr #32
    2d58:	004f1003 	subeq	r1, pc, r3
    2d5c:	bf040000 	svclt	0x00040000
    2d60:	03000001 	movweq	r0, #1
    2d64:	00004f27 	andeq	r4, r0, r7, lsr #30
    2d68:	03590500 	cmpeq	r9, #0, 10
    2d6c:	61040000 	mrsvs	r0, (UNDEF: 4)
    2d70:	00002c01 	andeq	r2, r0, r1, lsl #24
    2d74:	03040600 	movweq	r0, #17920	; 0x4600
    2d78:	0000b74a 	andeq	fp, r0, sl, asr #14
    2d7c:	00310700 	eorseq	r0, r1, r0, lsl #14
    2d80:	4c030000 	stcmi	0, cr0, [r3], {-0}
    2d84:	0000008c 	andeq	r0, r0, ip, lsl #1
    2d88:	00021a07 	andeq	r1, r2, r7, lsl #20
    2d8c:	b74d0300 	strblt	r0, [sp, -r0, lsl #6]
    2d90:	00000000 	andeq	r0, r0, r0
    2d94:	00003a08 	andeq	r3, r0, r8, lsl #20
    2d98:	0000c700 	andeq	ip, r0, r0, lsl #14
    2d9c:	00c70900 	sbceq	r0, r7, r0, lsl #18
    2da0:	00030000 	andeq	r0, r3, r0
    2da4:	6b070403 	blvs	1c3db8 <_stack+0x143db8>
    2da8:	0a000000 	beq	2db0 <CPSR_IRQ_INHIBIT+0x2d30>
    2dac:	ef470308 	svc	0x00470308
    2db0:	0b000000 	bleq	2db8 <CPSR_IRQ_INHIBIT+0x2d38>
    2db4:	000000bb 	strheq	r0, [r0], -fp
    2db8:	00254903 	eoreq	r4, r5, r3, lsl #18
    2dbc:	0b000000 	bleq	2dc4 <CPSR_IRQ_INHIBIT+0x2d44>
    2dc0:	00000040 	andeq	r0, r0, r0, asr #32
    2dc4:	00984e03 	addseq	r4, r8, r3, lsl #28
    2dc8:	00040000 	andeq	r0, r4, r0
    2dcc:	0003a904 	andeq	sl, r3, r4, lsl #18
    2dd0:	ce4f0300 	cdpgt	3, 4, cr0, cr15, cr0, {0}
    2dd4:	04000000 	streq	r0, [r0], #-0
    2dd8:	000001ce 	andeq	r0, r0, lr, asr #3
    2ddc:	006b5303 	rsbeq	r5, fp, r3, lsl #6
    2de0:	040c0000 	streq	r0, [ip], #-0
    2de4:	0004b504 	andeq	fp, r4, r4, lsl #10
    2de8:	56160500 	ldrpl	r0, [r6], -r0, lsl #10
    2dec:	0d000000 	stceq	0, cr0, [r0, #-0]
    2df0:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
    2df4:	652d0518 	strvs	r0, [sp, #-1304]!	; 0x518
    2df8:	0b000001 	bleq	2e04 <CPSR_IRQ_INHIBIT+0x2d84>
    2dfc:	0000050d 	andeq	r0, r0, sp, lsl #10
    2e00:	01652f05 	cmneq	r5, r5, lsl #30
    2e04:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    2e08:	05006b5f 	streq	r6, [r0, #-2911]	; 0xb5f
    2e0c:	00002530 	andeq	r2, r0, r0, lsr r5
    2e10:	bc0b0400 	cfstrslt	mvf0, [fp], {-0}
    2e14:	05000003 	streq	r0, [r0, #-3]
    2e18:	00002530 	andeq	r2, r0, r0, lsr r5
    2e1c:	020b0800 	andeq	r0, fp, #0, 16
    2e20:	05000005 	streq	r0, [r0, #-5]
    2e24:	00002530 	andeq	r2, r0, r0, lsr r5
    2e28:	390b0c00 	stmdbcc	fp, {sl, fp}
    2e2c:	05000003 	streq	r0, [r0, #-3]
    2e30:	00002530 	andeq	r2, r0, r0, lsr r5
    2e34:	5f0e1000 	svcpl	0x000e1000
    2e38:	31050078 	tstcc	r5, r8, ror r0
    2e3c:	0000016b 	andeq	r0, r0, fp, ror #2
    2e40:	040f0014 	streq	r0, [pc], #-20	; 2e48 <CPSR_IRQ_INHIBIT+0x2dc8>
    2e44:	00000112 	andeq	r0, r0, r2, lsl r1
    2e48:	00010708 	andeq	r0, r1, r8, lsl #14
    2e4c:	00017b00 	andeq	r7, r1, r0, lsl #22
    2e50:	00c70900 	sbceq	r0, r7, r0, lsl #18
    2e54:	00000000 	andeq	r0, r0, r0
    2e58:	00033e0d 	andeq	r3, r3, sp, lsl #28
    2e5c:	35052400 	strcc	r2, [r5, #-1024]	; 0x400
    2e60:	000001f4 	strdeq	r0, [r0], -r4
    2e64:	0001e40b 	andeq	lr, r1, fp, lsl #8
    2e68:	25370500 	ldrcs	r0, [r7, #-1280]!	; 0x500
    2e6c:	00000000 	andeq	r0, r0, r0
    2e70:	0001390b 	andeq	r3, r1, fp, lsl #18
    2e74:	25380500 	ldrcs	r0, [r8, #-1280]!	; 0x500
    2e78:	04000000 	streq	r0, [r0], #-0
    2e7c:	0001ed0b 	andeq	lr, r1, fp, lsl #26
    2e80:	25390500 	ldrcs	r0, [r9, #-1280]!	; 0x500
    2e84:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    2e88:	0000c30b 	andeq	ip, r0, fp, lsl #6
    2e8c:	253a0500 	ldrcs	r0, [sl, #-1280]!	; 0x500
    2e90:	0c000000 	stceq	0, cr0, [r0], {-0}
    2e94:	0004cb0b 	andeq	ip, r4, fp, lsl #22
    2e98:	253b0500 	ldrcs	r0, [fp, #-1280]!	; 0x500
    2e9c:	10000000 	andne	r0, r0, r0
    2ea0:	0003c40b 	andeq	ip, r3, fp, lsl #8
    2ea4:	253c0500 	ldrcs	r0, [ip, #-1280]!	; 0x500
    2ea8:	14000000 	strne	r0, [r0], #-0
    2eac:	00016d0b 	andeq	r6, r1, fp, lsl #26
    2eb0:	253d0500 	ldrcs	r0, [sp, #-1280]!	; 0x500
    2eb4:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    2eb8:	0004ab0b 	andeq	sl, r4, fp, lsl #22
    2ebc:	253e0500 	ldrcs	r0, [lr, #-1280]!	; 0x500
    2ec0:	1c000000 	stcne	0, cr0, [r0], {-0}
    2ec4:	0001990b 	andeq	r9, r1, fp, lsl #18
    2ec8:	253f0500 	ldrcs	r0, [pc, #-1280]!	; 29d0 <CPSR_IRQ_INHIBIT+0x2950>
    2ecc:	20000000 	andcs	r0, r0, r0
    2ed0:	02491000 	subeq	r1, r9, #0
    2ed4:	01080000 	mrseq	r0, (UNDEF: 8)
    2ed8:	02344805 	eorseq	r4, r4, #327680	; 0x50000
    2edc:	850b0000 	strhi	r0, [fp, #-0]
    2ee0:	05000001 	streq	r0, [r0, #-1]
    2ee4:	00023449 	andeq	r3, r2, r9, asr #8
    2ee8:	f10b0000 			; <UNDEFINED> instruction: 0xf10b0000
    2eec:	05000004 	streq	r0, [r0, #-4]
    2ef0:	0002344a 	andeq	r3, r2, sl, asr #8
    2ef4:	b6118000 	ldrlt	r8, [r1], -r0
    2ef8:	05000001 	streq	r0, [r0, #-1]
    2efc:	0001074c 	andeq	r0, r1, ip, asr #14
    2f00:	11010000 	mrsne	r0, (UNDEF: 1)
    2f04:	00000380 	andeq	r0, r0, r0, lsl #7
    2f08:	01074f05 	tsteq	r7, r5, lsl #30
    2f0c:	01040000 	mrseq	r0, (UNDEF: 4)
    2f10:	01050800 	tsteq	r5, r0, lsl #16
    2f14:	02440000 	subeq	r0, r4, #0
    2f18:	c7090000 	strgt	r0, [r9, -r0]
    2f1c:	1f000000 	svcne	0x00000000
    2f20:	00eb1000 	rsceq	r1, fp, r0
    2f24:	01900000 	orrseq	r0, r0, r0
    2f28:	02825b05 	addeq	r5, r2, #5120	; 0x1400
    2f2c:	0d0b0000 	stceq	0, cr0, [fp, #-0]
    2f30:	05000005 	streq	r0, [r0, #-5]
    2f34:	0002825c 	andeq	r8, r2, ip, asr r2
    2f38:	de0b0000 	cdple	0, 0, cr0, cr11, cr0, {0}
    2f3c:	05000004 	streq	r0, [r0, #-4]
    2f40:	0000255d 	andeq	r2, r0, sp, asr r5
    2f44:	5f0b0400 	svcpl	0x000b0400
    2f48:	05000001 	streq	r0, [r0, #-1]
    2f4c:	0002885f 	andeq	r8, r2, pc, asr r8
    2f50:	490b0800 	stmdbmi	fp, {fp}
    2f54:	05000002 	streq	r0, [r0, #-2]
    2f58:	0001f460 	andeq	pc, r1, r0, ror #8
    2f5c:	0f008800 	svceq	0x00008800
    2f60:	00024404 	andeq	r4, r2, r4, lsl #8
    2f64:	02980800 	addseq	r0, r8, #0, 16
    2f68:	02980000 	addseq	r0, r8, #0
    2f6c:	c7090000 	strgt	r0, [r9, -r0]
    2f70:	1f000000 	svcne	0x00000000
    2f74:	9e040f00 	cdpls	15, 0, cr0, cr4, cr0, {0}
    2f78:	12000002 	andne	r0, r0, #2
    2f7c:	0000500d 	andeq	r5, r0, sp
    2f80:	73050800 	movwvc	r0, #22528	; 0x5800
    2f84:	000002c4 	andeq	r0, r0, r4, asr #5
    2f88:	0007c10b 	andeq	ip, r7, fp, lsl #2
    2f8c:	c4740500 	ldrbtgt	r0, [r4], #-1280	; 0x500
    2f90:	00000002 	andeq	r0, r0, r2
    2f94:	00087b0b 	andeq	r7, r8, fp, lsl #22
    2f98:	25750500 	ldrbcs	r0, [r5, #-1280]!	; 0x500
    2f9c:	04000000 	streq	r0, [r0], #-0
    2fa0:	3a040f00 	bcc	106ba8 <_stack+0x86ba8>
    2fa4:	0d000000 	stceq	0, cr0, [r0, #-0]
    2fa8:	0000054c 	andeq	r0, r0, ip, asr #10
    2fac:	f4b30568 			; <UNDEFINED> instruction: 0xf4b30568
    2fb0:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
    2fb4:	0500705f 	streq	r7, [r0, #-95]	; 0x5f
    2fb8:	0002c4b4 			; <UNDEFINED> instruction: 0x0002c4b4
    2fbc:	5f0e0000 	svcpl	0x000e0000
    2fc0:	b5050072 	strlt	r0, [r5, #-114]	; 0x72
    2fc4:	00000025 	andeq	r0, r0, r5, lsr #32
    2fc8:	775f0e04 	ldrbvc	r0, [pc, -r4, lsl #28]
    2fcc:	25b60500 	ldrcs	r0, [r6, #1280]!	; 0x500
    2fd0:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    2fd4:	00009e0b 	andeq	r9, r0, fp, lsl #28
    2fd8:	41b70500 			; <UNDEFINED> instruction: 0x41b70500
    2fdc:	0c000000 	stceq	0, cr0, [r0], {-0}
    2fe0:	0003170b 	andeq	r1, r3, fp, lsl #14
    2fe4:	41b80500 			; <UNDEFINED> instruction: 0x41b80500
    2fe8:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    2fec:	66625f0e 	strbtvs	r5, [r2], -lr, lsl #30
    2ff0:	9fb90500 	svcls	0x00b90500
    2ff4:	10000002 	andne	r0, r0, r2
    2ff8:	0000370b 	andeq	r3, r0, fp, lsl #14
    2ffc:	25ba0500 	ldrcs	r0, [sl, #1280]!	; 0x500
    3000:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    3004:	0002bb0b 	andeq	fp, r2, fp, lsl #22
    3008:	05c10500 	strbeq	r0, [r1, #1280]	; 0x500
    300c:	1c000001 	stcne	0, cr0, [r0], {1}
    3010:	0002050b 	andeq	r0, r2, fp, lsl #10
    3014:	57c30500 	strbpl	r0, [r3, r0, lsl #10]
    3018:	20000005 	andcs	r0, r0, r5
    301c:	0000a50b 	andeq	sl, r0, fp, lsl #10
    3020:	86c50500 	strbhi	r0, [r5], r0, lsl #10
    3024:	24000005 	strcs	r0, [r0], #-5
    3028:	0004bd0b 	andeq	fp, r4, fp, lsl #26
    302c:	aac80500 	bge	ff204434 <_stack+0xff184434>
    3030:	28000005 	stmdacs	r0, {r0, r2}
    3034:	0001c70b 	andeq	ip, r1, fp, lsl #14
    3038:	c4c90500 	strbgt	r0, [r9], #1280	; 0x500
    303c:	2c000005 	stccs	0, cr0, [r0], {5}
    3040:	62755f0e 	rsbsvs	r5, r5, #14, 30	; 0x38
    3044:	9fcc0500 	svcls	0x00cc0500
    3048:	30000002 	andcc	r0, r0, r2
    304c:	70755f0e 	rsbsvc	r5, r5, lr, lsl #30
    3050:	c4cd0500 	strbgt	r0, [sp], #1280	; 0x500
    3054:	38000002 	stmdacc	r0, {r1}
    3058:	72755f0e 	rsbsvc	r5, r5, #14, 30	; 0x38
    305c:	25ce0500 	strbcs	r0, [lr, #1280]	; 0x500
    3060:	3c000000 	stccc	0, cr0, [r0], {-0}
    3064:	0005390b 	andeq	r3, r5, fp, lsl #18
    3068:	cad10500 	bgt	ff444470 <_stack+0xff3c4470>
    306c:	40000005 	andmi	r0, r0, r5
    3070:	0001060b 	andeq	r0, r1, fp, lsl #12
    3074:	dad20500 	ble	ff48447c <_stack+0xff40447c>
    3078:	43000005 	movwmi	r0, #5
    307c:	626c5f0e 	rsbvs	r5, ip, #14, 30	; 0x38
    3080:	9fd50500 	svcls	0x00d50500
    3084:	44000002 	strmi	r0, [r0], #-2
    3088:	0001ad0b 	andeq	sl, r1, fp, lsl #26
    308c:	25d80500 	ldrbcs	r0, [r8, #1280]	; 0x500
    3090:	4c000000 	stcmi	0, cr0, [r0], {-0}
    3094:	0000740b 	andeq	r7, r0, fp, lsl #8
    3098:	76d90500 	ldrbvc	r0, [r9], r0, lsl #10
    309c:	50000000 	andpl	r0, r0, r0
    30a0:	0007d40b 	andeq	sp, r7, fp, lsl #8
    30a4:	12dc0500 	sbcsne	r0, ip, #0, 10
    30a8:	54000004 	strpl	r0, [r0], #-4
    30ac:	0006b00b 	andeq	fp, r6, fp
    30b0:	fae00500 	blx	ff8044b8 <_stack+0xff7844b8>
    30b4:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
    30b8:	0001640b 	andeq	r6, r1, fp, lsl #8
    30bc:	efe20500 	svc	0x00e20500
    30c0:	5c000000 	stcpl	0, cr0, [r0], {-0}
    30c4:	00000b0b 	andeq	r0, r0, fp, lsl #22
    30c8:	25e30500 	strbcs	r0, [r3, #1280]!	; 0x500
    30cc:	64000000 	strvs	r0, [r0], #-0
    30d0:	00251300 	eoreq	r1, r5, r0, lsl #6
    30d4:	04120000 	ldreq	r0, [r2], #-0
    30d8:	12140000 	andsne	r0, r4, #0
    30dc:	14000004 	strne	r0, [r0], #-4
    30e0:	00000105 	andeq	r0, r0, r5, lsl #2
    30e4:	00054a14 	andeq	r4, r5, r4, lsl sl
    30e8:	00251400 	eoreq	r1, r5, r0, lsl #8
    30ec:	0f000000 	svceq	0x00000000
    30f0:	00041804 	andeq	r1, r4, r4, lsl #16
    30f4:	03a21500 			; <UNDEFINED> instruction: 0x03a21500
    30f8:	04280000 	strteq	r0, [r8], #-0
    30fc:	4a023905 	bmi	91518 <_stack+0x11518>
    3100:	16000005 	strne	r0, [r0], -r5
    3104:	0000023a 	andeq	r0, r0, sl, lsr r2
    3108:	25023b05 	strcs	r3, [r2, #-2821]	; 0xb05
    310c:	00000000 	andeq	r0, r0, r0
    3110:	00051316 	andeq	r1, r5, r6, lsl r3
    3114:	02400500 	subeq	r0, r0, #0, 10
    3118:	00000631 	andeq	r0, r0, r1, lsr r6
    311c:	00e31604 	rsceq	r1, r3, r4, lsl #12
    3120:	40050000 	andmi	r0, r5, r0
    3124:	00063102 	andeq	r3, r6, r2, lsl #2
    3128:	12160800 	andsne	r0, r6, #0, 16
    312c:	05000002 	streq	r0, [r0, #-2]
    3130:	06310240 	ldrteq	r0, [r1], -r0, asr #4
    3134:	160c0000 	strne	r0, [ip], -r0
    3138:	000004d9 	ldrdeq	r0, [r0], -r9
    313c:	25024205 	strcs	r4, [r2, #-517]	; 0x205
    3140:	10000000 	andne	r0, r0, r0
    3144:	0000f316 	andeq	pc, r0, r6, lsl r3	; <UNPREDICTABLE>
    3148:	02430500 	subeq	r0, r3, #0, 10
    314c:	00000813 	andeq	r0, r0, r3, lsl r8
    3150:	036e1614 	cmneq	lr, #20, 12	; 0x1400000
    3154:	45050000 	strmi	r0, [r5, #-0]
    3158:	00002502 	andeq	r2, r0, r2, lsl #10
    315c:	1a163000 	bne	58f164 <_stack+0x50f164>
    3160:	05000005 	streq	r0, [r0, #-5]
    3164:	057b0246 	ldrbeq	r0, [fp, #-582]!	; 0x246
    3168:	16340000 	ldrtne	r0, [r4], -r0
    316c:	00000000 	andeq	r0, r0, r0
    3170:	25024805 	strcs	r4, [r2, #-2053]	; 0x805
    3174:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
    3178:	00038816 	andeq	r8, r3, r6, lsl r8
    317c:	024a0500 	subeq	r0, sl, #0, 10
    3180:	0000082e 	andeq	r0, r0, lr, lsr #16
    3184:	04c3163c 	strbeq	r1, [r3], #1596	; 0x63c
    3188:	4d050000 	stcmi	0, cr0, [r5, #-0]
    318c:	00016502 	andeq	r6, r1, r2, lsl #10
    3190:	61164000 	tstvs	r6, r0
    3194:	05000000 	streq	r0, [r0, #-0]
    3198:	0025024e 	eoreq	r0, r5, lr, asr #4
    319c:	16440000 	strbne	r0, [r4], -r0
    31a0:	000004fd 	strdeq	r0, [r0], -sp
    31a4:	65024f05 	strvs	r4, [r2, #-3845]	; 0xf05
    31a8:	48000001 	stmdami	r0, {r0}
    31ac:	00015516 	andeq	r5, r1, r6, lsl r5
    31b0:	02500500 	subseq	r0, r0, #0, 10
    31b4:	00000834 	andeq	r0, r0, r4, lsr r8
    31b8:	00fe164c 	rscseq	r1, lr, ip, asr #12
    31bc:	53050000 	movwpl	r0, #20480	; 0x5000
    31c0:	00002502 	andeq	r2, r0, r2, lsl #10
    31c4:	b3165000 	tstlt	r6, #0
    31c8:	05000002 	streq	r0, [r0, #-2]
    31cc:	054a0254 	strbeq	r0, [sl, #-596]	; 0x254
    31d0:	16540000 	ldrbne	r0, [r4], -r0
    31d4:	00000554 	andeq	r0, r0, r4, asr r5
    31d8:	f1027705 			; <UNDEFINED> instruction: 0xf1027705
    31dc:	58000007 	stmdapl	r0, {r0, r1, r2}
    31e0:	0000eb17 	andeq	lr, r0, r7, lsl fp
    31e4:	027b0500 	rsbseq	r0, fp, #0, 10
    31e8:	00000282 	andeq	r0, r0, r2, lsl #5
    31ec:	a4170148 	ldrge	r0, [r7], #-328	; 0x148
    31f0:	05000001 	streq	r0, [r0, #-1]
    31f4:	0244027c 	subeq	r0, r4, #124, 4	; 0xc0000007
    31f8:	014c0000 	mrseq	r0, (UNDEF: 76)
    31fc:	00014217 	andeq	r4, r1, r7, lsl r2
    3200:	02800500 	addeq	r0, r0, #0, 10
    3204:	00000845 	andeq	r0, r0, r5, asr #16
    3208:	411702dc 			; <UNDEFINED> instruction: 0x411702dc
    320c:	05000002 	streq	r0, [r0, #-2]
    3210:	05f60285 	ldrbeq	r0, [r6, #645]!	; 0x285
    3214:	02e00000 	rsceq	r0, r0, #0
    3218:	00007c17 	andeq	r7, r0, r7, lsl ip
    321c:	02860500 	addeq	r0, r6, #0, 10
    3220:	00000851 	andeq	r0, r0, r1, asr r8
    3224:	0f0002ec 	svceq	0x000002ec
    3228:	00055004 	andeq	r5, r5, r4
    322c:	08010300 	stmdaeq	r1, {r8, r9}
    3230:	00000200 	andeq	r0, r0, r0, lsl #4
    3234:	03f4040f 	mvnseq	r0, #251658240	; 0xf000000
    3238:	25130000 	ldrcs	r0, [r3, #-0]
    323c:	7b000000 	blvc	3244 <CPSR_IRQ_INHIBIT+0x31c4>
    3240:	14000005 	strne	r0, [r0], #-5
    3244:	00000412 	andeq	r0, r0, r2, lsl r4
    3248:	00010514 	andeq	r0, r1, r4, lsl r5
    324c:	057b1400 	ldrbeq	r1, [fp, #-1024]!	; 0x400
    3250:	25140000 	ldrcs	r0, [r4, #-0]
    3254:	00000000 	andeq	r0, r0, r0
    3258:	0581040f 	streq	r0, [r1, #1039]	; 0x40f
    325c:	50180000 	andspl	r0, r8, r0
    3260:	0f000005 	svceq	0x00000005
    3264:	00055d04 	andeq	r5, r5, r4, lsl #26
    3268:	00811300 	addeq	r1, r1, r0, lsl #6
    326c:	05aa0000 	streq	r0, [sl, #0]!
    3270:	12140000 	andsne	r0, r4, #0
    3274:	14000004 	strne	r0, [r0], #-4
    3278:	00000105 	andeq	r0, r0, r5, lsl #2
    327c:	00008114 	andeq	r8, r0, r4, lsl r1
    3280:	00251400 	eoreq	r1, r5, r0, lsl #8
    3284:	0f000000 	svceq	0x00000000
    3288:	00058c04 	andeq	r8, r5, r4, lsl #24
    328c:	00251300 	eoreq	r1, r5, r0, lsl #6
    3290:	05c40000 	strbeq	r0, [r4]
    3294:	12140000 	andsne	r0, r4, #0
    3298:	14000004 	strne	r0, [r0], #-4
    329c:	00000105 	andeq	r0, r0, r5, lsl #2
    32a0:	b0040f00 	andlt	r0, r4, r0, lsl #30
    32a4:	08000005 	stmdaeq	r0, {r0, r2}
    32a8:	0000003a 	andeq	r0, r0, sl, lsr r0
    32ac:	000005da 	ldrdeq	r0, [r0], -sl
    32b0:	0000c709 	andeq	ip, r0, r9, lsl #14
    32b4:	08000200 	stmdaeq	r0, {r9}
    32b8:	0000003a 	andeq	r0, r0, sl, lsr r0
    32bc:	000005ea 	andeq	r0, r0, sl, ror #11
    32c0:	0000c709 	andeq	ip, r0, r9, lsl #14
    32c4:	05000000 	streq	r0, [r0, #-0]
    32c8:	00000125 	andeq	r0, r0, r5, lsr #2
    32cc:	ca011d05 	bgt	4a6e8 <__bss_end__+0x40ec0>
    32d0:	19000002 	stmdbne	r0, {r1}
    32d4:	000001de 	ldrdeq	r0, [r0], -lr
    32d8:	0121050c 	teqeq	r1, ip, lsl #10
    32dc:	0000062b 	andeq	r0, r0, fp, lsr #12
    32e0:	00050d16 	andeq	r0, r5, r6, lsl sp
    32e4:	01230500 	teqeq	r3, r0, lsl #10
    32e8:	0000062b 	andeq	r0, r0, fp, lsr #12
    32ec:	011e1600 	tsteq	lr, r0, lsl #12
    32f0:	24050000 	strcs	r0, [r5], #-0
    32f4:	00002501 	andeq	r2, r0, r1, lsl #10
    32f8:	8d160400 	cfldrshi	mvf0, [r6, #-0]
    32fc:	05000001 	streq	r0, [r0, #-1]
    3300:	06310125 	ldrteq	r0, [r1], -r5, lsr #2
    3304:	00080000 	andeq	r0, r8, r0
    3308:	05f6040f 	ldrbeq	r0, [r6, #1039]!	; 0x40f
    330c:	040f0000 	streq	r0, [pc], #-0	; 3314 <CPSR_IRQ_INHIBIT+0x3294>
    3310:	000005ea 	andeq	r0, r0, sl, ror #11
    3314:	0004a319 	andeq	sl, r4, r9, lsl r3
    3318:	3d050e00 	stccc	14, cr0, [r5, #-0]
    331c:	00066c01 	andeq	r6, r6, r1, lsl #24
    3320:	049d1600 	ldreq	r1, [sp], #1536	; 0x600
    3324:	3e050000 	cdpcc	0, 0, cr0, cr5, cr0, {0}
    3328:	00066c01 	andeq	r6, r6, r1, lsl #24
    332c:	93160000 	tstls	r6, #0
    3330:	05000001 	streq	r0, [r0, #-1]
    3334:	066c013f 			; <UNDEFINED> instruction: 0x066c013f
    3338:	16060000 	strne	r0, [r6], -r0
    333c:	000004d4 	ldrdeq	r0, [r0], -r4
    3340:	48014005 	stmdami	r1, {r0, r2, lr}
    3344:	0c000000 	stceq	0, cr0, [r0], {-0}
    3348:	00480800 	subeq	r0, r8, r0, lsl #16
    334c:	067c0000 	ldrbteq	r0, [ip], -r0
    3350:	c7090000 	strgt	r0, [r9, -r0]
    3354:	02000000 	andeq	r0, r0, #0
    3358:	05d01a00 	ldrbeq	r1, [r0, #2560]	; 0xa00
    335c:	077d0258 			; <UNDEFINED> instruction: 0x077d0258
    3360:	2c160000 	ldccs	0, cr0, [r6], {-0}
    3364:	05000003 	streq	r0, [r0, #-3]
    3368:	002c025a 	eoreq	r0, ip, sl, asr r2
    336c:	16000000 	strne	r0, [r0], -r0
    3370:	00000490 	muleq	r0, r0, r4
    3374:	4a025b05 	bmi	99f90 <_stack+0x19f90>
    3378:	04000005 	streq	r0, [r0], #-5
    337c:	00053f16 	andeq	r3, r5, r6, lsl pc
    3380:	025c0500 	subseq	r0, ip, #0, 10
    3384:	0000077d 	andeq	r0, r0, sp, ror r7
    3388:	00ac1608 	adceq	r1, ip, r8, lsl #12
    338c:	5d050000 	stcpl	0, cr0, [r5, #-0]
    3390:	00017b02 	andeq	r7, r1, r2, lsl #22
    3394:	1d162400 	cfldrsne	mvf2, [r6, #-0]
    3398:	05000003 	streq	r0, [r0, #-3]
    339c:	0025025e 	eoreq	r0, r5, lr, asr r2
    33a0:	16480000 	strbne	r0, [r8], -r0
    33a4:	00000508 	andeq	r0, r0, r8, lsl #10
    33a8:	64025f05 	strvs	r5, [r2], #-3845	; 0xf05
    33ac:	50000000 	andpl	r0, r0, r0
    33b0:	0000de16 	andeq	sp, r0, r6, lsl lr
    33b4:	02600500 	rsbeq	r0, r0, #0, 10
    33b8:	00000637 	andeq	r0, r0, r7, lsr r6
    33bc:	00131658 	andseq	r1, r3, r8, asr r6
    33c0:	61050000 	mrsvs	r0, (UNDEF: 5)
    33c4:	0000ef02 	andeq	lr, r0, r2, lsl #30
    33c8:	4b166800 	blmi	59d3d0 <_stack+0x51d3d0>
    33cc:	05000003 	streq	r0, [r0, #-3]
    33d0:	00ef0262 	rsceq	r0, pc, r2, ror #4
    33d4:	16700000 	ldrbtne	r0, [r0], -r0
    33d8:	000004e3 	andeq	r0, r0, r3, ror #9
    33dc:	ef026305 	svc	0x00026305
    33e0:	78000000 	stmdavc	r0, {}	; <UNPREDICTABLE>
    33e4:	00002016 	andeq	r2, r0, r6, lsl r0
    33e8:	02640500 	rsbeq	r0, r4, #0, 10
    33ec:	0000078d 	andeq	r0, r0, sp, lsl #15
    33f0:	00811680 	addeq	r1, r1, r0, lsl #13
    33f4:	65050000 	strvs	r0, [r5, #-0]
    33f8:	00079d02 	andeq	r9, r7, r2, lsl #26
    33fc:	2c168800 	ldccs	8, cr8, [r6], {-0}
    3400:	05000001 	streq	r0, [r0, #-1]
    3404:	00250266 	eoreq	r0, r5, r6, ror #4
    3408:	16a00000 	strtne	r0, [r0], r0
    340c:	00000360 	andeq	r0, r0, r0, ror #6
    3410:	ef026705 	svc	0x00026705
    3414:	a4000000 	strge	r0, [r0], #-0
    3418:	00028916 	andeq	r8, r2, r6, lsl r9
    341c:	02680500 	rsbeq	r0, r8, #0, 10
    3420:	000000ef 	andeq	r0, r0, pc, ror #1
    3424:	00cd16ac 	sbceq	r1, sp, ip, lsr #13
    3428:	69050000 	stmdbvs	r5, {}	; <UNPREDICTABLE>
    342c:	0000ef02 	andeq	lr, r0, r2, lsl #30
    3430:	2a16b400 	bcs	5b0438 <_stack+0x530438>
    3434:	05000005 	streq	r0, [r0, #-5]
    3438:	00ef026a 	rsceq	r0, pc, sl, ror #4
    343c:	16bc0000 	ldrtne	r0, [ip], r0
    3440:	0000008d 	andeq	r0, r0, sp, lsl #1
    3444:	ef026b05 	svc	0x00026b05
    3448:	c4000000 	strgt	r0, [r0], #-0
    344c:	00023816 	andeq	r3, r2, r6, lsl r8
    3450:	026c0500 	rsbeq	r0, ip, #0, 10
    3454:	00000025 	andeq	r0, r0, r5, lsr #32
    3458:	500800cc 	andpl	r0, r8, ip, asr #1
    345c:	8d000005 	stchi	0, cr0, [r0, #-20]	; 0xffffffec
    3460:	09000007 	stmdbeq	r0, {r0, r1, r2}
    3464:	000000c7 	andeq	r0, r0, r7, asr #1
    3468:	50080019 	andpl	r0, r8, r9, lsl r0
    346c:	9d000005 	stcls	0, cr0, [r0, #-20]	; 0xffffffec
    3470:	09000007 	stmdbeq	r0, {r0, r1, r2}
    3474:	000000c7 	andeq	r0, r0, r7, asr #1
    3478:	50080007 	andpl	r0, r8, r7
    347c:	ad000005 	stcge	0, cr0, [r0, #-20]	; 0xffffffec
    3480:	09000007 	stmdbeq	r0, {r0, r1, r2}
    3484:	000000c7 	andeq	r0, r0, r7, asr #1
    3488:	f01a0017 			; <UNDEFINED> instruction: 0xf01a0017
    348c:	d1027105 	tstle	r2, r5, lsl #2
    3490:	16000007 	strne	r0, [r0], -r7
    3494:	0000020b 	andeq	r0, r0, fp, lsl #4
    3498:	d1027405 	tstle	r2, r5, lsl #8
    349c:	00000007 	andeq	r0, r0, r7
    34a0:	00014c16 	andeq	r4, r1, r6, lsl ip
    34a4:	02750500 	rsbseq	r0, r5, #0, 10
    34a8:	000007e1 	andeq	r0, r0, r1, ror #15
    34ac:	c4080078 	strgt	r0, [r8], #-120	; 0x78
    34b0:	e1000002 	tst	r0, r2
    34b4:	09000007 	stmdbeq	r0, {r0, r1, r2}
    34b8:	000000c7 	andeq	r0, r0, r7, asr #1
    34bc:	2c08001d 	stccs	0, cr0, [r8], {29}
    34c0:	f1000000 	cps	#0
    34c4:	09000007 	stmdbeq	r0, {r0, r1, r2}
    34c8:	000000c7 	andeq	r0, r0, r7, asr #1
    34cc:	f01b001d 			; <UNDEFINED> instruction: 0xf01b001d
    34d0:	13025605 	movwne	r5, #9733	; 0x2605
    34d4:	1c000008 	stcne	0, cr0, [r0], {8}
    34d8:	000003a2 	andeq	r0, r0, r2, lsr #7
    34dc:	7c026d05 	stcvc	13, cr6, [r2], {5}
    34e0:	1c000006 	stcne	0, cr0, [r0], {6}
    34e4:	00000343 	andeq	r0, r0, r3, asr #6
    34e8:	ad027605 	stcge	6, cr7, [r2, #-20]	; 0xffffffec
    34ec:	00000007 	andeq	r0, r0, r7
    34f0:	00055008 	andeq	r5, r5, r8
    34f4:	00082300 	andeq	r2, r8, r0, lsl #6
    34f8:	00c70900 	sbceq	r0, r7, r0, lsl #18
    34fc:	00180000 	andseq	r0, r8, r0
    3500:	00082e1d 	andeq	r2, r8, sp, lsl lr
    3504:	04121400 	ldreq	r1, [r2], #-1024	; 0x400
    3508:	0f000000 	svceq	0x00000000
    350c:	00082304 	andeq	r2, r8, r4, lsl #6
    3510:	65040f00 	strvs	r0, [r4, #-3840]	; 0xf00
    3514:	1d000001 	stcne	0, cr0, [r0, #-4]
    3518:	00000845 	andeq	r0, r0, r5, asr #16
    351c:	00002514 	andeq	r2, r0, r4, lsl r5
    3520:	040f0000 	streq	r0, [pc], #-0	; 3528 <CPSR_IRQ_INHIBIT+0x34a8>
    3524:	0000084b 	andeq	r0, r0, fp, asr #16
    3528:	083a040f 	ldmdaeq	sl!, {r0, r1, r2, r3, sl}
    352c:	ea080000 	b	203534 <_stack+0x183534>
    3530:	61000005 	tstvs	r0, r5
    3534:	09000008 	stmdbeq	r0, {r3}
    3538:	000000c7 	andeq	r0, r0, r7, asr #1
    353c:	a81e0002 	ldmdage	lr, {r1}
    3540:	01000006 	tsteq	r0, r6
    3544:	008e882f 	addeq	r8, lr, pc, lsr #16
    3548:	00000200 	andeq	r0, r0, r0, lsl #4
    354c:	849c0100 	ldrhi	r0, [ip], #256	; 0x100
    3550:	1f000008 	svcne	0x00000008
    3554:	00727470 	rsbseq	r7, r2, r0, ror r4
    3558:	04123001 	ldreq	r3, [r2], #-1
    355c:	50010000 	andpl	r0, r1, r0
    3560:	06241e00 	strteq	r1, [r4], -r0, lsl #28
    3564:	38010000 	stmdacc	r1, {}	; <UNPREDICTABLE>
    3568:	00008e8c 	andeq	r8, r0, ip, lsl #29
    356c:	00000002 	andeq	r0, r0, r2
    3570:	08a79c01 	stmiaeq	r7!, {r0, sl, fp, ip, pc}
    3574:	701f0000 	andsvc	r0, pc, r0
    3578:	01007274 	tsteq	r0, r4, ror r2
    357c:	00041239 	andeq	r1, r4, r9, lsr r2
    3580:	00500100 	subseq	r0, r0, r0, lsl #2
    3584:	00090f20 	andeq	r0, r9, r0, lsr #30
    3588:	252b0100 	strcs	r0, [fp, #-256]!	; 0x100
    358c:	00000000 	andeq	r0, r0, r0
    3590:	0008f000 	andeq	pc, r8, r0
    3594:	ff000400 			; <UNDEFINED> instruction: 0xff000400
    3598:	0400000a 	streq	r0, [r0], #-10
    359c:	0003ce01 	andeq	ip, r3, r1, lsl #28
    35a0:	095c0100 	ldmdbeq	ip, {r8}^
    35a4:	02c30000 	sbceq	r0, r3, #0
    35a8:	00a80000 	adceq	r0, r8, r0
    35ac:	00000000 	andeq	r0, r0, r0
    35b0:	097d0000 	ldmdbeq	sp!, {}^	; <UNPREDICTABLE>
    35b4:	b6020000 	strlt	r0, [r2], -r0
    35b8:	02000006 	andeq	r0, r0, #6
    35bc:	00003093 	muleq	r0, r3, r0
    35c0:	05040300 	streq	r0, [r4, #-768]	; 0x300
    35c4:	00746e69 	rsbseq	r6, r4, r9, ror #28
    35c8:	2b070404 	blcs	1c45e0 <_stack+0x1445e0>
    35cc:	04000002 	streq	r0, [r0], #-2
    35d0:	01f90601 	mvnseq	r0, r1, lsl #12
    35d4:	01040000 	mrseq	r0, (UNDEF: 4)
    35d8:	0001f708 	andeq	pc, r1, r8, lsl #14
    35dc:	05020400 	streq	r0, [r2, #-1024]	; 0x400
    35e0:	00000057 	andeq	r0, r0, r7, asr r0
    35e4:	a0070204 	andge	r0, r7, r4, lsl #4
    35e8:	04000002 	streq	r0, [r0], #-2
    35ec:	017c0504 	cmneq	ip, r4, lsl #10
    35f0:	04040000 	streq	r0, [r4], #-0
    35f4:	00022607 	andeq	r2, r2, r7, lsl #12
    35f8:	05080400 	streq	r0, [r8, #-1024]	; 0x400
    35fc:	00000177 	andeq	r0, r0, r7, ror r1
    3600:	21070804 	tstcs	r7, r4, lsl #16
    3604:	02000002 	andeq	r0, r0, #2
    3608:	0000010c 	andeq	r0, r0, ip, lsl #2
    360c:	00300703 	eorseq	r0, r0, r3, lsl #14
    3610:	2a020000 	bcs	83618 <_stack+0x3618>
    3614:	04000000 	streq	r0, [r0], #-0
    3618:	00005a10 	andeq	r5, r0, r0, lsl sl
    361c:	01bf0200 			; <UNDEFINED> instruction: 0x01bf0200
    3620:	27040000 	strcs	r0, [r4, -r0]
    3624:	0000005a 	andeq	r0, r0, sl, asr r0
    3628:	00035905 	andeq	r5, r3, r5, lsl #18
    362c:	01610200 	cmneq	r1, r0, lsl #4
    3630:	00000037 	andeq	r0, r0, r7, lsr r0
    3634:	4a040406 	bmi	104654 <_stack+0x84654>
    3638:	000000c2 	andeq	r0, r0, r2, asr #1
    363c:	00003107 	andeq	r3, r0, r7, lsl #2
    3640:	974c0400 	strbls	r0, [ip, -r0, lsl #8]
    3644:	07000000 	streq	r0, [r0, -r0]
    3648:	0000021a 	andeq	r0, r0, sl, lsl r2
    364c:	00c24d04 	sbceq	r4, r2, r4, lsl #26
    3650:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    3654:	00000045 	andeq	r0, r0, r5, asr #32
    3658:	000000d2 	ldrdeq	r0, [r0], -r2
    365c:	0000d209 	andeq	sp, r0, r9, lsl #4
    3660:	04000300 	streq	r0, [r0], #-768	; 0x300
    3664:	006b0704 	rsbeq	r0, fp, r4, lsl #14
    3668:	080a0000 	stmdaeq	sl, {}	; <UNPREDICTABLE>
    366c:	00fa4704 	rscseq	r4, sl, r4, lsl #14
    3670:	bb0b0000 	bllt	2c3678 <_stack+0x243678>
    3674:	04000000 	streq	r0, [r0], #-0
    3678:	00003049 	andeq	r3, r0, r9, asr #32
    367c:	400b0000 	andmi	r0, fp, r0
    3680:	04000000 	streq	r0, [r0], #-0
    3684:	0000a34e 	andeq	sl, r0, lr, asr #6
    3688:	02000400 	andeq	r0, r0, #0, 8
    368c:	000003a9 	andeq	r0, r0, r9, lsr #7
    3690:	00d94f04 	sbcseq	r4, r9, r4, lsl #30
    3694:	ce020000 	cdpgt	0, 0, cr0, cr2, cr0, {0}
    3698:	04000001 	streq	r0, [r0], #-1
    369c:	00007653 	andeq	r7, r0, r3, asr r6
    36a0:	02040c00 	andeq	r0, r4, #0, 24
    36a4:	000004b5 			; <UNDEFINED> instruction: 0x000004b5
    36a8:	00611605 	rsbeq	r1, r1, r5, lsl #12
    36ac:	b40d0000 	strlt	r0, [sp], #-0
    36b0:	18000003 	stmdane	r0, {r0, r1}
    36b4:	01702d05 	cmneq	r0, r5, lsl #26
    36b8:	0d0b0000 	stceq	0, cr0, [fp, #-0]
    36bc:	05000005 	streq	r0, [r0, #-5]
    36c0:	0001702f 	andeq	r7, r1, pc, lsr #32
    36c4:	5f0e0000 	svcpl	0x000e0000
    36c8:	3005006b 	andcc	r0, r5, fp, rrx
    36cc:	00000030 	andeq	r0, r0, r0, lsr r0
    36d0:	03bc0b04 			; <UNDEFINED> instruction: 0x03bc0b04
    36d4:	30050000 	andcc	r0, r5, r0
    36d8:	00000030 	andeq	r0, r0, r0, lsr r0
    36dc:	05020b08 	streq	r0, [r2, #-2824]	; 0xb08
    36e0:	30050000 	andcc	r0, r5, r0
    36e4:	00000030 	andeq	r0, r0, r0, lsr r0
    36e8:	03390b0c 	teqeq	r9, #12, 22	; 0x3000
    36ec:	30050000 	andcc	r0, r5, r0
    36f0:	00000030 	andeq	r0, r0, r0, lsr r0
    36f4:	785f0e10 	ldmdavc	pc, {r4, r9, sl, fp}^	; <UNPREDICTABLE>
    36f8:	76310500 	ldrtvc	r0, [r1], -r0, lsl #10
    36fc:	14000001 	strne	r0, [r0], #-1
    3700:	1d040f00 	stcne	15, cr0, [r4, #-0]
    3704:	08000001 	stmdaeq	r0, {r0}
    3708:	00000112 	andeq	r0, r0, r2, lsl r1
    370c:	00000186 	andeq	r0, r0, r6, lsl #3
    3710:	0000d209 	andeq	sp, r0, r9, lsl #4
    3714:	0d000000 	stceq	0, cr0, [r0, #-0]
    3718:	0000033e 	andeq	r0, r0, lr, lsr r3
    371c:	ff350524 			; <UNDEFINED> instruction: 0xff350524
    3720:	0b000001 	bleq	372c <CPSR_IRQ_INHIBIT+0x36ac>
    3724:	000001e4 	andeq	r0, r0, r4, ror #3
    3728:	00303705 	eorseq	r3, r0, r5, lsl #14
    372c:	0b000000 	bleq	3734 <CPSR_IRQ_INHIBIT+0x36b4>
    3730:	00000139 	andeq	r0, r0, r9, lsr r1
    3734:	00303805 	eorseq	r3, r0, r5, lsl #16
    3738:	0b040000 	bleq	103740 <_stack+0x83740>
    373c:	000001ed 	andeq	r0, r0, sp, ror #3
    3740:	00303905 	eorseq	r3, r0, r5, lsl #18
    3744:	0b080000 	bleq	20374c <_stack+0x18374c>
    3748:	000000c3 	andeq	r0, r0, r3, asr #1
    374c:	00303a05 	eorseq	r3, r0, r5, lsl #20
    3750:	0b0c0000 	bleq	303758 <_stack+0x283758>
    3754:	000004cb 	andeq	r0, r0, fp, asr #9
    3758:	00303b05 	eorseq	r3, r0, r5, lsl #22
    375c:	0b100000 	bleq	403764 <_stack+0x383764>
    3760:	000003c4 	andeq	r0, r0, r4, asr #7
    3764:	00303c05 	eorseq	r3, r0, r5, lsl #24
    3768:	0b140000 	bleq	503770 <_stack+0x483770>
    376c:	0000016d 	andeq	r0, r0, sp, ror #2
    3770:	00303d05 	eorseq	r3, r0, r5, lsl #26
    3774:	0b180000 	bleq	60377c <_stack+0x58377c>
    3778:	000004ab 	andeq	r0, r0, fp, lsr #9
    377c:	00303e05 	eorseq	r3, r0, r5, lsl #28
    3780:	0b1c0000 	bleq	703788 <_stack+0x683788>
    3784:	00000199 	muleq	r0, r9, r1
    3788:	00303f05 	eorseq	r3, r0, r5, lsl #30
    378c:	00200000 	eoreq	r0, r0, r0
    3790:	00024910 	andeq	r4, r2, r0, lsl r9
    3794:	05010800 	streq	r0, [r1, #-2048]	; 0x800
    3798:	00023f48 	andeq	r3, r2, r8, asr #30
    379c:	01850b00 	orreq	r0, r5, r0, lsl #22
    37a0:	49050000 	stmdbmi	r5, {}	; <UNPREDICTABLE>
    37a4:	0000023f 	andeq	r0, r0, pc, lsr r2
    37a8:	04f10b00 	ldrbteq	r0, [r1], #2816	; 0xb00
    37ac:	4a050000 	bmi	1437b4 <_stack+0xc37b4>
    37b0:	0000023f 	andeq	r0, r0, pc, lsr r2
    37b4:	01b61180 			; <UNDEFINED> instruction: 0x01b61180
    37b8:	4c050000 	stcmi	0, cr0, [r5], {-0}
    37bc:	00000112 	andeq	r0, r0, r2, lsl r1
    37c0:	80110100 	andshi	r0, r1, r0, lsl #2
    37c4:	05000003 	streq	r0, [r0, #-3]
    37c8:	0001124f 	andeq	r1, r1, pc, asr #4
    37cc:	00010400 	andeq	r0, r1, r0, lsl #8
    37d0:	00011008 	andeq	r1, r1, r8
    37d4:	00024f00 	andeq	r4, r2, r0, lsl #30
    37d8:	00d20900 	sbcseq	r0, r2, r0, lsl #18
    37dc:	001f0000 	andseq	r0, pc, r0
    37e0:	0000eb10 	andeq	lr, r0, r0, lsl fp
    37e4:	05019000 	streq	r9, [r1, #-0]
    37e8:	00028d5b 	andeq	r8, r2, fp, asr sp
    37ec:	050d0b00 	streq	r0, [sp, #-2816]	; 0xb00
    37f0:	5c050000 	stcpl	0, cr0, [r5], {-0}
    37f4:	0000028d 	andeq	r0, r0, sp, lsl #5
    37f8:	04de0b00 	ldrbeq	r0, [lr], #2816	; 0xb00
    37fc:	5d050000 	stcpl	0, cr0, [r5, #-0]
    3800:	00000030 	andeq	r0, r0, r0, lsr r0
    3804:	015f0b04 	cmpeq	pc, r4, lsl #22
    3808:	5f050000 	svcpl	0x00050000
    380c:	00000293 	muleq	r0, r3, r2
    3810:	02490b08 	subeq	r0, r9, #8, 22	; 0x2000
    3814:	60050000 	andvs	r0, r5, r0
    3818:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    381c:	040f0088 	streq	r0, [pc], #-136	; 3824 <CPSR_IRQ_INHIBIT+0x37a4>
    3820:	0000024f 	andeq	r0, r0, pc, asr #4
    3824:	0002a308 	andeq	sl, r2, r8, lsl #6
    3828:	0002a300 	andeq	sl, r2, r0, lsl #6
    382c:	00d20900 	sbcseq	r0, r2, r0, lsl #18
    3830:	001f0000 	andseq	r0, pc, r0
    3834:	02a9040f 	adceq	r0, r9, #251658240	; 0xf000000
    3838:	0d120000 	ldceq	0, cr0, [r2, #-0]
    383c:	00000050 	andeq	r0, r0, r0, asr r0
    3840:	cf730508 	svcgt	0x00730508
    3844:	0b000002 	bleq	3854 <CPSR_IRQ_INHIBIT+0x37d4>
    3848:	000007c1 	andeq	r0, r0, r1, asr #15
    384c:	02cf7405 	sbceq	r7, pc, #83886080	; 0x5000000
    3850:	0b000000 	bleq	3858 <CPSR_IRQ_INHIBIT+0x37d8>
    3854:	0000087b 	andeq	r0, r0, fp, ror r8
    3858:	00307505 	eorseq	r7, r0, r5, lsl #10
    385c:	00040000 	andeq	r0, r4, r0
    3860:	0045040f 	subeq	r0, r5, pc, lsl #8
    3864:	4c0d0000 	stcmi	0, cr0, [sp], {-0}
    3868:	68000005 	stmdavs	r0, {r0, r2}
    386c:	03ffb305 	mvnseq	fp, #335544320	; 0x14000000
    3870:	5f0e0000 	svcpl	0x000e0000
    3874:	b4050070 	strlt	r0, [r5], #-112	; 0x70
    3878:	000002cf 	andeq	r0, r0, pc, asr #5
    387c:	725f0e00 	subsvc	r0, pc, #0, 28
    3880:	30b50500 	adcscc	r0, r5, r0, lsl #10
    3884:	04000000 	streq	r0, [r0], #-0
    3888:	00775f0e 	rsbseq	r5, r7, lr, lsl #30
    388c:	0030b605 	eorseq	fp, r0, r5, lsl #12
    3890:	0b080000 	bleq	203898 <_stack+0x183898>
    3894:	0000009e 	muleq	r0, lr, r0
    3898:	004cb705 	subeq	fp, ip, r5, lsl #14
    389c:	0b0c0000 	bleq	3038a4 <_stack+0x2838a4>
    38a0:	00000317 	andeq	r0, r0, r7, lsl r3
    38a4:	004cb805 	subeq	fp, ip, r5, lsl #16
    38a8:	0e0e0000 	cdpeq	0, 0, cr0, cr14, cr0, {0}
    38ac:	0066625f 	rsbeq	r6, r6, pc, asr r2
    38b0:	02aab905 	adceq	fp, sl, #81920	; 0x14000
    38b4:	0b100000 	bleq	4038bc <_stack+0x3838bc>
    38b8:	00000037 	andeq	r0, r0, r7, lsr r0
    38bc:	0030ba05 	eorseq	fp, r0, r5, lsl #20
    38c0:	0b180000 	bleq	6038c8 <_stack+0x5838c8>
    38c4:	000002bb 			; <UNDEFINED> instruction: 0x000002bb
    38c8:	0110c105 	tsteq	r0, r5, lsl #2
    38cc:	0b1c0000 	bleq	7038d4 <_stack+0x6838d4>
    38d0:	00000205 	andeq	r0, r0, r5, lsl #4
    38d4:	0562c305 	strbeq	ip, [r2, #-773]!	; 0x305
    38d8:	0b200000 	bleq	8038e0 <_stack+0x7838e0>
    38dc:	000000a5 	andeq	r0, r0, r5, lsr #1
    38e0:	0591c505 	ldreq	ip, [r1, #1285]	; 0x505
    38e4:	0b240000 	bleq	9038ec <_stack+0x8838ec>
    38e8:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
    38ec:	05b5c805 	ldreq	ip, [r5, #2053]!	; 0x805
    38f0:	0b280000 	bleq	a038f8 <_stack+0x9838f8>
    38f4:	000001c7 	andeq	r0, r0, r7, asr #3
    38f8:	05cfc905 	strbeq	ip, [pc, #2309]	; 4205 <CPSR_IRQ_INHIBIT+0x4185>
    38fc:	0e2c0000 	cdpeq	0, 2, cr0, cr12, cr0, {0}
    3900:	0062755f 	rsbeq	r7, r2, pc, asr r5
    3904:	02aacc05 	adceq	ip, sl, #1280	; 0x500
    3908:	0e300000 	cdpeq	0, 3, cr0, cr0, cr0, {0}
    390c:	0070755f 	rsbseq	r7, r0, pc, asr r5
    3910:	02cfcd05 	sbceq	ip, pc, #320	; 0x140
    3914:	0e380000 	cdpeq	0, 3, cr0, cr8, cr0, {0}
    3918:	0072755f 	rsbseq	r7, r2, pc, asr r5
    391c:	0030ce05 	eorseq	ip, r0, r5, lsl #28
    3920:	0b3c0000 	bleq	f03928 <_stack+0xe83928>
    3924:	00000539 	andeq	r0, r0, r9, lsr r5
    3928:	05d5d105 	ldrbeq	sp, [r5, #261]	; 0x105
    392c:	0b400000 	bleq	1003934 <_stack+0xf83934>
    3930:	00000106 	andeq	r0, r0, r6, lsl #2
    3934:	05e5d205 	strbeq	sp, [r5, #517]!	; 0x205
    3938:	0e430000 	cdpeq	0, 4, cr0, cr3, cr0, {0}
    393c:	00626c5f 	rsbeq	r6, r2, pc, asr ip
    3940:	02aad505 	adceq	sp, sl, #20971520	; 0x1400000
    3944:	0b440000 	bleq	110394c <_stack+0x108394c>
    3948:	000001ad 	andeq	r0, r0, sp, lsr #3
    394c:	0030d805 	eorseq	sp, r0, r5, lsl #16
    3950:	0b4c0000 	bleq	1303958 <_stack+0x1283958>
    3954:	00000074 	andeq	r0, r0, r4, ror r0
    3958:	0081d905 	addeq	sp, r1, r5, lsl #18
    395c:	0b500000 	bleq	1403964 <_stack+0x1383964>
    3960:	000007d4 	ldrdeq	r0, [r0], -r4
    3964:	041ddc05 	ldreq	sp, [sp], #-3077	; 0xc05
    3968:	0b540000 	bleq	1503970 <_stack+0x1483970>
    396c:	000006b0 			; <UNDEFINED> instruction: 0x000006b0
    3970:	0105e005 	tsteq	r5, r5
    3974:	0b580000 	bleq	160397c <_stack+0x158397c>
    3978:	00000164 	andeq	r0, r0, r4, ror #2
    397c:	00fae205 	rscseq	lr, sl, r5, lsl #4
    3980:	0b5c0000 	bleq	1703988 <_stack+0x1683988>
    3984:	0000000b 	andeq	r0, r0, fp
    3988:	0030e305 	eorseq	lr, r0, r5, lsl #6
    398c:	00640000 	rsbeq	r0, r4, r0
    3990:	00003013 	andeq	r3, r0, r3, lsl r0
    3994:	00041d00 	andeq	r1, r4, r0, lsl #26
    3998:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
    399c:	10140000 	andsne	r0, r4, r0
    39a0:	14000001 	strne	r0, [r0], #-1
    39a4:	00000555 	andeq	r0, r0, r5, asr r5
    39a8:	00003014 	andeq	r3, r0, r4, lsl r0
    39ac:	040f0000 	streq	r0, [pc], #-0	; 39b4 <CPSR_IRQ_INHIBIT+0x3934>
    39b0:	00000423 	andeq	r0, r0, r3, lsr #8
    39b4:	0003a215 	andeq	sl, r3, r5, lsl r2
    39b8:	05042800 	streq	r2, [r4, #-2048]	; 0x800
    39bc:	05550239 	ldrbeq	r0, [r5, #-569]	; 0x239
    39c0:	3a160000 	bcc	5839c8 <_stack+0x5039c8>
    39c4:	05000002 	streq	r0, [r0, #-2]
    39c8:	0030023b 	eorseq	r0, r0, fp, lsr r2
    39cc:	16000000 	strne	r0, [r0], -r0
    39d0:	00000513 	andeq	r0, r0, r3, lsl r5
    39d4:	3c024005 	stccc	0, cr4, [r2], {5}
    39d8:	04000006 	streq	r0, [r0], #-6
    39dc:	0000e316 	andeq	lr, r0, r6, lsl r3
    39e0:	02400500 	subeq	r0, r0, #0, 10
    39e4:	0000063c 	andeq	r0, r0, ip, lsr r6
    39e8:	02121608 	andseq	r1, r2, #8, 12	; 0x800000
    39ec:	40050000 	andmi	r0, r5, r0
    39f0:	00063c02 	andeq	r3, r6, r2, lsl #24
    39f4:	d9160c00 	ldmdble	r6, {sl, fp}
    39f8:	05000004 	streq	r0, [r0, #-4]
    39fc:	00300242 	eorseq	r0, r0, r2, asr #4
    3a00:	16100000 	ldrne	r0, [r0], -r0
    3a04:	000000f3 	strdeq	r0, [r0], -r3
    3a08:	1e024305 	cdpne	3, 0, cr4, cr2, cr5, {0}
    3a0c:	14000008 	strne	r0, [r0], #-8
    3a10:	00036e16 	andeq	r6, r3, r6, lsl lr
    3a14:	02450500 	subeq	r0, r5, #0, 10
    3a18:	00000030 	andeq	r0, r0, r0, lsr r0
    3a1c:	051a1630 	ldreq	r1, [sl, #-1584]	; 0x630
    3a20:	46050000 	strmi	r0, [r5], -r0
    3a24:	00058602 	andeq	r8, r5, r2, lsl #12
    3a28:	00163400 	andseq	r3, r6, r0, lsl #8
    3a2c:	05000000 	streq	r0, [r0, #-0]
    3a30:	00300248 	eorseq	r0, r0, r8, asr #4
    3a34:	16380000 	ldrtne	r0, [r8], -r0
    3a38:	00000388 	andeq	r0, r0, r8, lsl #7
    3a3c:	39024a05 	stmdbcc	r2, {r0, r2, r9, fp, lr}
    3a40:	3c000008 	stccc	0, cr0, [r0], {8}
    3a44:	0004c316 	andeq	ip, r4, r6, lsl r3
    3a48:	024d0500 	subeq	r0, sp, #0, 10
    3a4c:	00000170 	andeq	r0, r0, r0, ror r1
    3a50:	00611640 	rsbeq	r1, r1, r0, asr #12
    3a54:	4e050000 	cdpmi	0, 0, cr0, cr5, cr0, {0}
    3a58:	00003002 	andeq	r3, r0, r2
    3a5c:	fd164400 	ldc2	4, cr4, [r6, #-0]
    3a60:	05000004 	streq	r0, [r0, #-4]
    3a64:	0170024f 	cmneq	r0, pc, asr #4
    3a68:	16480000 	strbne	r0, [r8], -r0
    3a6c:	00000155 	andeq	r0, r0, r5, asr r1
    3a70:	3f025005 	svccc	0x00025005
    3a74:	4c000008 	stcmi	0, cr0, [r0], {8}
    3a78:	0000fe16 	andeq	pc, r0, r6, lsl lr	; <UNPREDICTABLE>
    3a7c:	02530500 	subseq	r0, r3, #0, 10
    3a80:	00000030 	andeq	r0, r0, r0, lsr r0
    3a84:	02b31650 	adcseq	r1, r3, #80, 12	; 0x5000000
    3a88:	54050000 	strpl	r0, [r5], #-0
    3a8c:	00055502 	andeq	r5, r5, r2, lsl #10
    3a90:	54165400 	ldrpl	r5, [r6], #-1024	; 0x400
    3a94:	05000005 	streq	r0, [r0, #-5]
    3a98:	07fc0277 			; <UNDEFINED> instruction: 0x07fc0277
    3a9c:	17580000 	ldrbne	r0, [r8, -r0]
    3aa0:	000000eb 	andeq	r0, r0, fp, ror #1
    3aa4:	8d027b05 	vstrhi	d7, [r2, #-20]	; 0xffffffec
    3aa8:	48000002 	stmdami	r0, {r1}
    3aac:	01a41701 			; <UNDEFINED> instruction: 0x01a41701
    3ab0:	7c050000 	stcvc	0, cr0, [r5], {-0}
    3ab4:	00024f02 	andeq	r4, r2, r2, lsl #30
    3ab8:	17014c00 	strne	r4, [r1, -r0, lsl #24]
    3abc:	00000142 	andeq	r0, r0, r2, asr #2
    3ac0:	50028005 	andpl	r8, r2, r5
    3ac4:	dc000008 	stcle	0, cr0, [r0], {8}
    3ac8:	02411702 	subeq	r1, r1, #524288	; 0x80000
    3acc:	85050000 	strhi	r0, [r5, #-0]
    3ad0:	00060102 	andeq	r0, r6, r2, lsl #2
    3ad4:	1702e000 	strne	lr, [r2, -r0]
    3ad8:	0000007c 	andeq	r0, r0, ip, ror r0
    3adc:	5c028605 	stcpl	6, cr8, [r2], {5}
    3ae0:	ec000008 	stc	0, cr0, [r0], {8}
    3ae4:	040f0002 	streq	r0, [pc], #-2	; 3aec <CPSR_IRQ_INHIBIT+0x3a6c>
    3ae8:	0000055b 	andeq	r0, r0, fp, asr r5
    3aec:	00080104 	andeq	r0, r8, r4, lsl #2
    3af0:	0f000002 	svceq	0x00000002
    3af4:	0003ff04 	andeq	pc, r3, r4, lsl #30
    3af8:	00301300 	eorseq	r1, r0, r0, lsl #6
    3afc:	05860000 	streq	r0, [r6]
    3b00:	1d140000 	ldcne	0, cr0, [r4, #-0]
    3b04:	14000004 	strne	r0, [r0], #-4
    3b08:	00000110 	andeq	r0, r0, r0, lsl r1
    3b0c:	00058614 	andeq	r8, r5, r4, lsl r6
    3b10:	00301400 	eorseq	r1, r0, r0, lsl #8
    3b14:	0f000000 	svceq	0x00000000
    3b18:	00058c04 	andeq	r8, r5, r4, lsl #24
    3b1c:	055b1800 	ldrbeq	r1, [fp, #-2048]	; 0x800
    3b20:	040f0000 	streq	r0, [pc], #-0	; 3b28 <CPSR_IRQ_INHIBIT+0x3aa8>
    3b24:	00000568 	andeq	r0, r0, r8, ror #10
    3b28:	00008c13 	andeq	r8, r0, r3, lsl ip
    3b2c:	0005b500 	andeq	fp, r5, r0, lsl #10
    3b30:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
    3b34:	10140000 	andsne	r0, r4, r0
    3b38:	14000001 	strne	r0, [r0], #-1
    3b3c:	0000008c 	andeq	r0, r0, ip, lsl #1
    3b40:	00003014 	andeq	r3, r0, r4, lsl r0
    3b44:	040f0000 	streq	r0, [pc], #-0	; 3b4c <CPSR_IRQ_INHIBIT+0x3acc>
    3b48:	00000597 	muleq	r0, r7, r5
    3b4c:	00003013 	andeq	r3, r0, r3, lsl r0
    3b50:	0005cf00 	andeq	ip, r5, r0, lsl #30
    3b54:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
    3b58:	10140000 	andsne	r0, r4, r0
    3b5c:	00000001 	andeq	r0, r0, r1
    3b60:	05bb040f 	ldreq	r0, [fp, #1039]!	; 0x40f
    3b64:	45080000 	strmi	r0, [r8, #-0]
    3b68:	e5000000 	str	r0, [r0, #-0]
    3b6c:	09000005 	stmdbeq	r0, {r0, r2}
    3b70:	000000d2 	ldrdeq	r0, [r0], -r2
    3b74:	45080002 	strmi	r0, [r8, #-2]
    3b78:	f5000000 			; <UNDEFINED> instruction: 0xf5000000
    3b7c:	09000005 	stmdbeq	r0, {r0, r2}
    3b80:	000000d2 	ldrdeq	r0, [r0], -r2
    3b84:	25050000 	strcs	r0, [r5, #-0]
    3b88:	05000001 	streq	r0, [r0, #-1]
    3b8c:	02d5011d 	sbcseq	r0, r5, #1073741831	; 0x40000007
    3b90:	de190000 	cdple	0, 1, cr0, cr9, cr0, {0}
    3b94:	0c000001 	stceq	0, cr0, [r0], {1}
    3b98:	36012105 	strcc	r2, [r1], -r5, lsl #2
    3b9c:	16000006 	strne	r0, [r0], -r6
    3ba0:	0000050d 	andeq	r0, r0, sp, lsl #10
    3ba4:	36012305 	strcc	r2, [r1], -r5, lsl #6
    3ba8:	00000006 	andeq	r0, r0, r6
    3bac:	00011e16 	andeq	r1, r1, r6, lsl lr
    3bb0:	01240500 	teqeq	r4, r0, lsl #10
    3bb4:	00000030 	andeq	r0, r0, r0, lsr r0
    3bb8:	018d1604 	orreq	r1, sp, r4, lsl #12
    3bbc:	25050000 	strcs	r0, [r5, #-0]
    3bc0:	00063c01 	andeq	r3, r6, r1, lsl #24
    3bc4:	0f000800 	svceq	0x00000800
    3bc8:	00060104 	andeq	r0, r6, r4, lsl #2
    3bcc:	f5040f00 			; <UNDEFINED> instruction: 0xf5040f00
    3bd0:	19000005 	stmdbne	r0, {r0, r2}
    3bd4:	000004a3 	andeq	r0, r0, r3, lsr #9
    3bd8:	013d050e 	teqeq	sp, lr, lsl #10
    3bdc:	00000677 	andeq	r0, r0, r7, ror r6
    3be0:	00049d16 	andeq	r9, r4, r6, lsl sp
    3be4:	013e0500 	teqeq	lr, r0, lsl #10
    3be8:	00000677 	andeq	r0, r0, r7, ror r6
    3bec:	01931600 	orrseq	r1, r3, r0, lsl #12
    3bf0:	3f050000 	svccc	0x00050000
    3bf4:	00067701 	andeq	r7, r6, r1, lsl #14
    3bf8:	d4160600 	ldrle	r0, [r6], #-1536	; 0x600
    3bfc:	05000004 	streq	r0, [r0, #-4]
    3c00:	00530140 	subseq	r0, r3, r0, asr #2
    3c04:	000c0000 	andeq	r0, ip, r0
    3c08:	00005308 	andeq	r5, r0, r8, lsl #6
    3c0c:	00068700 	andeq	r8, r6, r0, lsl #14
    3c10:	00d20900 	sbcseq	r0, r2, r0, lsl #18
    3c14:	00020000 	andeq	r0, r2, r0
    3c18:	5805d01a 	stmdapl	r5, {r1, r3, r4, ip, lr, pc}
    3c1c:	00078802 	andeq	r8, r7, r2, lsl #16
    3c20:	032c1600 	teqeq	ip, #0, 12
    3c24:	5a050000 	bpl	143c2c <_stack+0xc3c2c>
    3c28:	00003702 	andeq	r3, r0, r2, lsl #14
    3c2c:	90160000 	andsls	r0, r6, r0
    3c30:	05000004 	streq	r0, [r0, #-4]
    3c34:	0555025b 	ldrbeq	r0, [r5, #-603]	; 0x25b
    3c38:	16040000 	strne	r0, [r4], -r0
    3c3c:	0000053f 	andeq	r0, r0, pc, lsr r5
    3c40:	88025c05 	stmdahi	r2, {r0, r2, sl, fp, ip, lr}
    3c44:	08000007 	stmdaeq	r0, {r0, r1, r2}
    3c48:	0000ac16 	andeq	sl, r0, r6, lsl ip
    3c4c:	025d0500 	subseq	r0, sp, #0, 10
    3c50:	00000186 	andeq	r0, r0, r6, lsl #3
    3c54:	031d1624 	tsteq	sp, #36, 12	; 0x2400000
    3c58:	5e050000 	cdppl	0, 0, cr0, cr5, cr0, {0}
    3c5c:	00003002 	andeq	r3, r0, r2
    3c60:	08164800 	ldmdaeq	r6, {fp, lr}
    3c64:	05000005 	streq	r0, [r0, #-5]
    3c68:	006f025f 	rsbeq	r0, pc, pc, asr r2	; <UNPREDICTABLE>
    3c6c:	16500000 	ldrbne	r0, [r0], -r0
    3c70:	000000de 	ldrdeq	r0, [r0], -lr
    3c74:	42026005 	andmi	r6, r2, #5
    3c78:	58000006 	stmdapl	r0, {r1, r2}
    3c7c:	00001316 	andeq	r1, r0, r6, lsl r3
    3c80:	02610500 	rsbeq	r0, r1, #0, 10
    3c84:	000000fa 	strdeq	r0, [r0], -sl
    3c88:	034b1668 	movteq	r1, #46696	; 0xb668
    3c8c:	62050000 	andvs	r0, r5, #0
    3c90:	0000fa02 	andeq	pc, r0, r2, lsl #20
    3c94:	e3167000 	tst	r6, #0
    3c98:	05000004 	streq	r0, [r0, #-4]
    3c9c:	00fa0263 	rscseq	r0, sl, r3, ror #4
    3ca0:	16780000 	ldrbtne	r0, [r8], -r0
    3ca4:	00000020 	andeq	r0, r0, r0, lsr #32
    3ca8:	98026405 	stmdals	r2, {r0, r2, sl, sp, lr}
    3cac:	80000007 	andhi	r0, r0, r7
    3cb0:	00008116 	andeq	r8, r0, r6, lsl r1
    3cb4:	02650500 	rsbeq	r0, r5, #0, 10
    3cb8:	000007a8 	andeq	r0, r0, r8, lsr #15
    3cbc:	012c1688 	smlawbeq	ip, r8, r6, r1
    3cc0:	66050000 	strvs	r0, [r5], -r0
    3cc4:	00003002 	andeq	r3, r0, r2
    3cc8:	6016a000 	andsvs	sl, r6, r0
    3ccc:	05000003 	streq	r0, [r0, #-3]
    3cd0:	00fa0267 	rscseq	r0, sl, r7, ror #4
    3cd4:	16a40000 	strtne	r0, [r4], r0
    3cd8:	00000289 	andeq	r0, r0, r9, lsl #5
    3cdc:	fa026805 	blx	9dcf8 <_stack+0x1dcf8>
    3ce0:	ac000000 	stcge	0, cr0, [r0], {-0}
    3ce4:	0000cd16 	andeq	ip, r0, r6, lsl sp
    3ce8:	02690500 	rsbeq	r0, r9, #0, 10
    3cec:	000000fa 	strdeq	r0, [r0], -sl
    3cf0:	052a16b4 	streq	r1, [sl, #-1716]!	; 0x6b4
    3cf4:	6a050000 	bvs	143cfc <_stack+0xc3cfc>
    3cf8:	0000fa02 	andeq	pc, r0, r2, lsl #20
    3cfc:	8d16bc00 	ldchi	12, cr11, [r6, #-0]
    3d00:	05000000 	streq	r0, [r0, #-0]
    3d04:	00fa026b 	rscseq	r0, sl, fp, ror #4
    3d08:	16c40000 	strbne	r0, [r4], r0
    3d0c:	00000238 	andeq	r0, r0, r8, lsr r2
    3d10:	30026c05 	andcc	r6, r2, r5, lsl #24
    3d14:	cc000000 	stcgt	0, cr0, [r0], {-0}
    3d18:	055b0800 	ldrbeq	r0, [fp, #-2048]	; 0x800
    3d1c:	07980000 	ldreq	r0, [r8, r0]
    3d20:	d2090000 	andle	r0, r9, #0
    3d24:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    3d28:	055b0800 	ldrbeq	r0, [fp, #-2048]	; 0x800
    3d2c:	07a80000 	streq	r0, [r8, r0]!
    3d30:	d2090000 	andle	r0, r9, #0
    3d34:	07000000 	streq	r0, [r0, -r0]
    3d38:	055b0800 	ldrbeq	r0, [fp, #-2048]	; 0x800
    3d3c:	07b80000 	ldreq	r0, [r8, r0]!
    3d40:	d2090000 	andle	r0, r9, #0
    3d44:	17000000 	strne	r0, [r0, -r0]
    3d48:	05f01a00 	ldrbeq	r1, [r0, #2560]!	; 0xa00
    3d4c:	07dc0271 			; <UNDEFINED> instruction: 0x07dc0271
    3d50:	0b160000 	bleq	583d58 <_stack+0x503d58>
    3d54:	05000002 	streq	r0, [r0, #-2]
    3d58:	07dc0274 			; <UNDEFINED> instruction: 0x07dc0274
    3d5c:	16000000 	strne	r0, [r0], -r0
    3d60:	0000014c 	andeq	r0, r0, ip, asr #2
    3d64:	ec027505 	cfstr32	mvfx7, [r2], {5}
    3d68:	78000007 	stmdavc	r0, {r0, r1, r2}
    3d6c:	02cf0800 	sbceq	r0, pc, #0, 16
    3d70:	07ec0000 	strbeq	r0, [ip, r0]!
    3d74:	d2090000 	andle	r0, r9, #0
    3d78:	1d000000 	stcne	0, cr0, [r0, #-0]
    3d7c:	00370800 	eorseq	r0, r7, r0, lsl #16
    3d80:	07fc0000 	ldrbeq	r0, [ip, r0]!
    3d84:	d2090000 	andle	r0, r9, #0
    3d88:	1d000000 	stcne	0, cr0, [r0, #-0]
    3d8c:	05f01b00 	ldrbeq	r1, [r0, #2816]!	; 0xb00
    3d90:	081e0256 	ldmdaeq	lr, {r1, r2, r4, r6, r9}
    3d94:	a21c0000 	andsge	r0, ip, #0
    3d98:	05000003 	streq	r0, [r0, #-3]
    3d9c:	0687026d 	streq	r0, [r7], sp, ror #4
    3da0:	431c0000 	tstmi	ip, #0
    3da4:	05000003 	streq	r0, [r0, #-3]
    3da8:	07b80276 			; <UNDEFINED> instruction: 0x07b80276
    3dac:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    3db0:	0000055b 	andeq	r0, r0, fp, asr r5
    3db4:	0000082e 	andeq	r0, r0, lr, lsr #16
    3db8:	0000d209 	andeq	sp, r0, r9, lsl #4
    3dbc:	1d001800 	stcne	8, cr1, [r0, #-0]
    3dc0:	00000839 	andeq	r0, r0, r9, lsr r8
    3dc4:	00041d14 	andeq	r1, r4, r4, lsl sp
    3dc8:	040f0000 	streq	r0, [pc], #-0	; 3dd0 <CPSR_IRQ_INHIBIT+0x3d50>
    3dcc:	0000082e 	andeq	r0, r0, lr, lsr #16
    3dd0:	0170040f 	cmneq	r0, pc, lsl #8
    3dd4:	501d0000 	andspl	r0, sp, r0
    3dd8:	14000008 	strne	r0, [r0], #-8
    3ddc:	00000030 	andeq	r0, r0, r0, lsr r0
    3de0:	56040f00 	strpl	r0, [r4], -r0, lsl #30
    3de4:	0f000008 	svceq	0x00000008
    3de8:	00084504 	andeq	r4, r8, r4, lsl #10
    3dec:	05f50800 	ldrbeq	r0, [r5, #2048]!	; 0x800
    3df0:	086c0000 	stmdaeq	ip!, {}^	; <UNPREDICTABLE>
    3df4:	d2090000 	andle	r0, r9, #0
    3df8:	02000000 	andeq	r0, r0, #0
    3dfc:	07991e00 	ldreq	r1, [r9, r0, lsl #28]
    3e00:	9a060000 	bls	183e08 <_stack+0x103e08>
    3e04:	00000110 	andeq	r0, r0, r0, lsl r1
    3e08:	00008e90 	muleq	r0, r0, lr
    3e0c:	00000026 	andeq	r0, r0, r6, lsr #32
    3e10:	08d79c01 	ldmeq	r7, {r0, sl, fp, ip, pc}^
    3e14:	701f0000 	andsvc	r0, pc, r0
    3e18:	01007274 	tsteq	r0, r4, ror r2
    3e1c:	00041d32 	andeq	r1, r4, r2, lsr sp
    3e20:	0013ff00 	andseq	pc, r3, r0, lsl #30
    3e24:	09572000 	ldmdbeq	r7, {sp}^
    3e28:	32010000 	andcc	r0, r1, #0
    3e2c:	00000025 	andeq	r0, r0, r5, lsr #32
    3e30:	0000141d 	andeq	r1, r0, sp, lsl r4
    3e34:	74657221 	strbtvc	r7, [r5], #-545	; 0x221
    3e38:	55360100 	ldrpl	r0, [r6, #-256]!	; 0x100
    3e3c:	01000005 	tsteq	r0, r5
    3e40:	098e2250 	stmibeq	lr, {r4, r6, r9, sp}
    3e44:	37010000 	strcc	r0, [r1, -r0]
    3e48:	00000110 	andeq	r0, r0, r0, lsl r1
    3e4c:	000008c5 	andeq	r0, r0, r5, asr #17
    3e50:	00002514 	andeq	r2, r0, r4, lsl r5
    3e54:	a6230000 	strtge	r0, [r3], -r0
    3e58:	e200008e 	and	r0, r0, #142	; 0x8e
    3e5c:	24000008 	strcs	r0, [r0], #-8
    3e60:	f3035001 	vhadd.u8	d5, d3, d1
    3e64:	00005101 	andeq	r5, r0, r1, lsl #2
    3e68:	00023b25 	andeq	r3, r2, r5, lsr #22
    3e6c:	30180100 	andscc	r0, r8, r0, lsl #2
    3e70:	26000000 	strcs	r0, [r0], -r0
    3e74:	0000098e 	andeq	r0, r0, lr, lsl #19
    3e78:	01103701 	tsteq	r0, r1, lsl #14
    3e7c:	25140000 	ldrcs	r0, [r4, #-0]
    3e80:	00000000 	andeq	r0, r0, r0
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	25011101 	strcs	r1, [r1, #-257]	; 0x101
   4:	030b130e 	movweq	r1, #45838	; 0xb30e
   8:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
   c:	10011117 	andne	r1, r1, r7, lsl r1
  10:	02000017 	andeq	r0, r0, #23
  14:	0b0b0024 	bleq	2c00ac <_stack+0x2400ac>
  18:	0e030b3e 	vmoveq.16	d3[0], r0
  1c:	24030000 	strcs	r0, [r3], #-0
  20:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  24:	0008030b 	andeq	r0, r8, fp, lsl #6
  28:	00160400 	andseq	r0, r6, r0, lsl #8
  2c:	0b3a0e03 	bleq	e83840 <_stack+0xe03840>
  30:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  34:	16050000 	strne	r0, [r5], -r0
  38:	3a0e0300 	bcc	380c40 <_stack+0x300c40>
  3c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
  40:	06000013 			; <UNDEFINED> instruction: 0x06000013
  44:	0b0b0117 	bleq	2c04a8 <_stack+0x2404a8>
  48:	0b3b0b3a 	bleq	ec2d38 <_stack+0xe42d38>
  4c:	00001301 	andeq	r1, r0, r1, lsl #6
  50:	03000d07 	movweq	r0, #3335	; 0xd07
  54:	3b0b3a0e 	blcc	2ce894 <_stack+0x24e894>
  58:	0013490b 	andseq	r4, r3, fp, lsl #18
  5c:	01010800 	tsteq	r1, r0, lsl #16
  60:	13011349 	movwne	r1, #4937	; 0x1349
  64:	21090000 	mrscs	r0, (UNDEF: 9)
  68:	2f134900 	svccs	0x00134900
  6c:	0a00000b 	beq	a0 <CPSR_IRQ_INHIBIT+0x20>
  70:	0b0b0113 	bleq	2c04c4 <_stack+0x2404c4>
  74:	0b3b0b3a 	bleq	ec2d64 <_stack+0xe42d64>
  78:	00001301 	andeq	r1, r0, r1, lsl #6
  7c:	03000d0b 	movweq	r0, #3339	; 0xd0b
  80:	3b0b3a0e 	blcc	2ce8c0 <_stack+0x24e8c0>
  84:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
  88:	0c00000b 	stceq	0, cr0, [r0], {11}
  8c:	0b0b000f 	bleq	2c00d0 <_stack+0x2400d0>
  90:	130d0000 	movwne	r0, #53248	; 0xd000
  94:	0b0e0301 	bleq	380ca0 <_stack+0x300ca0>
  98:	3b0b3a0b 	blcc	2ce8cc <_stack+0x24e8cc>
  9c:	0013010b 	andseq	r0, r3, fp, lsl #2
  a0:	000d0e00 	andeq	r0, sp, r0, lsl #28
  a4:	0b3a0803 	bleq	e820b8 <_stack+0xe020b8>
  a8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  ac:	00000b38 	andeq	r0, r0, r8, lsr fp
  b0:	0b000f0f 	bleq	3cf4 <CPSR_IRQ_INHIBIT+0x3c74>
  b4:	0013490b 	andseq	r4, r3, fp, lsl #18
  b8:	01131000 	tsteq	r3, r0
  bc:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
  c0:	0b3b0b3a 	bleq	ec2db0 <_stack+0xe42db0>
  c4:	00001301 	andeq	r1, r0, r1, lsl #6
  c8:	03000d11 	movweq	r0, #3345	; 0xd11
  cc:	3b0b3a0e 	blcc	2ce90c <_stack+0x24e90c>
  d0:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
  d4:	12000005 	andne	r0, r0, #5
  d8:	19270015 	stmdbne	r7!, {r0, r2, r4}
  dc:	15130000 	ldrne	r0, [r3, #-0]
  e0:	49192701 	ldmdbmi	r9, {r0, r8, r9, sl, sp}
  e4:	00130113 	andseq	r0, r3, r3, lsl r1
  e8:	00051400 	andeq	r1, r5, r0, lsl #8
  ec:	00001349 	andeq	r1, r0, r9, asr #6
  f0:	03011315 	movweq	r1, #4885	; 0x1315
  f4:	3a050b0e 	bcc	142d34 <_stack+0xc2d34>
  f8:	01053b0b 	tsteq	r5, fp, lsl #22
  fc:	16000013 			; <UNDEFINED> instruction: 0x16000013
 100:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 104:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 108:	0b381349 	bleq	e04e34 <_stack+0xd84e34>
 10c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 110:	3a0e0300 	bcc	380d18 <_stack+0x300d18>
 114:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 118:	00053813 	andeq	r3, r5, r3, lsl r8
 11c:	00261800 	eoreq	r1, r6, r0, lsl #16
 120:	00001349 	andeq	r1, r0, r9, asr #6
 124:	03011319 	movweq	r1, #4889	; 0x1319
 128:	3a0b0b0e 	bcc	2c2d68 <_stack+0x242d68>
 12c:	01053b0b 	tsteq	r5, fp, lsl #22
 130:	1a000013 	bne	184 <CPSR_IRQ_INHIBIT+0x104>
 134:	0b0b0113 	bleq	2c0588 <_stack+0x240588>
 138:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 13c:	00001301 	andeq	r1, r0, r1, lsl #6
 140:	0b01171b 	bleq	45db4 <__bss_end__+0x3c58c>
 144:	3b0b3a0b 	blcc	2ce978 <_stack+0x24e978>
 148:	00130105 	andseq	r0, r3, r5, lsl #2
 14c:	000d1c00 	andeq	r1, sp, r0, lsl #24
 150:	0b3a0e03 	bleq	e83964 <_stack+0xe03964>
 154:	1349053b 	movtne	r0, #38203	; 0x953b
 158:	151d0000 	ldrne	r0, [sp, #-0]
 15c:	01192701 	tsteq	r9, r1, lsl #14
 160:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
 164:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 168:	0b3a0e03 	bleq	e8397c <_stack+0xe0397c>
 16c:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 170:	06120111 			; <UNDEFINED> instruction: 0x06120111
 174:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 178:	00130119 	andseq	r0, r3, r9, lsl r1
 17c:	00051f00 	andeq	r1, r5, r0, lsl #30
 180:	0b3a0803 	bleq	e82194 <_stack+0xe02194>
 184:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 188:	00001702 	andeq	r1, r0, r2, lsl #14
 18c:	03000520 	movweq	r0, #1312	; 0x520
 190:	3b0b3a0e 	blcc	2ce9d0 <_stack+0x24e9d0>
 194:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 198:	21000017 	tstcs	r0, r7, lsl r0
 19c:	01018289 	smlabbeq	r1, r9, r2, r8
 1a0:	13310111 	teqne	r1, #1073741828	; 0x40000004
 1a4:	00001301 	andeq	r1, r0, r1, lsl #6
 1a8:	01828a22 	orreq	r8, r2, r2, lsr #20
 1ac:	91180200 	tstls	r8, r0, lsl #4
 1b0:	00001842 	andeq	r1, r0, r2, asr #16
 1b4:	01828923 	orreq	r8, r2, r3, lsr #18
 1b8:	95011101 	strls	r1, [r1, #-257]	; 0x101
 1bc:	13311942 	teqne	r1, #1081344	; 0x108000
 1c0:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 1c4:	03193f01 	tsteq	r9, #1, 30
 1c8:	3b0b3a0e 	blcc	2cea08 <_stack+0x24ea08>
 1cc:	11192705 	tstne	r9, r5, lsl #14
 1d0:	40061201 	andmi	r1, r6, r1, lsl #4
 1d4:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 1d8:	00001301 	andeq	r1, r0, r1, lsl #6
 1dc:	55010b25 	strpl	r0, [r1, #-2853]	; 0xb25
 1e0:	00130117 	andseq	r0, r3, r7, lsl r1
 1e4:	00342600 	eorseq	r2, r4, r0, lsl #12
 1e8:	0b3a0803 	bleq	e821fc <_stack+0xe021fc>
 1ec:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 1f0:	00001702 	andeq	r1, r0, r2, lsl #14
 1f4:	11010b27 	tstne	r1, r7, lsr #22
 1f8:	01061201 	tsteq	r6, r1, lsl #4
 1fc:	28000013 	stmdacs	r0, {r0, r1, r4}
 200:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 204:	0b3b0b3a 	bleq	ec2ef4 <_stack+0xe42ef4>
 208:	17021349 	strne	r1, [r2, -r9, asr #6]
 20c:	89290000 	stmdbhi	r9!, {}	; <UNPREDICTABLE>
 210:	11010182 	smlabbne	r1, r2, r1, r0
 214:	00133101 	andseq	r3, r3, r1, lsl #2
 218:	82892a00 	addhi	r2, r9, #0, 20
 21c:	01110101 	tsteq	r1, r1, lsl #2
 220:	00001301 	andeq	r1, r0, r1, lsl #6
 224:	0300342b 	movweq	r3, #1067	; 0x42b
 228:	3b0b3a0e 	blcc	2cea68 <_stack+0x24ea68>
 22c:	3f134905 	svccc	0x00134905
 230:	00193c19 	andseq	r3, r9, r9, lsl ip
 234:	00342c00 	eorseq	r2, r4, r0, lsl #24
 238:	0b3a0e03 	bleq	e83a4c <_stack+0xe03a4c>
 23c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 240:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 244:	2e2d0000 	cdpcs	0, 2, cr0, cr13, cr0, {0}
 248:	03193f01 	tsteq	r9, #1, 30
 24c:	3b0b3a0e 	blcc	2cea8c <_stack+0x24ea8c>
 250:	3c19270b 	ldccc	7, cr2, [r9], {11}
 254:	00000019 	andeq	r0, r0, r9, lsl r0
 258:	25011101 	strcs	r1, [r1, #-257]	; 0x101
 25c:	030b130e 	movweq	r1, #45838	; 0xb30e
 260:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
 264:	10011117 	andne	r1, r1, r7, lsl r1
 268:	02000017 	andeq	r0, r0, #23
 26c:	0b0b0024 	bleq	2c0304 <_stack+0x240304>
 270:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 274:	16030000 	strne	r0, [r3], -r0
 278:	3a0e0300 	bcc	380e80 <_stack+0x300e80>
 27c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 280:	04000013 	streq	r0, [r0], #-19
 284:	0b0b0024 	bleq	2c031c <_stack+0x24031c>
 288:	0e030b3e 	vmoveq.16	d3[0], r0
 28c:	0f050000 	svceq	0x00050000
 290:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 294:	06000013 			; <UNDEFINED> instruction: 0x06000013
 298:	13490026 	movtne	r0, #36902	; 0x9026
 29c:	2e070000 	cdpcs	0, 0, cr0, cr7, cr0, {0}
 2a0:	03193f01 	tsteq	r9, #1, 30
 2a4:	3b0b3a0e 	blcc	2ceae4 <_stack+0x24eae4>
 2a8:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
 2ac:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 2b0:	97184006 	ldrls	r4, [r8, -r6]
 2b4:	00001942 	andeq	r1, r0, r2, asr #18
 2b8:	03000508 	movweq	r0, #1288	; 0x508
 2bc:	3b0b3a08 	blcc	2ceae4 <_stack+0x24eae4>
 2c0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 2c4:	00000017 	andeq	r0, r0, r7, lsl r0
 2c8:	25011101 	strcs	r1, [r1, #-257]	; 0x101
 2cc:	030b130e 	movweq	r1, #45838	; 0xb30e
 2d0:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
 2d4:	10011117 	andne	r1, r1, r7, lsl r1
 2d8:	02000017 	andeq	r0, r0, #23
 2dc:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 2e0:	0b3b0b3a 	bleq	ec2fd0 <_stack+0xe42fd0>
 2e4:	00001349 	andeq	r1, r0, r9, asr #6
 2e8:	0b002403 	bleq	92fc <impure_data+0x354>
 2ec:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 2f0:	04000008 	streq	r0, [r0], #-8
 2f4:	0b0b0024 	bleq	2c038c <_stack+0x24038c>
 2f8:	0e030b3e 	vmoveq.16	d3[0], r0
 2fc:	0f050000 	svceq	0x00050000
 300:	000b0b00 	andeq	r0, fp, r0, lsl #22
 304:	00160600 	andseq	r0, r6, r0, lsl #12
 308:	0b3a0e03 	bleq	e83b1c <_stack+0xe03b1c>
 30c:	1349053b 	movtne	r0, #38203	; 0x953b
 310:	17070000 	strne	r0, [r7, -r0]
 314:	3a0b0b01 	bcc	2c2f20 <_stack+0x242f20>
 318:	010b3b0b 	tsteq	fp, fp, lsl #22
 31c:	08000013 	stmdaeq	r0, {r0, r1, r4}
 320:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 324:	0b3b0b3a 	bleq	ec3014 <_stack+0xe43014>
 328:	00001349 	andeq	r1, r0, r9, asr #6
 32c:	49010109 	stmdbmi	r1, {r0, r3, r8}
 330:	00130113 	andseq	r0, r3, r3, lsl r1
 334:	00210a00 	eoreq	r0, r1, r0, lsl #20
 338:	0b2f1349 	bleq	bc5064 <_stack+0xb45064>
 33c:	130b0000 	movwne	r0, #45056	; 0xb000
 340:	3a0b0b01 	bcc	2c2f4c <_stack+0x242f4c>
 344:	010b3b0b 	tsteq	fp, fp, lsl #22
 348:	0c000013 	stceq	0, cr0, [r0], {19}
 34c:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 350:	0b3b0b3a 	bleq	ec3040 <_stack+0xe43040>
 354:	0b381349 	bleq	e05080 <_stack+0xd85080>
 358:	130d0000 	movwne	r0, #53248	; 0xd000
 35c:	0b0e0301 	bleq	380f68 <_stack+0x300f68>
 360:	3b0b3a0b 	blcc	2ceb94 <_stack+0x24eb94>
 364:	0013010b 	andseq	r0, r3, fp, lsl #2
 368:	000d0e00 	andeq	r0, sp, r0, lsl #28
 36c:	0b3a0803 	bleq	e82380 <_stack+0xe02380>
 370:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 374:	00000b38 	andeq	r0, r0, r8, lsr fp
 378:	0b000f0f 	bleq	3fbc <CPSR_IRQ_INHIBIT+0x3f3c>
 37c:	0013490b 	andseq	r4, r3, fp, lsl #18
 380:	01131000 	tsteq	r3, r0
 384:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
 388:	0b3b0b3a 	bleq	ec3078 <_stack+0xe43078>
 38c:	00001301 	andeq	r1, r0, r1, lsl #6
 390:	03000d11 	movweq	r0, #3345	; 0xd11
 394:	3b0b3a0e 	blcc	2cebd4 <_stack+0x24ebd4>
 398:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 39c:	12000005 	andne	r0, r0, #5
 3a0:	19270015 	stmdbne	r7!, {r0, r2, r4}
 3a4:	15130000 	ldrne	r0, [r3, #-0]
 3a8:	49192701 	ldmdbmi	r9, {r0, r8, r9, sl, sp}
 3ac:	00130113 	andseq	r0, r3, r3, lsl r1
 3b0:	00051400 	andeq	r1, r5, r0, lsl #8
 3b4:	00001349 	andeq	r1, r0, r9, asr #6
 3b8:	03011315 	movweq	r1, #4885	; 0x1315
 3bc:	3a050b0e 	bcc	142ffc <_stack+0xc2ffc>
 3c0:	01053b0b 	tsteq	r5, fp, lsl #22
 3c4:	16000013 			; <UNDEFINED> instruction: 0x16000013
 3c8:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 3cc:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 3d0:	0b381349 	bleq	e050fc <_stack+0xd850fc>
 3d4:	0d170000 	ldceq	0, cr0, [r7, #-0]
 3d8:	3a0e0300 	bcc	380fe0 <_stack+0x300fe0>
 3dc:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e0:	00053813 	andeq	r3, r5, r3, lsl r8
 3e4:	00261800 	eoreq	r1, r6, r0, lsl #16
 3e8:	00001349 	andeq	r1, r0, r9, asr #6
 3ec:	03011319 	movweq	r1, #4889	; 0x1319
 3f0:	3a0b0b0e 	bcc	2c3030 <_stack+0x243030>
 3f4:	01053b0b 	tsteq	r5, fp, lsl #22
 3f8:	1a000013 	bne	44c <CPSR_IRQ_INHIBIT+0x3cc>
 3fc:	0b0b0113 	bleq	2c0850 <_stack+0x240850>
 400:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 404:	00001301 	andeq	r1, r0, r1, lsl #6
 408:	0b01171b 	bleq	4607c <__bss_end__+0x3c854>
 40c:	3b0b3a0b 	blcc	2cec40 <_stack+0x24ec40>
 410:	00130105 	andseq	r0, r3, r5, lsl #2
 414:	000d1c00 	andeq	r1, sp, r0, lsl #24
 418:	0b3a0e03 	bleq	e83c2c <_stack+0xe03c2c>
 41c:	1349053b 	movtne	r0, #38203	; 0x953b
 420:	151d0000 	ldrne	r0, [sp, #-0]
 424:	01192701 	tsteq	r9, r1, lsl #14
 428:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
 42c:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 430:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 434:	0b381349 	bleq	e05160 <_stack+0xd85160>
 438:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 43c:	03193f01 	tsteq	r9, #1, 30
 440:	3b0b3a0e 	blcc	2cec80 <_stack+0x24ec80>
 444:	49192705 	ldmdbmi	r9, {r0, r2, r8, r9, sl, sp}
 448:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 44c:	97184006 	ldrls	r4, [r8, -r6]
 450:	13011942 	movwne	r1, #6466	; 0x1942
 454:	05200000 	streq	r0, [r0, #-0]!
 458:	3a0e0300 	bcc	381060 <_stack+0x301060>
 45c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 460:	00170213 	andseq	r0, r7, r3, lsl r2
 464:	00052100 	andeq	r2, r5, r0, lsl #2
 468:	0b3a0803 	bleq	e8247c <_stack+0xe0247c>
 46c:	1349053b 	movtne	r0, #38203	; 0x953b
 470:	00001702 	andeq	r1, r0, r2, lsl #14
 474:	03003422 	movweq	r3, #1058	; 0x422
 478:	3b0b3a0e 	blcc	2cecb8 <_stack+0x24ecb8>
 47c:	02134905 	andseq	r4, r3, #81920	; 0x14000
 480:	23000017 	movwcs	r0, #23
 484:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 488:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 48c:	051c1349 	ldreq	r1, [ip, #-841]	; 0x349
 490:	89240000 	stmdbhi	r4!, {}	; <UNPREDICTABLE>
 494:	11010182 	smlabbne	r1, r2, r1, r0
 498:	01133101 	tsteq	r3, r1, lsl #2
 49c:	25000013 	strcs	r0, [r0, #-19]
 4a0:	0001828a 	andeq	r8, r1, sl, lsl #5
 4a4:	42911802 	addsmi	r1, r1, #131072	; 0x20000
 4a8:	26000018 			; <UNDEFINED> instruction: 0x26000018
 4ac:	01018289 	smlabbeq	r1, r9, r2, r8
 4b0:	13310111 	teqne	r1, #1073741828	; 0x40000004
 4b4:	2e270000 	cdpcs	0, 2, cr0, cr7, cr0, {0}
 4b8:	03193f01 	tsteq	r9, #1, 30
 4bc:	3b0b3a0e 	blcc	2cecfc <_stack+0x24ecfc>
 4c0:	11192705 	tstne	r9, r5, lsl #14
 4c4:	40061201 	andmi	r1, r6, r1, lsl #4
 4c8:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 4cc:	00001301 	andeq	r1, r0, r1, lsl #6
 4d0:	03003428 	movweq	r3, #1064	; 0x428
 4d4:	3b0b3a08 	blcc	2cecfc <_stack+0x24ecfc>
 4d8:	02134905 	andseq	r4, r3, #81920	; 0x14000
 4dc:	29000017 	stmdbcs	r0, {r0, r1, r2, r4}
 4e0:	01018289 	smlabbeq	r1, r9, r2, r8
 4e4:	42950111 	addsmi	r0, r5, #1073741828	; 0x40000004
 4e8:	01133119 	tsteq	r3, r9, lsl r1
 4ec:	2a000013 	bcs	540 <CPSR_IRQ_INHIBIT+0x4c0>
 4f0:	13490021 	movtne	r0, #36897	; 0x9021
 4f4:	0000052f 	andeq	r0, r0, pc, lsr #10
 4f8:	0300342b 	movweq	r3, #1067	; 0x42b
 4fc:	3b0b3a0e 	blcc	2ced3c <_stack+0x24ed3c>
 500:	3f134905 	svccc	0x00134905
 504:	00193c19 	andseq	r3, r9, r9, lsl ip
 508:	012e2c00 	teqeq	lr, r0, lsl #24
 50c:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 510:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 514:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
 518:	00001301 	andeq	r1, r0, r1, lsl #6
 51c:	3f012e2d 	svccc	0x00012e2d
 520:	3a0e0319 	bcc	38118c <_stack+0x30118c>
 524:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 528:	3c134919 	ldccc	9, cr4, [r3], {25}
 52c:	00130119 	andseq	r0, r3, r9, lsl r1
 530:	012e2e00 	teqeq	lr, r0, lsl #28
 534:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
 538:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 53c:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
 540:	01000000 	mrseq	r0, (UNDEF: 0)
 544:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 548:	0e030b13 	vmoveq.32	d3[0], r0
 54c:	17100e1b 			; <UNDEFINED> instruction: 0x17100e1b
 550:	24020000 	strcs	r0, [r2], #-0
 554:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 558:	0008030b 	andeq	r0, r8, fp, lsl #6
 55c:	00240300 	eoreq	r0, r4, r0, lsl #6
 560:	0b3e0b0b 	bleq	f83194 <_stack+0xf03194>
 564:	00000e03 	andeq	r0, r0, r3, lsl #28
 568:	03001604 	movweq	r1, #1540	; 0x604
 56c:	3b0b3a0e 	blcc	2cedac <_stack+0x24edac>
 570:	0013490b 	andseq	r4, r3, fp, lsl #18
 574:	00160500 	andseq	r0, r6, r0, lsl #10
 578:	0b3a0e03 	bleq	e83d8c <_stack+0xe03d8c>
 57c:	1349053b 	movtne	r0, #38203	; 0x953b
 580:	17060000 	strne	r0, [r6, -r0]
 584:	3a0b0b01 	bcc	2c3190 <_stack+0x243190>
 588:	010b3b0b 	tsteq	fp, fp, lsl #22
 58c:	07000013 	smladeq	r0, r3, r0, r0
 590:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 594:	0b3b0b3a 	bleq	ec3284 <_stack+0xe43284>
 598:	00001349 	andeq	r1, r0, r9, asr #6
 59c:	49010108 	stmdbmi	r1, {r3, r8}
 5a0:	00130113 	andseq	r0, r3, r3, lsl r1
 5a4:	00210900 	eoreq	r0, r1, r0, lsl #18
 5a8:	0b2f1349 	bleq	bc52d4 <_stack+0xb452d4>
 5ac:	130a0000 	movwne	r0, #40960	; 0xa000
 5b0:	3a0b0b01 	bcc	2c31bc <_stack+0x2431bc>
 5b4:	010b3b0b 	tsteq	fp, fp, lsl #22
 5b8:	0b000013 	bleq	60c <CPSR_IRQ_INHIBIT+0x58c>
 5bc:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 5c0:	0b3b0b3a 	bleq	ec32b0 <_stack+0xe432b0>
 5c4:	0b381349 	bleq	e052f0 <_stack+0xd852f0>
 5c8:	0f0c0000 	svceq	0x000c0000
 5cc:	000b0b00 	andeq	r0, fp, r0, lsl #22
 5d0:	01130d00 	tsteq	r3, r0, lsl #26
 5d4:	0b0b0e03 	bleq	2c3de8 <_stack+0x243de8>
 5d8:	0b3b0b3a 	bleq	ec32c8 <_stack+0xe432c8>
 5dc:	00001301 	andeq	r1, r0, r1, lsl #6
 5e0:	03000d0e 	movweq	r0, #3342	; 0xd0e
 5e4:	3b0b3a08 	blcc	2cee0c <_stack+0x24ee0c>
 5e8:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 5ec:	0f00000b 	svceq	0x0000000b
 5f0:	0b0b000f 	bleq	2c0634 <_stack+0x240634>
 5f4:	00001349 	andeq	r1, r0, r9, asr #6
 5f8:	03011310 	movweq	r1, #4880	; 0x1310
 5fc:	3a050b0e 	bcc	14323c <_stack+0xc323c>
 600:	010b3b0b 	tsteq	fp, fp, lsl #22
 604:	11000013 	tstne	r0, r3, lsl r0
 608:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 60c:	0b3b0b3a 	bleq	ec32fc <_stack+0xe432fc>
 610:	05381349 	ldreq	r1, [r8, #-841]!	; 0x349
 614:	15120000 	ldrne	r0, [r2, #-0]
 618:	00192700 	andseq	r2, r9, r0, lsl #14
 61c:	01151300 	tsteq	r5, r0, lsl #6
 620:	13491927 	movtne	r1, #39207	; 0x9927
 624:	00001301 	andeq	r1, r0, r1, lsl #6
 628:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 62c:	15000013 	strne	r0, [r0, #-19]
 630:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 634:	0b3a050b 	bleq	e81a68 <_stack+0xe01a68>
 638:	1301053b 	movwne	r0, #5435	; 0x153b
 63c:	0d160000 	ldceq	0, cr0, [r6, #-0]
 640:	3a0e0300 	bcc	381248 <_stack+0x301248>
 644:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 648:	000b3813 	andeq	r3, fp, r3, lsl r8
 64c:	000d1700 	andeq	r1, sp, r0, lsl #14
 650:	0b3a0e03 	bleq	e83e64 <_stack+0xe03e64>
 654:	1349053b 	movtne	r0, #38203	; 0x953b
 658:	00000538 	andeq	r0, r0, r8, lsr r5
 65c:	49002618 	stmdbmi	r0, {r3, r4, r9, sl, sp}
 660:	19000013 	stmdbne	r0, {r0, r1, r4}
 664:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 668:	0b3a0b0b 	bleq	e8329c <_stack+0xe0329c>
 66c:	1301053b 	movwne	r0, #5435	; 0x153b
 670:	131a0000 	tstne	sl, #0
 674:	3a0b0b01 	bcc	2c3280 <_stack+0x243280>
 678:	01053b0b 	tsteq	r5, fp, lsl #22
 67c:	1b000013 	blne	6d0 <CPSR_IRQ_INHIBIT+0x650>
 680:	0b0b0117 	bleq	2c0ae4 <_stack+0x240ae4>
 684:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 688:	00001301 	andeq	r1, r0, r1, lsl #6
 68c:	03000d1c 	movweq	r0, #3356	; 0xd1c
 690:	3b0b3a0e 	blcc	2ceed0 <_stack+0x24eed0>
 694:	00134905 	andseq	r4, r3, r5, lsl #18
 698:	01151d00 	tsteq	r5, r0, lsl #26
 69c:	13011927 	movwne	r1, #6439	; 0x1927
 6a0:	341e0000 	ldrcc	r0, [lr], #-0
 6a4:	3a0e0300 	bcc	3812ac <_stack+0x3012ac>
 6a8:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6ac:	00180213 	andseq	r0, r8, r3, lsl r2
 6b0:	00341f00 	eorseq	r1, r4, r0, lsl #30
 6b4:	0b3a0e03 	bleq	e83ec8 <_stack+0xe03ec8>
 6b8:	1349053b 	movtne	r0, #38203	; 0x953b
 6bc:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 6c0:	01000000 	mrseq	r0, (UNDEF: 0)
 6c4:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 6c8:	0e030b13 	vmoveq.32	d3[0], r0
 6cc:	17550e1b 	smmlane	r5, fp, lr, r0
 6d0:	17100111 			; <UNDEFINED> instruction: 0x17100111
 6d4:	16020000 	strne	r0, [r2], -r0
 6d8:	3a0e0300 	bcc	3812e0 <_stack+0x3012e0>
 6dc:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6e0:	03000013 	movweq	r0, #19
 6e4:	0b0b0024 	bleq	2c077c <_stack+0x24077c>
 6e8:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 6ec:	24040000 	strcs	r0, [r4], #-0
 6f0:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 6f4:	000e030b 	andeq	r0, lr, fp, lsl #6
 6f8:	000f0500 	andeq	r0, pc, r0, lsl #10
 6fc:	00000b0b 	andeq	r0, r0, fp, lsl #22
 700:	03001606 	movweq	r1, #1542	; 0x606
 704:	3b0b3a0e 	blcc	2cef44 <_stack+0x24ef44>
 708:	00134905 	andseq	r4, r3, r5, lsl #18
 70c:	01170700 	tsteq	r7, r0, lsl #14
 710:	0b3a0b0b 	bleq	e83344 <_stack+0xe03344>
 714:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 718:	0d080000 	stceq	0, cr0, [r8, #-0]
 71c:	3a0e0300 	bcc	381324 <_stack+0x301324>
 720:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 724:	09000013 	stmdbeq	r0, {r0, r1, r4}
 728:	13490101 	movtne	r0, #37121	; 0x9101
 72c:	00001301 	andeq	r1, r0, r1, lsl #6
 730:	4900210a 	stmdbmi	r0, {r1, r3, r8, sp}
 734:	000b2f13 	andeq	r2, fp, r3, lsl pc
 738:	01130b00 	tsteq	r3, r0, lsl #22
 73c:	0b3a0b0b 	bleq	e83370 <_stack+0xe03370>
 740:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 744:	0d0c0000 	stceq	0, cr0, [ip, #-0]
 748:	3a0e0300 	bcc	381350 <_stack+0x301350>
 74c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 750:	000b3813 	andeq	r3, fp, r3, lsl r8
 754:	01130d00 	tsteq	r3, r0, lsl #26
 758:	0b0b0e03 	bleq	2c3f6c <_stack+0x243f6c>
 75c:	0b3b0b3a 	bleq	ec344c <_stack+0xe4344c>
 760:	00001301 	andeq	r1, r0, r1, lsl #6
 764:	03000d0e 	movweq	r0, #3342	; 0xd0e
 768:	3b0b3a08 	blcc	2cef90 <_stack+0x24ef90>
 76c:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 770:	0f00000b 	svceq	0x0000000b
 774:	0b0b000f 	bleq	2c07b8 <_stack+0x2407b8>
 778:	00001349 	andeq	r1, r0, r9, asr #6
 77c:	03011310 	movweq	r1, #4880	; 0x1310
 780:	3a050b0e 	bcc	1433c0 <_stack+0xc33c0>
 784:	010b3b0b 	tsteq	fp, fp, lsl #22
 788:	11000013 	tstne	r0, r3, lsl r0
 78c:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 790:	0b3b0b3a 	bleq	ec3480 <_stack+0xe43480>
 794:	05381349 	ldreq	r1, [r8, #-841]!	; 0x349
 798:	15120000 	ldrne	r0, [r2, #-0]
 79c:	00192700 	andseq	r2, r9, r0, lsl #14
 7a0:	01151300 	tsteq	r5, r0, lsl #6
 7a4:	13491927 	movtne	r1, #39207	; 0x9927
 7a8:	00001301 	andeq	r1, r0, r1, lsl #6
 7ac:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 7b0:	15000013 	strne	r0, [r0, #-19]
 7b4:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 7b8:	0b3a050b 	bleq	e81bec <_stack+0xe01bec>
 7bc:	1301053b 	movwne	r0, #5435	; 0x153b
 7c0:	0d160000 	ldceq	0, cr0, [r6, #-0]
 7c4:	3a0e0300 	bcc	3813cc <_stack+0x3013cc>
 7c8:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 7cc:	000b3813 	andeq	r3, fp, r3, lsl r8
 7d0:	000d1700 	andeq	r1, sp, r0, lsl #14
 7d4:	0b3a0e03 	bleq	e83fe8 <_stack+0xe03fe8>
 7d8:	1349053b 	movtne	r0, #38203	; 0x953b
 7dc:	00000538 	andeq	r0, r0, r8, lsr r5
 7e0:	49002618 	stmdbmi	r0, {r3, r4, r9, sl, sp}
 7e4:	19000013 	stmdbne	r0, {r0, r1, r4}
 7e8:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 7ec:	0b3a0b0b 	bleq	e83420 <_stack+0xe03420>
 7f0:	1301053b 	movwne	r0, #5435	; 0x153b
 7f4:	131a0000 	tstne	sl, #0
 7f8:	3a0b0b01 	bcc	2c3404 <_stack+0x243404>
 7fc:	01053b0b 	tsteq	r5, fp, lsl #22
 800:	1b000013 	blne	854 <CPSR_IRQ_INHIBIT+0x7d4>
 804:	0b0b0117 	bleq	2c0c68 <_stack+0x240c68>
 808:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 80c:	00001301 	andeq	r1, r0, r1, lsl #6
 810:	03000d1c 	movweq	r0, #3356	; 0xd1c
 814:	3b0b3a0e 	blcc	2cf054 <_stack+0x24f054>
 818:	00134905 	andseq	r4, r3, r5, lsl #18
 81c:	01151d00 	tsteq	r5, r0, lsl #26
 820:	13011927 	movwne	r1, #6439	; 0x1927
 824:	0d1e0000 	ldceq	0, cr0, [lr, #-0]
 828:	3a080300 	bcc	201430 <_stack+0x181430>
 82c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 830:	000b3813 	andeq	r3, fp, r3, lsl r8
 834:	012e1f00 	teqeq	lr, r0, lsl #30
 838:	0b3a0e03 	bleq	e8404c <_stack+0xe0404c>
 83c:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
 840:	13010b20 	movwne	r0, #6944	; 0x1b20
 844:	05200000 	streq	r0, [r0, #-0]!
 848:	3a0e0300 	bcc	381450 <_stack+0x301450>
 84c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 850:	21000013 	tstcs	r0, r3, lsl r0
 854:	08030005 	stmdaeq	r3, {r0, r2}
 858:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 85c:	00001349 	andeq	r1, r0, r9, asr #6
 860:	03003422 	movweq	r3, #1058	; 0x422
 864:	3b0b3a08 	blcc	2cf08c <_stack+0x24f08c>
 868:	00134905 	andseq	r4, r3, r5, lsl #18
 86c:	00342300 	eorseq	r2, r4, r0, lsl #6
 870:	0b3a0e03 	bleq	e84084 <_stack+0xe04084>
 874:	1349053b 	movtne	r0, #38203	; 0x953b
 878:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 87c:	03193f01 	tsteq	r9, #1, 30
 880:	3b0b3a0e 	blcc	2cf0c0 <_stack+0x24f0c0>
 884:	49192705 	ldmdbmi	r9, {r0, r2, r8, r9, sl, sp}
 888:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 88c:	97184006 	ldrls	r4, [r8, -r6]
 890:	13011942 	movwne	r1, #6466	; 0x1942
 894:	05250000 	streq	r0, [r5, #-0]!
 898:	3a0e0300 	bcc	3814a0 <_stack+0x3014a0>
 89c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 8a0:	00170213 	andseq	r0, r7, r3, lsl r2
 8a4:	00342600 	eorseq	r2, r4, r0, lsl #12
 8a8:	0b3a0e03 	bleq	e840bc <_stack+0xe040bc>
 8ac:	1349053b 	movtne	r0, #38203	; 0x953b
 8b0:	00001702 	andeq	r1, r0, r2, lsl #14
 8b4:	03003427 	movweq	r3, #1063	; 0x427
 8b8:	3b0b3a08 	blcc	2cf0e0 <_stack+0x24f0e0>
 8bc:	02134905 	andseq	r4, r3, #81920	; 0x14000
 8c0:	28000017 	stmdacs	r0, {r0, r1, r2, r4}
 8c4:	1331011d 	teqne	r1, #1073741831	; 0x40000007
 8c8:	17550152 			; <UNDEFINED> instruction: 0x17550152
 8cc:	05590b58 	ldrbeq	r0, [r9, #-2904]	; 0xb58
 8d0:	00001301 	andeq	r1, r0, r1, lsl #6
 8d4:	31000529 	tstcc	r0, r9, lsr #10
 8d8:	00170213 	andseq	r0, r7, r3, lsl r2
 8dc:	010b2a00 	tsteq	fp, r0, lsl #20
 8e0:	00001755 	andeq	r1, r0, r5, asr r7
 8e4:	3100342b 	tstcc	r0, fp, lsr #8
 8e8:	00170213 	andseq	r0, r7, r3, lsl r2
 8ec:	82892c00 	addhi	r2, r9, #0, 24
 8f0:	01110101 	tsteq	r1, r1, lsl #2
 8f4:	13011331 	movwne	r1, #4913	; 0x1331
 8f8:	8a2d0000 	bhi	b40900 <_stack+0xac0900>
 8fc:	02000182 	andeq	r0, r0, #-2147483616	; 0x80000020
 900:	18429118 	stmdane	r2, {r3, r4, r8, ip, pc}^
 904:	892e0000 	stmdbhi	lr!, {}	; <UNPREDICTABLE>
 908:	11010182 	smlabbne	r1, r2, r1, r0
 90c:	00133101 	andseq	r3, r3, r1, lsl #2
 910:	00212f00 	eoreq	r2, r1, r0, lsl #30
 914:	052f1349 	streq	r1, [pc, #-841]!	; 5d3 <CPSR_IRQ_INHIBIT+0x553>
 918:	34300000 	ldrtcc	r0, [r0], #-0
 91c:	3a0e0300 	bcc	381524 <_stack+0x301524>
 920:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 924:	02193f13 	andseq	r3, r9, #19, 30	; 0x4c
 928:	31000018 	tstcc	r0, r8, lsl r0
 92c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 930:	0b3a0e03 	bleq	e84144 <_stack+0xe04144>
 934:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 938:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 93c:	00001301 	andeq	r1, r0, r1, lsl #6
 940:	3f012e32 	svccc	0x00012e32
 944:	3a0e0319 	bcc	3815b0 <_stack+0x3015b0>
 948:	27053b0b 	strcs	r3, [r5, -fp, lsl #22]
 94c:	01193c19 	tsteq	r9, r9, lsl ip
 950:	33000013 	movwcc	r0, #19
 954:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 958:	0b3a0e03 	bleq	e8416c <_stack+0xe0416c>
 95c:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
 960:	0000193c 	andeq	r1, r0, ip, lsr r9
 964:	01110100 	tsteq	r1, r0, lsl #2
 968:	0b130e25 	bleq	4c4204 <_stack+0x444204>
 96c:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 970:	01111755 	tsteq	r1, r5, asr r7
 974:	00001710 	andeq	r1, r0, r0, lsl r7
 978:	0b002402 	bleq	9988 <__bss_end__+0x160>
 97c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 980:	03000008 	movweq	r0, #8
 984:	0b0b0024 	bleq	2c0a1c <_stack+0x240a1c>
 988:	0e030b3e 	vmoveq.16	d3[0], r0
 98c:	16040000 	strne	r0, [r4], -r0
 990:	3a0e0300 	bcc	381598 <_stack+0x301598>
 994:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 998:	05000013 	streq	r0, [r0, #-19]
 99c:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 9a0:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 9a4:	00001349 	andeq	r1, r0, r9, asr #6
 9a8:	0b011706 	bleq	465c8 <__bss_end__+0x3cda0>
 9ac:	3b0b3a0b 	blcc	2cf1e0 <_stack+0x24f1e0>
 9b0:	0013010b 	andseq	r0, r3, fp, lsl #2
 9b4:	000d0700 	andeq	r0, sp, r0, lsl #14
 9b8:	0b3a0e03 	bleq	e841cc <_stack+0xe041cc>
 9bc:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 9c0:	01080000 	mrseq	r0, (UNDEF: 8)
 9c4:	01134901 	tsteq	r3, r1, lsl #18
 9c8:	09000013 	stmdbeq	r0, {r0, r1, r4}
 9cc:	13490021 	movtne	r0, #36897	; 0x9021
 9d0:	00000b2f 	andeq	r0, r0, pc, lsr #22
 9d4:	0b01130a 	bleq	45604 <__bss_end__+0x3bddc>
 9d8:	3b0b3a0b 	blcc	2cf20c <_stack+0x24f20c>
 9dc:	0013010b 	andseq	r0, r3, fp, lsl #2
 9e0:	000d0b00 	andeq	r0, sp, r0, lsl #22
 9e4:	0b3a0e03 	bleq	e841f8 <_stack+0xe041f8>
 9e8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 9ec:	00000b38 	andeq	r0, r0, r8, lsr fp
 9f0:	0b000f0c 	bleq	4628 <CPSR_IRQ_INHIBIT+0x45a8>
 9f4:	0d00000b 	stceq	0, cr0, [r0, #-44]	; 0xffffffd4
 9f8:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 9fc:	0b3a0b0b 	bleq	e83630 <_stack+0xe03630>
 a00:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 a04:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 a08:	3a080300 	bcc	201610 <_stack+0x181610>
 a0c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 a10:	000b3813 	andeq	r3, fp, r3, lsl r8
 a14:	000f0f00 	andeq	r0, pc, r0, lsl #30
 a18:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 a1c:	13100000 	tstne	r0, #0
 a20:	0b0e0301 	bleq	38162c <_stack+0x30162c>
 a24:	3b0b3a05 	blcc	2cf240 <_stack+0x24f240>
 a28:	0013010b 	andseq	r0, r3, fp, lsl #2
 a2c:	000d1100 	andeq	r1, sp, r0, lsl #2
 a30:	0b3a0e03 	bleq	e84244 <_stack+0xe04244>
 a34:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 a38:	00000538 	andeq	r0, r0, r8, lsr r5
 a3c:	27001512 	smladcs	r0, r2, r5, r1
 a40:	13000019 	movwne	r0, #25
 a44:	19270115 	stmdbne	r7!, {r0, r2, r4, r8}
 a48:	13011349 	movwne	r1, #4937	; 0x1349
 a4c:	05140000 	ldreq	r0, [r4, #-0]
 a50:	00134900 	andseq	r4, r3, r0, lsl #18
 a54:	01131500 	tsteq	r3, r0, lsl #10
 a58:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
 a5c:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 a60:	00001301 	andeq	r1, r0, r1, lsl #6
 a64:	03000d16 	movweq	r0, #3350	; 0xd16
 a68:	3b0b3a0e 	blcc	2cf2a8 <_stack+0x24f2a8>
 a6c:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
 a70:	1700000b 	strne	r0, [r0, -fp]
 a74:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 a78:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 a7c:	05381349 	ldreq	r1, [r8, #-841]!	; 0x349
 a80:	26180000 	ldrcs	r0, [r8], -r0
 a84:	00134900 	andseq	r4, r3, r0, lsl #18
 a88:	01131900 	tsteq	r3, r0, lsl #18
 a8c:	0b0b0e03 	bleq	2c42a0 <_stack+0x2442a0>
 a90:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 a94:	00001301 	andeq	r1, r0, r1, lsl #6
 a98:	0b01131a 	bleq	45708 <__bss_end__+0x3bee0>
 a9c:	3b0b3a0b 	blcc	2cf2d0 <_stack+0x24f2d0>
 aa0:	00130105 	andseq	r0, r3, r5, lsl #2
 aa4:	01171b00 	tsteq	r7, r0, lsl #22
 aa8:	0b3a0b0b 	bleq	e836dc <_stack+0xe036dc>
 aac:	1301053b 	movwne	r0, #5435	; 0x153b
 ab0:	0d1c0000 	ldceq	0, cr0, [ip, #-0]
 ab4:	3a0e0300 	bcc	3816bc <_stack+0x3016bc>
 ab8:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 abc:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 ac0:	19270115 	stmdbne	r7!, {r0, r2, r4, r8}
 ac4:	00001301 	andeq	r1, r0, r1, lsl #6
 ac8:	3f012e1e 	svccc	0x00012e1e
 acc:	3a0e0319 	bcc	381738 <_stack+0x301738>
 ad0:	110b3b0b 	tstne	fp, fp, lsl #22
 ad4:	40061201 	andmi	r1, r6, r1, lsl #4
 ad8:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 adc:	00001301 	andeq	r1, r0, r1, lsl #6
 ae0:	0300051f 	movweq	r0, #1311	; 0x51f
 ae4:	3b0b3a08 	blcc	2cf30c <_stack+0x24f30c>
 ae8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 aec:	20000018 	andcs	r0, r0, r8, lsl r0
 af0:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 af4:	0b3b0b3a 	bleq	ec37e4 <_stack+0xe437e4>
 af8:	0b1c1349 	bleq	705824 <_stack+0x685824>
 afc:	01000000 	mrseq	r0, (UNDEF: 0)
 b00:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 b04:	0e030b13 	vmoveq.32	d3[0], r0
 b08:	17550e1b 	smmlane	r5, fp, lr, r0
 b0c:	17100111 			; <UNDEFINED> instruction: 0x17100111
 b10:	16020000 	strne	r0, [r2], -r0
 b14:	3a0e0300 	bcc	38171c <_stack+0x30171c>
 b18:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 b1c:	03000013 	movweq	r0, #19
 b20:	0b0b0024 	bleq	2c0bb8 <_stack+0x240bb8>
 b24:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 b28:	24040000 	strcs	r0, [r4], #-0
 b2c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 b30:	000e030b 	andeq	r0, lr, fp, lsl #6
 b34:	00160500 	andseq	r0, r6, r0, lsl #10
 b38:	0b3a0e03 	bleq	e8434c <_stack+0xe0434c>
 b3c:	1349053b 	movtne	r0, #38203	; 0x953b
 b40:	17060000 	strne	r0, [r6, -r0]
 b44:	3a0b0b01 	bcc	2c3750 <_stack+0x243750>
 b48:	010b3b0b 	tsteq	fp, fp, lsl #22
 b4c:	07000013 	smladeq	r0, r3, r0, r0
 b50:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 b54:	0b3b0b3a 	bleq	ec3844 <_stack+0xe43844>
 b58:	00001349 	andeq	r1, r0, r9, asr #6
 b5c:	49010108 	stmdbmi	r1, {r3, r8}
 b60:	00130113 	andseq	r0, r3, r3, lsl r1
 b64:	00210900 	eoreq	r0, r1, r0, lsl #18
 b68:	0b2f1349 	bleq	bc5894 <_stack+0xb45894>
 b6c:	130a0000 	movwne	r0, #40960	; 0xa000
 b70:	3a0b0b01 	bcc	2c377c <_stack+0x24377c>
 b74:	010b3b0b 	tsteq	fp, fp, lsl #22
 b78:	0b000013 	bleq	bcc <CPSR_IRQ_INHIBIT+0xb4c>
 b7c:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 b80:	0b3b0b3a 	bleq	ec3870 <_stack+0xe43870>
 b84:	0b381349 	bleq	e058b0 <_stack+0xd858b0>
 b88:	0f0c0000 	svceq	0x000c0000
 b8c:	000b0b00 	andeq	r0, fp, r0, lsl #22
 b90:	01130d00 	tsteq	r3, r0, lsl #26
 b94:	0b0b0e03 	bleq	2c43a8 <_stack+0x2443a8>
 b98:	0b3b0b3a 	bleq	ec3888 <_stack+0xe43888>
 b9c:	00001301 	andeq	r1, r0, r1, lsl #6
 ba0:	03000d0e 	movweq	r0, #3342	; 0xd0e
 ba4:	3b0b3a08 	blcc	2cf3cc <_stack+0x24f3cc>
 ba8:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 bac:	0f00000b 	svceq	0x0000000b
 bb0:	0b0b000f 	bleq	2c0bf4 <_stack+0x240bf4>
 bb4:	00001349 	andeq	r1, r0, r9, asr #6
 bb8:	03011310 	movweq	r1, #4880	; 0x1310
 bbc:	3a050b0e 	bcc	1437fc <_stack+0xc37fc>
 bc0:	010b3b0b 	tsteq	fp, fp, lsl #22
 bc4:	11000013 	tstne	r0, r3, lsl r0
 bc8:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 bcc:	0b3b0b3a 	bleq	ec38bc <_stack+0xe438bc>
 bd0:	05381349 	ldreq	r1, [r8, #-841]!	; 0x349
 bd4:	15120000 	ldrne	r0, [r2, #-0]
 bd8:	00192700 	andseq	r2, r9, r0, lsl #14
 bdc:	01151300 	tsteq	r5, r0, lsl #6
 be0:	13491927 	movtne	r1, #39207	; 0x9927
 be4:	00001301 	andeq	r1, r0, r1, lsl #6
 be8:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 bec:	15000013 	strne	r0, [r0, #-19]
 bf0:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 bf4:	0b3a050b 	bleq	e82028 <_stack+0xe02028>
 bf8:	1301053b 	movwne	r0, #5435	; 0x153b
 bfc:	0d160000 	ldceq	0, cr0, [r6, #-0]
 c00:	3a0e0300 	bcc	381808 <_stack+0x301808>
 c04:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 c08:	000b3813 	andeq	r3, fp, r3, lsl r8
 c0c:	000d1700 	andeq	r1, sp, r0, lsl #14
 c10:	0b3a0e03 	bleq	e84424 <_stack+0xe04424>
 c14:	1349053b 	movtne	r0, #38203	; 0x953b
 c18:	00000538 	andeq	r0, r0, r8, lsr r5
 c1c:	49002618 	stmdbmi	r0, {r3, r4, r9, sl, sp}
 c20:	19000013 	stmdbne	r0, {r0, r1, r4}
 c24:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 c28:	0b3a0b0b 	bleq	e8385c <_stack+0xe0385c>
 c2c:	1301053b 	movwne	r0, #5435	; 0x153b
 c30:	131a0000 	tstne	sl, #0
 c34:	3a0b0b01 	bcc	2c3840 <_stack+0x243840>
 c38:	01053b0b 	tsteq	r5, fp, lsl #22
 c3c:	1b000013 	blne	c90 <CPSR_IRQ_INHIBIT+0xc10>
 c40:	0b0b0117 	bleq	2c10a4 <_stack+0x2410a4>
 c44:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 c48:	00001301 	andeq	r1, r0, r1, lsl #6
 c4c:	03000d1c 	movweq	r0, #3356	; 0xd1c
 c50:	3b0b3a0e 	blcc	2cf490 <_stack+0x24f490>
 c54:	00134905 	andseq	r4, r3, r5, lsl #18
 c58:	01151d00 	tsteq	r5, r0, lsl #26
 c5c:	13011927 	movwne	r1, #6439	; 0x1927
 c60:	2e1e0000 	cdpcs	0, 1, cr0, cr14, cr0, {0}
 c64:	03193f01 	tsteq	r9, #1, 30
 c68:	3b0b3a0e 	blcc	2cf4a8 <_stack+0x24f4a8>
 c6c:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
 c70:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 c74:	97184006 	ldrls	r4, [r8, -r6]
 c78:	13011942 	movwne	r1, #6466	; 0x1942
 c7c:	051f0000 	ldreq	r0, [pc, #-0]	; c84 <CPSR_IRQ_INHIBIT+0xc04>
 c80:	3a080300 	bcc	201888 <_stack+0x181888>
 c84:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 c88:	00170213 	andseq	r0, r7, r3, lsl r2
 c8c:	00052000 	andeq	r2, r5, r0
 c90:	0b3a0e03 	bleq	e844a4 <_stack+0xe044a4>
 c94:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 c98:	00001702 	andeq	r1, r0, r2, lsl #14
 c9c:	03003421 	movweq	r3, #1057	; 0x421
 ca0:	3b0b3a08 	blcc	2cf4c8 <_stack+0x24f4c8>
 ca4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 ca8:	22000018 	andcs	r0, r0, #24
 cac:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 cb0:	0b3a0e03 	bleq	e844c4 <_stack+0xe044c4>
 cb4:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 cb8:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 cbc:	00001301 	andeq	r1, r0, r1, lsl #6
 cc0:	01828923 	orreq	r8, r2, r3, lsr #18
 cc4:	31011101 	tstcc	r1, r1, lsl #2
 cc8:	24000013 	strcs	r0, [r0], #-19
 ccc:	0001828a 	andeq	r8, r1, sl, lsl #5
 cd0:	42911802 	addsmi	r1, r1, #131072	; 0x20000
 cd4:	25000018 	strcs	r0, [r0, #-24]
 cd8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 cdc:	0b3b0b3a 	bleq	ec39cc <_stack+0xe439cc>
 ce0:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 ce4:	0000193c 	andeq	r1, r0, ip, lsr r9
 ce8:	3f012e26 	svccc	0x00012e26
 cec:	3a0e0319 	bcc	381958 <_stack+0x301958>
 cf0:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 cf4:	3c134919 	ldccc	9, cr4, [r3], {25}
 cf8:	00000019 	andeq	r0, r0, r9, lsl r0

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00000165 	andeq	r0, r0, r5, ror #2
   4:	010c0002 	tsteq	ip, r2
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
  1c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  20:	2f2e2e2f 	svccs	0x002e2e2f
  24:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
  28:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  2c:	2f2e2e2f 	svccs	0x002e2e2f
  30:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
  34:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
  38:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
  3c:	722f6362 	eorvc	r6, pc, #-2013265919	; 0x88000001
  40:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
  44:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
  48:	2f646c69 	svccs	0x00646c69
  4c:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
  50:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
  54:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
  58:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
  5c:	2f302e31 	svccs	0x00302e31
  60:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
  64:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; fffffec8 <_stack+0xfff7fec8>
  68:	2f636269 	svccs	0x00636269
  6c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
  70:	2f656475 	svccs	0x00656475
  74:	00737973 	rsbseq	r7, r3, r3, ror r9
  78:	7273752f 	rsbsvc	r7, r3, #197132288	; 0xbc00000
  7c:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
  80:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
  84:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
  88:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
  8c:	61652d65 	cmnvs	r5, r5, ror #26
  90:	342f6962 	strtcc	r6, [pc], #-2402	; 98 <CPSR_IRQ_INHIBIT+0x18>
  94:	322e382e 	eorcc	r3, lr, #3014656	; 0x2e0000
  98:	636e692f 	cmnvs	lr, #770048	; 0xbc000
  9c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
  a0:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
  a4:	2f646c69 	svccs	0x00646c69
  a8:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
  ac:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
  b0:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
  b4:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
  b8:	2f302e31 	svccs	0x00302e31
  bc:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
  c0:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; ffffff24 <_stack+0xfff7ff24>
  c4:	2f636269 	svccs	0x00636269
  c8:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
  cc:	00656475 	rsbeq	r6, r5, r5, ror r4
  d0:	65657200 	strbvs	r7, [r5, #-512]!	; 0x200
  d4:	632e746e 	teqvs	lr, #1845493760	; 0x6e000000
  d8:	00000100 	andeq	r0, r0, r0, lsl #2
  dc:	6b636f6c 	blvs	18dbe94 <_stack+0x185be94>
  e0:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
  e4:	745f0000 	ldrbvc	r0, [pc], #-0	; ec <CPSR_IRQ_INHIBIT+0x6c>
  e8:	73657079 	cmnvc	r5, #121	; 0x79
  ec:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
  f0:	74730000 	ldrbtvc	r0, [r3], #-0
  f4:	66656464 	strbtvs	r6, [r5], -r4, ror #8
  f8:	0300682e 	movweq	r6, #2094	; 0x82e
  fc:	65720000 	ldrbvs	r0, [r2, #-0]!
 100:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
 104:	00020068 	andeq	r0, r2, r8, rrx
 108:	64747300 	ldrbtvs	r7, [r4], #-768	; 0x300
 10c:	2e62696c 	cdpcs	9, 6, cr6, cr2, cr12, {3}
 110:	00040068 	andeq	r0, r4, r8, rrx
 114:	05000000 	streq	r0, [r0, #-0]
 118:	0085d802 	addeq	sp, r5, r2, lsl #16
 11c:	01230300 	teqeq	r3, r0, lsl #6
 120:	221e2220 	andscs	r2, lr, #32, 4
 124:	2d2f3021 	stccs	0, cr3, [pc, #-132]!	; a8 <CPSR_IRQ_INHIBIT+0x28>
 128:	01000202 	tsteq	r0, r2, lsl #4
 12c:	02050001 	andeq	r0, r5, #1
 130:	000085f4 	strdeq	r8, [r0], -r4
 134:	13012e03 	movwne	r2, #7683	; 0x1e03
 138:	43212049 	teqmi	r1, #73	; 0x49
 13c:	2f271d31 	svccs	0x00271d31
 140:	37382f31 			; <UNDEFINED> instruction: 0x37382f31
 144:	4c4a0d03 	mcrrmi	13, 0, r0, sl, cr3
 148:	3c1c032f 	ldccc	3, cr0, [ip], {47}	; 0x2f
 14c:	01040200 	mrseq	r0, R12_usr
 150:	50063c06 	andpl	r3, r6, r6, lsl #24
 154:	1d233821 	stcne	8, cr3, [r3, #-132]!	; 0xffffff7c
 158:	2f200a03 	svccs	0x00200a03
 15c:	4b3e4043 	blmi	f90270 <_stack+0xf10270>
 160:	2e7a0326 	cdpcs	3, 7, cr0, cr10, cr6, {1}
 164:	01000202 	tsteq	r0, r2, lsl #4
 168:	0000d901 	andeq	sp, r0, r1, lsl #18
 16c:	c2000200 	andgt	r0, r0, #0, 4
 170:	02000000 	andeq	r0, r0, #0
 174:	0d0efb01 	vstreq	d15, [lr, #-4]
 178:	01010100 	mrseq	r0, (UNDEF: 17)
 17c:	00000001 	andeq	r0, r0, r1
 180:	01000001 	tsteq	r0, r1
 184:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 188:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 18c:	2f2e2e2f 	svccs	0x002e2e2f
 190:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 194:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 198:	2f2e2e2f 	svccs	0x002e2e2f
 19c:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 1a0:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 1a4:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 1a8:	6d2f6362 	stcvs	3, cr6, [pc, #-392]!	; 28 <CPSR_THUMB+0x8>
 1ac:	69686361 	stmdbvs	r8!, {r0, r5, r6, r8, r9, sp, lr}^
 1b0:	612f656e 	teqvs	pc, lr, ror #10
 1b4:	2f006d72 	svccs	0x00006d72
 1b8:	2f727375 	svccs	0x00727375
 1bc:	2f62696c 	svccs	0x0062696c
 1c0:	2f636367 	svccs	0x00636367
 1c4:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 1c8:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
 1cc:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 1d0:	2e342f69 	cdpcs	15, 3, cr2, cr4, cr9, {3}
 1d4:	2f322e38 	svccs	0x00322e38
 1d8:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 1dc:	00656475 	rsbeq	r6, r5, r5, ror r4
 1e0:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 1e4:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 1e8:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 1ec:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 1f0:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 1f4:	312e322d 	teqcc	lr, sp, lsr #4
 1f8:	6e2f302e 	cdpvs	0, 2, cr3, cr15, cr14, {1}
 1fc:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 200:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 204:	692f6362 	stmdbvs	pc!, {r1, r5, r6, r8, r9, sp, lr}	; <UNPREDICTABLE>
 208:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 20c:	00006564 	andeq	r6, r0, r4, ror #10
 210:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
 214:	632e6e65 	teqvs	lr, #1616	; 0x650
 218:	00000100 	andeq	r0, r0, r0, lsl #2
 21c:	64647473 	strbtvs	r7, [r4], #-1139	; 0x473
 220:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 224:	00000200 	andeq	r0, r0, r0, lsl #4
 228:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 22c:	682e676e 	stmdavs	lr!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
 230:	00000300 	andeq	r0, r0, r0, lsl #6
 234:	02050000 	andeq	r0, r5, #0
 238:	00008684 	andeq	r8, r0, r4, lsl #13
 23c:	0100c203 	tsteq	r0, r3, lsl #4
 240:	002f0213 	eoreq	r0, pc, r3, lsl r2	; <UNPREDICTABLE>
 244:	02210101 	eoreq	r0, r1, #1073741824	; 0x40000000
 248:	00020000 	andeq	r0, r2, r0
 24c:	0000010e 	andeq	r0, r0, lr, lsl #2
 250:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 254:	0101000d 	tsteq	r1, sp
 258:	00000101 	andeq	r0, r0, r1, lsl #2
 25c:	00000100 	andeq	r0, r0, r0, lsl #2
 260:	2f2e2e01 	svccs	0x002e2e01
 264:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 268:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 26c:	2f2e2e2f 	svccs	0x002e2e2f
 270:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 274:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 278:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 27c:	2f62696c 	svccs	0x0062696c
 280:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 284:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0x32f
 288:	0062696c 	rsbeq	r6, r2, ip, ror #18
 28c:	7273752f 	rsbsvc	r7, r3, #197132288	; 0xbc00000
 290:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 294:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 298:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 29c:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 2a0:	61652d65 	cmnvs	r5, r5, ror #26
 2a4:	342f6962 	strtcc	r6, [pc], #-2402	; 2ac <CPSR_IRQ_INHIBIT+0x22c>
 2a8:	322e382e 	eorcc	r3, lr, #3014656	; 0x2e0000
 2ac:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 2b0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 2b4:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
 2b8:	2f646c69 	svccs	0x00646c69
 2bc:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 2c0:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
 2c4:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 2c8:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
 2cc:	2f302e31 	svccs	0x00302e31
 2d0:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 2d4:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 138 <CPSR_IRQ_INHIBIT+0xb8>
 2d8:	2f636269 	svccs	0x00636269
 2dc:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 2e0:	2f656475 	svccs	0x00656475
 2e4:	00737973 	rsbseq	r7, r3, r3, ror r9
 2e8:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 2ec:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 2f0:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 2f4:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 2f8:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 2fc:	312e322d 	teqcc	lr, sp, lsr #4
 300:	6e2f302e 	cdpvs	0, 2, cr3, cr15, cr14, {1}
 304:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 308:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 30c:	692f6362 	stmdbvs	pc!, {r1, r5, r6, r8, r9, sp, lr}	; <UNPREDICTABLE>
 310:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 314:	00006564 	andeq	r6, r0, r4, ror #10
 318:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 31c:	2e72636f 	cdpcs	3, 7, cr6, cr2, cr15, {3}
 320:	00010063 	andeq	r0, r1, r3, rrx
 324:	64747300 	ldrbtvs	r7, [r4], #-768	; 0x300
 328:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 32c:	00020068 	andeq	r0, r2, r8, rrx
 330:	636f6c00 	cmnvs	pc, #0, 24
 334:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 338:	5f000003 	svcpl	0x00000003
 33c:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0x974
 340:	00682e73 	rsbeq	r2, r8, r3, ror lr
 344:	72000003 	andvc	r0, r0, #3
 348:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 34c:	0300682e 	movweq	r6, #2094	; 0x82e
 350:	65720000 	ldrbvs	r0, [r2, #-0]!
 354:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
 358:	00040068 	andeq	r0, r4, r8, rrx
 35c:	05000000 	streq	r0, [r0, #-0]
 360:	0086e402 	addeq	lr, r6, r2, lsl #8
 364:	19ec0300 	stmibne	ip!, {r8, r9}^
 368:	200a0301 	andcs	r0, sl, r1, lsl #6
 36c:	364a7603 	strbcc	r7, [sl], -r3, lsl #12
 370:	03684b30 	cmneq	r8, #48, 22	; 0xc000
 374:	034b3c09 	movteq	r3, #48137	; 0xbc09
 378:	033d4a78 	teqeq	sp, #120, 20	; 0x78000
 37c:	034c2e0f 	movteq	r2, #52751	; 0xce0f
 380:	49212e12 	stmdbmi	r1!, {r1, r4, r9, sl, fp, sp}
 384:	1f2f1d23 	svcne	0x002f1d23
 388:	242f3021 	strtcs	r3, [pc], #-33	; 390 <CPSR_IRQ_INHIBIT+0x310>
 38c:	4b206903 	blmi	81a7a0 <_stack+0x79a7a0>
 390:	3b91302f 	blcc	fe44c454 <_stack+0xfe3cc454>
 394:	01000302 	tsteq	r0, r2, lsl #6
 398:	02050001 	andeq	r0, r5, #1
 39c:	00008788 	andeq	r8, r0, r8, lsl #15
 3a0:	0114c103 	tsteq	r4, r3, lsl #2
 3a4:	032e1203 	teqeq	lr, #805306368	; 0x30000000
 3a8:	1203206e 	andne	r2, r3, #110	; 0x6e
 3ac:	03313120 	teqeq	r1, #32, 2
 3b0:	6e032e11 	mcrvs	14, 0, r2, cr3, cr1, {0}
 3b4:	2e0e034a 	cdpcs	3, 0, cr0, cr14, cr10, {2}
 3b8:	221e232f 	andscs	r2, lr, #-1140850688	; 0xbc000000
 3bc:	1803301e 	stmdane	r3, {r1, r2, r3, r4, ip, sp}
 3c0:	30222a20 	eorcc	r2, r2, r0, lsr #20
 3c4:	212b3222 	teqcs	fp, r2, lsr #4
 3c8:	223a3122 	eorscs	r3, sl, #-2147483640	; 0x80000008
 3cc:	00224c4d 	eoreq	r4, r2, sp, asr #24
 3d0:	06010402 	streq	r0, [r1], -r2, lsl #8
 3d4:	4042062e 	submi	r0, r2, lr, lsr #12
 3d8:	0021213d 	eoreq	r2, r1, sp, lsr r1
 3dc:	06020402 	streq	r0, [r2], -r2, lsl #8
 3e0:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 3e4:	02003c03 	andeq	r3, r0, #768	; 0x300
 3e8:	003c1204 	eorseq	r1, ip, r4, lsl #4
 3ec:	90020402 	andls	r0, r2, r2, lsl #8
 3f0:	01040200 	mrseq	r0, R12_usr
 3f4:	04020058 	streq	r0, [r2], #-88	; 0x58
 3f8:	02003c03 	andeq	r3, r0, #768	; 0x300
 3fc:	06200104 	strteq	r0, [r0], -r4, lsl #2
 400:	034a5b03 	movteq	r5, #43779	; 0xab03
 404:	5603202a 	strpl	r2, [r3], -sl, lsr #32
 408:	0402002e 	streq	r0, [r2], #-46	; 0x2e
 40c:	4a250301 	bmi	941018 <_stack+0x8c1018>
 410:	01040200 	mrseq	r0, R12_usr
 414:	00ba5b03 	adcseq	r5, sl, r3, lsl #22
 418:	03010402 	movweq	r0, #5122	; 0x1402
 41c:	02002025 	andeq	r2, r0, #37	; 0x25
 420:	00410104 	subeq	r0, r1, r4, lsl #2
 424:	03010402 	movweq	r0, #5122	; 0x1402
 428:	74032e56 	strvc	r2, [r3], #-3670	; 0xe56
 42c:	22221e2e 	eorcs	r1, r2, #736	; 0x2e0
 430:	4f21212f 	svcmi	0x0021212f
 434:	211f3e48 	tstcs	pc, r8, asr #28
 438:	901c032f 	andsls	r0, ip, pc, lsr #6
 43c:	2e790327 	cdpcs	3, 7, cr0, cr9, cr7, {1}
 440:	02002143 	andeq	r2, r0, #-1073741808	; 0xc0000010
 444:	00300404 	eorseq	r0, r0, r4, lsl #8
 448:	06060402 	streq	r0, [r6], -r2, lsl #8
 44c:	04020066 	streq	r0, [r2], #-102	; 0x66
 450:	02002e07 	andeq	r2, r0, #7, 28	; 0x70
 454:	004a0104 	subeq	r0, sl, r4, lsl #2
 458:	90080402 	andls	r0, r8, r2, lsl #8
 45c:	09040200 	stmdbeq	r4, {r9}
 460:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 464:	0d024a0a 	vstreq	s8, [r2, #-40]	; 0xffffffd8
 468:	d8010100 	stmdale	r1, {r8}
 46c:	02000000 	andeq	r0, r0, #0
 470:	0000d200 	andeq	sp, r0, r0, lsl #4
 474:	fb010200 	blx	40c7e <__bss_end__+0x37456>
 478:	01000d0e 	tsteq	r0, lr, lsl #26
 47c:	00010101 	andeq	r0, r1, r1, lsl #2
 480:	00010000 	andeq	r0, r1, r0
 484:	622f0100 	eorvs	r0, pc, #0, 2
 488:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 48c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 490:	2f64646c 	svccs	0x0064646c
 494:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 498:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 49c:	302e312e 	eorcc	r3, lr, lr, lsr #2
 4a0:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 4a4:	2f62696c 	svccs	0x0062696c
 4a8:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 4ac:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 4b0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 4b4:	7379732f 	cmnvc	r9, #-1140850688	; 0xbc000000
 4b8:	73752f00 	cmnvc	r5, #0, 30
 4bc:	696c2f72 	stmdbvs	ip!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 4c0:	63672f62 	cmnvs	r7, #392	; 0x188
 4c4:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 4c8:	6f6e2d6d 	svcvs	0x006e2d6d
 4cc:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
 4d0:	2f696261 	svccs	0x00696261
 4d4:	2e382e34 	mrccs	14, 1, r2, cr8, cr4, {1}
 4d8:	6e692f32 	mcrvs	15, 3, r2, cr9, cr2, {1}
 4dc:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 4e0:	2e2e0065 	cdpcs	0, 2, cr0, cr14, cr5, {3}
 4e4:	2f2e2e2f 	svccs	0x002e2e2f
 4e8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 4ec:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 4f0:	2f2e2e2f 	svccs	0x002e2e2f
 4f4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 4f8:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xf2e
 4fc:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 500:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 504:	65722f63 	ldrbvs	r2, [r2, #-3939]!	; 0xf63
 508:	00746e65 	rsbseq	r6, r4, r5, ror #28
 50c:	636f6c00 	cmnvs	pc, #0, 24
 510:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 514:	5f000001 	svcpl	0x00000001
 518:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0x974
 51c:	00682e73 	rsbeq	r2, r8, r3, ror lr
 520:	73000001 	movwvc	r0, #1
 524:	65646474 	strbvs	r6, [r4, #-1140]!	; 0x474
 528:	00682e66 	rsbeq	r2, r8, r6, ror #28
 52c:	72000002 	andvc	r0, r0, #2
 530:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 534:	0100682e 	tsteq	r0, lr, lsr #16
 538:	6d690000 	stclvs	0, cr0, [r9, #-0]
 53c:	65727570 	ldrbvs	r7, [r2, #-1392]!	; 0x570
 540:	0300632e 	movweq	r6, #814	; 0x32e
 544:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
 548:	02000003 	andeq	r0, r0, #3
 54c:	00010e00 	andeq	r0, r1, r0, lsl #28
 550:	fb010200 	blx	40d5a <__bss_end__+0x37532>
 554:	01000d0e 	tsteq	r0, lr, lsl #26
 558:	00010101 	andeq	r0, r1, r1, lsl #2
 55c:	00010000 	andeq	r0, r1, r0
 560:	2e2e0100 	sufcse	f0, f6, f0
 564:	2f2e2e2f 	svccs	0x002e2e2f
 568:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 56c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 570:	2f2e2e2f 	svccs	0x002e2e2f
 574:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 578:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xf2e
 57c:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 580:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 584:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xf63
 588:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 58c:	73752f00 	cmnvc	r5, #0, 30
 590:	696c2f72 	stmdbvs	ip!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 594:	63672f62 	cmnvs	r7, #392	; 0x188
 598:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 59c:	6f6e2d6d 	svcvs	0x006e2d6d
 5a0:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
 5a4:	2f696261 	svccs	0x00696261
 5a8:	2e382e34 	mrccs	14, 1, r2, cr8, cr4, {1}
 5ac:	6e692f32 	mcrvs	15, 3, r2, cr9, cr2, {1}
 5b0:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 5b4:	622f0065 	eorvs	r0, pc, #101	; 0x65
 5b8:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 5bc:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 5c0:	2f64646c 	svccs	0x0064646c
 5c4:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 5c8:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 5cc:	302e312e 	eorcc	r3, lr, lr, lsr #2
 5d0:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 5d4:	2f62696c 	svccs	0x0062696c
 5d8:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 5dc:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 5e0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 5e4:	7379732f 	cmnvc	r9, #-1140850688	; 0xbc000000
 5e8:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
 5ec:	2f646c69 	svccs	0x00646c69
 5f0:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 5f4:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
 5f8:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 5fc:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
 600:	2f302e31 	svccs	0x00302e31
 604:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 608:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 46c <CPSR_IRQ_INHIBIT+0x3ec>
 60c:	2f636269 	svccs	0x00636269
 610:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 614:	00656475 	rsbeq	r6, r5, r5, ror r4
 618:	6c616d00 	stclvs	13, cr6, [r1], #-0
 61c:	72636f6c 	rsbvc	r6, r3, #108, 30	; 0x1b0
 620:	0100632e 	tsteq	r0, lr, lsr #6
 624:	74730000 	ldrbtvc	r0, [r3], #-0
 628:	66656464 	strbtvs	r6, [r5], -r4, ror #8
 62c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 630:	6f6c0000 	svcvs	0x006c0000
 634:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 638:	00000300 	andeq	r0, r0, r0, lsl #6
 63c:	7079745f 	rsbsvc	r7, r9, pc, asr r4
 640:	682e7365 	stmdavs	lr!, {r0, r2, r5, r6, r8, r9, ip, sp, lr}
 644:	00000300 	andeq	r0, r0, r0, lsl #6
 648:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 64c:	00682e74 	rsbeq	r2, r8, r4, ror lr
 650:	72000003 	andvc	r0, r0, #3
 654:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 658:	0400682e 	streq	r6, [r0], #-2094	; 0x82e
 65c:	00000000 	andeq	r0, r0, r0
 660:	89200205 	stmdbhi	r0!, {r0, r2, r9}
 664:	97030000 	strls	r0, [r3, -r0]
 668:	14030112 	strne	r0, [r3], #-274	; 0x112
 66c:	3c6c032e 	stclcc	3, cr0, [ip], #-184	; 0xffffff48
 670:	03201403 	teqeq	r0, #50331648	; 0x3000000
 674:	14033c6c 	strne	r3, [r3], #-3180	; 0xc6c
 678:	3288313c 	addcc	r3, r8, #60, 2
 67c:	2467323e 	strbtcs	r3, [r7], #-574	; 0x23e
 680:	232a2544 	teqcs	sl, #68, 10	; 0x11000000
 684:	2d212f1c 	stccs	15, cr2, [r1, #-112]!	; 0xffffff90
 688:	22212d21 	eorcs	r2, r1, #2112	; 0x840
 68c:	2e01d103 	mvfcss	f5, f3
 690:	4a7eb803 	bmi	1fae6a4 <_stack+0x1f2e6a4>
 694:	12040200 	andne	r0, r4, #0, 4
 698:	04020083 	streq	r0, [r2], #-131	; 0x83
 69c:	0b036812 	bleq	da6ec <_stack+0x5a6ec>
 6a0:	3c75034a 	ldclcc	3, cr0, [r5], #-296	; 0xfffffed8
 6a4:	30223d3e 	eorcc	r3, r2, lr, lsr sp
 6a8:	342e0e03 	strtcc	r0, [lr], #-3587	; 0xe03
 6ac:	03223dae 	teqeq	r2, #11136	; 0x2b80
 6b0:	4c1e3c0e 	ldcmi	12, cr3, [lr], {14}
 6b4:	00200a03 	eoreq	r0, r0, r3, lsl #20
 6b8:	06010402 	streq	r0, [r1], -r2, lsl #8
 6bc:	1a08064a 	bne	201fec <_stack+0x181fec>
 6c0:	1f2f316b 	svcne	0x002f316b
 6c4:	2e0b0330 	mcrcs	3, 0, r0, cr11, cr0, {1}
 6c8:	4a120351 	bmi	481414 <_stack+0x401414>
 6cc:	4c3c6e03 	ldcmi	14, cr6, [ip], #-12
 6d0:	5632223d 			; <UNDEFINED> instruction: 0x5632223d
 6d4:	207a0327 	rsbscs	r0, sl, r7, lsr #6
 6d8:	4b212b31 	blmi	84b3a4 <_stack+0x7cb3a4>
 6dc:	2f222167 	svccs	0x00222167
 6e0:	207eeb03 	rsbscs	lr, lr, r3, lsl #22
 6e4:	01f0031f 	mvnseq	r0, pc, lsl r3
 6e8:	0402002e 	streq	r0, [r2], #-46	; 0x2e
 6ec:	7eb80302 	cdpvc	3, 11, cr0, cr8, cr2, {0}
 6f0:	0402004a 	streq	r0, [r2], #-74	; 0x4a
 6f4:	064a0603 	strbeq	r0, [sl], -r3, lsl #12
 6f8:	23743303 	cmncs	r4, #201326592	; 0xc000000
 6fc:	034c1e2d 	movteq	r1, #52781	; 0xce2d
 700:	032e0193 	teqeq	lr, #-1073741788	; 0xc0000024
 704:	004b4a5f 	subeq	r4, fp, pc, asr sl
 708:	2d010402 	cfstrscs	mvf0, [r1, #-8]
 70c:	01040200 	mrseq	r0, R12_usr
 710:	7cea032f 	stclvc	3, cr0, [sl], #188	; 0xbc
 714:	7903353c 	stmdbvc	r3, {r2, r3, r4, r5, r8, sl, ip, sp}
 718:	0331352e 	teqeq	r1, #192937984	; 0xb800000
 71c:	27322072 			; <UNDEFINED> instruction: 0x27322072
 720:	272e7903 	strcs	r7, [lr, -r3, lsl #18]!
 724:	3c780321 	ldclcc	3, cr0, [r8], #-132	; 0xffffff7c
 728:	475b6836 	smmlarmi	fp, r6, r8, r6
 72c:	1e4c5c23 	cdpne	12, 4, cr5, cr12, cr3, {1}
 730:	2e09035a 	mcrcs	3, 0, r0, cr9, cr10, {2}
 734:	03741303 	cmneq	r4, #201326592	; 0xc000000
 738:	303a2070 	eorscc	r2, sl, r0, ror r0
 73c:	42593040 	subsmi	r3, r9, #64	; 0x40
 740:	032e7703 	teqeq	lr, #786432	; 0xc0000
 744:	444d3c09 	strbmi	r3, [sp], #-3081	; 0xc09
 748:	79032c30 	stmdbvc	r3, {r4, r5, sl, fp, sp}
 74c:	7903272e 	stmdbvc	r3, {r1, r2, r3, r5, r8, r9, sl, sp}
 750:	0b033e66 	bleq	d00f0 <_stack+0x500f0>
 754:	207a033c 	rsbscs	r0, sl, ip, lsr r3
 758:	27342a24 	ldrcs	r2, [r4, -r4, lsr #20]!
 75c:	301f2f51 	andscc	r2, pc, r1, asr pc	; <UNPREDICTABLE>
 760:	207a034f 	rsbscs	r0, sl, pc, asr #6
 764:	33313059 	teqcc	r1, #89	; 0x59
 768:	03673375 	cmneq	r7, #-738197503	; 0xd4000001
 76c:	1f5802c8 	svcne	0x005802c8
 770:	0402002f 	streq	r0, [r2], #-47	; 0x2f
 774:	06200601 	strteq	r0, [r0], -r1, lsl #12
 778:	2f1f2130 	svccs	0x001f2130
 77c:	1c302126 	ldfnes	f2, [r0], #-152	; 0xffffff68
 780:	22211c41 	eorcs	r1, r1, #16640	; 0x4100
 784:	7ec90332 	mcrvc	3, 6, r0, cr9, cr2, {1}
 788:	1e311f4a 	cdpne	15, 3, cr1, cr1, cr10, {2}
 78c:	2d212a23 	vstmdbcs	r1!, {s4-s38}
 790:	b5032221 	strlt	r2, [r3, #-545]	; 0x221
 794:	02002e01 	andeq	r2, r0, #1, 28
 798:	b8030404 	stmdalt	r3, {r2, sl}
 79c:	02004a7e 	andeq	r4, r0, #516096	; 0x7e000
 7a0:	90060604 	andls	r0, r6, r4, lsl #12
 7a4:	07040200 	streq	r0, [r4, -r0, lsl #4]
 7a8:	0402004a 	streq	r0, [r2], #-74	; 0x4a
 7ac:	3b030602 	blcc	c1fbc <_stack+0x41fbc>
 7b0:	04020074 	streq	r0, [r2], #-116	; 0x74
 7b4:	003c0604 	eorseq	r0, ip, r4, lsl #12
 7b8:	66060402 	strvs	r0, [r6], -r2, lsl #8
 7bc:	07040200 	streq	r0, [r4, -r0, lsl #4]
 7c0:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 7c4:	02003c12 	andeq	r3, r0, #4608	; 0x1200
 7c8:	00900204 	addseq	r0, r0, r4, lsl #4
 7cc:	58010402 	stmdapl	r1, {r1, sl}
 7d0:	03040200 	movweq	r0, #16896	; 0x4200
 7d4:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 7d8:	03062e01 	movweq	r2, #28161	; 0x6e01
 7dc:	1b26586a 	blne	99698c <_stack+0x91698c>
 7e0:	29262c30 	stmdbcs	r6!, {r4, r5, sl, fp, sp}
 7e4:	2f222167 	svccs	0x00222167
 7e8:	2000d903 	andcs	sp, r0, r3, lsl #18
 7ec:	032e7703 	teqeq	lr, #786432	; 0xc0000
 7f0:	e8032009 	stmda	r3, {r0, r3, sp}
 7f4:	232f587e 	teqcs	pc, #8257536	; 0x7e0000
 7f8:	03200a03 	teqeq	r0, #12288	; 0x3000
 7fc:	82033c76 	andhi	r3, r3, #30208	; 0x7600
 800:	3e213c01 	cdpcc	12, 2, cr3, cr1, cr1, {0}
 804:	304b1f1e 	subcc	r1, fp, lr, lsl pc
 808:	0402002f 	streq	r0, [r2], #-47	; 0x2f
 80c:	20440303 	subcs	r0, r4, r3, lsl #6
 810:	4a7de503 	bmi	1f79c24 <_stack+0x1ef9c24>
 814:	8202f203 	andhi	pc, r2, #805306368	; 0x30000000
 818:	344a7903 	strbcc	r7, [sl], #-2307	; 0x903
 81c:	0322292d 	teqeq	r2, #737280	; 0xb4000
 820:	02004a09 	andeq	r4, r0, #36864	; 0x9000
 824:	4a060104 	bmi	180c3c <_stack+0x100c3c>
 828:	01040200 	mrseq	r0, R12_usr
 82c:	02003e06 	andeq	r3, r0, #6, 28	; 0x60
 830:	6d030104 	stfvss	f0, [r3, #-16]
 834:	04020020 	streq	r0, [r2], #-32
 838:	20130301 	andscs	r0, r3, r1, lsl #6
 83c:	002c1f31 	eoreq	r1, ip, r1, lsr pc
 840:	03080402 	movweq	r0, #33794	; 0x8402
 844:	003c7ee8 	eorseq	r7, ip, r8, ror #29
 848:	06090402 	streq	r0, [r9], -r2, lsl #8
 84c:	d803063c 	stmdale	r3, {r2, r3, r4, r5, r9, sl}
 850:	0200747e 	andeq	r7, r0, #2113929216	; 0x7e000000
 854:	e3030104 	movw	r0, #12548	; 0x3104
 858:	02006601 	andeq	r6, r0, #1048576	; 0x100000
 85c:	45030a04 	strmi	r0, [r3, #-2564]	; 0xa04
 860:	7ea7039e 	mcrvc	3, 5, r0, cr7, cr14, {4}
 864:	2f1f5be4 	svccs	0x001f5be4
 868:	004a3b03 	subeq	r3, sl, r3, lsl #22
 86c:	03080402 	movweq	r0, #33794	; 0x8402
 870:	009001d6 			; <UNDEFINED> instruction: 0x009001d6
 874:	06090402 	streq	r0, [r9], -r2, lsl #8
 878:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 87c:	0d024a0a 	vstreq	s8, [r2, #-40]	; 0xffffffd8
 880:	f6010100 			; <UNDEFINED> instruction: 0xf6010100
 884:	02000000 	andeq	r0, r0, #0
 888:	0000d200 	andeq	sp, r0, r0, lsl #4
 88c:	fb010200 	blx	41096 <__bss_end__+0x3786e>
 890:	01000d0e 	tsteq	r0, lr, lsl #26
 894:	00010101 	andeq	r0, r1, r1, lsl #2
 898:	00010000 	andeq	r0, r1, r0
 89c:	2e2e0100 	sufcse	f0, f6, f0
 8a0:	2f2e2e2f 	svccs	0x002e2e2f
 8a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 8a8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 8ac:	2f2e2e2f 	svccs	0x002e2e2f
 8b0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 8b4:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xf2e
 8b8:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 8bc:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 8c0:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xf63
 8c4:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 8c8:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
 8cc:	2f646c69 	svccs	0x00646c69
 8d0:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 8d4:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
 8d8:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 8dc:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
 8e0:	2f302e31 	svccs	0x00302e31
 8e4:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 8e8:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 74c <CPSR_IRQ_INHIBIT+0x6cc>
 8ec:	2f636269 	svccs	0x00636269
 8f0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 8f4:	2f656475 	svccs	0x00656475
 8f8:	00737973 	rsbseq	r7, r3, r3, ror r9
 8fc:	7273752f 	rsbsvc	r7, r3, #197132288	; 0xbc00000
 900:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 904:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 908:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 90c:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 910:	61652d65 	cmnvs	r5, r5, ror #26
 914:	342f6962 	strtcc	r6, [pc], #-2402	; 91c <CPSR_IRQ_INHIBIT+0x89c>
 918:	322e382e 	eorcc	r3, lr, #3014656	; 0x2e0000
 91c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 920:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 924:	6c6d0000 	stclvs	0, cr0, [sp], #-0
 928:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 92c:	00010063 	andeq	r0, r1, r3, rrx
 930:	636f6c00 	cmnvs	pc, #0, 24
 934:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 938:	5f000002 	svcpl	0x00000002
 93c:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0x974
 940:	00682e73 	rsbeq	r2, r8, r3, ror lr
 944:	73000002 	movwvc	r0, #2
 948:	65646474 	strbvs	r6, [r4, #-1140]!	; 0x474
 94c:	00682e66 	rsbeq	r2, r8, r6, ror #28
 950:	72000003 	andvc	r0, r0, #3
 954:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 958:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 95c:	00000000 	andeq	r0, r0, r0
 960:	8e880205 	cdphi	2, 8, cr0, cr8, cr5, {0}
 964:	30030000 	andcc	r0, r3, r0
 968:	00010201 	andeq	r0, r1, r1, lsl #4
 96c:	05000101 	streq	r0, [r0, #-257]	; 0x101
 970:	008e8c02 	addeq	r8, lr, r2, lsl #24
 974:	01390300 	teqeq	r9, r0, lsl #6
 978:	01000102 	tsteq	r0, r2, lsl #2
 97c:	00012d01 	andeq	r2, r1, r1, lsl #26
 980:	0b000200 	bleq	1188 <CPSR_IRQ_INHIBIT+0x1108>
 984:	02000001 	andeq	r0, r0, #1
 988:	0d0efb01 	vstreq	d15, [lr, #-4]
 98c:	01010100 	mrseq	r0, (UNDEF: 17)
 990:	00000001 	andeq	r0, r0, r1
 994:	01000001 	tsteq	r0, r1
 998:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 99c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 9a0:	2f2e2e2f 	svccs	0x002e2e2f
 9a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 9a8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 9ac:	2f2e2e2f 	svccs	0x002e2e2f
 9b0:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 9b4:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 818 <CPSR_IRQ_INHIBIT+0x798>
 9b8:	2f636269 	svccs	0x00636269
 9bc:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 9c0:	752f0074 	strvc	r0, [pc, #-116]!	; 954 <CPSR_IRQ_INHIBIT+0x8d4>
 9c4:	6c2f7273 	sfmvs	f7, 4, [pc], #-460	; 800 <CPSR_IRQ_INHIBIT+0x780>
 9c8:	672f6269 	strvs	r6, [pc, -r9, ror #4]!
 9cc:	612f6363 	teqvs	pc, r3, ror #6
 9d0:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 9d4:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 9d8:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 9dc:	382e342f 	stmdacc	lr!, {r0, r1, r2, r3, r5, sl, ip, sp}
 9e0:	692f322e 	stmdbvs	pc!, {r1, r2, r3, r5, r9, ip, sp}	; <UNPREDICTABLE>
 9e4:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 9e8:	2f006564 	svccs	0x00006564
 9ec:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 9f0:	75622f64 	strbvc	r2, [r2, #-3940]!	; 0xf64
 9f4:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xc69
 9f8:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 9fc:	2d62696c 	stclcs	9, cr6, [r2, #-432]!	; 0xfffffe50
 a00:	2e312e32 	mrccs	14, 1, r2, cr1, cr2, {1}
 a04:	656e2f30 	strbvs	r2, [lr, #-3888]!	; 0xf30
 a08:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 a0c:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 a10:	6e692f63 	cdpvs	15, 6, cr2, cr9, cr3, {3}
 a14:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 a18:	79732f65 	ldmdbvc	r3!, {r0, r2, r5, r6, r8, r9, sl, fp, sp}^
 a1c:	622f0073 	eorvs	r0, pc, #115	; 0x73
 a20:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 a24:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 a28:	2f64646c 	svccs	0x0064646c
 a2c:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 a30:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 a34:	302e312e 	eorcc	r3, lr, lr, lsr #2
 a38:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 a3c:	2f62696c 	svccs	0x0062696c
 a40:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 a44:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 a48:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 a4c:	62730000 	rsbsvs	r0, r3, #0
 a50:	2e726b72 	vmovcs.s8	r6, d2[7]
 a54:	00010063 	andeq	r0, r1, r3, rrx
 a58:	64747300 	ldrbtvs	r7, [r4], #-768	; 0x300
 a5c:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 a60:	00020068 	andeq	r0, r2, r8, rrx
 a64:	636f6c00 	cmnvs	pc, #0, 24
 a68:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 a6c:	5f000003 	svcpl	0x00000003
 a70:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0x974
 a74:	00682e73 	rsbeq	r2, r8, r3, ror lr
 a78:	72000003 	andvc	r0, r0, #3
 a7c:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 a80:	0300682e 	movweq	r6, #2094	; 0x82e
 a84:	65720000 	ldrbvs	r0, [r2, #-0]!
 a88:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
 a8c:	00040068 	andeq	r0, r4, r8, rrx
 a90:	05000000 	streq	r0, [r0, #-0]
 a94:	008e9002 	addeq	r9, lr, r2
 a98:	01340300 	teqeq	r4, r0, lsl #6
 a9c:	1f254624 	svcne	0x00254624
 aa0:	02004d2f 	andeq	r4, r0, #3008	; 0xbc0
 aa4:	3d1d0104 	ldfccs	f0, [sp, #-16]
 aa8:	00010222 	andeq	r0, r1, r2, lsr #4
 aac:	Address 0x0000000000000aac is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	00000018 	andeq	r0, r0, r8, lsl r0
  14:	00000000 	andeq	r0, r0, r0
  18:	000085d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
  1c:	0000001a 	andeq	r0, r0, sl, lsl r0
  20:	83100e41 	tsthi	r0, #1040	; 0x410
  24:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
  28:	00018e02 	andeq	r8, r1, r2, lsl #28
  2c:	00000018 	andeq	r0, r0, r8, lsl r0
  30:	00000000 	andeq	r0, r0, r0
  34:	000085f4 	strdeq	r8, [r0], -r4
  38:	00000090 	muleq	r0, r0, r0
  3c:	84100e45 	ldrhi	r0, [r0], #-3653	; 0xe45
  40:	86038504 	strhi	r8, [r3], -r4, lsl #10
  44:	00018e02 	andeq	r8, r1, r2, lsl #28
  48:	0000000c 	andeq	r0, r0, ip
  4c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  50:	7c020001 	stcvc	0, cr0, [r2], {1}
  54:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  58:	0000000c 	andeq	r0, r0, ip
  5c:	00000048 	andeq	r0, r0, r8, asr #32
  60:	00008684 	andeq	r8, r0, r4, lsl #13
  64:	0000005e 	andeq	r0, r0, lr, asr r0
  68:	0000000c 	andeq	r0, r0, ip
  6c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  70:	7c020001 	stcvc	0, cr0, [r2], {1}
  74:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  78:	0000001c 	andeq	r0, r0, ip, lsl r0
  7c:	00000068 	andeq	r0, r0, r8, rrx
  80:	000086e4 	andeq	r8, r0, r4, ror #13
  84:	000000a2 	andeq	r0, r0, r2, lsr #1
  88:	83180e41 	tsthi	r8, #1040	; 0x410
  8c:	85058406 	strhi	r8, [r5, #-1030]	; 0x406
  90:	87038604 	strhi	r8, [r3, -r4, lsl #12]
  94:	00018e02 	andeq	r8, r1, r2, lsl #28
  98:	0000001c 	andeq	r0, r0, ip, lsl r0
  9c:	00000068 	andeq	r0, r0, r8, rrx
  a0:	00008788 	andeq	r8, r0, r8, lsl #15
  a4:	00000198 	muleq	r0, r8, r1
  a8:	84180e42 	ldrhi	r0, [r8], #-3650	; 0xe42
  ac:	86058506 	strhi	r8, [r5], -r6, lsl #10
  b0:	88038704 	stmdahi	r3, {r2, r8, r9, sl, pc}
  b4:	00018e02 	andeq	r8, r1, r2, lsl #28
  b8:	0000000c 	andeq	r0, r0, ip
  bc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  c0:	7c020001 	stcvc	0, cr0, [r2], {1}
  c4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  c8:	00000024 	andeq	r0, r0, r4, lsr #32
  cc:	000000b8 	strheq	r0, [r0], -r8
  d0:	00008920 	andeq	r8, r0, r0, lsr #18
  d4:	00000566 	andeq	r0, r0, r6, ror #10
  d8:	84240e42 	strthi	r0, [r4], #-3650	; 0xe42
  dc:	86088509 	strhi	r8, [r8], -r9, lsl #10
  e0:	88068707 	stmdahi	r6, {r0, r1, r2, r8, r9, sl, pc}
  e4:	8a048905 	bhi	122500 <_stack+0xa2500>
  e8:	8e028b03 	vmlahi.f64	d8, d2, d3
  ec:	300e4401 	andcc	r4, lr, r1, lsl #8
  f0:	0000000c 	andeq	r0, r0, ip
  f4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  f8:	7c020001 	stcvc	0, cr0, [r2], {1}
  fc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 100:	0000000c 	andeq	r0, r0, ip
 104:	000000f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 108:	00008e88 	andeq	r8, r0, r8, lsl #29
 10c:	00000002 	andeq	r0, r0, r2
 110:	0000000c 	andeq	r0, r0, ip
 114:	000000f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 118:	00008e8c 	andeq	r8, r0, ip, lsl #29
 11c:	00000002 	andeq	r0, r0, r2
 120:	0000000c 	andeq	r0, r0, ip
 124:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 128:	7c020001 	stcvc	0, cr0, [r2], {1}
 12c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 130:	00000018 	andeq	r0, r0, r8, lsl r0
 134:	00000120 	andeq	r0, r0, r0, lsr #2
 138:	00008e90 	muleq	r0, r0, lr
 13c:	00000026 	andeq	r0, r0, r6, lsr #32
 140:	83100e41 	tsthi	r0, #1040	; 0x410
 144:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
 148:	00018e02 	andeq	r8, r1, r2, lsl #28

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	64735f5f 	ldrbtvs	r5, [r3], #-3935	; 0xf5f
   4:	6e696469 	cdpvs	4, 6, cr6, cr9, cr9, {3}
   8:	5f007469 	svcpl	0x00007469
   c:	67616c66 	strbvs	r6, [r1, -r6, ror #24]!
  10:	5f003273 	svcpl	0x00003273
  14:	656c626d 	strbvs	r6, [ip, #-621]!	; 0x26d
  18:	74735f6e 	ldrbtvc	r5, [r3], #-3950	; 0xf6e
  1c:	00657461 	rsbeq	r7, r5, r1, ror #8
  20:	34366c5f 	ldrtcc	r6, [r6], #-3167	; 0xc5f
  24:	75625f61 	strbvc	r5, [r2, #-3937]!	; 0xf61
  28:	6f5f0066 	svcvs	0x005f0066
  2c:	745f6666 	ldrbvc	r6, [pc], #-1638	; 34 <CPSR_THUMB+0x14>
  30:	775f5f00 	ldrbvc	r5, [pc, -r0, lsl #30]
  34:	5f006863 	svcpl	0x00006863
  38:	7366626c 	cmnvc	r6, #108, 4	; 0xc0000006
  3c:	00657a69 	rsbeq	r7, r5, r9, ror #20
  40:	61765f5f 	cmnvs	r6, pc, asr pc
  44:	0065756c 	rsbeq	r7, r5, ip, ror #10
  48:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0x56e
  4c:	00656e6f 	rsbeq	r6, r5, pc, ror #28
  50:	62735f5f 	rsbsvs	r5, r3, #380	; 0x17c
  54:	73006675 	movwvc	r6, #1653	; 0x675
  58:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xf68
  5c:	746e6920 	strbtvc	r6, [lr], #-2336	; 0x920
  60:	65725f00 	ldrbvs	r5, [r2, #-3840]!	; 0xf00
  64:	746c7573 	strbtvc	r7, [ip], #-1395	; 0x573
  68:	73006b5f 	movwvc	r6, #2911	; 0xb5f
  6c:	74657a69 	strbtvc	r7, [r5], #-2665	; 0xa69
  70:	00657079 	rsbeq	r7, r5, r9, ror r0
  74:	66666f5f 	uqsaxvs	r6, r6, pc	; <UNPREDICTABLE>
  78:	00746573 	rsbseq	r6, r4, r3, ror r5
  7c:	66735f5f 	uhsaxvs	r5, r3, pc	; <UNPREDICTABLE>
  80:	69735f00 	ldmdbvs	r3!, {r8, r9, sl, fp, ip, lr}^
  84:	6c616e67 	stclvs	14, cr6, [r1], #-412	; 0xfffffe64
  88:	6675625f 			; <UNDEFINED> instruction: 0x6675625f
  8c:	63775f00 	cmnvs	r7, #0, 30
  90:	6f747273 	svcvs	0x00747273
  94:	5f73626d 	svcpl	0x0073626d
  98:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
  9c:	665f0065 	ldrbvs	r0, [pc], -r5, rrx
  a0:	7367616c 	cmnvc	r7, #108, 2
  a4:	72775f00 	rsbsvc	r5, r7, #0, 30
  a8:	00657469 	rsbeq	r7, r5, r9, ror #8
  ac:	636f6c5f 	cmnvs	pc, #24320	; 0x5f00
  b0:	69746c61 	ldmdbvs	r4!, {r0, r5, r6, sl, fp, sp, lr}^
  b4:	625f656d 	subsvs	r6, pc, #457179136	; 0x1b400000
  b8:	5f006675 	svcpl	0x00006675
  bc:	756f635f 	strbvc	r6, [pc, #-863]!	; fffffd65 <_stack+0xfff7fd65>
  c0:	5f00746e 	svcpl	0x0000746e
  c4:	5f6d745f 	svcpl	0x006d745f
  c8:	7961646d 	stmdbvc	r1!, {r0, r2, r3, r5, r6, sl, sp, lr}^
  cc:	626d5f00 	rsbvs	r5, sp, #0, 30
  d0:	6f747273 	svcvs	0x00747273
  d4:	5f736377 	svcpl	0x00736377
  d8:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
  dc:	725f0065 	subsvc	r0, pc, #101	; 0x65
  e0:	5f003834 	svcpl	0x00003834
  e4:	6f647473 	svcvs	0x00647473
  e8:	5f007475 	svcpl	0x00007475
  ec:	78657461 	stmdavc	r5!, {r0, r5, r6, sl, ip, sp, lr}^
  f0:	5f007469 	svcpl	0x00007469
  f4:	72656d65 	rsbvc	r6, r5, #6464	; 0x1940
  f8:	636e6567 	cmnvs	lr, #432013312	; 0x19c00000
  fc:	635f0079 	cmpvs	pc, #121	; 0x79
 100:	656c7476 	strbvs	r7, [ip, #-1142]!	; 0x476
 104:	6e5f006e 	cdpvs	0, 5, cr0, cr15, cr14, {3}
 108:	00667562 	rsbeq	r7, r6, r2, ror #10
 10c:	434f4c5f 	movtmi	r4, #64607	; 0xfc5f
 110:	45525f4b 	ldrbmi	r5, [r2, #-3915]	; 0xf4b
 114:	53525543 	cmppl	r2, #281018368	; 0x10c00000
 118:	5f455649 	svcpl	0x00455649
 11c:	6e5f0054 	mrcvs	0, 2, r0, cr15, cr4, {2}
 120:	73626f69 	cmnvc	r2, #420	; 0x1a4
 124:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
 128:	00454c49 	subeq	r4, r5, r9, asr #24
 12c:	7465675f 	strbtvc	r6, [r5], #-1887	; 0x75f
 130:	65746164 	ldrbvs	r6, [r4, #-356]!	; 0x164
 134:	7272655f 	rsbsvc	r6, r2, #398458880	; 0x17c00000
 138:	745f5f00 	ldrbvc	r5, [pc], #-3840	; 140 <CPSR_IRQ_INHIBIT+0xc0>
 13c:	696d5f6d 	stmdbvs	sp!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
 140:	735f006e 	cmpvc	pc, #110	; 0x6e
 144:	665f6769 	ldrbvs	r6, [pc], -r9, ror #14
 148:	00636e75 	rsbeq	r6, r3, r5, ror lr
 14c:	616d6e5f 	cmnvs	sp, pc, asr lr
 150:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 154:	72665f00 	rsbvc	r5, r6, #0, 30
 158:	696c6565 	stmdbvs	ip!, {r0, r2, r5, r6, r8, sl, sp, lr}^
 15c:	5f007473 	svcpl	0x00007473
 160:	00736e66 	rsbseq	r6, r3, r6, ror #28
 164:	73626d5f 	cmnvc	r2, #6080	; 0x17c0
 168:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 16c:	745f5f00 	ldrbvc	r5, [pc], #-3840	; 174 <CPSR_IRQ_INHIBIT+0xf4>
 170:	64775f6d 	ldrbtvs	r5, [r7], #-3949	; 0xf6d
 174:	6c007961 	stcvs	9, cr7, [r0], {97}	; 0x61
 178:	20676e6f 	rsbcs	r6, r7, pc, ror #28
 17c:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
 180:	746e6920 	strbtvc	r6, [lr], #-2336	; 0x920
 184:	6e665f00 	cdpvs	15, 6, cr5, cr6, cr0, {0}
 188:	73677261 	cmnvc	r7, #268435462	; 0x10000006
 18c:	6f695f00 	svcvs	0x00695f00
 190:	5f007362 	svcpl	0x00007362
 194:	746c756d 	strbtvc	r7, [ip], #-1389	; 0x56d
 198:	745f5f00 	ldrbvc	r5, [pc], #-3840	; 1a0 <CPSR_IRQ_INHIBIT+0x120>
 19c:	73695f6d 	cmnvc	r9, #436	; 0x1b4
 1a0:	00747364 	rsbseq	r7, r4, r4, ror #6
 1a4:	6574615f 	ldrbvs	r6, [r4, #-351]!	; 0x15f
 1a8:	30746978 	rsbscc	r6, r4, r8, ror r9
 1ac:	6c625f00 	stclvs	15, cr5, [r2], #-0
 1b0:	7a69736b 	bvc	1a5cf64 <_stack+0x19dcf64>
 1b4:	665f0065 	ldrbvs	r0, [pc], -r5, rrx
 1b8:	7079746e 	rsbsvc	r7, r9, lr, ror #8
 1bc:	5f007365 	svcpl	0x00007365
 1c0:	736f7066 	cmnvc	pc, #102	; 0x66
 1c4:	5f00745f 	svcpl	0x0000745f
 1c8:	736f6c63 	cmnvc	pc, #25344	; 0x6300
 1cc:	665f0065 	ldrbvs	r0, [pc], -r5, rrx
 1d0:	6b636f6c 	blvs	18dbf88 <_stack+0x185bf88>
 1d4:	6300745f 	movwvs	r7, #1119	; 0x45f
 1d8:	6e61656c 	cdpvs	5, 6, cr6, cr1, cr12, {3}
 1dc:	675f7075 			; <UNDEFINED> instruction: 0x675f7075
 1e0:	0065756c 	rsbeq	r7, r5, ip, ror #10
 1e4:	6d745f5f 	ldclvs	15, cr5, [r4, #-380]!	; 0xfffffe84
 1e8:	6365735f 	cmnvs	r5, #2080374785	; 0x7c000001
 1ec:	745f5f00 	ldrbvc	r5, [pc], #-3840	; 1f4 <CPSR_IRQ_INHIBIT+0x174>
 1f0:	6f685f6d 	svcvs	0x00685f6d
 1f4:	75007275 	strvc	r7, [r0, #-629]	; 0x275
 1f8:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
 1fc:	2064656e 	rsbcs	r6, r4, lr, ror #10
 200:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
 204:	65725f00 	ldrbvs	r5, [r2, #-3840]!	; 0xf00
 208:	5f006461 	svcpl	0x00006461
 20c:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0x56e
 210:	735f0066 	cmpvc	pc, #102	; 0x66
 214:	72656474 	rsbvc	r6, r5, #116, 8	; 0x74000000
 218:	5f5f0072 	svcpl	0x005f0072
 21c:	62686377 	rsbvs	r6, r8, #-603979775	; 0xdc000001
 220:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
 224:	6f6c2067 	svcvs	0x006c2067
 228:	7520676e 	strvc	r6, [r0, #-1902]!	; 0x76e
 22c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
 230:	2064656e 	rsbcs	r6, r4, lr, ror #10
 234:	00746e69 	rsbseq	r6, r4, r9, ror #28
 238:	655f685f 	ldrbvs	r6, [pc, #-2143]	; fffff9e1 <_stack+0xfff7f9e1>
 23c:	6f6e7272 	svcvs	0x006e7272
 240:	735f5f00 	cmpvc	pc, #0, 30
 244:	65756c67 	ldrbvs	r6, [r5, #-3175]!	; 0xc67
 248:	6e6f5f00 	cdpvs	15, 6, cr5, cr15, cr0, {0}
 24c:	6978655f 	ldmdbvs	r8!, {r0, r1, r2, r3, r4, r6, r8, sl, sp, lr}^
 250:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 254:	2e007367 	cdpcs	3, 0, cr7, cr0, cr7, {3}
 258:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 25c:	2f2e2e2f 	svccs	0x002e2e2f
 260:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 264:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 268:	2f2e2e2f 	svccs	0x002e2e2f
 26c:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 270:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 274:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 278:	722f6362 	eorvc	r6, pc, #-2013265919	; 0x88000001
 27c:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 280:	6565722f 	strbvs	r7, [r5, #-559]!	; 0x22f
 284:	632e746e 	teqvs	lr, #1845493760	; 0x6e000000
 288:	626d5f00 	rsbvs	r5, sp, #0, 30
 28c:	776f7472 			; <UNDEFINED> instruction: 0x776f7472
 290:	74735f63 	ldrbtvc	r5, [r3], #-3939	; 0xf63
 294:	00657461 	rsbeq	r7, r5, r1, ror #8
 298:	6572665f 	ldrbvs	r6, [r2, #-1631]!	; 0x65f
 29c:	00725f65 	rsbseq	r5, r2, r5, ror #30
 2a0:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
 2a4:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
 2a8:	6e676973 	mcrvs	9, 3, r6, cr7, cr3, {3}
 2ac:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
 2b0:	5f00746e 	svcpl	0x0000746e
 2b4:	62747663 	rsbsvs	r7, r4, #103809024	; 0x6300000
 2b8:	5f006675 	svcpl	0x00006675
 2bc:	6b6f6f63 	blvs	1bdc050 <_stack+0x1b5c050>
 2c0:	2f006569 	svccs	0x00006569
 2c4:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 2c8:	75622f64 	strbvc	r2, [r2, #-3940]!	; 0xf64
 2cc:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xc69
 2d0:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 2d4:	2d62696c 	stclcs	9, cr6, [r2, #-432]!	; 0xfffffe50
 2d8:	2e312e32 	mrccs	14, 1, r2, cr1, cr2, {1}
 2dc:	75622f30 	strbvc	r2, [r2, #-3888]!	; 0xf30
 2e0:	2f646c69 	svccs	0x00646c69
 2e4:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 2e8:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
 2ec:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 2f0:	72612f69 	rsbvc	r2, r1, #420	; 0x1a4
 2f4:	2d37766d 	ldccs	6, cr7, [r7, #-436]!	; 0xfffffe4c
 2f8:	742f7261 	strtvc	r7, [pc], #-609	; 300 <CPSR_IRQ_INHIBIT+0x280>
 2fc:	626d7568 	rsbvs	r7, sp, #104, 10	; 0x1a000000
 300:	7570662f 	ldrbvc	r6, [r0, #-1583]!	; 0x62f
 304:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 308:	2f62696c 	svccs	0x0062696c
 30c:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 310:	6565722f 	strbvs	r7, [r5, #-559]!	; 0x22f
 314:	5f00746e 	svcpl	0x0000746e
 318:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0x966
 31c:	61675f00 	cmnvs	r7, r0, lsl #30
 320:	5f616d6d 	svcpl	0x00616d6d
 324:	6e676973 	mcrvs	9, 3, r6, cr7, cr3, {3}
 328:	006d6167 	rsbeq	r6, sp, r7, ror #2
 32c:	756e755f 	strbvc	r7, [lr, #-1375]!	; 0x55f
 330:	5f646573 	svcpl	0x00646573
 334:	646e6172 	strbtvs	r6, [lr], #-370	; 0x172
 338:	64775f00 	ldrbtvs	r5, [r7], #-3840	; 0xf00
 33c:	5f5f0073 	svcpl	0x005f0073
 340:	5f006d74 	svcpl	0x00006d74
 344:	73756e75 	cmnvc	r5, #1872	; 0x750
 348:	5f006465 	svcpl	0x00006465
 34c:	6f74626d 	svcvs	0x0074626d
 350:	735f6377 	cmpvc	pc, #-603979775	; 0xdc000001
 354:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 358:	6e697700 	cdpvs	7, 6, cr7, cr9, cr0, {0}
 35c:	00745f74 	rsbseq	r5, r4, r4, ror pc
 360:	72626d5f 	rsbvc	r6, r2, #6080	; 0x17c0
 364:	5f6e656c 	svcpl	0x006e656c
 368:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
 36c:	635f0065 	cmpvs	pc, #101	; 0x65
 370:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0x275
 374:	635f746e 	cmpvs	pc, #1845493760	; 0x6e000000
 378:	67657461 	strbvs	r7, [r5, -r1, ror #8]!
 37c:	0079726f 	rsbseq	r7, r9, pc, ror #4
 380:	5f73695f 	svcpl	0x0073695f
 384:	00617863 	rsbeq	r7, r1, r3, ror #16
 388:	6c635f5f 	stclvs	15, cr5, [r3], #-380	; 0xfffffe84
 38c:	756e6165 	strbvc	r6, [lr, #-357]!	; 0x165
 390:	68740070 	ldmdavs	r4!, {r4, r5, r6}^
 394:	6e6f7369 	cdpvs	3, 6, cr7, cr15, cr9, {3}
 398:	725f0065 	subsvc	r0, pc, #101	; 0x65
 39c:	616c6365 	cmnvs	ip, r5, ror #6
 3a0:	725f6d69 	subsvc	r6, pc, #6720	; 0x1a40
 3a4:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 3a8:	626d5f00 	rsbvs	r5, sp, #0, 30
 3ac:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
 3b0:	00745f65 	rsbseq	r5, r4, r5, ror #30
 3b4:	6769425f 			; <UNDEFINED> instruction: 0x6769425f
 3b8:	00746e69 	rsbseq	r6, r4, r9, ror #28
 3bc:	78616d5f 	stmdavc	r1!, {r0, r1, r2, r3, r4, r6, r8, sl, fp, sp, lr}^
 3c0:	00736477 	rsbseq	r6, r3, r7, ror r4
 3c4:	6d745f5f 	ldclvs	15, cr5, [r4, #-380]!	; 0xfffffe84
 3c8:	6165795f 	cmnvs	r5, pc, asr r9
 3cc:	4e470072 	mcrmi	0, 2, r0, cr7, cr2, {3}
 3d0:	20432055 	subcs	r2, r3, r5, asr r0
 3d4:	2e382e34 	mrccs	14, 1, r2, cr8, cr4, {1}
 3d8:	6d2d2032 	stcvs	0, cr2, [sp, #-200]!	; 0xffffff38
 3dc:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
 3e0:	6d2d2062 	stcvs	0, cr2, [sp, #-392]!	; 0xfffffe78
 3e4:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
 3e8:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
 3ec:	2d203776 	stccs	7, cr3, [r0, #-472]!	; 0xfffffe28
 3f0:	6f6c666d 	svcvs	0x006c666d
 3f4:	612d7461 	teqvs	sp, r1, ror #8
 3f8:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
 3fc:	20647261 	rsbcs	r7, r4, r1, ror #4
 400:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
 404:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
 408:	2d337670 	ldccs	6, cr7, [r3, #-448]!	; 0xfffffe40
 40c:	20363164 	eorscs	r3, r6, r4, ror #2
 410:	68746d2d 	ldmdavs	r4!, {r0, r2, r3, r5, r8, sl, fp, sp, lr}^
 414:	20626d75 	rsbcs	r6, r2, r5, ror sp
 418:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
 41c:	613d6863 	teqvs	sp, r3, ror #16
 420:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
 424:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
 428:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xf6c
 42c:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
 430:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
 434:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
 438:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
 43c:	76706676 			; <UNDEFINED> instruction: 0x76706676
 440:	31642d33 	cmncc	r4, r3, lsr sp
 444:	672d2036 			; <UNDEFINED> instruction: 0x672d2036
 448:	324f2d20 	subcc	r2, pc, #32, 26	; 0x800
 44c:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
 450:	75622d6f 	strbvc	r2, [r2, #-3439]!	; 0xd6f
 454:	69746c69 	ldmdbvs	r4!, {r0, r3, r5, r6, sl, fp, sp, lr}^
 458:	662d206e 	strtvs	r2, [sp], -lr, rrx
 45c:	752d6f6e 	strvc	r6, [sp, #-3950]!	; 0xf6e
 460:	6c6f726e 	sfmvs	f7, 2, [pc], #-440	; 2b0 <CPSR_IRQ_INHIBIT+0x230>
 464:	6f6c2d6c 	svcvs	0x006c2d6c
 468:	2073706f 	rsbscs	r7, r3, pc, rrx
 46c:	7566662d 	strbvc	r6, [r6, #-1581]!	; 0x62d
 470:	6974636e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
 474:	732d6e6f 	teqvc	sp, #1776	; 0x6f0
 478:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
 47c:	20736e6f 	rsbscs	r6, r3, pc, ror #28
 480:	6164662d 	cmnvs	r4, sp, lsr #12
 484:	732d6174 	teqvc	sp, #116, 2
 488:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
 48c:	00736e6f 	rsbseq	r6, r3, pc, ror #28
 490:	7274735f 	rsbsvc	r7, r4, #2080374785	; 0x7c000001
 494:	5f6b6f74 	svcpl	0x006b6f74
 498:	7473616c 	ldrbtvc	r6, [r3], #-364	; 0x16c
 49c:	65735f00 	ldrbvs	r5, [r3, #-3840]!	; 0xf00
 4a0:	5f006465 	svcpl	0x00006465
 4a4:	646e6172 	strbtvs	r6, [lr], #-370	; 0x172
 4a8:	5f003834 	svcpl	0x00003834
 4ac:	5f6d745f 	svcpl	0x006d745f
 4b0:	79616479 	stmdbvc	r1!, {r0, r3, r4, r5, r6, sl, sp, lr}^
 4b4:	555f5f00 	ldrbpl	r5, [pc, #-3840]	; fffff5bc <_stack+0xfff7f5bc>
 4b8:	676e6f4c 	strbvs	r6, [lr, -ip, asr #30]!
 4bc:	65735f00 	ldrbvs	r5, [r3, #-3840]!	; 0xf00
 4c0:	5f006b65 	svcpl	0x00006b65
 4c4:	75736572 	ldrbvc	r6, [r3, #-1394]!	; 0x572
 4c8:	5f00746c 	svcpl	0x0000746c
 4cc:	5f6d745f 	svcpl	0x006d745f
 4d0:	006e6f6d 	rsbeq	r6, lr, sp, ror #30
 4d4:	6464615f 	strbtvs	r6, [r4], #-351	; 0x15f
 4d8:	6e695f00 	cdpvs	15, 6, cr5, cr9, cr0, {0}
 4dc:	695f0063 	ldmdbvs	pc, {r0, r1, r5, r6}^	; <UNPREDICTABLE>
 4e0:	5f00646e 	svcpl	0x0000646e
 4e4:	6f746377 	svcvs	0x00746377
 4e8:	735f626d 	cmpvc	pc, #-805306362	; 0xd0000006
 4ec:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 4f0:	73645f00 	cmnvc	r4, #0, 30
 4f4:	61685f6f 	cmnvs	r8, pc, ror #30
 4f8:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0x46e
 4fc:	35705f00 	ldrbcc	r5, [r0, #-3840]!	; 0xf00
 500:	735f0073 	cmpvc	pc, #115	; 0x73
 504:	006e6769 	rsbeq	r6, lr, r9, ror #14
 508:	6e61725f 	mcrvs	2, 3, r7, cr1, cr15, {2}
 50c:	656e5f64 	strbvs	r5, [lr, #-3940]!	; 0xf64
 510:	5f007478 	svcpl	0x00007478
 514:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 518:	635f006e 	cmpvs	pc, #110	; 0x6e
 51c:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0x275
 520:	6c5f746e 	cfldrdvs	mvd7, [pc], {110}	; 0x6e
 524:	6c61636f 	stclvs	3, cr6, [r1], #-444	; 0xfffffe44
 528:	775f0065 	ldrbvc	r0, [pc, -r5, rrx]
 52c:	6f747263 	svcvs	0x00747263
 530:	735f626d 	cmpvc	pc, #-805306362	; 0xd0000006
 534:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 538:	62755f00 	rsbsvs	r5, r5, #0, 30
 53c:	5f006675 	svcpl	0x00006675
 540:	74637361 	strbtvc	r7, [r3], #-865	; 0x361
 544:	5f656d69 	svcpl	0x00656d69
 548:	00667562 	rsbeq	r7, r6, r2, ror #10
 54c:	46735f5f 	uhsaxmi	r5, r3, pc	; <UNPREDICTABLE>
 550:	00454c49 	subeq	r4, r5, r9, asr #24
 554:	77656e5f 			; <UNDEFINED> instruction: 0x77656e5f
 558:	7a697300 	bvc	1a5d160 <_stack+0x19dd160>
 55c:	00745f65 	rsbseq	r5, r4, r5, ror #30
 560:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 564:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 568:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 56c:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 570:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 574:	312e322d 	teqcc	lr, sp, lsr #4
 578:	622f302e 	eorvs	r3, pc, #46	; 0x2e
 57c:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 580:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 584:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 588:	61652d65 	cmnvs	r5, r5, ror #26
 58c:	612f6962 	teqvs	pc, r2, ror #18
 590:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
 594:	2f72612d 	svccs	0x0072612d
 598:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
 59c:	70662f62 	rsbvc	r2, r6, r2, ror #30
 5a0:	656e2f75 	strbvs	r2, [lr, #-3957]!	; 0xf75
 5a4:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 5a8:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 5ac:	616d2f63 	cmnvs	sp, r3, ror #30
 5b0:	6e696863 	cdpvs	8, 6, cr6, cr9, cr3, {3}
 5b4:	72612f65 	rsbvc	r2, r1, #404	; 0x194
 5b8:	7473006d 	ldrbtvc	r0, [r3], #-109	; 0x6d
 5bc:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
 5c0:	2f2e2e00 	svccs	0x002e2e00
 5c4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 5c8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 5cc:	2f2e2e2f 	svccs	0x002e2e2f
 5d0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 5d4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 5d8:	2f2e2e2f 	svccs	0x002e2e2f
 5dc:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 5e0:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 444 <CPSR_IRQ_INHIBIT+0x3c4>
 5e4:	2f636269 	svccs	0x00636269
 5e8:	6863616d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, sp, lr}^
 5ec:	2f656e69 	svccs	0x00656e69
 5f0:	2f6d7261 	svccs	0x006d7261
 5f4:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
 5f8:	632e6e65 	teqvs	lr, #1616	; 0x650
 5fc:	65727000 	ldrbvs	r7, [r2, #-0]!
 600:	69735f76 	ldmdbvs	r3!, {r1, r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 604:	5f00657a 	svcpl	0x0000657a
 608:	6c616d5f 	stclvs	13, cr6, [r1], #-380	; 0xfffffe84
 60c:	5f636f6c 	svcpl	0x00636f6c
 610:	5f706f74 	svcpl	0x00706f74
 614:	00646170 	rsbeq	r6, r4, r0, ror r1
 618:	6b6c6268 	blvs	1b18fc0 <_stack+0x1a98fc0>
 61c:	72610073 	rsbvc	r0, r1, #115	; 0x73
 620:	00616e65 	rsbeq	r6, r1, r5, ror #28
 624:	616d5f5f 	cmnvs	sp, pc, asr pc
 628:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 62c:	6c6e755f 	cfstr64vs	mvdx7, [lr], #-380	; 0xfffffe84
 630:	006b636f 	rsbeq	r6, fp, pc, ror #6
 634:	6e69626d 	cdpvs	2, 6, cr6, cr9, cr13, {3}
 638:	00727470 	rsbseq	r7, r2, r0, ror r4
 63c:	5f77656e 	svcpl	0x0077656e
 640:	006b7262 	rsbeq	r7, fp, r2, ror #4
 644:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 648:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 64c:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 650:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 654:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 658:	312e322d 	teqcc	lr, sp, lsr #4
 65c:	622f302e 	eorvs	r3, pc, #46	; 0x2e
 660:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 664:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 668:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 66c:	61652d65 	cmnvs	r5, r5, ror #26
 670:	612f6962 	teqvs	pc, r2, ror #18
 674:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
 678:	2f72612d 	svccs	0x0072612d
 67c:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
 680:	70662f62 	rsbvc	r2, r6, r2, ror #30
 684:	656e2f75 	strbvs	r2, [lr, #-3957]!	; 0xf75
 688:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 68c:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 690:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xf63
 694:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 698:	726f6600 	rsbvc	r6, pc, #0, 12
 69c:	6b6c6264 	blvs	1b19034 <_stack+0x1a99034>
 6a0:	78650073 	stmdavc	r5!, {r0, r1, r4, r5, r6}^
 6a4:	00617274 	rsbeq	r7, r1, r4, ror r2
 6a8:	616d5f5f 	cmnvs	sp, pc, asr pc
 6ac:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 6b0:	636f6c5f 	cmnvs	pc, #24320	; 0x5f00
 6b4:	7470006b 	ldrbtvc	r0, [r0], #-107	; 0x6b
 6b8:	66696472 			; <UNDEFINED> instruction: 0x66696472
 6bc:	00745f66 	rsbseq	r5, r4, r6, ror #30
 6c0:	64726f75 	ldrbtvs	r6, [r2], #-3957	; 0xf75
 6c4:	736b6c62 	cmnvc	fp, #25088	; 0x6200
 6c8:	6d736600 	ldclvs	6, cr6, [r3, #-0]
 6cc:	736b6c62 	cmnvc	fp, #25088	; 0x6200
 6d0:	6c616d00 	stclvs	13, cr6, [r1], #-0
 6d4:	5f636f6c 	svcpl	0x00636f6c
 6d8:	6e756863 	cdpvs	8, 7, cr6, cr5, cr3, {3}
 6dc:	5f5f006b 	svcpl	0x005f006b
 6e0:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 6e4:	745f636f 	ldrbvc	r6, [pc], #-879	; 6ec <CPSR_IRQ_INHIBIT+0x66c>
 6e8:	5f6d6972 	svcpl	0x006d6972
 6ec:	65726874 	ldrbvs	r6, [r2, #-2164]!	; 0x874
 6f0:	6c6f6873 	stclvs	8, cr6, [pc], #-460	; 52c <CPSR_IRQ_INHIBIT+0x4ac>
 6f4:	73750064 	cmnvc	r5, #100	; 0x64
 6f8:	6b6c626d 	blvs	1b190b4 <_stack+0x1a990b4>
 6fc:	73690073 	cmnvc	r9, #115	; 0x73
 700:	7000726c 	andvc	r7, r0, ip, ror #4
 704:	73656761 	cmnvc	r5, #25427968	; 0x1840000
 708:	7563007a 	strbvc	r0, [r3, #-122]!	; 0x7a
 70c:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
 710:	72625f74 	rsbvc	r5, r2, #116, 30	; 0x1d0
 714:	5f5f006b 	svcpl	0x005f006b
 718:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 71c:	635f636f 	cmpvs	pc, #-1140850687	; 0xbc000001
 720:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0x275
 724:	6d5f746e 	cfldrdvs	mvd7, [pc, #-440]	; 574 <CPSR_IRQ_INHIBIT+0x4f4>
 728:	696c6c61 	stmdbvs	ip!, {r0, r5, r6, sl, fp, sp, lr}^
 72c:	006f666e 	rsbeq	r6, pc, lr, ror #12
 730:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0x56e
 734:	5f007a73 	svcpl	0x00007a73
 738:	6c616d5f 	stclvs	13, cr6, [r1], #-380	; 0xfffffe84
 73c:	5f636f6c 	svcpl	0x00636f6c
 740:	005f7661 	subseq	r7, pc, r1, ror #12
 744:	76657270 			; <UNDEFINED> instruction: 0x76657270
 748:	72007a73 	andvc	r7, r0, #471040	; 0x73000
 74c:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 750:	7274705f 	rsbsvc	r7, r4, #95	; 0x5f
 754:	616d5f00 	cmnvs	sp, r0, lsl #30
 758:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 75c:	6972745f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, sl, ip, sp, lr}^
 760:	00725f6d 	rsbseq	r5, r2, sp, ror #30
 764:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 768:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 76c:	2f2e2e2f 	svccs	0x002e2e2f
 770:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 774:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 778:	2f2e2e2f 	svccs	0x002e2e2f
 77c:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 780:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 5e4 <CPSR_IRQ_INHIBIT+0x564>
 784:	2f636269 	svccs	0x00636269
 788:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 78c:	6d2f6269 	sfmvs	f6, 4, [pc, #-420]!	; 5f0 <CPSR_IRQ_INHIBIT+0x570>
 790:	6f6c6c61 	svcvs	0x006c6c61
 794:	632e7263 	teqvs	lr, #805306374	; 0x30000006
 798:	62735f00 	rsbsvs	r5, r3, #0, 30
 79c:	725f6b72 	subsvc	r6, pc, #116736	; 0x1c800
 7a0:	68636d00 	stmdavs	r3!, {r8, sl, fp, sp, lr}^
 7a4:	706b6e75 	rsbvc	r6, fp, r5, ror lr
 7a8:	6b007274 	blvs	1d180 <__bss_end__+0x13958>
 7ac:	63706565 	cmnvs	r0, #423624704	; 0x19400000
 7b0:	0074736f 	rsbseq	r7, r4, pc, ror #6
 7b4:	616d5f5f 	cmnvs	sp, pc, asr pc
 7b8:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 7bc:	7262735f 	rsbvc	r7, r2, #2080374785	; 0x7c000001
 7c0:	61625f6b 	cmnvs	r2, fp, ror #30
 7c4:	68006573 	stmdavs	r0, {r0, r1, r4, r5, r6, r8, sl, sp, lr}
 7c8:	686b6c62 	stmdavs	fp!, {r1, r5, r6, sl, fp, sp, lr}^
 7cc:	6d690064 	stclvs	0, cr0, [r9, #-400]!	; 0xfffffe70
 7d0:	65727570 	ldrbvs	r7, [r2, #-1392]!	; 0x570
 7d4:	7461645f 	strbtvc	r6, [r1], #-1119	; 0x45f
 7d8:	2e2e0061 	cdpcs	0, 2, cr0, cr14, cr1, {3}
 7dc:	2f2e2e2f 	svccs	0x002e2e2f
 7e0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7e4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 7e8:	2f2e2e2f 	svccs	0x002e2e2f
 7ec:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7f0:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xf2e
 7f4:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 7f8:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 7fc:	65722f63 	ldrbvs	r2, [r2, #-3939]!	; 0xf63
 800:	2f746e65 	svccs	0x00746e65
 804:	75706d69 	ldrbvc	r6, [r0, #-3433]!	; 0xd69
 808:	632e6572 	teqvs	lr, #478150656	; 0x1c800000
 80c:	6c675f00 	stclvs	15, cr5, [r7], #-0
 810:	6c61626f 	sfmvs	f6, 2, [r1], #-444	; 0xfffffe44
 814:	706d695f 	rsbvc	r6, sp, pc, asr r9
 818:	5f657275 	svcpl	0x00657275
 81c:	00727470 	rsbseq	r7, r2, r0, ror r4
 820:	74636976 	strbtvc	r6, [r3], #-2422	; 0x976
 824:	62006d69 	andvs	r6, r0, #6720	; 0x1a40
 828:	73657479 	cmnvc	r5, #2030043136	; 0x79000000
 82c:	6d657200 	sfmvs	f7, 2, [r5, #-0]
 830:	646e6961 	strbtvs	r6, [lr], #-2401	; 0x961
 834:	735f7265 	cmpvc	pc, #1342177286	; 0x50000006
 838:	00657a69 	rsbeq	r7, r5, r9, ror #20
 83c:	5f646c6f 	svcpl	0x00646c6f
 840:	00646e65 	rsbeq	r6, r4, r5, ror #28
 844:	636f6c62 	cmnvs	pc, #25088	; 0x6200
 848:	6976006b 	ldmdbvs	r6!, {r0, r1, r3, r5, r6}^
 84c:	6d697463 	cfstrdvs	mvd7, [r9, #-396]!	; 0xfffffe74
 850:	7a69735f 	bvc	1a5d5d4 <_stack+0x19dd5d4>
 854:	616d0065 	cmnvs	sp, r5, rrx
 858:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 85c:	7478655f 	ldrbtvc	r6, [r8], #-1375	; 0x55f
 860:	5f646e65 	svcpl	0x00646e65
 864:	00706f74 	rsbseq	r6, r0, r4, ror pc
 868:	6e6f7266 	cdpvs	2, 6, cr7, cr15, cr6, {3}
 86c:	696d5f74 	stmdbvs	sp!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 870:	696c6173 	stmdbvs	ip!, {r0, r1, r4, r5, r6, r8, sp, lr}^
 874:	73006e67 	movwvc	r6, #3687	; 0xe67
 878:	5f6b7262 	svcpl	0x006b7262
 87c:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0x973
 880:	6d657200 	sfmvs	f7, 2, [r5, #-0]
 884:	646e6961 	strbtvs	r6, [lr], #-2401	; 0x961
 888:	695f7265 	ldmdbvs	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
 88c:	7865646e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, sp, lr}^
 890:	6d5f5f00 	ldclvs	15, cr5, [pc, #-0]	; 898 <CPSR_IRQ_INHIBIT+0x818>
 894:	6f6c6c61 	svcvs	0x006c6c61
 898:	616d5f63 	cmnvs	sp, r3, ror #30
 89c:	6f745f78 	svcvs	0x00745f78
 8a0:	5f6c6174 	svcpl	0x006c6174
 8a4:	006d656d 	rsbeq	r6, sp, sp, ror #10
 8a8:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
 8ac:	78646974 	stmdavc	r4!, {r2, r4, r5, r6, r8, fp, sp, lr}^
 8b0:	616d5f00 	cmnvs	sp, r0, lsl #30
 8b4:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 8b8:	7200725f 	andvc	r7, r0, #-268435451	; 0xf0000005
 8bc:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
 8c0:	7265646e 	rsbvc	r6, r5, #1845493760	; 0x6e000000
 8c4:	646c6f00 	strbtvs	r6, [ip], #-3840	; 0xf00
 8c8:	706f745f 	rsbvc	r7, pc, pc, asr r4	; <UNPREDICTABLE>
 8cc:	6d5f5f00 	ldclvs	15, cr5, [pc, #-0]	; 8d4 <CPSR_IRQ_INHIBIT+0x854>
 8d0:	6f6c6c61 	svcvs	0x006c6c61
 8d4:	616d5f63 	cmnvs	sp, r3, ror #30
 8d8:	62735f78 	rsbsvs	r5, r3, #120, 30	; 0x1e0
 8dc:	64656b72 	strbtvs	r6, [r5], #-2930	; 0xb72
 8e0:	6d656d5f 	stclvs	13, cr6, [r5, #-380]!	; 0xfffffe84
 8e4:	726f6300 	rsbvc	r6, pc, #0, 6
 8e8:	74636572 	strbtvc	r6, [r3], #-1394	; 0x572
 8ec:	5f6e6f69 	svcpl	0x006e6f69
 8f0:	6c696166 	stfvse	f6, [r9], #-408	; 0xfffffe68
 8f4:	6f006465 	svcvs	0x00006465
 8f8:	745f646c 	ldrbvc	r6, [pc], #-1132	; 900 <CPSR_IRQ_INHIBIT+0x880>
 8fc:	735f706f 	cmpvc	pc, #111	; 0x6f
 900:	00657a69 	rsbeq	r7, r5, r9, ror #20
 904:	72726f63 	rsbsvc	r6, r2, #396	; 0x18c
 908:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
 90c:	5f006e6f 	svcpl	0x00006e6f
 910:	6c616d5f 	stclvs	13, cr6, [r1], #-380	; 0xfffffe84
 914:	5f636f6c 	svcpl	0x00636f6c
 918:	6b636f6c 	blvs	18dc6d0 <_stack+0x185c6d0>
 91c:	6a626f5f 	bvs	189c6a0 <_stack+0x181c6a0>
 920:	00746365 	rsbseq	r6, r4, r5, ror #6
 924:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 928:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 92c:	2f2e2e2f 	svccs	0x002e2e2f
 930:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 934:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 938:	2f2e2e2f 	svccs	0x002e2e2f
 93c:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 940:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 7a4 <CPSR_IRQ_INHIBIT+0x724>
 944:	2f636269 	svccs	0x00636269
 948:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 94c:	6d2f6269 	sfmvs	f6, 4, [pc, #-420]!	; 7b0 <CPSR_IRQ_INHIBIT+0x730>
 950:	6b636f6c 	blvs	18dc708 <_stack+0x185c708>
 954:	6900632e 	stmdbvs	r0, {r1, r2, r3, r5, r8, r9, sp, lr}
 958:	0072636e 	rsbseq	r6, r2, lr, ror #6
 95c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 960:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 964:	2f2e2e2f 	svccs	0x002e2e2f
 968:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 96c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 970:	2f2e2e2f 	svccs	0x002e2e2f
 974:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 978:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 7dc <CPSR_IRQ_INHIBIT+0x75c>
 97c:	2f636269 	svccs	0x00636269
 980:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 984:	62732f74 	rsbsvs	r2, r3, #116, 30	; 0x1d0
 988:	2e726b72 	vmovcs.s8	r6, d2[7]
 98c:	735f0063 	cmpvc	pc, #99	; 0x63
 990:	006b7262 	rsbeq	r7, fp, r2, ror #4

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
       0:	000085d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
       4:	000085e5 	andeq	r8, r0, r5, ror #11
       8:	e5500001 	ldrb	r0, [r0, #-1]
       c:	ee000085 	cdp	0, 0, cr0, cr0, cr5, {4}
      10:	01000085 	smlabbeq	r0, r5, r0, r0
      14:	85ee5500 	strbhi	r5, [lr, #1280]!	; 0x500
      18:	85f10000 	ldrbhi	r0, [r1, #0]!
      1c:	00010000 	andeq	r0, r1, r0
      20:	0085f150 	addeq	pc, r5, r0, asr r1	; <UNPREDICTABLE>
      24:	0085f200 	addeq	pc, r5, r0, lsl #4
      28:	f3000400 	vshl.u8	d0, d0, d0
      2c:	009f5001 	addseq	r5, pc, r1
      30:	00000000 	andeq	r0, r0, r0
      34:	d8000000 	stmdale	r0, {}	; <UNPREDICTABLE>
      38:	de000085 	cdple	0, 0, cr0, cr0, cr5, {4}
      3c:	01000085 	smlabbeq	r0, r5, r0, r0
      40:	85de5100 	ldrbhi	r5, [lr, #256]	; 0x100
      44:	85ee0000 	strbhi	r0, [lr, #0]!
      48:	00010000 	andeq	r0, r1, r0
      4c:	0085ee54 	addeq	lr, r5, r4, asr lr
      50:	0085f100 	addeq	pc, r5, r0, lsl #2
      54:	51000100 	mrspl	r0, (UNDEF: 16)
      58:	000085f1 	strdeq	r8, [r0], -r1
      5c:	000085f2 	strdeq	r8, [r0], -r2
      60:	01f30004 	mvnseq	r0, r4
      64:	00009f51 	andeq	r9, r0, r1, asr pc
      68:	00000000 	andeq	r0, r0, r0
      6c:	85f40000 	ldrbhi	r0, [r4, #0]!
      70:	860e0000 	strhi	r0, [lr], -r0
      74:	00010000 	andeq	r0, r1, r0
      78:	00860e50 	addeq	r0, r6, r0, asr lr
      7c:	00868000 	addeq	r8, r6, r0
      80:	55000100 	strpl	r0, [r0, #-256]	; 0x100
      84:	00008680 	andeq	r8, r0, r0, lsl #13
      88:	00008683 	andeq	r8, r0, r3, lsl #13
      8c:	83500001 	cmphi	r0, #1
      90:	84000086 	strhi	r0, [r0], #-134	; 0x86
      94:	04000086 	streq	r0, [r0], #-134	; 0x86
      98:	5001f300 	andpl	pc, r1, r0, lsl #6
      9c:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
      a0:	00000000 	andeq	r0, r0, r0
      a4:	00860e00 	addeq	r0, r6, r0, lsl #28
      a8:	00863600 	addeq	r3, r6, r0, lsl #12
      ac:	56000100 	strpl	r0, [r0], -r0, lsl #2
	...
      b8:	00008618 	andeq	r8, r0, r8, lsl r6
      bc:	0000861f 	andeq	r8, r0, pc, lsl r6
      c0:	00510001 	subseq	r0, r1, r1
      c4:	00000000 	andeq	r0, r0, r0
      c8:	12000000 	andne	r0, r0, #0
      cc:	16000086 	strne	r0, [r0], -r6, lsl #1
      d0:	01000086 	smlabbeq	r0, r6, r0, r0
      d4:	86165100 	ldrhi	r5, [r6], -r0, lsl #2
      d8:	86180000 	ldrhi	r0, [r8], -r0
      dc:	00010000 	andeq	r0, r1, r0
      e0:	00861854 	addeq	r1, r6, r4, asr r8
      e4:	00861a00 	addeq	r1, r6, r0, lsl #20
      e8:	51000100 	mrspl	r0, (UNDEF: 16)
      ec:	0000861a 	andeq	r8, r0, sl, lsl r6
      f0:	00008626 	andeq	r8, r0, r6, lsr #12
      f4:	00540001 	subseq	r0, r4, r1
      f8:	00000000 	andeq	r0, r0, r0
      fc:	4e000000 	cdpmi	0, 0, cr0, cr0, cr0, {0}
     100:	50000086 	andpl	r0, r0, r6, lsl #1
     104:	01000086 	smlabbeq	r0, r6, r0, r0
     108:	86505100 	ldrbhi	r5, [r0], -r0, lsl #2
     10c:	865c0000 	ldrbhi	r0, [ip], -r0
     110:	00010000 	andeq	r0, r1, r0
     114:	00000054 	andeq	r0, r0, r4, asr r0
     118:	00000000 	andeq	r0, r0, r0
     11c:	00864e00 	addeq	r4, r6, r0, lsl #28
     120:	00865500 	addeq	r5, r6, r0, lsl #10
     124:	51000100 	mrspl	r0, (UNDEF: 16)
	...
     130:	00008684 	andeq	r8, r0, r4, lsl #13
     134:	000086e2 	andeq	r8, r0, r2, ror #13
     138:	e2500001 	subs	r0, r0, #1
     13c:	e2000086 	and	r0, r0, #134	; 0x86
     140:	04000086 	streq	r0, [r0], #-134	; 0x86
     144:	5001f300 	andpl	pc, r1, r0, lsl #6
     148:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     14c:	00000000 	andeq	r0, r0, r0
     150:	0086e400 	addeq	lr, r6, r0, lsl #8
     154:	0086f500 	addeq	pc, r6, r0, lsl #10
     158:	50000100 	andpl	r0, r0, r0, lsl #2
     15c:	000086f5 	strdeq	r8, [r0], -r5
     160:	00008786 	andeq	r8, r0, r6, lsl #15
     164:	00550001 	subseq	r0, r5, r1
     168:	00000000 	andeq	r0, r0, r0
     16c:	e4000000 	str	r0, [r0], #-0
     170:	f5000086 			; <UNDEFINED> instruction: 0xf5000086
     174:	01000086 	smlabbeq	r0, r6, r0, r0
     178:	86f55100 	ldrbthi	r5, [r5], r0, lsl #2
     17c:	87000000 	strhi	r0, [r0, -r0]
     180:	00010000 	andeq	r0, r1, r0
     184:	00870057 	addeq	r0, r7, r7, asr r0
     188:	00878600 	addeq	r8, r7, r0, lsl #12
     18c:	f3000400 	vshl.u8	d0, d0, d0
     190:	009f5101 	addseq	r5, pc, r1, lsl #2
     194:	00000000 	andeq	r0, r0, r0
     198:	fe000000 	cdp2	0, 0, cr0, cr0, cr0, {0}
     19c:	20000086 	andcs	r0, r0, r6, lsl #1
     1a0:	01000087 	smlabbeq	r0, r7, r0, r0
     1a4:	872a5600 	strhi	r5, [sl, -r0, lsl #12]!
     1a8:	87420000 	strbhi	r0, [r2, -r0]
     1ac:	00010000 	andeq	r0, r1, r0
     1b0:	00875856 	addeq	r5, r7, r6, asr r8
     1b4:	00876400 	addeq	r6, r7, r0, lsl #8
     1b8:	56000100 	strpl	r0, [r0], -r0, lsl #2
     1bc:	00008764 	andeq	r8, r0, r4, ror #14
     1c0:	0000877e 	andeq	r8, r0, lr, ror r7
     1c4:	7e520001 	cdpvc	0, 5, cr0, cr2, cr1, {0}
     1c8:	82000087 	andhi	r0, r0, #135	; 0x87
     1cc:	06000087 	streq	r0, [r0], -r7, lsl #1
     1d0:	73007000 	movwvc	r7, #0
     1d4:	009f1c00 	addseq	r1, pc, r0, lsl #24
     1d8:	00000000 	andeq	r0, r0, r0
     1dc:	0a000000 	beq	1e4 <CPSR_IRQ_INHIBIT+0x164>
     1e0:	4e000087 	cdpmi	0, 0, cr0, cr0, cr7, {4}
     1e4:	01000087 	smlabbeq	r0, r7, r0, r0
     1e8:	87585700 	ldrbhi	r5, [r8, -r0, lsl #14]
     1ec:	87860000 	strhi	r0, [r6, r0]
     1f0:	00010000 	andeq	r0, r1, r0
     1f4:	00000057 	andeq	r0, r0, r7, asr r0
     1f8:	00000000 	andeq	r0, r0, r0
     1fc:	00871800 	addeq	r1, r7, r0, lsl #16
     200:	00872000 	addeq	r2, r7, r0
     204:	50000100 	andpl	r0, r0, r0, lsl #2
     208:	0000872a 	andeq	r8, r0, sl, lsr #14
     20c:	0000872c 	andeq	r8, r0, ip, lsr #14
     210:	60500001 	subsvs	r0, r0, r1
     214:	82000087 	andhi	r0, r0, #135	; 0x87
     218:	01000087 	smlabbeq	r0, r7, r0, r0
     21c:	00005000 	andeq	r5, r0, r0
     220:	00000000 	andeq	r0, r0, r0
     224:	87320000 	ldrhi	r0, [r2, -r0]!
     228:	87340000 	ldrhi	r0, [r4, -r0]!
     22c:	00010000 	andeq	r0, r1, r0
     230:	00873450 	addeq	r3, r7, r0, asr r4
     234:	00874400 	addeq	r4, r7, r0, lsl #8
     238:	70000300 	andvc	r0, r0, r0, lsl #6
     23c:	87589f7f 			; <UNDEFINED> instruction: 0x87589f7f
     240:	875a0000 	ldrbhi	r0, [sl, -r0]
     244:	00030000 	andeq	r0, r3, r0
     248:	009f7f70 	addseq	r7, pc, r0, ror pc	; <UNPREDICTABLE>
     24c:	00000000 	andeq	r0, r0, r0
     250:	88000000 	stmdahi	r0, {}	; <UNPREDICTABLE>
     254:	97000087 	strls	r0, [r0, -r7, lsl #1]
     258:	01000087 	smlabbeq	r0, r7, r0, r0
     25c:	87975000 	ldrhi	r5, [r7, r0]
     260:	884e0000 	stmdahi	lr, {}^	; <UNPREDICTABLE>
     264:	00010000 	andeq	r0, r1, r0
     268:	00884e58 	addeq	r4, r8, r8, asr lr
     26c:	00885100 	addeq	r5, r8, r0, lsl #2
     270:	50000100 	andpl	r0, r0, r0, lsl #2
     274:	00008851 	andeq	r8, r0, r1, asr r8
     278:	00008852 	andeq	r8, r0, r2, asr r8
     27c:	01f30004 	mvnseq	r0, r4
     280:	88529f50 	ldmdahi	r2, {r4, r6, r8, r9, sl, fp, ip, pc}^
     284:	88560000 	ldmdahi	r6, {}^	; <UNPREDICTABLE>
     288:	00010000 	andeq	r0, r1, r0
     28c:	00885650 	addeq	r5, r8, r0, asr r6
     290:	00887a00 	addeq	r7, r8, r0, lsl #20
     294:	58000100 	stmdapl	r0, {r8}
     298:	0000887a 	andeq	r8, r0, sl, ror r8
     29c:	0000887d 	andeq	r8, r0, sp, ror r8
     2a0:	7d500001 	ldclvc	0, cr0, [r0, #-4]
     2a4:	7e000088 	cdpvc	0, 0, cr0, cr0, cr8, {4}
     2a8:	04000088 	streq	r0, [r0], #-136	; 0x88
     2ac:	5001f300 	andpl	pc, r1, r0, lsl #6
     2b0:	00887e9f 	umulleq	r7, r8, pc, lr	; <UNPREDICTABLE>
     2b4:	00892000 	addeq	r2, r9, r0
     2b8:	58000100 	stmdapl	r0, {r8}
	...
     2c4:	00008788 	andeq	r8, r0, r8, lsl #15
     2c8:	00008797 	muleq	r0, r7, r7
     2cc:	97510001 	ldrbls	r0, [r1, -r1]
     2d0:	ca000087 	bgt	4f4 <CPSR_IRQ_INHIBIT+0x474>
     2d4:	01000087 	smlabbeq	r0, r7, r0, r0
     2d8:	87ca5600 	strbhi	r5, [sl, r0, lsl #12]
     2dc:	87d00000 	ldrbhi	r0, [r0, r0]
     2e0:	00030000 	andeq	r0, r3, r0
     2e4:	d09f0874 	addsle	r0, pc, r4, ror r8	; <UNPREDICTABLE>
     2e8:	52000087 	andpl	r0, r0, #135	; 0x87
     2ec:	04000088 	streq	r0, [r0], #-136	; 0x88
     2f0:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     2f4:	0088529f 	umulleq	r5, r8, pc, r2	; <UNPREDICTABLE>
     2f8:	00885600 	addeq	r5, r8, r0, lsl #12
     2fc:	51000100 	mrspl	r0, (UNDEF: 16)
     300:	00008856 	andeq	r8, r0, r6, asr r8
     304:	0000887e 	andeq	r8, r0, lr, ror r8
     308:	01f30004 	mvnseq	r0, r4
     30c:	887e9f51 	ldmdahi	lr!, {r0, r4, r6, r8, r9, sl, fp, ip, pc}^
     310:	88bc0000 	ldmhi	ip!, {}	; <UNPREDICTABLE>
     314:	00010000 	andeq	r0, r1, r0
     318:	0088bc56 	addeq	fp, r8, r6, asr ip
     31c:	00892000 	addeq	r2, r9, r0
     320:	f3000400 	vshl.u8	d0, d0, d0
     324:	009f5101 	addseq	r5, pc, r1, lsl #2
     328:	00000000 	andeq	r0, r0, r0
     32c:	a8000000 	stmdage	r0, {}	; <UNPREDICTABLE>
     330:	4e000087 	cdpmi	0, 0, cr0, cr0, cr7, {4}
     334:	01000088 	smlabbeq	r0, r8, r0, r0
     338:	88565400 	ldmdahi	r6, {sl, ip, lr}^
     33c:	887a0000 	ldmdahi	sl!, {}^	; <UNPREDICTABLE>
     340:	00010000 	andeq	r0, r1, r0
     344:	00887a54 	addeq	r7, r8, r4, asr sl
     348:	00887d00 	addeq	r7, r8, r0, lsl #26
     34c:	72000200 	andvc	r0, r0, #0, 4
     350:	00887e08 	addeq	r7, r8, r8, lsl #28
     354:	00892000 	addeq	r2, r9, r0
     358:	54000100 	strpl	r0, [r0], #-256	; 0x100
	...
     364:	000087a8 	andeq	r8, r0, r8, lsr #15
     368:	000087be 			; <UNDEFINED> instruction: 0x000087be
     36c:	be510001 	cdplt	0, 5, cr0, cr1, cr1, {0}
     370:	c0000087 	andgt	r0, r0, r7, lsl #1
     374:	02000087 	andeq	r0, r0, #135	; 0x87
     378:	7e7c7600 	cdpvc	6, 7, cr7, cr12, cr0, {0}
     37c:	b6000088 	strlt	r0, [r0], -r8, lsl #1
     380:	01000088 	smlabbeq	r0, r8, r0, r0
     384:	00005100 	andeq	r5, r0, r0, lsl #2
     388:	00000000 	andeq	r0, r0, r0
     38c:	87ac0000 	strhi	r0, [ip, r0]!
     390:	88400000 	stmdahi	r0, {}^	; <UNPREDICTABLE>
     394:	00010000 	andeq	r0, r1, r0
     398:	00885653 	addeq	r5, r8, r3, asr r6
     39c:	00885800 	addeq	r5, r8, r0, lsl #16
     3a0:	53000100 	movwpl	r0, #256	; 0x100
     3a4:	0000887e 	andeq	r8, r0, lr, ror r8
     3a8:	00008882 	andeq	r8, r0, r2, lsl #17
     3ac:	82530001 	subshi	r0, r3, #1
     3b0:	b4000088 	strlt	r0, [r0], #-136	; 0x88
     3b4:	01000088 	smlabbeq	r0, r8, r0, r0
     3b8:	88bc5000 	ldmhi	ip!, {ip, lr}
     3bc:	88e80000 	stmiahi	r8!, {}^	; <UNPREDICTABLE>
     3c0:	00010000 	andeq	r0, r1, r0
     3c4:	0088f853 	addeq	pc, r8, r3, asr r8	; <UNPREDICTABLE>
     3c8:	00892000 	addeq	r2, r9, r0
     3cc:	53000100 	movwpl	r0, #256	; 0x100
	...
     3d8:	0000881c 	andeq	r8, r0, ip, lsl r8
     3dc:	00008840 	andeq	r8, r0, r0, asr #16
     3e0:	58500001 	ldmdapl	r0, {r0}^
     3e4:	62000088 	andvs	r0, r0, #136	; 0x88
     3e8:	01000088 	smlabbeq	r0, r8, r0, r0
     3ec:	88e65300 	stmiahi	r6!, {r8, r9, ip, lr}^
     3f0:	88ec0000 	stmiahi	ip!, {}^	; <UNPREDICTABLE>
     3f4:	00010000 	andeq	r0, r1, r0
     3f8:	00000050 	andeq	r0, r0, r0, asr r0
     3fc:	00000000 	andeq	r0, r0, r0
     400:	0087ae00 	addeq	sl, r7, r0, lsl #28
     404:	0087fc00 	addeq	pc, r7, r0, lsl #24
     408:	52000100 	andpl	r0, r0, #0, 2
     40c:	0000887e 	andeq	r8, r0, lr, ror r8
     410:	0000888e 	andeq	r8, r0, lr, lsl #17
     414:	8e520001 	cdphi	0, 5, cr0, cr2, cr1, {0}
     418:	b6000088 	strlt	r0, [r0], -r8, lsl #1
     41c:	0b000088 	bleq	644 <CPSR_IRQ_INHIBIT+0x5c4>
     420:	09007100 	stmdbeq	r0, {r8, ip, sp, lr}
     424:	00761afe 	ldrshteq	r1, [r6], #-174	; 0xffffff52
     428:	9f1c3822 	svcls	0x001c3822
     42c:	000088bc 			; <UNDEFINED> instruction: 0x000088bc
     430:	000088c2 	andeq	r8, r0, r2, asr #17
     434:	00520001 	subseq	r0, r2, r1
     438:	00000000 	andeq	r0, r0, r0
     43c:	b8000000 	stmdalt	r0, {}	; <UNPREDICTABLE>
     440:	f2000087 	vhadd.s8	d0, d16, d7
     444:	01000087 	smlabbeq	r0, r7, r0, r0
     448:	87f25000 	ldrbhi	r5, [r2, r0]!
     44c:	87fc0000 	ldrbhi	r0, [ip, r0]!
     450:	00020000 	andeq	r0, r2, r0
     454:	887e0472 	ldmdahi	lr!, {r1, r4, r5, r6, sl}^
     458:	88820000 	stmhi	r2, {}	; <UNPREDICTABLE>
     45c:	00010000 	andeq	r0, r1, r0
     460:	00888250 	addeq	r8, r8, r0, asr r2
     464:	00888e00 	addeq	r8, r8, r0, lsl #28
     468:	72000700 	andvc	r0, r0, #0, 14
     46c:	fc090604 	stc2	6, cr0, [r9], {4}
     470:	888e9f1a 	stmhi	lr, {r1, r3, r4, r8, r9, sl, fp, ip, pc}
     474:	88a20000 	stmiahi	r2!, {}	; <UNPREDICTABLE>
     478:	000f0000 	andeq	r0, pc, r0
     47c:	fe090071 	mcr2	0, 0, r0, cr9, cr1, {3}
     480:	2200761a 	andcs	r7, r0, #27262976	; 0x1a00000
     484:	09061c34 	stmdbeq	r6, {r2, r4, r5, sl, fp, ip}
     488:	bc9f1afc 	vldmialt	pc, {s2-s253}
     48c:	c2000088 	andgt	r0, r0, #136	; 0x88
     490:	02000088 	andeq	r0, r0, #136	; 0x88
     494:	00047200 	andeq	r7, r4, r0, lsl #4
     498:	00000000 	andeq	r0, r0, r0
     49c:	ca000000 	bgt	4a4 <CPSR_IRQ_INHIBIT+0x424>
     4a0:	d4000087 	strle	r0, [r0], #-135	; 0x87
     4a4:	01000087 	smlabbeq	r0, r7, r0, r0
     4a8:	87d45600 	ldrbhi	r5, [r4, r0, lsl #12]
     4ac:	87e60000 	strbhi	r0, [r6, r0]!
     4b0:	00050000 	andeq	r0, r5, r0
     4b4:	385101f3 	ldmdacc	r1, {r0, r1, r4, r5, r6, r7, r8}^
     4b8:	0088881c 	addeq	r8, r8, ip, lsl r8
     4bc:	00889000 	addeq	r9, r8, r0
     4c0:	53000100 	movwpl	r0, #256	; 0x100
     4c4:	00008890 	muleq	r0, r0, r8
     4c8:	00008894 	muleq	r0, r4, r8
     4cc:	78760002 	ldmdavc	r6!, {r1}^
	...
     4d8:	000087dc 	ldrdeq	r8, [r0], -ip
     4dc:	000087e6 	andeq	r8, r0, r6, ror #15
     4e0:	fc5c0001 	mrrc2	0, 0, r0, ip, cr1
     4e4:	00000087 	andeq	r0, r0, r7, lsl #1
     4e8:	01000088 	smlabbeq	r0, r8, r0, r0
     4ec:	88205200 	stmdahi	r0!, {r9, ip, lr}
     4f0:	88400000 	stmdahi	r0, {}^	; <UNPREDICTABLE>
     4f4:	00010000 	andeq	r0, r1, r0
     4f8:	00884055 	addeq	r4, r8, r5, asr r0
     4fc:	00884800 	addeq	r4, r8, r0, lsl #16
     500:	53000100 	movwpl	r0, #256	; 0x100
     504:	00008860 	andeq	r8, r0, r0, ror #16
     508:	0000887d 	andeq	r8, r0, sp, ror r8
     50c:	90520001 	subsls	r0, r2, r1
     510:	94000088 	strls	r0, [r0], #-136	; 0x88
     514:	01000088 	smlabbeq	r0, r8, r0, r0
     518:	88e65300 	stmiahi	r6!, {r8, r9, ip, lr}^
     51c:	88ea0000 	stmiahi	sl!, {}^	; <UNPREDICTABLE>
     520:	00010000 	andeq	r0, r1, r0
     524:	00000055 	andeq	r0, r0, r5, asr r0
     528:	00000000 	andeq	r0, r0, r0
     52c:	0087dc00 	addeq	sp, r7, r0, lsl #24
     530:	0087e600 	addeq	lr, r7, r0, lsl #12
     534:	56000100 	strpl	r0, [r0], -r0, lsl #2
     538:	000087fc 	strdeq	r8, [r0], -ip
     53c:	00008800 	andeq	r8, r0, r0, lsl #16
     540:	2a500001 	bcs	140054c <_stack+0x138054c>
     544:	48000088 	stmdami	r0, {r3, r7}
     548:	01000088 	smlabbeq	r0, r8, r0, r0
     54c:	88685200 	stmdahi	r8!, {r9, ip, lr}^
     550:	887d0000 	ldmdahi	sp!, {}^	; <UNPREDICTABLE>
     554:	00010000 	andeq	r0, r1, r0
     558:	00889051 	addeq	r9, r8, r1, asr r0
     55c:	00889400 	addeq	r9, r8, r0, lsl #8
     560:	52000100 	andpl	r0, r0, #0, 2
     564:	000088e6 	andeq	r8, r0, r6, ror #17
     568:	000088f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
     56c:	00520001 	subseq	r0, r2, r1
     570:	00000000 	andeq	r0, r0, r0
     574:	c0000000 	andgt	r0, r0, r0
     578:	e6000087 	str	r0, [r0], -r7, lsl #1
     57c:	02000087 	andeq	r0, r0, #135	; 0x87
     580:	e69f3000 	ldr	r3, [pc], r0
     584:	1c000087 	stcne	0, cr0, [r0], {135}	; 0x87
     588:	01000088 	smlabbeq	r0, r8, r0, r0
     58c:	88565100 	ldmdahi	r6, {r8, ip, lr}^
     590:	885a0000 	ldmdahi	sl, {}^	; <UNPREDICTABLE>
     594:	00010000 	andeq	r0, r1, r0
     598:	0088bc51 	addeq	fp, r8, r1, asr ip
     59c:	0088ce00 	addeq	ip, r8, r0, lsl #28
     5a0:	31000200 	mrscc	r0, R8_usr
     5a4:	0088ce9f 	umulleq	ip, r8, pc, lr	; <UNPREDICTABLE>
     5a8:	0088d800 	addeq	sp, r8, r0, lsl #16
     5ac:	51000100 	mrspl	r0, (UNDEF: 16)
	...
     5b8:	00008920 	andeq	r8, r0, r0, lsr #18
     5bc:	0000894f 	andeq	r8, r0, pc, asr #18
     5c0:	4f500001 	svcmi	0x00500001
     5c4:	90000089 	andls	r0, r0, r9, lsl #1
     5c8:	01000089 	smlabbeq	r0, r9, r0, r0
     5cc:	89905700 	ldmibhi	r0, {r8, r9, sl, ip, lr}
     5d0:	89980000 	ldmibhi	r8, {}	; <UNPREDICTABLE>
     5d4:	00040000 	andeq	r0, r4, r0
     5d8:	9f5001f3 	svcls	0x005001f3
     5dc:	00008998 	muleq	r0, r8, r9
     5e0:	00008a94 	muleq	r0, r4, sl
     5e4:	94570001 	ldrbls	r0, [r7], #-1
     5e8:	b100008a 	smlabblt	r0, sl, r0, r0
     5ec:	0100008a 	smlabbeq	r0, sl, r0, r0
     5f0:	8ab15000 	bhi	fec545f8 <_stack+0xfebd45f8>
     5f4:	8ab40000 	bhi	fed005fc <_stack+0xfec805fc>
     5f8:	00040000 	andeq	r0, r4, r0
     5fc:	9f5001f3 	svcls	0x005001f3
     600:	00008ab4 			; <UNDEFINED> instruction: 0x00008ab4
     604:	00008abc 			; <UNDEFINED> instruction: 0x00008abc
     608:	bc500001 	mrrclt	0, 0, r0, r0, cr1	; <UNPREDICTABLE>
     60c:	2c00008a 	stccs	0, cr0, [r0], {138}	; 0x8a
     610:	0100008d 	smlabbeq	r0, sp, r0, r0
     614:	8d2c5700 	stchi	7, cr5, [ip, #-0]
     618:	8d450000 	stclhi	0, cr0, [r5, #-0]
     61c:	00010000 	andeq	r0, r1, r0
     620:	008d4550 	addeq	r4, sp, r0, asr r5
     624:	008d4800 	addeq	r4, sp, r0, lsl #16
     628:	f3000400 	vshl.u8	d0, d0, d0
     62c:	489f5001 	ldmmi	pc, {r0, ip, lr}	; <UNPREDICTABLE>
     630:	8600008d 	strhi	r0, [r0], -sp, lsl #1
     634:	0100008e 	smlabbeq	r0, lr, r0, r0
     638:	00005700 	andeq	r5, r0, r0, lsl #14
     63c:	00000000 	andeq	r0, r0, r0
     640:	89200000 	stmdbhi	r0!, {}	; <UNPREDICTABLE>
     644:	89460000 	stmdbhi	r6, {}^	; <UNPREDICTABLE>
     648:	00010000 	andeq	r0, r1, r0
     64c:	00894651 	addeq	r4, r9, r1, asr r6
     650:	008e8600 	addeq	r8, lr, r0, lsl #12
     654:	f3000400 	vshl.u8	d0, d0, d0
     658:	009f5101 	addseq	r5, pc, r1, lsl #2
     65c:	00000000 	andeq	r0, r0, r0
     660:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     664:	80000089 	andhi	r0, r0, r9, lsl #1
     668:	01000089 	smlabbeq	r0, r9, r0, r0
     66c:	89805300 	stmibhi	r0, {r8, r9, ip, lr}
     670:	89900000 	ldmibhi	r0, {}	; <UNPREDICTABLE>
     674:	00030000 	andeq	r0, r3, r0
     678:	b69f7875 			; <UNDEFINED> instruction: 0xb69f7875
     67c:	3a000089 	bcc	8a8 <CPSR_IRQ_INHIBIT+0x828>
     680:	0100008a 	smlabbeq	r0, sl, r0, r0
     684:	8a5e5300 	bhi	179528c <_stack+0x171528c>
     688:	8ab10000 	bhi	fec40690 <_stack+0xfebc0690>
     68c:	00010000 	andeq	r0, r1, r0
     690:	008ab152 	addeq	fp, sl, r2, asr r1
     694:	008ab400 	addeq	fp, sl, r0, lsl #8
     698:	75000300 	strvc	r0, [r0, #-768]	; 0x300
     69c:	8ad89f78 	bhi	ff628484 <_stack+0xff5a8484>
     6a0:	8ae20000 	bhi	ff8806a8 <_stack+0xff8006a8>
     6a4:	00010000 	andeq	r0, r1, r0
     6a8:	008ae253 	addeq	lr, sl, r3, asr r2
     6ac:	008aeb00 	addeq	lr, sl, r0, lsl #22
     6b0:	03000500 	movweq	r0, #1280	; 0x500
     6b4:	000093e4 	andeq	r9, r0, r4, ror #7
     6b8:	00008aeb 	andeq	r8, r0, fp, ror #21
     6bc:	00008af4 	strdeq	r8, [r0], -r4
     6c0:	78750003 	ldmdavc	r5!, {r0, r1}^
     6c4:	008c669f 	umulleq	r6, ip, pc, r6	; <UNPREDICTABLE>
     6c8:	008c7600 	addeq	r7, ip, r0, lsl #12
     6cc:	55000100 	strpl	r0, [r0, #-256]	; 0x100
     6d0:	00008c76 	andeq	r8, r0, r6, ror ip
     6d4:	00008c86 	andeq	r8, r0, r6, lsl #25
     6d8:	78750003 	ldmdavc	r5!, {r0, r1}^
     6dc:	008c869f 	umulleq	r8, ip, pc, r6	; <UNPREDICTABLE>
     6e0:	008ca100 	addeq	sl, ip, r0, lsl #2
     6e4:	53000100 	movwpl	r0, #256	; 0x100
     6e8:	00008ca1 	andeq	r8, r0, r1, lsr #25
     6ec:	00008caa 	andeq	r8, r0, sl, lsr #25
     6f0:	78750003 	ldmdavc	r5!, {r0, r1}^
     6f4:	008cd29f 	umulleq	sp, ip, pc, r2	; <UNPREDICTABLE>
     6f8:	008d4500 	addeq	r4, sp, r0, lsl #10
     6fc:	53000100 	movwpl	r0, #256	; 0x100
     700:	00008d45 	andeq	r8, r0, r5, asr #26
     704:	00008d48 	andeq	r8, r0, r8, asr #26
     708:	78750003 	ldmdavc	r5!, {r0, r1}^
     70c:	008d489f 	umulleq	r4, sp, pc, r8	; <UNPREDICTABLE>
     710:	008d5800 	addeq	r5, sp, r0, lsl #16
     714:	52000100 	andpl	r0, r0, #0, 2
     718:	00008d58 	andeq	r8, r0, r8, asr sp
     71c:	00008d6c 	andeq	r8, r0, ip, ror #26
     720:	6c530001 	mrrcvs	0, 0, r0, r3, cr1
     724:	7800008d 	stmdavc	r0, {r0, r2, r3, r7}
     728:	0100008d 	smlabbeq	r0, sp, r0, r0
     72c:	8d785200 	lfmhi	f5, 2, [r8, #-0]
     730:	8d8a0000 	stchi	0, cr0, [sl]
     734:	00030000 	andeq	r0, r3, r0
     738:	8a9f7875 	bhi	fe7de914 <_stack+0xfe75e914>
     73c:	9200008d 	andls	r0, r0, #141	; 0x8d
     740:	0100008d 	smlabbeq	r0, sp, r0, r0
     744:	8da25300 	stchi	3, cr5, [r2]
     748:	8de20000 	stclhi	0, cr0, [r2]
     74c:	00010000 	andeq	r0, r1, r0
     750:	008e0252 	addeq	r0, lr, r2, asr r2
     754:	008e1600 	addeq	r1, lr, r0, lsl #12
     758:	53000100 	movwpl	r0, #256	; 0x100
     75c:	00008e5e 	andeq	r8, r0, lr, asr lr
     760:	00008e82 	andeq	r8, r0, r2, lsl #29
     764:	82530001 	subshi	r0, r3, #1
     768:	8600008e 	strhi	r0, [r0], -lr, lsl #1
     76c:	0100008e 	smlabbeq	r0, lr, r0, r0
     770:	00005200 	andeq	r5, r0, r0, lsl #4
     774:	00000000 	andeq	r0, r0, r0
     778:	897c0000 	ldmdbhi	ip!, {}^	; <UNPREDICTABLE>
     77c:	89820000 	stmibhi	r2, {}	; <UNPREDICTABLE>
     780:	00010000 	andeq	r0, r1, r0
     784:	00898254 	addeq	r8, r9, r4, asr r2
     788:	00898c00 	addeq	r8, r9, r0, lsl #24
     78c:	75000700 	strvc	r0, [r0, #-1792]	; 0x700
     790:	fc09067c 	stc2	6, cr0, [r9], {124}	; 0x7c
     794:	89bc9f1a 	ldmibhi	ip!, {r1, r3, r4, r8, r9, sl, fp, ip, pc}
     798:	89c80000 	stmibhi	r8, {}^	; <UNPREDICTABLE>
     79c:	00010000 	andeq	r0, r1, r0
     7a0:	0089ce51 	addeq	ip, r9, r1, asr lr
     7a4:	0089d800 	addeq	sp, r9, r0, lsl #16
     7a8:	51000100 	mrspl	r0, (UNDEF: 16)
     7ac:	000089f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
     7b0:	00008a16 	andeq	r8, r0, r6, lsl sl
     7b4:	16500001 	ldrbne	r0, [r0], -r1
     7b8:	3000008a 	andcc	r0, r0, sl, lsl #1
     7bc:	0700008a 	streq	r0, [r0, -sl, lsl #1]
     7c0:	06047300 	streq	r7, [r4], -r0, lsl #6
     7c4:	9f1afc09 	svcls	0x001afc09
     7c8:	00008a64 	andeq	r8, r0, r4, ror #20
     7cc:	00008a72 	andeq	r8, r0, r2, ror sl
     7d0:	78530001 	ldmdavc	r3, {r0}^
     7d4:	8a00008a 	bhi	a04 <CPSR_IRQ_INHIBIT+0x984>
     7d8:	0100008a 	smlabbeq	r0, sl, r0, r0
     7dc:	8a8a5300 	bhi	fe2953e4 <_stack+0xfe2153e4>
     7e0:	8a960000 	bhi	fe5807e8 <_stack+0xfe5007e8>
     7e4:	00070000 	andeq	r0, r7, r0
     7e8:	09060472 	stmdbeq	r6, {r1, r4, r5, r6, sl}
     7ec:	d89f1afc 	ldmle	pc, {r2, r3, r4, r5, r6, r7, r9, fp, ip}	; <UNPREDICTABLE>
     7f0:	e000008a 	and	r0, r0, sl, lsl #1
     7f4:	0100008a 	smlabbeq	r0, sl, r0, r0
     7f8:	8ae05000 	bhi	ff814800 <_stack+0xff794800>
     7fc:	8ae20000 	bhi	ff880804 <_stack+0xff800804>
     800:	00070000 	andeq	r0, r7, r0
     804:	09060473 	stmdbeq	r6, {r0, r1, r4, r5, r6, sl}
     808:	e29f1afc 	adds	r1, pc, #252, 20	; 0xfc000
     80c:	e800008a 	stmda	r0, {r1, r3, r7}
     810:	0d00008a 	stceq	0, cr0, [r0, #-552]	; 0xfffffdd8
     814:	93e40300 	mvnls	r0, #0, 6
     818:	23060000 	movwcs	r0, #24576	; 0x6000
     81c:	fc090604 	stc2	6, cr0, [r9], {4}
     820:	8c869f1a 	stchi	15, cr9, [r6], {26}
     824:	8c880000 	stchi	0, cr0, [r8], {0}
     828:	00010000 	andeq	r0, r1, r0
     82c:	008c8851 	addeq	r8, ip, r1, asr r8
     830:	008c9e00 	addeq	r9, ip, r0, lsl #28
     834:	73000700 	movwvc	r0, #1792	; 0x700
     838:	fc090604 	stc2	6, cr0, [r9], {4}
     83c:	8cd29f1a 	ldclhi	15, cr9, [r2], {26}
     840:	8d140000 	ldchi	0, cr0, [r4, #-0]
     844:	00010000 	andeq	r0, r1, r0
     848:	008d1450 	addeq	r1, sp, r0, asr r4
     84c:	008d1600 	addeq	r1, sp, r0, lsl #12
     850:	73000700 	movwvc	r0, #1792	; 0x700
     854:	fc090604 	stc2	6, cr0, [r9], {4}
     858:	8d209f1a 	stchi	15, cr9, [r0, #-104]!	; 0xffffff98
     85c:	8d240000 	stchi	0, cr0, [r4, #-0]
     860:	00010000 	andeq	r0, r1, r0
     864:	008d2450 	addeq	r2, sp, r0, asr r4
     868:	008d2e00 	addeq	r2, sp, r0, lsl #28
     86c:	73000700 	movwvc	r0, #1792	; 0x700
     870:	fc090604 	stc2	6, cr0, [r9], {4}
     874:	8d6c9f1a 	stclhi	15, cr9, [ip, #-104]!	; 0xffffff98
     878:	8d6e0000 	stclhi	0, cr0, [lr, #-0]
     87c:	00010000 	andeq	r0, r1, r0
     880:	008d6e53 	addeq	r6, sp, r3, asr lr
     884:	008d7800 	addeq	r7, sp, r0, lsl #16
     888:	72000700 	andvc	r0, r0, #0, 14
     88c:	fc090604 	stc2	6, cr0, [r9], {4}
     890:	8d789f1a 	ldclhi	15, cr9, [r8, #-104]!	; 0xffffff98
     894:	8d800000 	stchi	0, cr0, [r0]
     898:	00070000 	andeq	r0, r7, r0
     89c:	09067c75 	stmdbeq	r6, {r0, r2, r4, r5, r6, sl, fp, ip, sp, lr}
     8a0:	8a9f1afc 	bhi	fe7c7498 <_stack+0xfe747498>
     8a4:	9200008d 	andls	r0, r0, #141	; 0x8d
     8a8:	0100008d 	smlabbeq	r0, sp, r0, r0
     8ac:	8e025000 	cdphi	0, 0, cr5, cr2, cr0, {0}
     8b0:	8e040000 	cdphi	0, 0, cr0, cr4, cr0, {0}
     8b4:	00010000 	andeq	r0, r1, r0
     8b8:	008e0450 	addeq	r0, lr, r0, asr r4
     8bc:	008e1400 	addeq	r1, lr, r0, lsl #8
     8c0:	73000700 	movwvc	r0, #1792	; 0x700
     8c4:	fc090604 	stc2	6, cr0, [r9], {4}
     8c8:	8e5e9f1a 	mrchi	15, 2, r9, cr14, cr10, {0}
     8cc:	8e820000 	cdphi	0, 8, cr0, cr2, cr0, {0}
     8d0:	00010000 	andeq	r0, r1, r0
     8d4:	00000050 	andeq	r0, r0, r0, asr r0
     8d8:	00000000 	andeq	r0, r0, r0
     8dc:	00895a00 	addeq	r5, r9, r0, lsl #20
     8e0:	00896e00 	addeq	r6, r9, r0, lsl #28
     8e4:	5c000100 	stfpls	f0, [r0], {-0}
     8e8:	0000896e 	andeq	r8, r0, lr, ror #18
     8ec:	0000897c 	andeq	r8, r0, ip, ror r9
     8f0:	00740005 	rsbseq	r0, r4, r5
     8f4:	7c9f2533 	cfldr32vc	mvfx2, [pc], {51}	; 0x33
     8f8:	90000089 	andls	r0, r0, r9, lsl #1
     8fc:	39000089 	stmdbcc	r0, {r0, r3, r7}
     900:	01f34000 	mvnseq	r4, r0
     904:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     908:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     90c:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     910:	0b235101 	bleq	8d4d1c <_stack+0x854d1c>
     914:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     918:	0000160c 	andeq	r1, r0, ip, lsl #12
     91c:	01282b80 	smlawbeq	r8, r0, fp, r2
     920:	f3131600 	vmax.u16	d1, d3, d0
     924:	0b235101 	bleq	8d4d30 <_stack+0x854d30>
     928:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     92c:	0000160c 	andeq	r1, r0, ip, lsl #12
     930:	01282c80 	smlawbeq	r8, r0, ip, r2
     934:	33131600 	tstcc	r3, #0, 12
     938:	89a89f25 	stmibhi	r8!, {r0, r2, r5, r8, r9, sl, fp, ip, pc}
     93c:	8a4a0000 	bhi	1280944 <_stack+0x1200944>
     940:	00010000 	andeq	r0, r1, r0
     944:	008a505c 	addeq	r5, sl, ip, asr r0
     948:	008a5c00 	addeq	r5, sl, r0, lsl #24
     94c:	5c000100 	stfpls	f0, [r0], {-0}
     950:	00008a5c 	andeq	r8, r0, ip, asr sl
     954:	00008ab4 			; <UNDEFINED> instruction: 0x00008ab4
     958:	d8590001 	ldmdale	r9, {r0}^
     95c:	eb00008a 	bl	b8c <CPSR_IRQ_INHIBIT+0xb0c>
     960:	0100008a 	smlabbeq	r0, sl, r0, r0
     964:	8c865c00 	stchi	12, cr5, [r6], {0}
     968:	8ca10000 	stchi	0, cr0, [r1]
     96c:	00010000 	andeq	r0, r1, r0
     970:	008cd25c 	addeq	sp, ip, ip, asr r2
     974:	008d4500 	addeq	r4, sp, r0, lsl #10
     978:	5c000100 	stfpls	f0, [r0], {-0}
     97c:	00008d48 	andeq	r8, r0, r8, asr #26
     980:	00008d4c 	andeq	r8, r0, ip, asr #26
     984:	4c590001 	mrrcmi	0, 0, r0, r9, cr1
     988:	4e00008d 	cdpmi	0, 0, cr0, cr0, cr13, {4}
     98c:	0300008d 	movweq	r0, #141	; 0x8d
     990:	9f7f7900 	svcls	0x007f7900
     994:	00008d4e 	andeq	r8, r0, lr, asr #26
     998:	00008d58 	andeq	r8, r0, r8, asr sp
     99c:	58590001 	ldmdapl	r9, {r0}^
     9a0:	6600008d 	strvs	r0, [r0], -sp, lsl #1
     9a4:	0100008d 	smlabbeq	r0, sp, r0, r0
     9a8:	8d665c00 	stclhi	12, cr5, [r6, #-0]
     9ac:	8d6c0000 	stclhi	0, cr0, [ip, #-0]
     9b0:	00050000 	andeq	r0, r5, r0
     9b4:	25330074 	ldrcs	r0, [r3, #-116]!	; 0x74
     9b8:	008d6c9f 	umulleq	r6, sp, pc, ip	; <UNPREDICTABLE>
     9bc:	008d8a00 	addeq	r8, sp, r0, lsl #20
     9c0:	59000100 	stmdbpl	r0, {r8}
     9c4:	00008d8a 	andeq	r8, r0, sl, lsl #27
     9c8:	00008d92 	muleq	r0, r2, sp
     9cc:	a25c0001 	subsge	r0, ip, #1
     9d0:	d600008d 	strle	r0, [r0], -sp, lsl #1
     9d4:	0100008d 	smlabbeq	r0, sp, r0, r0
     9d8:	8dd65900 	ldclhi	9, cr5, [r6]
     9dc:	8de20000 	stclhi	0, cr0, [r2]
     9e0:	00010000 	andeq	r0, r1, r0
     9e4:	008e025c 	addeq	r0, lr, ip, asr r2
     9e8:	008e1600 	addeq	r1, lr, r0, lsl #12
     9ec:	5c000100 	stfpls	f0, [r0], {-0}
     9f0:	00008e5e 	andeq	r8, r0, lr, asr lr
     9f4:	00008e82 	andeq	r8, r0, r2, lsl #29
     9f8:	825c0001 	subshi	r0, ip, #1
     9fc:	8600008e 	strhi	r0, [r0], -lr, lsl #1
     a00:	0100008e 	smlabbeq	r0, lr, r0, r0
     a04:	00005900 	andeq	r5, r0, r0, lsl #18
     a08:	00000000 	andeq	r0, r0, r0
     a0c:	89b40000 	ldmibhi	r4!, {}	; <UNPREDICTABLE>
     a10:	89dc0000 	ldmibhi	ip, {}^	; <UNPREDICTABLE>
     a14:	00010000 	andeq	r0, r1, r0
     a18:	008a5855 	addeq	r5, sl, r5, asr r8
     a1c:	008a5c00 	addeq	r5, sl, r0, lsl #24
     a20:	58000100 	stmdapl	r0, {r8}
     a24:	00008a5c 	andeq	r8, r0, ip, asr sl
     a28:	00008a80 	andeq	r8, r0, r0, lsl #21
     a2c:	86550001 	ldrbhi	r0, [r5], -r1
     a30:	9400008c 	strls	r0, [r0], #-140	; 0x8c
     a34:	0100008c 	smlabbeq	r0, ip, r0, r0
     a38:	8d485500 	cfstr64hi	mvdx5, [r8, #-0]
     a3c:	8d580000 	ldclhi	0, cr0, [r8, #-0]
     a40:	00010000 	andeq	r0, r1, r0
     a44:	008d6c55 	addeq	r6, sp, r5, asr ip
     a48:	008d7000 	addeq	r7, sp, r0
     a4c:	55000100 	strpl	r0, [r0, #-256]	; 0x100
     a50:	00008da2 	andeq	r8, r0, r2, lsr #27
     a54:	00008de2 	andeq	r8, r0, r2, ror #27
     a58:	82550001 	subshi	r0, r5, #1
     a5c:	8600008e 	strhi	r0, [r0], -lr, lsl #1
     a60:	0100008e 	smlabbeq	r0, lr, r0, r0
     a64:	00005500 	andeq	r5, r0, r0, lsl #10
     a68:	00000000 	andeq	r0, r0, r0
     a6c:	8a8a0000 	bhi	fe280a74 <_stack+0xfe200a74>
     a70:	8ab10000 	bhi	fec40a78 <_stack+0xfebc0a78>
     a74:	00010000 	andeq	r0, r1, r0
     a78:	008ab153 	addeq	fp, sl, r3, asr r1
     a7c:	008ab400 	addeq	fp, sl, r0, lsl #8
     a80:	40003c00 	andmi	r3, r0, r0, lsl #24
     a84:	235101f3 	cmpcs	r1, #-1073741764	; 0xc000003c
     a88:	1af8090b 	bne	ffe02ebc <_stack+0xffd82ebc>
     a8c:	235101f3 	cmpcs	r1, #-1073741764	; 0xc000003c
     a90:	5101f30b 	tstpl	r1, fp, lsl #6
     a94:	4b400b23 	blmi	1003728 <_stack+0xf83728>
     a98:	160c2224 	strne	r2, [ip], -r4, lsr #4
     a9c:	2b800000 	blcs	fe000aa4 <_stack+0xfdf80aa4>
     aa0:	16000128 	strne	r0, [r0], -r8, lsr #2
     aa4:	5101f313 	tstpl	r1, r3, lsl r3
     aa8:	4b400b23 	blmi	100373c <_stack+0xf8373c>
     aac:	160c2224 	strne	r2, [ip], -r4, lsr #4
     ab0:	2c800000 	stccs	0, cr0, [r0], {0}
     ab4:	16000128 	strne	r0, [r0], -r8, lsr #2
     ab8:	22007513 	andcs	r7, r0, #79691776	; 0x4c00000
     abc:	229f1c38 	addscs	r1, pc, #56, 24	; 0x3800
     ac0:	4800008d 	stmdami	r0, {r0, r2, r3, r7}
     ac4:	0100008d 	smlabbeq	r0, sp, r0, r0
     ac8:	00005600 	andeq	r5, r0, r0, lsl #12
     acc:	00000000 	andeq	r0, r0, r0
     ad0:	89bc0000 	ldmibhi	ip!, {}	; <UNPREDICTABLE>
     ad4:	89c20000 	stmibhi	r2, {}^	; <UNPREDICTABLE>
     ad8:	00010000 	andeq	r0, r1, r0
     adc:	0089d052 	addeq	sp, r9, r2, asr r0
     ae0:	0089d800 	addeq	sp, r9, r0, lsl #16
     ae4:	52000100 	andpl	r0, r0, #0, 2
     ae8:	000089fa 	strdeq	r8, [r0], -sl
     aec:	00008a1c 	andeq	r8, r0, ip, lsl sl
     af0:	1c510001 	mrrcne	0, 0, r0, r1, cr1
     af4:	3000008a 	andcc	r0, r0, sl, lsl #1
     af8:	0a00008a 	beq	d28 <CPSR_IRQ_INHIBIT+0xca8>
     afc:	06047300 	streq	r7, [r4], -r0, lsl #6
     b00:	741afc09 	ldrvc	pc, [sl], #-3081	; 0xc09
     b04:	649f1c00 	ldrvs	r1, [pc], #3072	; b0c <CPSR_IRQ_INHIBIT+0xa8c>
     b08:	7200008a 	andvc	r0, r0, #138	; 0x8a
     b0c:	0100008a 	smlabbeq	r0, sl, r0, r0
     b10:	8a7a5100 	bhi	1e94f18 <_stack+0x1e14f18>
     b14:	8ab10000 	bhi	fec40b1c <_stack+0xfebc0b1c>
     b18:	00010000 	andeq	r0, r1, r0
     b1c:	008ad851 	addeq	sp, sl, r1, asr r8
     b20:	008aeb00 	addeq	lr, sl, r0, lsl #22
     b24:	51000100 	mrspl	r0, (UNDEF: 16)
     b28:	00008afc 	strdeq	r8, [r0], -ip
     b2c:	00008b04 	andeq	r8, r0, r4, lsl #22
     b30:	00790006 	rsbseq	r0, r9, r6
     b34:	9f1c0074 	svcls	0x001c0074
     b38:	00008b04 	andeq	r8, r0, r4, lsl #22
     b3c:	00008b0a 	andeq	r8, r0, sl, lsl #22
     b40:	0a530001 	beq	14c0b4c <_stack+0x1440b4c>
     b44:	5600008b 	strpl	r0, [r0], -fp, lsl #1
     b48:	0600008c 	streq	r0, [r0], -ip, lsl #1
     b4c:	74007900 	strvc	r7, [r0], #-2304	; 0x900
     b50:	569f1c00 	ldrpl	r1, [pc], r0, lsl #24
     b54:	6300008c 	movwvs	r0, #140	; 0x8c
     b58:	0100008c 	smlabbeq	r0, ip, r0, r0
     b5c:	8c665300 	stclhi	3, cr5, [r6], #-0
     b60:	8c6c0000 	stclhi	0, cr0, [ip], #-0
     b64:	00010000 	andeq	r0, r1, r0
     b68:	008c8653 	addeq	r8, ip, r3, asr r6
     b6c:	008c8a00 	addeq	r8, ip, r0, lsl #20
     b70:	52000100 	andpl	r0, r0, #0, 2
     b74:	00008c8a 	andeq	r8, r0, sl, lsl #25
     b78:	00008c8c 	andeq	r8, r0, ip, lsl #25
     b7c:	0473000a 	ldrbteq	r0, [r3], #-10
     b80:	1afc0906 	bne	fff02fa0 <_stack+0xffe82fa0>
     b84:	9f1c0074 	svcls	0x001c0074
     b88:	00008c8c 	andeq	r8, r0, ip, lsl #25
     b8c:	00008c9e 	muleq	r0, lr, ip
     b90:	0473003e 	ldrbteq	r0, [r3], #-62	; 0x3e
     b94:	1afc0906 	bne	fff02fb4 <_stack+0xffe82fb4>
     b98:	5101f340 	tstpl	r1, r0, asr #6
     b9c:	f8090b23 			; <UNDEFINED> instruction: 0xf8090b23
     ba0:	5101f31a 	tstpl	r1, sl, lsl r3
     ba4:	01f30b23 	mvnseq	r0, r3, lsr #22
     ba8:	400b2351 	andmi	r2, fp, r1, asr r3
     bac:	0c22244b 	cfstrseq	mvf2, [r2], #-300	; 0xfffffed4
     bb0:	80000016 	andhi	r0, r0, r6, lsl r0
     bb4:	0001282b 	andeq	r2, r1, fp, lsr #16
     bb8:	01f31316 	mvnseq	r1, r6, lsl r3
     bbc:	400b2351 	andmi	r2, fp, r1, asr r3
     bc0:	0c22244b 	cfstrseq	mvf2, [r2], #-300	; 0xfffffed4
     bc4:	80000016 	andhi	r0, r0, r6, lsl r0
     bc8:	0001282c 	andeq	r2, r1, ip, lsr #16
     bcc:	9f1c1316 	svcls	0x001c1316
     bd0:	00008cd2 	ldrdeq	r8, [r0], -r2
     bd4:	00008ce0 	andeq	r8, r0, r0, ror #25
     bd8:	e0510001 	subs	r0, r1, r1
     bdc:	1400008c 	strne	r0, [r0], #-140	; 0x8c
     be0:	0600008d 	streq	r0, [r0], -sp, lsl #1
     be4:	74007000 	strvc	r7, [r0], #-0
     be8:	149f1c00 	ldrne	r1, [pc], #3072	; bf0 <CPSR_IRQ_INHIBIT+0xb70>
     bec:	1600008d 	strne	r0, [r0], -sp, lsl #1
     bf0:	0a00008d 	beq	e2c <CPSR_IRQ_INHIBIT+0xdac>
     bf4:	06047300 	streq	r7, [r4], -r0, lsl #6
     bf8:	741afc09 	ldrvc	pc, [sl], #-3081	; 0xc09
     bfc:	209f1c00 	addscs	r1, pc, r0, lsl #24
     c00:	4500008d 	strmi	r0, [r0, #-141]	; 0x8d
     c04:	0100008d 	smlabbeq	r0, sp, r0, r0
     c08:	8d6c5100 	stfhie	f5, [ip, #-0]
     c0c:	8d740000 	ldclhi	0, cr0, [r4, #-0]
     c10:	00010000 	andeq	r0, r1, r0
     c14:	008d7451 	addeq	r7, sp, r1, asr r4
     c18:	008d7800 	addeq	r7, sp, r0, lsl #16
     c1c:	72000a00 	andvc	r0, r0, #0, 20
     c20:	fc090604 	stc2	6, cr0, [r9], {4}
     c24:	1c00741a 	cfstrsne	mvf7, [r0], {26}
     c28:	008d789f 	umulleq	r7, sp, pc, r8	; <UNPREDICTABLE>
     c2c:	008d7a00 	addeq	r7, sp, r0, lsl #20
     c30:	75000a00 	strvc	r0, [r0, #-2560]	; 0xa00
     c34:	fc09067c 	stc2	6, cr0, [r9], {124}	; 0x7c
     c38:	1c00741a 	cfstrsne	mvf7, [r0], {26}
     c3c:	008d7a9f 	umulleq	r7, sp, pc, sl	; <UNPREDICTABLE>
     c40:	008d8000 	addeq	r8, sp, r0
     c44:	75003e00 	strvc	r3, [r0, #-3584]	; 0xe00
     c48:	fc09067c 	stc2	6, cr0, [r9], {124}	; 0x7c
     c4c:	01f3401a 	mvnseq	r4, sl, lsl r0
     c50:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     c54:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     c58:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     c5c:	0b235101 	bleq	8d5068 <_stack+0x855068>
     c60:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     c64:	0000160c 	andeq	r1, r0, ip, lsl #12
     c68:	01282b80 	smlawbeq	r8, r0, fp, r2
     c6c:	f3131600 	vmax.u16	d1, d3, d0
     c70:	0b235101 	bleq	8d507c <_stack+0x85507c>
     c74:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     c78:	0000160c 	andeq	r1, r0, ip, lsl #12
     c7c:	01282c80 	smlawbeq	r8, r0, ip, r2
     c80:	1c131600 	ldcne	6, cr1, [r3], {-0}
     c84:	008d8a9f 	umulleq	r8, sp, pc, sl	; <UNPREDICTABLE>
     c88:	008d8c00 	addeq	r8, sp, r0, lsl #24
     c8c:	51000100 	mrspl	r0, (UNDEF: 16)
     c90:	00008d8c 	andeq	r8, r0, ip, lsl #27
     c94:	00008d92 	muleq	r0, r2, sp
     c98:	00700006 	rsbseq	r0, r0, r6
     c9c:	9f1c0074 	svcls	0x001c0074
     ca0:	00008d92 	muleq	r0, r2, sp
     ca4:	00008da2 	andeq	r8, r0, r2, lsr #27
     ca8:	00790006 	rsbseq	r0, r9, r6
     cac:	9f1c0074 	svcls	0x001c0074
     cb0:	00008df6 	strdeq	r8, [r0], -r6
     cb4:	00008e02 	andeq	r8, r0, r2, lsl #28
     cb8:	00790006 	rsbseq	r0, r9, r6
     cbc:	9f1c0074 	svcls	0x001c0074
     cc0:	00008e02 	andeq	r8, r0, r2, lsl #28
     cc4:	00008e04 	andeq	r8, r0, r4, lsl #28
     cc8:	00700006 	rsbseq	r0, r0, r6
     ccc:	9f1c0074 	svcls	0x001c0074
     cd0:	00008e04 	andeq	r8, r0, r4, lsl #28
     cd4:	00008e14 	andeq	r8, r0, r4, lsl lr
     cd8:	0473000a 	ldrbteq	r0, [r3], #-10
     cdc:	1afc0906 	bne	fff030fc <_stack+0xffe830fc>
     ce0:	9f1c0074 	svcls	0x001c0074
     ce4:	00008e34 	andeq	r8, r0, r4, lsr lr
     ce8:	00008e5e 	andeq	r8, r0, lr, asr lr
     cec:	00790006 	rsbseq	r0, r9, r6
     cf0:	9f1c0074 	svcls	0x001c0074
     cf4:	00008e5e 	andeq	r8, r0, lr, asr lr
     cf8:	00008e82 	andeq	r8, r0, r2, lsl #29
     cfc:	00700006 	rsbseq	r0, r0, r6
     d00:	9f1c0074 	svcls	0x001c0074
	...
     d0c:	00008a16 	andeq	r8, r0, r6, lsl sl
     d10:	00008a22 	andeq	r8, r0, r2, lsr #20
     d14:	22500001 	subscs	r0, r0, #1
     d18:	3000008a 	andcc	r0, r0, sl, lsl #1
     d1c:	0900008a 	stmdbeq	r0, {r1, r3, r7}
     d20:	06047300 	streq	r7, [r4], -r0, lsl #6
     d24:	331afc09 	tstcc	sl, #2304	; 0x900
     d28:	8cf09f25 	ldclhi	15, cr9, [r0], #148	; 0x94
     d2c:	8d020000 	stchi	0, cr0, [r2, #-0]
     d30:	00010000 	andeq	r0, r1, r0
     d34:	008e0251 	addeq	r0, lr, r1, asr r2
     d38:	008e0a00 	addeq	r0, lr, r0, lsl #20
     d3c:	51000100 	mrspl	r0, (UNDEF: 16)
	...
     d48:	00008a3e 	andeq	r8, r0, lr, lsr sl
     d4c:	00008a4c 	andeq	r8, r0, ip, asr #20
     d50:	50500001 	subspl	r0, r0, r1
     d54:	8c00008a 	stchi	0, cr0, [r0], {138}	; 0x8a
     d58:	0100008a 	smlabbeq	r0, sl, r0, r0
     d5c:	8af45000 	bhi	ffd14d64 <_stack+0xffc94d64>
     d60:	8b1c0000 	blhi	700d68 <_stack+0x680d68>
     d64:	00010000 	andeq	r0, r1, r0
     d68:	008d4850 	addeq	r4, sp, r0, asr r8
     d6c:	008d5800 	addeq	r5, sp, r0, lsl #16
     d70:	50000100 	andpl	r0, r0, r0, lsl #2
     d74:	00008d6c 	andeq	r8, r0, ip, ror #26
     d78:	00008d76 	andeq	r8, r0, r6, ror sp
     d7c:	a2500001 	subsge	r0, r0, #1
     d80:	d800008d 	stmdale	r0, {r0, r2, r3, r7}
     d84:	0100008d 	smlabbeq	r0, sp, r0, r0
     d88:	8ddc5000 	ldclhi	0, cr5, [ip]
     d8c:	8de20000 	stclhi	0, cr0, [r2]
     d90:	00010000 	andeq	r0, r1, r0
     d94:	008e8250 	addeq	r8, lr, r0, asr r2
     d98:	008e8600 	addeq	r8, lr, r0, lsl #12
     d9c:	50000100 	andpl	r0, r0, r0, lsl #2
	...
     da8:	00008a54 	andeq	r8, r0, r4, asr sl
     dac:	00008a84 	andeq	r8, r0, r4, lsl #21
     db0:	485c0001 	ldmdami	ip, {r0}^
     db4:	5800008d 	stmdapl	r0, {r0, r2, r3, r7}
     db8:	0100008d 	smlabbeq	r0, sp, r0, r0
     dbc:	8d6c5c00 	stclhi	12, cr5, [ip, #-0]
     dc0:	8d870000 	stchi	0, cr0, [r7]
     dc4:	00010000 	andeq	r0, r1, r0
     dc8:	008da25c 	addeq	sl, sp, ip, asr r2
     dcc:	008dd200 	addeq	sp, sp, r0, lsl #4
     dd0:	5c000100 	stfpls	f0, [r0], {-0}
     dd4:	00008e82 	andeq	r8, r0, r2, lsl #29
     dd8:	00008e86 	andeq	r8, r0, r6, lsl #29
     ddc:	005c0001 	subseq	r0, ip, r1
     de0:	00000000 	andeq	r0, r0, r0
     de4:	7e000000 	cdpvc	0, 0, cr0, cr0, cr0, {0}
     de8:	8f000089 	svchi	0x00000089
     dec:	01000089 	smlabbeq	r0, r9, r0, r0
     df0:	8a285100 	bhi	a151f8 <_stack+0x9951f8>
     df4:	8a360000 	bhi	d80dfc <_stack+0xd00dfc>
     df8:	00010000 	andeq	r0, r1, r0
     dfc:	008a8a50 	addeq	r8, sl, r0, asr sl
     e00:	008ab400 	addeq	fp, sl, r0, lsl #8
     e04:	58000100 	stmdapl	r0, {r8}
     e08:	00008c8c 	andeq	r8, r0, ip, lsl #25
     e0c:	00008caa 	andeq	r8, r0, sl, lsr #25
     e10:	fe540001 	cdp2	0, 5, cr0, cr4, cr1, {0}
     e14:	2000008c 	andcs	r0, r0, ip, lsl #1
     e18:	0100008d 	smlabbeq	r0, sp, r0, r0
     e1c:	8d785200 	lfmhi	f5, 2, [r8, #-0]
     e20:	8d870000 	stchi	0, cr0, [r7]
     e24:	00010000 	andeq	r0, r1, r0
     e28:	008e0251 	addeq	r0, lr, r1, asr r2
     e2c:	008e1600 	addeq	r1, lr, r0, lsl #12
     e30:	52000100 	andpl	r0, r0, #0, 2
	...
     e3c:	0000897c 	andeq	r8, r0, ip, ror r9
     e40:	0000898f 	andeq	r8, r0, pc, lsl #19
     e44:	20520001 	subscs	r0, r2, r1
     e48:	3600008a 	strcc	r0, [r0], -sl, lsl #1
     e4c:	0100008a 	smlabbeq	r0, sl, r0, r0
     e50:	8a8a5500 	bhi	fe296258 <_stack+0xfe216258>
     e54:	8ab10000 	bhi	fec40e5c <_stack+0xfebc0e5c>
     e58:	00010000 	andeq	r0, r1, r0
     e5c:	008c8a5c 	addeq	r8, ip, ip, asr sl
     e60:	008ca100 	addeq	sl, ip, r0, lsl #2
     e64:	52000100 	andpl	r0, r0, #0, 2
     e68:	00008cf4 	strdeq	r8, [r0], -r4
     e6c:	00008d14 	andeq	r8, r0, r4, lsl sp
     e70:	14550001 	ldrbne	r0, [r5], #-1
     e74:	2000008d 	andcs	r0, r0, sp, lsl #1
     e78:	0100008d 	smlabbeq	r0, sp, r0, r0
     e7c:	8d785000 	ldclhi	0, cr5, [r8, #-0]
     e80:	8d870000 	stchi	0, cr0, [r7]
     e84:	00010000 	andeq	r0, r1, r0
     e88:	008e0252 	addeq	r0, lr, r2, asr r2
     e8c:	008e0600 	addeq	r0, lr, r0, lsl #12
     e90:	55000100 	strpl	r0, [r0, #-256]	; 0x100
	...
     e9c:	00008966 	andeq	r8, r0, r6, ror #18
     ea0:	0000896e 	andeq	r8, r0, lr, ror #18
     ea4:	58520001 	ldmdapl	r2, {r0}^
     ea8:	8800008a 	stmdahi	r0, {r1, r3, r7}
     eac:	0100008a 	smlabbeq	r0, sl, r0, r0
     eb0:	8d485800 	stclhi	8, cr5, [r8, #-0]
     eb4:	8d580000 	ldclhi	0, cr0, [r8, #-0]
     eb8:	00010000 	andeq	r0, r1, r0
     ebc:	008d5858 	addeq	r5, sp, r8, asr r8
     ec0:	008d6c00 	addeq	r6, sp, r0, lsl #24
     ec4:	52000100 	andpl	r0, r0, #0, 2
     ec8:	00008d6c 	andeq	r8, r0, ip, ror #26
     ecc:	00008d8a 	andeq	r8, r0, sl, lsl #27
     ed0:	a2580001 	subsge	r0, r8, #1
     ed4:	aa00008d 	bge	1110 <CPSR_IRQ_INHIBIT+0x1090>
     ed8:	0100008d 	smlabbeq	r0, sp, r0, r0
     edc:	8daa5300 	stchi	3, cr5, [sl]
     ee0:	8db60000 	ldchi	0, cr0, [r6]
     ee4:	00010000 	andeq	r0, r1, r0
     ee8:	008db658 	addeq	fp, sp, r8, asr r6
     eec:	008dba00 	addeq	fp, sp, r0, lsl #20
     ef0:	53000100 	movwpl	r0, #256	; 0x100
     ef4:	00008dba 			; <UNDEFINED> instruction: 0x00008dba
     ef8:	00008dc0 	andeq	r8, r0, r0, asr #27
     efc:	78780003 	ldmdavc	r8!, {r0, r1}^
     f00:	008e829f 	umulleq	r8, lr, pc, r2	; <UNPREDICTABLE>
     f04:	008e8400 	addeq	r8, lr, r0, lsl #8
     f08:	53000100 	movwpl	r0, #256	; 0x100
	...
     f14:	0000893a 	andeq	r8, r0, sl, lsr r9
     f18:	0000897c 	andeq	r8, r0, ip, ror r9
     f1c:	7c540001 	mrrcvc	0, 0, r0, r4, cr1
     f20:	98000089 	stmdals	r0, {r0, r3, r7}
     f24:	37000089 	strcc	r0, [r0, -r9, lsl #1]
     f28:	01f34000 	mvnseq	r4, r0
     f2c:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     f30:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     f34:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     f38:	0b235101 	bleq	8d5344 <_stack+0x855344>
     f3c:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     f40:	0000160c 	andeq	r1, r0, ip, lsl #12
     f44:	01282b80 	smlawbeq	r8, r0, fp, r2
     f48:	f3131600 	vmax.u16	d1, d3, d0
     f4c:	0b235101 	bleq	8d5358 <_stack+0x855358>
     f50:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     f54:	0000160c 	andeq	r1, r0, ip, lsl #12
     f58:	01282c80 	smlawbeq	r8, r0, ip, r2
     f5c:	9f131600 	svcls	0x00131600
     f60:	00008998 	muleq	r0, r8, r9
     f64:	00008a90 	muleq	r0, r0, sl
     f68:	90540001 	subsls	r0, r4, r1
     f6c:	b400008a 	strlt	r0, [r0], #-138	; 0x8a
     f70:	3700008a 	strcc	r0, [r0, -sl, lsl #1]
     f74:	01f34000 	mvnseq	r4, r0
     f78:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     f7c:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     f80:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     f84:	0b235101 	bleq	8d5390 <_stack+0x855390>
     f88:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     f8c:	0000160c 	andeq	r1, r0, ip, lsl #12
     f90:	01282b80 	smlawbeq	r8, r0, fp, r2
     f94:	f3131600 	vmax.u16	d1, d3, d0
     f98:	0b235101 	bleq	8d53a4 <_stack+0x8553a4>
     f9c:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     fa0:	0000160c 	andeq	r1, r0, ip, lsl #12
     fa4:	01282c80 	smlawbeq	r8, r0, ip, r2
     fa8:	9f131600 	svcls	0x00131600
     fac:	00008ab4 			; <UNDEFINED> instruction: 0x00008ab4
     fb0:	00008c72 	andeq	r8, r0, r2, ror ip
     fb4:	72540001 	subsvc	r0, r4, #1
     fb8:	8600008c 	strhi	r0, [r0], -ip, lsl #1
     fbc:	3700008c 	strcc	r0, [r0, -ip, lsl #1]
     fc0:	01f34000 	mvnseq	r4, r0
     fc4:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     fc8:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     fcc:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     fd0:	0b235101 	bleq	8d53dc <_stack+0x8553dc>
     fd4:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     fd8:	0000160c 	andeq	r1, r0, ip, lsl #12
     fdc:	01282b80 	smlawbeq	r8, r0, fp, r2
     fe0:	f3131600 	vmax.u16	d1, d3, d0
     fe4:	0b235101 	bleq	8d53f0 <_stack+0x8553f0>
     fe8:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     fec:	0000160c 	andeq	r1, r0, ip, lsl #12
     ff0:	01282c80 	smlawbeq	r8, r0, ip, r2
     ff4:	9f131600 	svcls	0x00131600
     ff8:	00008c86 	andeq	r8, r0, r6, lsl #25
     ffc:	00008c8c 	andeq	r8, r0, ip, lsl #25
    1000:	8c540001 	mrrchi	0, 0, r0, r4, cr1
    1004:	aa00008c 	bge	123c <CPSR_IRQ_INHIBIT+0x11bc>
    1008:	3700008c 	strcc	r0, [r0, -ip, lsl #1]
    100c:	01f34000 	mvnseq	r4, r0
    1010:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
    1014:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
    1018:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
    101c:	0b235101 	bleq	8d5428 <_stack+0x855428>
    1020:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
    1024:	0000160c 	andeq	r1, r0, ip, lsl #12
    1028:	01282b80 	smlawbeq	r8, r0, fp, r2
    102c:	f3131600 	vmax.u16	d1, d3, d0
    1030:	0b235101 	bleq	8d543c <_stack+0x85543c>
    1034:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
    1038:	0000160c 	andeq	r1, r0, ip, lsl #12
    103c:	01282c80 	smlawbeq	r8, r0, ip, r2
    1040:	9f131600 	svcls	0x00131600
    1044:	00008caa 	andeq	r8, r0, sl, lsr #25
    1048:	00008d28 	andeq	r8, r0, r8, lsr #26
    104c:	28540001 	ldmdacs	r4, {r0}^
    1050:	4800008d 	stmdami	r0, {r0, r2, r3, r7}
    1054:	3700008d 	strcc	r0, [r0, -sp, lsl #1]
    1058:	01f34000 	mvnseq	r4, r0
    105c:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
    1060:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
    1064:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
    1068:	0b235101 	bleq	8d5474 <_stack+0x855474>
    106c:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
    1070:	0000160c 	andeq	r1, r0, ip, lsl #12
    1074:	01282b80 	smlawbeq	r8, r0, fp, r2
    1078:	f3131600 	vmax.u16	d1, d3, d0
    107c:	0b235101 	bleq	8d5488 <_stack+0x855488>
    1080:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
    1084:	0000160c 	andeq	r1, r0, ip, lsl #12
    1088:	01282c80 	smlawbeq	r8, r0, ip, r2
    108c:	9f131600 	svcls	0x00131600
    1090:	00008d48 	andeq	r8, r0, r8, asr #26
    1094:	00008d7a 	andeq	r8, r0, sl, ror sp
    1098:	7a540001 	bvc	15010a4 <_stack+0x14810a4>
    109c:	8a00008d 	bhi	12d8 <CPSR_IRQ_INHIBIT+0x1258>
    10a0:	3700008d 	strcc	r0, [r0, -sp, lsl #1]
    10a4:	01f34000 	mvnseq	r4, r0
    10a8:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
    10ac:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
    10b0:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
    10b4:	0b235101 	bleq	8d54c0 <_stack+0x8554c0>
    10b8:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
    10bc:	0000160c 	andeq	r1, r0, ip, lsl #12
    10c0:	01282b80 	smlawbeq	r8, r0, fp, r2
    10c4:	f3131600 	vmax.u16	d1, d3, d0
    10c8:	0b235101 	bleq	8d54d4 <_stack+0x8554d4>
    10cc:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
    10d0:	0000160c 	andeq	r1, r0, ip, lsl #12
    10d4:	01282c80 	smlawbeq	r8, r0, ip, r2
    10d8:	9f131600 	svcls	0x00131600
    10dc:	00008d8a 	andeq	r8, r0, sl, lsl #27
    10e0:	00008e86 	andeq	r8, r0, r6, lsl #29
    10e4:	00540001 	subseq	r0, r4, r1
    10e8:	00000000 	andeq	r0, r0, r0
    10ec:	0a000000 	beq	10f4 <CPSR_IRQ_INHIBIT+0x1074>
    10f0:	6600008b 	strvs	r0, [r0], -fp, lsl #1
    10f4:	0100008c 	smlabbeq	r0, ip, r0, r0
    10f8:	8d925400 	cfldrshi	mvf5, [r2]
    10fc:	8da20000 	stchi	0, cr0, [r2]
    1100:	00010000 	andeq	r0, r1, r0
    1104:	008df654 	addeq	pc, sp, r4, asr r6	; <UNPREDICTABLE>
    1108:	008e0200 	addeq	r0, lr, r0, lsl #4
    110c:	54000100 	strpl	r0, [r0], #-256	; 0x100
    1110:	00008e34 	andeq	r8, r0, r4, lsr lr
    1114:	00008e5e 	andeq	r8, r0, lr, asr lr
    1118:	00540001 	subseq	r0, r4, r1
    111c:	00000000 	andeq	r0, r0, r0
    1120:	0a000000 	beq	1128 <CPSR_IRQ_INHIBIT+0x10a8>
    1124:	6600008b 	strvs	r0, [r0], -fp, lsl #1
    1128:	0100008c 	smlabbeq	r0, ip, r0, r0
    112c:	8d925700 	ldchi	7, cr5, [r2]
    1130:	8da20000 	stchi	0, cr0, [r2]
    1134:	00010000 	andeq	r0, r1, r0
    1138:	008df657 	addeq	pc, sp, r7, asr r6	; <UNPREDICTABLE>
    113c:	008e0200 	addeq	r0, lr, r0, lsl #4
    1140:	57000100 	strpl	r0, [r0, -r0, lsl #2]
    1144:	00008e34 	andeq	r8, r0, r4, lsr lr
    1148:	00008e5e 	andeq	r8, r0, lr, asr lr
    114c:	00570001 	subseq	r0, r7, r1
    1150:	00000000 	andeq	r0, r0, r0
    1154:	54000000 	strpl	r0, [r0], #-0
    1158:	7a00008b 	bvc	138c <CPSR_IRQ_INHIBIT+0x130c>
    115c:	0100008b 	smlabbeq	r0, fp, r0, r0
    1160:	8b7a5000 	blhi	1e95168 <_stack+0x1e15168>
    1164:	8c660000 	stclhi	0, cr0, [r6], #-0
    1168:	00010000 	andeq	r0, r1, r0
    116c:	008d9258 	addeq	r9, sp, r8, asr r2
    1170:	008da200 	addeq	sl, sp, r0, lsl #4
    1174:	50000100 	andpl	r0, r0, r0, lsl #2
    1178:	00008df6 	strdeq	r8, [r0], -r6
    117c:	00008e02 	andeq	r8, r0, r2, lsl #28
    1180:	34580001 	ldrbcc	r0, [r8], #-1
    1184:	4c00008e 	stcmi	0, cr0, [r0], {142}	; 0x8e
    1188:	0100008e 	smlabbeq	r0, lr, r0, r0
    118c:	8e4c5000 	cdphi	0, 4, cr5, cr12, cr0, {0}
    1190:	8e5e0000 	cdphi	0, 5, cr0, cr14, cr0, {0}
    1194:	00010000 	andeq	r0, r1, r0
    1198:	00000058 	andeq	r0, r0, r8, asr r0
    119c:	00000000 	andeq	r0, r0, r0
    11a0:	008b7600 	addeq	r7, fp, r0, lsl #12
    11a4:	008b7a00 	addeq	r7, fp, r0, lsl #20
    11a8:	70000500 	andvc	r0, r0, r0, lsl #10
    11ac:	9f1a3700 	svcls	0x001a3700
    11b0:	00008b7a 	andeq	r8, r0, sl, ror fp
    11b4:	00008b9a 	muleq	r0, sl, fp
    11b8:	00780005 	rsbseq	r0, r8, r5
    11bc:	9a9f1a37 	bls	fe7c7aa0 <_stack+0xfe747aa0>
    11c0:	a400008b 	strge	r0, [r0], #-139	; 0x8b
    11c4:	0100008b 	smlabbeq	r0, fp, r0, r0
    11c8:	8ba45300 	blhi	fe915dd0 <_stack+0xfe895dd0>
    11cc:	8ba60000 	blhi	fe9811d4 <_stack+0xfe9011d4>
    11d0:	00050000 	andeq	r0, r5, r0
    11d4:	1a370078 	bne	dc13bc <_stack+0xd413bc>
    11d8:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    11dc:	00000000 	andeq	r0, r0, r0
    11e0:	008b9a00 	addeq	r9, fp, r0, lsl #20
    11e4:	008ba400 	addeq	sl, fp, r0, lsl #8
    11e8:	38000500 	stmdacc	r0, {r8, sl}
    11ec:	9f1c0073 	svcls	0x001c0073
    11f0:	00008ba4 	andeq	r8, r0, r4, lsr #23
    11f4:	00008ba6 	andeq	r8, r0, r6, lsr #23
    11f8:	78380007 	ldmdavc	r8!, {r0, r1, r2}
    11fc:	1c1a3700 	ldcne	7, cr3, [sl], {-0}
    1200:	008bbc9f 	umulleq	fp, fp, pc, ip	; <UNPREDICTABLE>
    1204:	008c2800 	addeq	r2, ip, r0, lsl #16
    1208:	5a000100 	bpl	1610 <CPSR_IRQ_INHIBIT+0x1590>
    120c:	00008df6 	strdeq	r8, [r0], -r6
    1210:	00008e02 	andeq	r8, r0, r2, lsl #28
    1214:	4c5a0001 	mrrcmi	0, 0, r0, sl, cr1
    1218:	5e00008e 	cdppl	0, 0, cr0, cr0, cr14, {4}
    121c:	0100008e 	smlabbeq	r0, lr, r0, r0
    1220:	00005a00 	andeq	r5, r0, r0, lsl #20
    1224:	00000000 	andeq	r0, r0, r0
    1228:	8b0a0000 	blhi	281230 <_stack+0x201230>
    122c:	8c660000 	stclhi	0, cr0, [r6], #-0
    1230:	00020000 	andeq	r0, r2, r0
    1234:	8d929f30 	ldchi	15, cr9, [r2, #192]	; 0xc0
    1238:	8da20000 	stchi	0, cr0, [r2]
    123c:	00020000 	andeq	r0, r2, r0
    1240:	8df69f30 	ldclhi	15, cr9, [r6, #192]!	; 0xc0
    1244:	8e020000 	cdphi	0, 0, cr0, cr2, cr0, {0}
    1248:	00020000 	andeq	r0, r2, r0
    124c:	8e349f30 	mrchi	15, 1, r9, cr4, cr0, {1}
    1250:	8e5e0000 	cdphi	0, 5, cr0, cr14, cr0, {0}
    1254:	00020000 	andeq	r0, r2, r0
    1258:	00009f30 	andeq	r9, r0, r0, lsr pc
    125c:	00000000 	andeq	r0, r0, r0
    1260:	8bc20000 	blhi	ff081268 <_stack+0xff001268>
    1264:	8be80000 	blhi	ffa0126c <_stack+0xff98126c>
    1268:	00010000 	andeq	r0, r1, r0
    126c:	00000050 	andeq	r0, r0, r0, asr r0
    1270:	00000000 	andeq	r0, r0, r0
    1274:	008e3e00 	addeq	r3, lr, r0, lsl #28
    1278:	008e4400 	addeq	r4, lr, r0, lsl #8
    127c:	7c000600 	stcvc	6, cr0, [r0], {-0}
    1280:	22007900 	andcs	r7, r0, #0, 18
    1284:	008e449f 	umulleq	r4, lr, pc, r4	; <UNPREDICTABLE>
    1288:	008e4800 	addeq	r4, lr, r0, lsl #16
    128c:	51000100 	mrspl	r0, (UNDEF: 16)
    1290:	00008e48 	andeq	r8, r0, r8, asr #28
    1294:	00008e4c 	andeq	r8, r0, ip, asr #28
    1298:	007c0006 	rsbseq	r0, ip, r6
    129c:	9f220079 	svcls	0x00220079
	...
    12a8:	00008b0a 	andeq	r8, r0, sl, lsl #22
    12ac:	00008c32 	andeq	r8, r0, r2, lsr ip
    12b0:	92550001 	subsls	r0, r5, #1
    12b4:	9a00008d 	bls	14f0 <CPSR_IRQ_INHIBIT+0x1470>
    12b8:	0100008d 	smlabbeq	r0, sp, r0, r0
    12bc:	8df65500 	cfldr64hi	mvdx5, [r6]
    12c0:	8dfa0000 	ldclhi	0, cr0, [sl]
    12c4:	00010000 	andeq	r0, r1, r0
    12c8:	008e3455 	addeq	r3, lr, r5, asr r4
    12cc:	008e5e00 	addeq	r5, lr, r0, lsl #28
    12d0:	55000100 	strpl	r0, [r0, #-256]	; 0x100
	...
    12dc:	00008b0a 	andeq	r8, r0, sl, lsl #22
    12e0:	00008c08 	andeq	r8, r0, r8, lsl #24
    12e4:	08590001 	ldmdaeq	r9, {r0}^
    12e8:	2800008c 	stmdacs	r0, {r2, r3, r7}
    12ec:	0100008c 	smlabbeq	r0, ip, r0, r0
    12f0:	8d925100 	ldfhis	f5, [r2]
    12f4:	8da20000 	stchi	0, cr0, [r2]
    12f8:	00010000 	andeq	r0, r1, r0
    12fc:	008df659 	addeq	pc, sp, r9, asr r6	; <UNPREDICTABLE>
    1300:	008e0200 	addeq	r0, lr, r0, lsl #4
    1304:	59000100 	stmdbpl	r0, {r8}
    1308:	00008e34 	andeq	r8, r0, r4, lsr lr
    130c:	00008e4c 	andeq	r8, r0, ip, asr #28
    1310:	4c590001 	mrrcmi	0, 0, r0, r9, cr1
    1314:	5000008e 	andpl	r0, r0, lr, lsl #1
    1318:	0100008e 	smlabbeq	r0, lr, r0, r0
    131c:	8e505100 	rdfhis	f5, f0, f0
    1320:	8e5e0000 	cdphi	0, 5, cr0, cr14, cr0, {0}
    1324:	00060000 	andeq	r0, r6, r0
    1328:	f8097479 			; <UNDEFINED> instruction: 0xf8097479
    132c:	00009f1a 	andeq	r9, r0, sl, lsl pc
    1330:	00000000 	andeq	r0, r0, r0
    1334:	8b200000 	blhi	80133c <_stack+0x78133c>
    1338:	8b490000 	blhi	1241340 <_stack+0x11c1340>
    133c:	00010000 	andeq	r0, r1, r0
    1340:	008b4952 	addeq	r4, fp, r2, asr r9
    1344:	008c3200 	addeq	r3, ip, r0, lsl #4
    1348:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
    134c:	22007900 	andcs	r7, r0, #0, 18
    1350:	008d929f 	umulleq	r9, sp, pc, r2	; <UNPREDICTABLE>
    1354:	008d9a00 	addeq	r9, sp, r0, lsl #20
    1358:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
    135c:	22007900 	andcs	r7, r0, #0, 18
    1360:	008df69f 	umulleq	pc, sp, pc, r6	; <UNPREDICTABLE>
    1364:	008dfa00 	addeq	pc, sp, r0, lsl #20
    1368:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
    136c:	22007900 	andcs	r7, r0, #0, 18
    1370:	008e349f 	umulleq	r3, lr, pc, r4	; <UNPREDICTABLE>
    1374:	008e5e00 	addeq	r5, lr, r0, lsl #28
    1378:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
    137c:	22007900 	andcs	r7, r0, #0, 18
    1380:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    1384:	00000000 	andeq	r0, r0, r0
    1388:	008b2800 	addeq	r2, fp, r0, lsl #16
    138c:	008b3000 	addeq	r3, fp, r0
    1390:	73000300 	movwvc	r0, #768	; 0x300
    1394:	8b309f10 	blhi	c28fdc <_stack+0xba8fdc>
    1398:	8b400000 	blhi	10013a0 <_stack+0xf813a0>
    139c:	000c0000 	andeq	r0, ip, r0
    13a0:	0097f803 	addseq	pc, r7, r3, lsl #16
    13a4:	00740600 	rsbseq	r0, r4, r0, lsl #12
    13a8:	9f102322 	svcls	0x00102322
    13ac:	00008b40 	andeq	r8, r0, r0, asr #22
    13b0:	00008b49 	andeq	r8, r0, r9, asr #22
    13b4:	005c0001 	subseq	r0, ip, r1
    13b8:	00000000 	andeq	r0, r0, r0
    13bc:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
    13c0:	6600008b 	strvs	r0, [r0], -fp, lsl #1
    13c4:	0400008c 	streq	r0, [r0], #-140	; 0x8c
    13c8:	10000a00 	andne	r0, r0, r0, lsl #20
    13cc:	008d929f 	umulleq	r9, sp, pc, r2	; <UNPREDICTABLE>
    13d0:	008da200 	addeq	sl, sp, r0, lsl #4
    13d4:	0a000400 	beq	23dc <CPSR_IRQ_INHIBIT+0x235c>
    13d8:	f69f1000 			; <UNDEFINED> instruction: 0xf69f1000
    13dc:	0200008d 	andeq	r0, r0, #141	; 0x8d
    13e0:	0400008e 	streq	r0, [r0], #-142	; 0x8e
    13e4:	10000a00 	andne	r0, r0, r0, lsl #20
    13e8:	008e349f 	umulleq	r3, lr, pc, r4	; <UNPREDICTABLE>
    13ec:	008e5e00 	addeq	r5, lr, r0, lsl #28
    13f0:	0a000400 	beq	23f8 <CPSR_IRQ_INHIBIT+0x2378>
    13f4:	009f1000 	addseq	r1, pc, r0
    13f8:	00000000 	andeq	r0, r0, r0
    13fc:	90000000 	andls	r0, r0, r0
    1400:	9e00008e 	cdpls	0, 0, cr0, cr0, cr14, {4}
    1404:	0100008e 	smlabbeq	r0, lr, r0, r0
    1408:	8e9e5000 	cdphi	0, 9, cr5, cr14, cr0, {0}
    140c:	8eb60000 	cdphi	0, 11, cr0, cr6, cr0, {0}
    1410:	00010000 	andeq	r0, r1, r0
    1414:	00000055 	andeq	r0, r0, r5, asr r0
    1418:	00000000 	andeq	r0, r0, r0
    141c:	008e9000 	addeq	r9, lr, r0
    1420:	008ea500 	addeq	sl, lr, r0, lsl #10
    1424:	51000100 	mrspl	r0, (UNDEF: 16)
    1428:	00008ea5 	andeq	r8, r0, r5, lsr #29
    142c:	00008eb6 			; <UNDEFINED> instruction: 0x00008eb6
    1430:	01f30004 	mvnseq	r0, r4
    1434:	00009f51 	andeq	r9, r0, r1, asr pc
    1438:	00000000 	andeq	r0, r0, r0
	...

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
   0:	0000860a 	andeq	r8, r0, sl, lsl #12
   4:	0000860c 	andeq	r8, r0, ip, lsl #12
   8:	0000860e 	andeq	r8, r0, lr, lsl #12
   c:	00008636 	andeq	r8, r0, r6, lsr r6
	...
  18:	000085d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
  1c:	000085f2 	strdeq	r8, [r0], -r2
  20:	000085f4 	strdeq	r8, [r0], -r4
  24:	00008684 	andeq	r8, r0, r4, lsl #13
	...
  30:	00008684 	andeq	r8, r0, r4, lsl #13
  34:	000086e2 	andeq	r8, r0, r2, ror #13
	...
  40:	000086e4 	andeq	r8, r0, r4, ror #13
  44:	00008786 	andeq	r8, r0, r6, lsl #15
  48:	00008788 	andeq	r8, r0, r8, lsl #15
  4c:	00008920 	andeq	r8, r0, r0, lsr #18
	...
  58:	00008b0a 	andeq	r8, r0, sl, lsl #22
  5c:	00008c50 	andeq	r8, r0, r0, asr ip
  60:	00008d92 	muleq	r0, r2, sp
  64:	00008da2 	andeq	r8, r0, r2, lsr #27
  68:	00008df6 	strdeq	r8, [r0], -r6
  6c:	00008e02 	andeq	r8, r0, r2, lsl #28
  70:	00008e34 	andeq	r8, r0, r4, lsr lr
  74:	00008e5e 	andeq	r8, r0, lr, asr lr
	...
  80:	00008920 	andeq	r8, r0, r0, lsr #18
  84:	00008e86 	andeq	r8, r0, r6, lsl #29
	...
  90:	00008e88 	andeq	r8, r0, r8, lsl #29
  94:	00008e8a 	andeq	r8, r0, sl, lsl #29
  98:	00008e8c 	andeq	r8, r0, ip, lsl #29
  9c:	00008e8e 	andeq	r8, r0, lr, lsl #29
	...
  a8:	00008e90 	muleq	r0, r0, lr
  ac:	00008eb6 			; <UNDEFINED> instruction: 0x00008eb6
	...

Disassembly of section .ARM.attributes:

00000000 <_stack-0x80000>:
   0:	00003441 	andeq	r3, r0, r1, asr #8
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	0000002a 	andeq	r0, r0, sl, lsr #32
  10:	412d3705 	teqmi	sp, r5, lsl #14
  14:	070a0600 	streq	r0, [sl, -r0, lsl #12]
  18:	09010841 	stmdbeq	r1, {r0, r6, fp}
  1c:	0c050a02 	stceq	10, cr0, [r5], {2}
  20:	14041202 	strne	r1, [r4], #-514	; 0x202
  24:	17011501 	strne	r1, [r1, -r1, lsl #10]
  28:	1a011803 	bne	4603c <__bss_end__+0x3c814>
  2c:	1c031b01 	stcne	11, cr1, [r3], {1}
  30:	22011e01 	andcs	r1, r1, #1, 28
  34:	Address 0x0000000000000034 is out of bounds.

