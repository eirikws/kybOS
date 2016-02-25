
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
    8024:	00008818 	andeq	r8, r0, r8, lsl r8

00008028 <_software_interrupt_vector_h>:
    8028:	00008284 	andeq	r8, r0, r4, lsl #5

0000802c <_prefetch_abort_vector_h>:
    802c:	000082b4 			; <UNDEFINED> instruction: 0x000082b4

00008030 <_data_abort_vector_h>:
    8030:	000082dc 	ldrdeq	r8, [r0], -ip

00008034 <_unused_handler_h>:
    8034:	00008040 	andeq	r8, r0, r0, asr #32

00008038 <_interrupt_vector_h>:
    8038:	0000809c 	muleq	r0, ip, r0

0000803c <_fast_interrupt_vector_h>:
    803c:	000089a0 	andeq	r8, r0, r0, lsr #19

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
    8064:	e3a000db 	mov	r0, #219	; 0xdb
    8068:	e121f000 	msr	CPSR_c, r0
    806c:	e3a0d63d 	mov	sp, #63963136	; 0x3d00000
    8070:	e3a000d7 	mov	r0, #215	; 0xd7
    8074:	e121f000 	msr	CPSR_c, r0
    8078:	e3a0d50f 	mov	sp, #62914560	; 0x3c00000
    807c:	e3a000df 	mov	r0, #223	; 0xdf
    8080:	e121f000 	msr	CPSR_c, r0
    8084:	e3a0d63e 	mov	sp, #65011712	; 0x3e00000
    8088:	e3a000d3 	mov	r0, #211	; 0xd3
    808c:	e121f000 	msr	CPSR_c, r0
    8090:	e3a0d63b 	mov	sp, #61865984	; 0x3b00000
    8094:	eb000142 	bl	85a4 <_cstartup>

00008098 <_inf_loop>:
    8098:	eafffffe 	b	8098 <_inf_loop>

0000809c <interrupt_vector>:
    809c:	e24ee004 	sub	lr, lr, #4
    80a0:	e92d500f 	push	{r0, r1, r2, r3, ip, lr}
    80a4:	eb00022c 	bl	895c <interrupt_vector_c>
    80a8:	e3500000 	cmp	r0, #0
    80ac:	08fd900f 	ldmeq	sp!, {r0, r1, r2, r3, ip, pc}^
    80b0:	e8bd500f 	pop	{r0, r1, r2, r3, ip, lr}

000080b4 <find_origin_context_switch>:
    80b4:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    80b8:	e14f0000 	mrs	r0, SPSR
    80bc:	e200001f 	and	r0, r0, #31
    80c0:	e3500010 	cmp	r0, #16
    80c4:	049d0004 	popeq	{r0}		; (ldreq r0, [sp], #4)
    80c8:	0a000002 	beq	80d8 <build_context_stack_user>
    80cc:	e3500013 	cmp	r0, #19
    80d0:	049d0004 	popeq	{r0}		; (ldreq r0, [sp], #4)
    80d4:	1a000010 	bne	811c <build_context_stack_svr>

000080d8 <build_context_stack_user>:
    80d8:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    80dc:	e3a000df 	mov	r0, #223	; 0xdf
    80e0:	e121f000 	msr	CPSR_c, r0
    80e4:	e92d1ffe 	push	{r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
    80e8:	e3a000d2 	mov	r0, #210	; 0xd2
    80ec:	e121f000 	msr	CPSR_c, r0
    80f0:	e49d0004 	pop	{r0}		; (ldr r0, [sp], #4)
    80f4:	e14f1000 	mrs	r1, SPSR
    80f8:	e1a0200e 	mov	r2, lr
    80fc:	e3a030df 	mov	r3, #223	; 0xdf
    8100:	e121f003 	msr	CPSR_c, r3
    8104:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8108:	e92d4006 	push	{r1, r2, lr}
    810c:	e1a0000d 	mov	r0, sp
    8110:	e3a010d2 	mov	r1, #210	; 0xd2
    8114:	e121f001 	msr	CPSR_c, r1
    8118:	ea000010 	b	8160 <update_stack>

0000811c <build_context_stack_svr>:
    811c:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8120:	e3a000d3 	mov	r0, #211	; 0xd3
    8124:	e121f000 	msr	CPSR_c, r0
    8128:	e92d1ffe 	push	{r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
    812c:	e3a000d2 	mov	r0, #210	; 0xd2
    8130:	e121f000 	msr	CPSR_c, r0
    8134:	e49d0004 	pop	{r0}		; (ldr r0, [sp], #4)
    8138:	e14f1000 	mrs	r1, SPSR
    813c:	e1a0200e 	mov	r2, lr
    8140:	e3a030d3 	mov	r3, #211	; 0xd3
    8144:	e121f003 	msr	CPSR_c, r3
    8148:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    814c:	e92d4006 	push	{r1, r2, lr}
    8150:	e1a0000d 	mov	r0, sp
    8154:	e3a010d2 	mov	r1, #210	; 0xd2
    8158:	e121f001 	msr	CPSR_c, r1
    815c:	eaffffff 	b	8160 <update_stack>

00008160 <update_stack>:
    8160:	eb0004f7 	bl	9544 <context_switch_c>
    8164:	e1a0100d 	mov	r1, sp
    8168:	e1a0d000 	mov	sp, r0
    816c:	e1a04000 	mov	r4, r0
    8170:	e49d0004 	pop	{r0}		; (ldr r0, [sp], #4)
    8174:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8178:	e1a0d001 	mov	sp, r1
    817c:	e200001f 	and	r0, r0, #31
    8180:	e3500010 	cmp	r0, #16
    8184:	0a000001 	beq	8190 <pop_return_stack_user>
    8188:	e3500013 	cmp	r0, #19
    818c:	0a000016 	beq	81ec <pop_return_stack_svr>

00008190 <pop_return_stack_user>:
    8190:	e3a000df 	mov	r0, #223	; 0xdf
    8194:	e121f000 	msr	CPSR_c, r0
    8198:	e1a0d004 	mov	sp, r4
    819c:	e8bd0007 	pop	{r0, r1, r2}
    81a0:	e1a0e002 	mov	lr, r2
    81a4:	e3a030d2 	mov	r3, #210	; 0xd2
    81a8:	e121f003 	msr	CPSR_c, r3
    81ac:	e52d1004 	push	{r1}		; (str r1, [sp, #-4]!)
    81b0:	e169f000 	msr	SPSR_fc, r0
    81b4:	e3a040df 	mov	r4, #223	; 0xdf
    81b8:	e121f004 	msr	CPSR_c, r4
    81bc:	e8bd1fff 	pop	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
    81c0:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    81c4:	e3a000d2 	mov	r0, #210	; 0xd2
    81c8:	e121f000 	msr	CPSR_c, r0
    81cc:	e92d1ffe 	push	{r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
    81d0:	e3a000df 	mov	r0, #223	; 0xdf
    81d4:	e121f000 	msr	CPSR_c, r0
    81d8:	e49d0004 	pop	{r0}		; (ldr r0, [sp], #4)
    81dc:	e3a010d2 	mov	r1, #210	; 0xd2
    81e0:	e121f001 	msr	CPSR_c, r1
    81e4:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    81e8:	e8fd9fff 	ldm	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}^

000081ec <pop_return_stack_svr>:
    81ec:	e3a000d3 	mov	r0, #211	; 0xd3
    81f0:	e121f000 	msr	CPSR_c, r0
    81f4:	e1a0d004 	mov	sp, r4
    81f8:	e8bd0007 	pop	{r0, r1, r2}
    81fc:	e1a0e002 	mov	lr, r2
    8200:	e3a030d2 	mov	r3, #210	; 0xd2
    8204:	e121f003 	msr	CPSR_c, r3
    8208:	e52d1004 	push	{r1}		; (str r1, [sp, #-4]!)
    820c:	e169f000 	msr	SPSR_fc, r0
    8210:	e3a040d3 	mov	r4, #211	; 0xd3
    8214:	e121f004 	msr	CPSR_c, r4
    8218:	e8bd1fff 	pop	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
    821c:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8220:	e3a000d2 	mov	r0, #210	; 0xd2
    8224:	e121f000 	msr	CPSR_c, r0
    8228:	e92d1ffe 	push	{r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
    822c:	e3a000d3 	mov	r0, #211	; 0xd3
    8230:	e121f000 	msr	CPSR_c, r0
    8234:	e49d0004 	pop	{r0}		; (ldr r0, [sp], #4)
    8238:	e3a010d2 	mov	r1, #210	; 0xd2
    823c:	e121f001 	msr	CPSR_c, r1
    8240:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8244:	e8fd9fff 	ldm	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}^

00008248 <software_context_switch>:
    8248:	e92d0007 	push	{r0, r1, r2}
    824c:	e14f0000 	mrs	r0, SPSR
    8250:	e1a0100e 	mov	r1, lr
    8254:	e3a020d2 	mov	r2, #210	; 0xd2
    8258:	e121f002 	msr	CPSR_c, r2
    825c:	e169f000 	msr	SPSR_fc, r0
    8260:	e1a0e001 	mov	lr, r1
    8264:	e52d3004 	push	{r3}		; (str r3, [sp, #-4]!)
    8268:	e3a020d3 	mov	r2, #211	; 0xd3
    826c:	e121f002 	msr	CPSR_c, r2
    8270:	e8bd0007 	pop	{r0, r1, r2}
    8274:	e3a030d2 	mov	r3, #210	; 0xd2
    8278:	e121f003 	msr	CPSR_c, r3
    827c:	e49d3004 	pop	{r3}		; (ldr r3, [sp], #4)
    8280:	eaffff8b 	b	80b4 <find_origin_context_switch>

00008284 <software_interrupt_vector>:
    8284:	e52d4004 	push	{r4}		; (str r4, [sp, #-4]!)
    8288:	e1a0400d 	mov	r4, sp
    828c:	e3a0d301 	mov	sp, #67108864	; 0x4000000
    8290:	e92d5000 	push	{ip, lr}
    8294:	eb00016b 	bl	8848 <software_interrupt_vector_c>
    8298:	e8bd5000 	pop	{ip, lr}
    829c:	e1a0d004 	mov	sp, r4
    82a0:	e49d4004 	pop	{r4}		; (ldr r4, [sp], #4)
    82a4:	e3500000 	cmp	r0, #0
    82a8:	1affffe6 	bne	8248 <software_context_switch>
    82ac:	e52de004 	push	{lr}		; (str lr, [sp, #-4]!)
    82b0:	e8fd8000 	ldm	sp!, {pc}^

000082b4 <prefetch_abort_vector>:
    82b4:	e24ee004 	sub	lr, lr, #4
    82b8:	e92d500f 	push	{r0, r1, r2, r3, ip, lr}
    82bc:	e1a0000e 	mov	r0, lr
    82c0:	e10f3000 	mrs	r3, CPSR
    82c4:	e14f2000 	mrs	r2, SPSR
    82c8:	e121f002 	msr	CPSR_c, r2
    82cc:	e1a0100d 	mov	r1, sp
    82d0:	e121f003 	msr	CPSR_c, r3
    82d4:	eb00017a 	bl	88c4 <prefetch_abort_vector_c>
    82d8:	e8fd900f 	ldm	sp!, {r0, r1, r2, r3, ip, pc}^

000082dc <data_abort_vector>:
    82dc:	e24ee008 	sub	lr, lr, #8
    82e0:	e92d500f 	push	{r0, r1, r2, r3, ip, lr}
    82e4:	e1a0000e 	mov	r0, lr
    82e8:	e10f3000 	mrs	r3, CPSR
    82ec:	e14f2000 	mrs	r2, SPSR
    82f0:	e121f002 	msr	CPSR_c, r2
    82f4:	e1a0100d 	mov	r1, sp
    82f8:	e121f003 	msr	CPSR_c, r3
    82fc:	eb000183 	bl	8910 <data_abort_vector_c>
    8300:	e8fd900f 	ldm	sp!, {r0, r1, r2, r3, ip, pc}^

00008304 <_get_stack_pointer>:
    8304:	e58dd000 	str	sp, [sp]
    8308:	e59d0000 	ldr	r0, [sp]
    830c:	e1a0f00e 	mov	pc, lr

00008310 <_get_user_sp>:
    8310:	e52d4004 	push	{r4}		; (str r4, [sp, #-4]!)
    8314:	e3a040df 	mov	r4, #223	; 0xdf
    8318:	e121f004 	msr	CPSR_c, r4
    831c:	e1a0000d 	mov	r0, sp
    8320:	e3a040d2 	mov	r4, #210	; 0xd2
    8324:	e121f004 	msr	CPSR_c, r4
    8328:	e49d4004 	pop	{r4}		; (ldr r4, [sp], #4)
    832c:	e1a0f00e 	mov	pc, lr

00008330 <_SYSTEM_CALL>:
    8330:	e92d5000 	push	{ip, lr}
    8334:	ef000000 	svc	0x00000000
    8338:	e8bd9000 	pop	{ip, pc}

0000833c <_get_cpsr>:
    833c:	e10f0000 	mrs	r0, CPSR
    8340:	e1a0f00e 	mov	pc, lr

00008344 <_push_stack_pointer>:
    8344:	e3a010df 	mov	r1, #223	; 0xdf
    8348:	e121f001 	msr	CPSR_c, r1
    834c:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8350:	e3a000d2 	mov	r0, #210	; 0xd2
    8354:	e121f000 	msr	CPSR_c, r0
    8358:	e1a0f00e 	mov	pc, lr

0000835c <_init_thr_stack>:
    835c:	e1a0300d 	mov	r3, sp
    8360:	e1a0d000 	mov	sp, r0
    8364:	e3a0002a 	mov	r0, #42	; 0x2a
    8368:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    836c:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8370:	e3a00000 	mov	r0, #0
    8374:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8378:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    837c:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8380:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8384:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8388:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    838c:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8390:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8394:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    8398:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    839c:	e3a0002a 	mov	r0, #42	; 0x2a
    83a0:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    83a4:	e52d0004 	push	{r0}		; (str r0, [sp, #-4]!)
    83a8:	e52d1004 	push	{r1}		; (str r1, [sp, #-4]!)
    83ac:	e52d2004 	push	{r2}		; (str r2, [sp, #-4]!)
    83b0:	e1a0000d 	mov	r0, sp
    83b4:	e1a0d003 	mov	sp, r3
    83b8:	e1a0f00e 	mov	pc, lr

000083bc <_set_cpu_mode>:
    83bc:	e1a0200e 	mov	r2, lr
    83c0:	e121f000 	msr	CPSR_c, r0
    83c4:	e1a0f002 	mov	pc, r2

000083c8 <_enable_interrupts>:
    83c8:	e10f0000 	mrs	r0, CPSR
    83cc:	e3c00080 	bic	r0, r0, #128	; 0x80
    83d0:	e121f000 	msr	CPSR_c, r0
    83d4:	e1a0f00e 	mov	pc, lr

000083d8 <loop_forever_and_ever>:
    83d8:	e24dd008 	sub	sp, sp, #8
    83dc:	e3a03000 	mov	r3, #0
    83e0:	e58d3004 	str	r3, [sp, #4]
    83e4:	e59d3004 	ldr	r3, [sp, #4]
    83e8:	e2833001 	add	r3, r3, #1
    83ec:	e58d3004 	str	r3, [sp, #4]
    83f0:	e59d3004 	ldr	r3, [sp, #4]
    83f4:	eafffffa 	b	83e4 <loop_forever_and_ever+0xc>

000083f8 <kernel_main>:
    83f8:	e92d40f0 	push	{r4, r5, r6, r7, lr}
    83fc:	e24dd00c 	sub	sp, sp, #12
    8400:	eb000171 	bl	89cc <uart_init>
    8404:	ebffffef 	bl	83c8 <_enable_interrupts>
    8408:	e30a074c 	movw	r0, #42828	; 0xa74c
    840c:	e3400000 	movt	r0, #0
    8410:	eb0001b3 	bl	8ae4 <uart_puts>
    8414:	e30a075c 	movw	r0, #42844	; 0xa75c
    8418:	e3400000 	movt	r0, #0
    841c:	eb0001b0 	bl	8ae4 <uart_puts>
    8420:	e30a0768 	movw	r0, #42856	; 0xa768
    8424:	e3400000 	movt	r0, #0
    8428:	eb0001ad 	bl	8ae4 <uart_puts>
    842c:	e3e00000 	mvn	r0, #0
    8430:	e3a01002 	mov	r1, #2
    8434:	eb0001db 	bl	8ba8 <uart_put_uint32_t>
    8438:	e30a0778 	movw	r0, #42872	; 0xa778
    843c:	e3400000 	movt	r0, #0
    8440:	eb0001a7 	bl	8ae4 <uart_puts>
    8444:	e3e00000 	mvn	r0, #0
    8448:	e3a0100a 	mov	r1, #10
    844c:	eb0001d5 	bl	8ba8 <uart_put_uint32_t>
    8450:	e30a0788 	movw	r0, #42888	; 0xa788
    8454:	e3400000 	movt	r0, #0
    8458:	eb0001a1 	bl	8ae4 <uart_puts>
    845c:	e3e00000 	mvn	r0, #0
    8460:	e3a01010 	mov	r1, #16
    8464:	eb0001cf 	bl	8ba8 <uart_put_uint32_t>
    8468:	e30a0b28 	movw	r0, #43816	; 0xab28
    846c:	e3400000 	movt	r0, #0
    8470:	eb00019b 	bl	8ae4 <uart_puts>
    8474:	eb000509 	bl	98a0 <jtag_enable>
    8478:	eb000383 	bl	928c <init_pri_array>
    847c:	e30a079c 	movw	r0, #42908	; 0xa79c
    8480:	e3400000 	movt	r0, #0
    8484:	eb000196 	bl	8ae4 <uart_puts>
    8488:	eb000517 	bl	98ec <mmu_init_table>
    848c:	eb000531 	bl	9958 <mmu_configure>
    8490:	eb0001fa 	bl	8c80 <cpu_control_config>
    8494:	e30a07ac 	movw	r0, #42924	; 0xa7ac
    8498:	e3400000 	movt	r0, #0
    849c:	eb000190 	bl	8ae4 <uart_puts>
    84a0:	e3a00003 	mov	r0, #3
    84a4:	e3a01000 	mov	r1, #0
    84a8:	e1a02001 	mov	r2, r1
    84ac:	e1a03001 	mov	r3, r1
    84b0:	ebffff9e 	bl	8330 <_SYSTEM_CALL>
    84b4:	e30a07bc 	movw	r0, #42940	; 0xa7bc
    84b8:	e3400000 	movt	r0, #0
    84bc:	eb000188 	bl	8ae4 <uart_puts>
    84c0:	eb0000c7 	bl	87e4 <get_gpio>
    84c4:	e5903010 	ldr	r3, [r0, #16]
    84c8:	e3833015 	orr	r3, r3, #21
    84cc:	e5803010 	str	r3, [r0, #16]
    84d0:	e30a07c4 	movw	r0, #42948	; 0xa7c4
    84d4:	e3400000 	movt	r0, #0
    84d8:	eb000181 	bl	8ae4 <uart_puts>
    84dc:	e3a04002 	mov	r4, #2
    84e0:	e3a06010 	mov	r6, #16
    84e4:	e58d6000 	str	r6, [sp]
    84e8:	e3080e24 	movw	r0, #36388	; 0x8e24
    84ec:	e3400000 	movt	r0, #0
    84f0:	e3a0100a 	mov	r1, #10
    84f4:	e3a02ffa 	mov	r2, #1000	; 0x3e8
    84f8:	e1a03004 	mov	r3, r4
    84fc:	eb00031d 	bl	9178 <thread_register>
    8500:	e3a05001 	mov	r5, #1
    8504:	e58d6000 	str	r6, [sp]
    8508:	e3080d88 	movw	r0, #36232	; 0x8d88
    850c:	e3400000 	movt	r0, #0
    8510:	e3a0100a 	mov	r1, #10
    8514:	e3a02ffa 	mov	r2, #1000	; 0x3e8
    8518:	e1a03005 	mov	r3, r5
    851c:	eb000315 	bl	9178 <thread_register>
    8520:	e3a07003 	mov	r7, #3
    8524:	e58d6000 	str	r6, [sp]
    8528:	e3080eb4 	movw	r0, #36532	; 0x8eb4
    852c:	e3400000 	movt	r0, #0
    8530:	e1a01005 	mov	r1, r5
    8534:	e3a02ffa 	mov	r2, #1000	; 0x3e8
    8538:	e1a03007 	mov	r3, r7
    853c:	eb00030d 	bl	9178 <thread_register>
    8540:	e30a07dc 	movw	r0, #42972	; 0xa7dc
    8544:	e3400000 	movt	r0, #0
    8548:	eb000165 	bl	8ae4 <uart_puts>
    854c:	eb0002b1 	bl	9018 <pcb_print>
    8550:	e1a00005 	mov	r0, r5
    8554:	e3a01000 	mov	r1, #0
    8558:	eb00033e 	bl	9258 <thread_start>
    855c:	e1a00004 	mov	r0, r4
    8560:	e3a01000 	mov	r1, #0
    8564:	eb00033b 	bl	9258 <thread_start>
    8568:	e1a00007 	mov	r0, r7
    856c:	e3a01000 	mov	r1, #0
    8570:	eb000338 	bl	9258 <thread_start>
    8574:	e30a07f0 	movw	r0, #42992	; 0xa7f0
    8578:	e3400000 	movt	r0, #0
    857c:	eb000158 	bl	8ae4 <uart_puts>
    8580:	e3020710 	movw	r0, #10000	; 0x2710
    8584:	eb000080 	bl	878c <arm_timer_set_freq>
    8588:	eb00008b 	bl	87bc <arm_timer_init>
    858c:	e1a00004 	mov	r0, r4
    8590:	e3a01000 	mov	r1, #0
    8594:	e1a02001 	mov	r2, r1
    8598:	e1a03001 	mov	r3, r1
    859c:	ebffff63 	bl	8330 <_SYSTEM_CALL>
    85a0:	ebffff8c 	bl	83d8 <loop_forever_and_ever>

000085a4 <_cstartup>:
    85a4:	e92d4008 	push	{r3, lr}
    85a8:	e30bc51c 	movw	ip, #46364	; 0xb51c
    85ac:	e340c000 	movt	ip, #0
    85b0:	e3043048 	movw	r3, #16456	; 0x4048
    85b4:	e3403001 	movt	r3, #1
    85b8:	e15c0003 	cmp	ip, r3
    85bc:	2a000009 	bcs	85e8 <_cstartup+0x44>
    85c0:	e24c3004 	sub	r3, ip, #4
    85c4:	e59fe024 	ldr	lr, [pc, #36]	; 85f0 <_cstartup+0x4c>
    85c8:	e063e00e 	rsb	lr, r3, lr
    85cc:	e3cee003 	bic	lr, lr, #3
    85d0:	e283c004 	add	ip, r3, #4
    85d4:	e08ee00c 	add	lr, lr, ip
    85d8:	e3a0c000 	mov	ip, #0
    85dc:	e5a3c004 	str	ip, [r3, #4]!
    85e0:	e153000e 	cmp	r3, lr
    85e4:	1afffffc 	bne	85dc <_cstartup+0x38>
    85e8:	ebffff82 	bl	83f8 <kernel_main>
    85ec:	eafffffe 	b	85ec <_cstartup+0x48>
    85f0:	00014043 	andeq	r4, r1, r3, asr #32

000085f4 <_exit>:
    85f4:	eafffffe 	b	85f4 <_exit>

000085f8 <close>:
    85f8:	e3e00000 	mvn	r0, #0
    85fc:	e12fff1e 	bx	lr

00008600 <execve>:
    8600:	e3043044 	movw	r3, #16452	; 0x4044
    8604:	e3403001 	movt	r3, #1
    8608:	e3a0200c 	mov	r2, #12
    860c:	e5832000 	str	r2, [r3]
    8610:	e3e00000 	mvn	r0, #0
    8614:	e12fff1e 	bx	lr

00008618 <fork>:
    8618:	e3043044 	movw	r3, #16452	; 0x4044
    861c:	e3403001 	movt	r3, #1
    8620:	e3a0200b 	mov	r2, #11
    8624:	e5832000 	str	r2, [r3]
    8628:	e3e00000 	mvn	r0, #0
    862c:	e12fff1e 	bx	lr

00008630 <fstat>:
    8630:	e3a03a02 	mov	r3, #8192	; 0x2000
    8634:	e5813004 	str	r3, [r1, #4]
    8638:	e3a00000 	mov	r0, #0
    863c:	e12fff1e 	bx	lr

00008640 <getpid>:
    8640:	e3a00001 	mov	r0, #1
    8644:	e12fff1e 	bx	lr

00008648 <isatty>:
    8648:	e3a00001 	mov	r0, #1
    864c:	e12fff1e 	bx	lr

00008650 <kill>:
    8650:	e3043044 	movw	r3, #16452	; 0x4044
    8654:	e3403001 	movt	r3, #1
    8658:	e3a02016 	mov	r2, #22
    865c:	e5832000 	str	r2, [r3]
    8660:	e3e00000 	mvn	r0, #0
    8664:	e12fff1e 	bx	lr

00008668 <link>:
    8668:	e3043044 	movw	r3, #16452	; 0x4044
    866c:	e3403001 	movt	r3, #1
    8670:	e3a0201f 	mov	r2, #31
    8674:	e5832000 	str	r2, [r3]
    8678:	e3e00000 	mvn	r0, #0
    867c:	e12fff1e 	bx	lr

00008680 <lseek>:
    8680:	e3a00000 	mov	r0, #0
    8684:	e12fff1e 	bx	lr

00008688 <open>:
    8688:	e3e00000 	mvn	r0, #0
    868c:	e12fff1e 	bx	lr

00008690 <read>:
    8690:	e3a00000 	mov	r0, #0
    8694:	e12fff1e 	bx	lr

00008698 <_sbrk>:
    8698:	e92d4070 	push	{r4, r5, r6, lr}
    869c:	e1a05000 	mov	r5, r0
    86a0:	e30c3000 	movw	r3, #49152	; 0xc000
    86a4:	e3403000 	movt	r3, #0
    86a8:	e5933000 	ldr	r3, [r3]
    86ac:	e3530000 	cmp	r3, #0
    86b0:	030c3000 	movweq	r3, #49152	; 0xc000
    86b4:	03403000 	movteq	r3, #0
    86b8:	03042048 	movweq	r2, #16456	; 0x4048
    86bc:	03402001 	movteq	r2, #1
    86c0:	05832000 	streq	r2, [r3]
    86c4:	e30c3000 	movw	r3, #49152	; 0xc000
    86c8:	e3403000 	movt	r3, #0
    86cc:	e5934000 	ldr	r4, [r3]
    86d0:	e0846000 	add	r6, r4, r0
    86d4:	ebffff0a 	bl	8304 <_get_stack_pointer>
    86d8:	e1560000 	cmp	r6, r0
    86dc:	9a000000 	bls	86e4 <_sbrk+0x4c>
    86e0:	eafffffe 	b	86e0 <_sbrk+0x48>
    86e4:	e30c3000 	movw	r3, #49152	; 0xc000
    86e8:	e3403000 	movt	r3, #0
    86ec:	e5932000 	ldr	r2, [r3]
    86f0:	e0825005 	add	r5, r2, r5
    86f4:	e5835000 	str	r5, [r3]
    86f8:	e1a00004 	mov	r0, r4
    86fc:	e8bd8070 	pop	{r4, r5, r6, pc}

00008700 <stat>:
    8700:	e3a03a02 	mov	r3, #8192	; 0x2000
    8704:	e5813004 	str	r3, [r1, #4]
    8708:	e3a00000 	mov	r0, #0
    870c:	e12fff1e 	bx	lr

00008710 <times>:
    8710:	e3e00000 	mvn	r0, #0
    8714:	e12fff1e 	bx	lr

00008718 <unlink>:
    8718:	e3043044 	movw	r3, #16452	; 0x4044
    871c:	e3403001 	movt	r3, #1
    8720:	e3a02002 	mov	r2, #2
    8724:	e5832000 	str	r2, [r3]
    8728:	e3e00000 	mvn	r0, #0
    872c:	e12fff1e 	bx	lr

00008730 <wait>:
    8730:	e3043044 	movw	r3, #16452	; 0x4044
    8734:	e3403001 	movt	r3, #1
    8738:	e3a0200a 	mov	r2, #10
    873c:	e5832000 	str	r2, [r3]
    8740:	e3e00000 	mvn	r0, #0
    8744:	e12fff1e 	bx	lr

00008748 <outbyte>:
    8748:	e12fff1e 	bx	lr

0000874c <write>:
    874c:	e2520000 	subs	r0, r2, #0
    8750:	d12fff1e 	bxle	lr
    8754:	e3a03000 	mov	r3, #0
    8758:	e2833001 	add	r3, r3, #1
    875c:	e1530000 	cmp	r3, r0
    8760:	1afffffc 	bne	8758 <write+0xc>
    8764:	e12fff1e 	bx	lr

00008768 <arm_timer_get_freq>:
    8768:	e30c3008 	movw	r3, #49160	; 0xc008
    876c:	e3403000 	movt	r3, #0
    8770:	e5930000 	ldr	r0, [r3]
    8774:	e12fff1e 	bx	lr

00008778 <arm_timer_irq_ack>:
    8778:	e3a03a0b 	mov	r3, #45056	; 0xb000
    877c:	e3433f00 	movt	r3, #16128	; 0x3f00
    8780:	e3a02001 	mov	r2, #1
    8784:	e583240c 	str	r2, [r3, #1036]	; 0x40c
    8788:	e12fff1e 	bx	lr

0000878c <arm_timer_set_freq>:
    878c:	e92d4010 	push	{r4, lr}
    8790:	e1a04000 	mov	r4, r0
    8794:	e3a00efa 	mov	r0, #4000	; 0xfa0
    8798:	e1a01004 	mov	r1, r4
    879c:	fa0004ab 	blx	9a50 <__aeabi_idiv>
    87a0:	e3a03a0b 	mov	r3, #45056	; 0xb000
    87a4:	e3433f00 	movt	r3, #16128	; 0x3f00
    87a8:	e5830400 	str	r0, [r3, #1024]	; 0x400
    87ac:	e30c3008 	movw	r3, #49160	; 0xc008
    87b0:	e3403000 	movt	r3, #0
    87b4:	e5834000 	str	r4, [r3]
    87b8:	e8bd8010 	pop	{r4, pc}

000087bc <arm_timer_init>:
    87bc:	e92d4008 	push	{r3, lr}
    87c0:	eb00000b 	bl	87f4 <irq_controller_get>
    87c4:	e5903018 	ldr	r3, [r0, #24]
    87c8:	e3833001 	orr	r3, r3, #1
    87cc:	e5803018 	str	r3, [r0, #24]
    87d0:	e3a03a0b 	mov	r3, #45056	; 0xb000
    87d4:	e3433f00 	movt	r3, #16128	; 0x3f00
    87d8:	e3a020aa 	mov	r2, #170	; 0xaa
    87dc:	e5832408 	str	r2, [r3, #1032]	; 0x408
    87e0:	e8bd8008 	pop	{r3, pc}

000087e4 <get_gpio>:
    87e4:	e3a00000 	mov	r0, #0
    87e8:	e3430f20 	movt	r0, #16160	; 0x3f20
    87ec:	e12fff1e 	bx	lr

000087f0 <gpio_init>:
    87f0:	e12fff1e 	bx	lr

000087f4 <irq_controller_get>:
    87f4:	e3a00cb2 	mov	r0, #45568	; 0xb200
    87f8:	e3430f00 	movt	r0, #16128	; 0x3f00
    87fc:	e12fff1e 	bx	lr

00008800 <reset_vector>:
    8800:	e24ee004 	sub	lr, lr, #4
    8804:	e92d500f 	push	{r0, r1, r2, r3, ip, lr}
    8808:	e30a0818 	movw	r0, #43032	; 0xa818
    880c:	e3400000 	movt	r0, #0
    8810:	eb0000b3 	bl	8ae4 <uart_puts>
    8814:	e8fd900f 	ldm	sp!, {r0, r1, r2, r3, ip, pc}^

00008818 <undefined_instruction_vector>:
    8818:	e92d503f 	push	{r0, r1, r2, r3, r4, r5, ip, lr}
    881c:	e1a0400e 	mov	r4, lr
    8820:	e30a082c 	movw	r0, #43052	; 0xa82c
    8824:	e3400000 	movt	r0, #0
    8828:	eb0000ad 	bl	8ae4 <uart_puts>
    882c:	e1a00004 	mov	r0, r4
    8830:	e3a01010 	mov	r1, #16
    8834:	eb0000db 	bl	8ba8 <uart_put_uint32_t>
    8838:	e30a0b28 	movw	r0, #43816	; 0xab28
    883c:	e3400000 	movt	r0, #0
    8840:	eb0000a7 	bl	8ae4 <uart_puts>
    8844:	e8fd903f 	ldm	sp!, {r0, r1, r2, r3, r4, r5, ip, pc}^

00008848 <software_interrupt_vector_c>:
    8848:	e92d4008 	push	{r3, lr}
    884c:	e6ef0070 	uxtb	r0, r0
    8850:	e3500003 	cmp	r0, #3
    8854:	979ff100 	ldrls	pc, [pc, r0, lsl #2]
    8858:	ea000018 	b	88c0 <software_interrupt_vector_c+0x78>
    885c:	0000886c 	andeq	r8, r0, ip, ror #16
    8860:	00008888 	andeq	r8, r0, r8, lsl #17
    8864:	000088b4 			; <UNDEFINED> instruction: 0x000088b4
    8868:	000088a0 	andeq	r8, r0, r0, lsr #17
    886c:	e1a00001 	mov	r0, r1
    8870:	e1a01002 	mov	r1, r2
    8874:	e5932000 	ldr	r2, [r3]
    8878:	eb0003c6 	bl	9798 <system_send>
    887c:	eb0002f8 	bl	9464 <reschedule>
    8880:	e3a00001 	mov	r0, #1
    8884:	e8bd8008 	pop	{r3, pc}
    8888:	e1a00001 	mov	r0, r1
    888c:	e1a01002 	mov	r1, r2
    8890:	eb0003d3 	bl	97e4 <system_receive>
    8894:	eb0002f2 	bl	9464 <reschedule>
    8898:	e3a00001 	mov	r0, #1
    889c:	e8bd8008 	pop	{r3, pc}
    88a0:	e30a0844 	movw	r0, #43076	; 0xa844
    88a4:	e3400000 	movt	r0, #0
    88a8:	eb00008d 	bl	8ae4 <uart_puts>
    88ac:	e3a00000 	mov	r0, #0
    88b0:	e8bd8008 	pop	{r3, pc}
    88b4:	eb0002ea 	bl	9464 <reschedule>
    88b8:	e3a00001 	mov	r0, #1
    88bc:	e8bd8008 	pop	{r3, pc}
    88c0:	e8bd8008 	pop	{r3, pc}

000088c4 <prefetch_abort_vector_c>:
    88c4:	e92d4038 	push	{r3, r4, r5, lr}
    88c8:	e1a05000 	mov	r5, r0
    88cc:	e1a04001 	mov	r4, r1
    88d0:	e30a0854 	movw	r0, #43092	; 0xa854
    88d4:	e3400000 	movt	r0, #0
    88d8:	eb000081 	bl	8ae4 <uart_puts>
    88dc:	e1a00005 	mov	r0, r5
    88e0:	e3a01010 	mov	r1, #16
    88e4:	eb0000af 	bl	8ba8 <uart_put_uint32_t>
    88e8:	e30a086c 	movw	r0, #43116	; 0xa86c
    88ec:	e3400000 	movt	r0, #0
    88f0:	eb00007b 	bl	8ae4 <uart_puts>
    88f4:	e1a00004 	mov	r0, r4
    88f8:	e3a01010 	mov	r1, #16
    88fc:	eb0000a9 	bl	8ba8 <uart_put_uint32_t>
    8900:	e30a0b28 	movw	r0, #43816	; 0xab28
    8904:	e3400000 	movt	r0, #0
    8908:	eb000075 	bl	8ae4 <uart_puts>
    890c:	e8bd8038 	pop	{r3, r4, r5, pc}

00008910 <data_abort_vector_c>:
    8910:	e92d4038 	push	{r3, r4, r5, lr}
    8914:	e1a05000 	mov	r5, r0
    8918:	e1a04001 	mov	r4, r1
    891c:	e30a087c 	movw	r0, #43132	; 0xa87c
    8920:	e3400000 	movt	r0, #0
    8924:	eb00006e 	bl	8ae4 <uart_puts>
    8928:	e1a00005 	mov	r0, r5
    892c:	e3a01010 	mov	r1, #16
    8930:	eb00009c 	bl	8ba8 <uart_put_uint32_t>
    8934:	e30a086c 	movw	r0, #43116	; 0xa86c
    8938:	e3400000 	movt	r0, #0
    893c:	eb000068 	bl	8ae4 <uart_puts>
    8940:	e1a00004 	mov	r0, r4
    8944:	e3a01010 	mov	r1, #16
    8948:	eb000096 	bl	8ba8 <uart_put_uint32_t>
    894c:	e30a0b28 	movw	r0, #43816	; 0xab28
    8950:	e3400000 	movt	r0, #0
    8954:	eb000062 	bl	8ae4 <uart_puts>
    8958:	e8bd8038 	pop	{r3, r4, r5, pc}

0000895c <interrupt_vector_c>:
    895c:	e92d4008 	push	{r3, lr}
    8960:	e3a03a0b 	mov	r3, #45056	; 0xb000
    8964:	e3433f00 	movt	r3, #16128	; 0x3f00
    8968:	e5933200 	ldr	r3, [r3, #512]	; 0x200
    896c:	e3130001 	tst	r3, #1
    8970:	0a000001 	beq	897c <interrupt_vector_c+0x20>
    8974:	eb000415 	bl	99d0 <time_handler>
    8978:	e8bd8008 	pop	{r3, pc}
    897c:	e3a03a0b 	mov	r3, #45056	; 0xb000
    8980:	e3433f00 	movt	r3, #16128	; 0x3f00
    8984:	e5933208 	ldr	r3, [r3, #520]	; 0x208
    8988:	e3130402 	tst	r3, #33554432	; 0x2000000
    898c:	0a000001 	beq	8998 <interrupt_vector_c+0x3c>
    8990:	eb0000a3 	bl	8c24 <uart_handler>
    8994:	e8bd8008 	pop	{r3, pc}
    8998:	e3a00000 	mov	r0, #0
    899c:	e8bd8008 	pop	{r3, pc}

000089a0 <fast_interrupt_vector>:
    89a0:	e24ee004 	sub	lr, lr, #4
    89a4:	e92d401f 	push	{r0, r1, r2, r3, r4, lr}
    89a8:	e30a0890 	movw	r0, #43152	; 0xa890
    89ac:	e3400000 	movt	r0, #0
    89b0:	eb00004b 	bl	8ae4 <uart_puts>
    89b4:	e8fd801f 	ldm	sp!, {r0, r1, r2, r3, r4, pc}^

000089b8 <_get_yield_val>:
    89b8:	e3a00002 	mov	r0, #2
    89bc:	e12fff1e 	bx	lr

000089c0 <delay>:
    89c0:	e2500001 	subs	r0, r0, #1
    89c4:	1afffffd 	bne	89c0 <delay>
    89c8:	e12fff1e 	bx	lr

000089cc <uart_init>:
    89cc:	e92d4038 	push	{r3, r4, r5, lr}
    89d0:	e3a04a01 	mov	r4, #4096	; 0x1000
    89d4:	e3434f20 	movt	r4, #16160	; 0x3f20
    89d8:	e3a05000 	mov	r5, #0
    89dc:	e5845030 	str	r5, [r4, #48]	; 0x30
    89e0:	ebffff7f 	bl	87e4 <get_gpio>
    89e4:	e5805094 	str	r5, [r0, #148]	; 0x94
    89e8:	e3a00096 	mov	r0, #150	; 0x96
    89ec:	ebfffff3 	bl	89c0 <delay>
    89f0:	ebffff7b 	bl	87e4 <get_gpio>
    89f4:	e3a03903 	mov	r3, #49152	; 0xc000
    89f8:	e5803098 	str	r3, [r0, #152]	; 0x98
    89fc:	e3a00096 	mov	r0, #150	; 0x96
    8a00:	ebffffee 	bl	89c0 <delay>
    8a04:	ebffff76 	bl	87e4 <get_gpio>
    8a08:	e5805094 	str	r5, [r0, #148]	; 0x94
    8a0c:	ebffff74 	bl	87e4 <get_gpio>
    8a10:	e5805098 	str	r5, [r0, #152]	; 0x98
    8a14:	e30037ff 	movw	r3, #2047	; 0x7ff
    8a18:	e5843044 	str	r3, [r4, #68]	; 0x44
    8a1c:	e3a03001 	mov	r3, #1
    8a20:	e5843024 	str	r3, [r4, #36]	; 0x24
    8a24:	e3a03028 	mov	r3, #40	; 0x28
    8a28:	e5843028 	str	r3, [r4, #40]	; 0x28
    8a2c:	e3a03060 	mov	r3, #96	; 0x60
    8a30:	e584302c 	str	r3, [r4, #44]	; 0x2c
    8a34:	e5943034 	ldr	r3, [r4, #52]	; 0x34
    8a38:	e5843034 	str	r3, [r4, #52]	; 0x34
    8a3c:	e5943038 	ldr	r3, [r4, #56]	; 0x38
    8a40:	e3833010 	orr	r3, r3, #16
    8a44:	e5843038 	str	r3, [r4, #56]	; 0x38
    8a48:	ebffff69 	bl	87f4 <irq_controller_get>
    8a4c:	e5903014 	ldr	r3, [r0, #20]
    8a50:	e3833402 	orr	r3, r3, #33554432	; 0x2000000
    8a54:	e5803014 	str	r3, [r0, #20]
    8a58:	e3003301 	movw	r3, #769	; 0x301
    8a5c:	e5843030 	str	r3, [r4, #48]	; 0x30
    8a60:	e8bd8038 	pop	{r3, r4, r5, pc}

00008a64 <uart_get>:
    8a64:	e3a00a01 	mov	r0, #4096	; 0x1000
    8a68:	e3430f20 	movt	r0, #16160	; 0x3f20
    8a6c:	e12fff1e 	bx	lr

00008a70 <uart_putc>:
    8a70:	e3a02a01 	mov	r2, #4096	; 0x1000
    8a74:	e3432f20 	movt	r2, #16160	; 0x3f20
    8a78:	e5923018 	ldr	r3, [r2, #24]
    8a7c:	e3130020 	tst	r3, #32
    8a80:	1afffffc 	bne	8a78 <uart_putc+0x8>
    8a84:	e3a03a01 	mov	r3, #4096	; 0x1000
    8a88:	e3433f20 	movt	r3, #16160	; 0x3f20
    8a8c:	e5830000 	str	r0, [r3]
    8a90:	e12fff1e 	bx	lr

00008a94 <uart_getc>:
    8a94:	e3a02a01 	mov	r2, #4096	; 0x1000
    8a98:	e3432f20 	movt	r2, #16160	; 0x3f20
    8a9c:	e5923018 	ldr	r3, [r2, #24]
    8aa0:	e3130010 	tst	r3, #16
    8aa4:	1afffffc 	bne	8a9c <uart_getc+0x8>
    8aa8:	e3a03a01 	mov	r3, #4096	; 0x1000
    8aac:	e3433f20 	movt	r3, #16160	; 0x3f20
    8ab0:	e5930000 	ldr	r0, [r3]
    8ab4:	e6ef0070 	uxtb	r0, r0
    8ab8:	e12fff1e 	bx	lr

00008abc <uart_write>:
    8abc:	e92d4038 	push	{r3, r4, r5, lr}
    8ac0:	e3510000 	cmp	r1, #0
    8ac4:	08bd8038 	popeq	{r3, r4, r5, pc}
    8ac8:	e1a04000 	mov	r4, r0
    8acc:	e0805001 	add	r5, r0, r1
    8ad0:	e4d40001 	ldrb	r0, [r4], #1
    8ad4:	ebffffe5 	bl	8a70 <uart_putc>
    8ad8:	e1540005 	cmp	r4, r5
    8adc:	1afffffb 	bne	8ad0 <uart_write+0x14>
    8ae0:	e8bd8038 	pop	{r3, r4, r5, pc}

00008ae4 <uart_puts>:
    8ae4:	e92d4010 	push	{r4, lr}
    8ae8:	e1a04000 	mov	r4, r0
    8aec:	fa00066f 	blx	a4b0 <strlen>
    8af0:	e1a01000 	mov	r1, r0
    8af4:	e1a00004 	mov	r0, r4
    8af8:	ebffffef 	bl	8abc <uart_write>
    8afc:	e8bd8010 	pop	{r4, pc}

00008b00 <uart_itoa>:
    8b00:	e92d41f0 	push	{r4, r5, r6, r7, r8, lr}
    8b04:	e1a04000 	mov	r4, r0
    8b08:	e1a07001 	mov	r7, r1
    8b0c:	e1a05002 	mov	r5, r2
    8b10:	e2423002 	sub	r3, r2, #2
    8b14:	e3530022 	cmp	r3, #34	; 0x22
    8b18:	83a03000 	movhi	r3, #0
    8b1c:	85c13000 	strbhi	r3, [r1]
    8b20:	8a00001e 	bhi	8ba0 <uart_itoa+0xa0>
    8b24:	e1a06001 	mov	r6, r1
    8b28:	e30a8898 	movw	r8, #43160	; 0xa898
    8b2c:	e3408000 	movt	r8, #0
    8b30:	e1a00004 	mov	r0, r4
    8b34:	e1a01005 	mov	r1, r5
    8b38:	fa0003c4 	blx	9a50 <__aeabi_idiv>
    8b3c:	e1a03006 	mov	r3, r6
    8b40:	e0624095 	mls	r2, r5, r0, r4
    8b44:	e0882002 	add	r2, r8, r2
    8b48:	e5d22023 	ldrb	r2, [r2, #35]	; 0x23
    8b4c:	e4c32001 	strb	r2, [r3], #1
    8b50:	e3500000 	cmp	r0, #0
    8b54:	11a04000 	movne	r4, r0
    8b58:	11a06003 	movne	r6, r3
    8b5c:	1afffff3 	bne	8b30 <uart_itoa+0x30>
    8b60:	e3540000 	cmp	r4, #0
    8b64:	b2863002 	addlt	r3, r6, #2
    8b68:	b3a0202d 	movlt	r2, #45	; 0x2d
    8b6c:	b5c62001 	strblt	r2, [r6, #1]
    8b70:	e2432001 	sub	r2, r3, #1
    8b74:	e3a01000 	mov	r1, #0
    8b78:	e5c31000 	strb	r1, [r3]
    8b7c:	e1570002 	cmp	r7, r2
    8b80:	2a000006 	bcs	8ba0 <uart_itoa+0xa0>
    8b84:	e1a03007 	mov	r3, r7
    8b88:	e5d21000 	ldrb	r1, [r2]
    8b8c:	e5d30000 	ldrb	r0, [r3]
    8b90:	e4420001 	strb	r0, [r2], #-1
    8b94:	e4c31001 	strb	r1, [r3], #1
    8b98:	e1520003 	cmp	r2, r3
    8b9c:	8afffff9 	bhi	8b88 <uart_itoa+0x88>
    8ba0:	e1a00007 	mov	r0, r7
    8ba4:	e8bd81f0 	pop	{r4, r5, r6, r7, r8, pc}

00008ba8 <uart_put_uint32_t>:
    8ba8:	e92d4030 	push	{r4, r5, lr}
    8bac:	e24dd02c 	sub	sp, sp, #44	; 0x2c
    8bb0:	e1a05000 	mov	r5, r0
    8bb4:	e1a04001 	mov	r4, r1
    8bb8:	e3510010 	cmp	r1, #16
    8bbc:	1a000003 	bne	8bd0 <uart_put_uint32_t+0x28>
    8bc0:	e30a08e0 	movw	r0, #43232	; 0xa8e0
    8bc4:	e3400000 	movt	r0, #0
    8bc8:	ebffffc5 	bl	8ae4 <uart_puts>
    8bcc:	ea000004 	b	8be4 <uart_put_uint32_t+0x3c>
    8bd0:	e3510002 	cmp	r1, #2
    8bd4:	1a000002 	bne	8be4 <uart_put_uint32_t+0x3c>
    8bd8:	e30a08e4 	movw	r0, #43236	; 0xa8e4
    8bdc:	e3400000 	movt	r0, #0
    8be0:	ebffffbf 	bl	8ae4 <uart_puts>
    8be4:	e1a00005 	mov	r0, r5
    8be8:	e28d1004 	add	r1, sp, #4
    8bec:	e1a02004 	mov	r2, r4
    8bf0:	ebffffc2 	bl	8b00 <uart_itoa>
    8bf4:	ebffffba 	bl	8ae4 <uart_puts>
    8bf8:	e28dd02c 	add	sp, sp, #44	; 0x2c
    8bfc:	e8bd8030 	pop	{r4, r5, pc}

00008c00 <print_alot>:
    8c00:	e92d4038 	push	{r3, r4, r5, lr}
    8c04:	e3a04014 	mov	r4, #20
    8c08:	e30a58e8 	movw	r5, #43240	; 0xa8e8
    8c0c:	e3405000 	movt	r5, #0
    8c10:	e1a00005 	mov	r0, r5
    8c14:	ebffffb2 	bl	8ae4 <uart_puts>
    8c18:	e2544001 	subs	r4, r4, #1
    8c1c:	1afffffb 	bne	8c10 <print_alot+0x10>
    8c20:	e8bd8038 	pop	{r3, r4, r5, pc}

00008c24 <uart_handler>:
    8c24:	e92d4008 	push	{r3, lr}
    8c28:	e30c300c 	movw	r3, #49164	; 0xc00c
    8c2c:	e3403000 	movt	r3, #0
    8c30:	e5933000 	ldr	r3, [r3]
    8c34:	e3530000 	cmp	r3, #0
    8c38:	0a000007 	beq	8c5c <uart_handler+0x38>
    8c3c:	ebfffee8 	bl	87e4 <get_gpio>
    8c40:	e3a03902 	mov	r3, #32768	; 0x8000
    8c44:	e5803020 	str	r3, [r0, #32]
    8c48:	e30c300c 	movw	r3, #49164	; 0xc00c
    8c4c:	e3403000 	movt	r3, #0
    8c50:	e3a02000 	mov	r2, #0
    8c54:	e5832000 	str	r2, [r3]
    8c58:	ea000006 	b	8c78 <uart_handler+0x54>
    8c5c:	ebfffee0 	bl	87e4 <get_gpio>
    8c60:	e3a03902 	mov	r3, #32768	; 0x8000
    8c64:	e580302c 	str	r3, [r0, #44]	; 0x2c
    8c68:	e30c300c 	movw	r3, #49164	; 0xc00c
    8c6c:	e3403000 	movt	r3, #0
    8c70:	e3a02001 	mov	r2, #1
    8c74:	e5832000 	str	r2, [r3]
    8c78:	e3a00000 	mov	r0, #0
    8c7c:	e8bd8008 	pop	{r3, pc}

00008c80 <cpu_control_config>:
    8c80:	e3013c27 	movw	r3, #7207	; 0x1c27
    8c84:	ee013f10 	mcr	15, 0, r3, cr1, cr0, {0}
    8c88:	e12fff1e 	bx	lr

00008c8c <cpu_set_irq_vectors_high>:
    8c8c:	ee113f10 	mrc	15, 0, r3, cr1, cr0, {0}
    8c90:	e3833a02 	orr	r3, r3, #8192	; 0x2000
    8c94:	ee113f10 	mrc	15, 0, r3, cr1, cr0, {0}
    8c98:	e12fff1e 	bx	lr

00008c9c <cpu_mode_print>:
    8c9c:	e92d4008 	push	{r3, lr}
    8ca0:	ebfffda5 	bl	833c <_get_cpsr>
    8ca4:	e200001f 	and	r0, r0, #31
    8ca8:	e2400010 	sub	r0, r0, #16
    8cac:	e350000f 	cmp	r0, #15
    8cb0:	979ff100 	ldrls	pc, [pc, r0, lsl #2]
    8cb4:	ea000032 	b	8d84 <cpu_mode_print+0xe8>
    8cb8:	00008cf8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    8cbc:	00008d0c 	andeq	r8, r0, ip, lsl #26
    8cc0:	00008d20 	andeq	r8, r0, r0, lsr #26
    8cc4:	00008d34 	andeq	r8, r0, r4, lsr sp
    8cc8:	00008d84 	andeq	r8, r0, r4, lsl #27
    8ccc:	00008d84 	andeq	r8, r0, r4, lsl #27
    8cd0:	00008d84 	andeq	r8, r0, r4, lsl #27
    8cd4:	00008d48 	andeq	r8, r0, r8, asr #26
    8cd8:	00008d84 	andeq	r8, r0, r4, lsl #27
    8cdc:	00008d84 	andeq	r8, r0, r4, lsl #27
    8ce0:	00008d84 	andeq	r8, r0, r4, lsl #27
    8ce4:	00008d5c 	andeq	r8, r0, ip, asr sp
    8ce8:	00008d84 	andeq	r8, r0, r4, lsl #27
    8cec:	00008d84 	andeq	r8, r0, r4, lsl #27
    8cf0:	00008d84 	andeq	r8, r0, r4, lsl #27
    8cf4:	00008d70 	andeq	r8, r0, r0, ror sp
    8cf8:	e30a092c 	movw	r0, #43308	; 0xa92c
    8cfc:	e3400000 	movt	r0, #0
    8d00:	ebffff77 	bl	8ae4 <uart_puts>
    8d04:	e3a00010 	mov	r0, #16
    8d08:	e8bd8008 	pop	{r3, pc}
    8d0c:	e30a0940 	movw	r0, #43328	; 0xa940
    8d10:	e3400000 	movt	r0, #0
    8d14:	ebffff72 	bl	8ae4 <uart_puts>
    8d18:	e3a00011 	mov	r0, #17
    8d1c:	e8bd8008 	pop	{r3, pc}
    8d20:	e30a0950 	movw	r0, #43344	; 0xa950
    8d24:	e3400000 	movt	r0, #0
    8d28:	ebffff6d 	bl	8ae4 <uart_puts>
    8d2c:	e3a00012 	mov	r0, #18
    8d30:	e8bd8008 	pop	{r3, pc}
    8d34:	e30a0960 	movw	r0, #43360	; 0xa960
    8d38:	e3400000 	movt	r0, #0
    8d3c:	ebffff68 	bl	8ae4 <uart_puts>
    8d40:	e3a00013 	mov	r0, #19
    8d44:	e8bd8008 	pop	{r3, pc}
    8d48:	e30a0970 	movw	r0, #43376	; 0xa970
    8d4c:	e3400000 	movt	r0, #0
    8d50:	ebffff63 	bl	8ae4 <uart_puts>
    8d54:	e3a00017 	mov	r0, #23
    8d58:	e8bd8008 	pop	{r3, pc}
    8d5c:	e30a0984 	movw	r0, #43396	; 0xa984
    8d60:	e3400000 	movt	r0, #0
    8d64:	ebffff5e 	bl	8ae4 <uart_puts>
    8d68:	e3a0001b 	mov	r0, #27
    8d6c:	e8bd8008 	pop	{r3, pc}
    8d70:	e30a099c 	movw	r0, #43420	; 0xa99c
    8d74:	e3400000 	movt	r0, #0
    8d78:	ebffff59 	bl	8ae4 <uart_puts>
    8d7c:	e3a0001f 	mov	r0, #31
    8d80:	e8bd8008 	pop	{r3, pc}
    8d84:	e8bd8008 	pop	{r3, pc}

00008d88 <prog1>:
    8d88:	e92d4ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
    8d8c:	e24dd00c 	sub	sp, sp, #12
    8d90:	e3a03000 	mov	r3, #0
    8d94:	e58d3004 	str	r3, [sp, #4]
    8d98:	e30a09b0 	movw	r0, #43440	; 0xa9b0
    8d9c:	e3400000 	movt	r0, #0
    8da0:	ebffff4f 	bl	8ae4 <uart_puts>
    8da4:	e3a04001 	mov	r4, #1
    8da8:	e30c7a6b 	movw	r7, #51819	; 0xca6b
    8dac:	e3467b5f 	movt	r7, #27487	; 0x6b5f
    8db0:	e3096680 	movw	r6, #38528	; 0x9680
    8db4:	e3406098 	movt	r6, #152	; 0x98
    8db8:	e30a99c8 	movw	r9, #43464	; 0xa9c8
    8dbc:	e3409000 	movt	r9, #0
    8dc0:	e3a0b00a 	mov	fp, #10
    8dc4:	e30a8b28 	movw	r8, #43816	; 0xab28
    8dc8:	e3408000 	movt	r8, #0
    8dcc:	e3a0a002 	mov	sl, #2
    8dd0:	e2844001 	add	r4, r4, #1
    8dd4:	e0832497 	umull	r2, r3, r7, r4
    8dd8:	e1a03b23 	lsr	r3, r3, #22
    8ddc:	e0634396 	mls	r3, r6, r3, r4
    8de0:	e3530000 	cmp	r3, #0
    8de4:	1afffff9 	bne	8dd0 <prog1+0x48>
    8de8:	e1a00009 	mov	r0, r9
    8dec:	ebffff3c 	bl	8ae4 <uart_puts>
    8df0:	e59d0004 	ldr	r0, [sp, #4]
    8df4:	e2800001 	add	r0, r0, #1
    8df8:	e28d5008 	add	r5, sp, #8
    8dfc:	e5250004 	str	r0, [r5, #-4]!
    8e00:	e1a0100b 	mov	r1, fp
    8e04:	ebffff67 	bl	8ba8 <uart_put_uint32_t>
    8e08:	e1a00008 	mov	r0, r8
    8e0c:	ebffff34 	bl	8ae4 <uart_puts>
    8e10:	e1a0000a 	mov	r0, sl
    8e14:	e1a01005 	mov	r1, r5
    8e18:	e3a02004 	mov	r2, #4
    8e1c:	eb000240 	bl	9724 <ipc_send>
    8e20:	eaffffea 	b	8dd0 <prog1+0x48>

00008e24 <prog2>:
    8e24:	e92d47f0 	push	{r4, r5, r6, r7, r8, r9, sl, lr}
    8e28:	e24dd008 	sub	sp, sp, #8
    8e2c:	e28d9008 	add	r9, sp, #8
    8e30:	e3a03000 	mov	r3, #0
    8e34:	e5293004 	str	r3, [r9, #-4]!
    8e38:	e30a09d8 	movw	r0, #43480	; 0xa9d8
    8e3c:	e3400000 	movt	r0, #0
    8e40:	ebffff27 	bl	8ae4 <uart_puts>
    8e44:	e30a89f0 	movw	r8, #43504	; 0xa9f0
    8e48:	e3408000 	movt	r8, #0
    8e4c:	e3a0a004 	mov	sl, #4
    8e50:	e30a7a0c 	movw	r7, #43532	; 0xaa0c
    8e54:	e3407000 	movt	r7, #0
    8e58:	e30a6a1c 	movw	r6, #43548	; 0xaa1c
    8e5c:	e3406000 	movt	r6, #0
    8e60:	e30a5b28 	movw	r5, #43816	; 0xab28
    8e64:	e3405000 	movt	r5, #0
    8e68:	e1a00008 	mov	r0, r8
    8e6c:	ebffff1c 	bl	8ae4 <uart_puts>
    8e70:	e1a00009 	mov	r0, r9
    8e74:	e1a0100a 	mov	r1, sl
    8e78:	eb000232 	bl	9748 <ipc_receive>
    8e7c:	e1a04000 	mov	r4, r0
    8e80:	e1a00007 	mov	r0, r7
    8e84:	ebffff16 	bl	8ae4 <uart_puts>
    8e88:	e59d0004 	ldr	r0, [sp, #4]
    8e8c:	e3a0100a 	mov	r1, #10
    8e90:	ebffff44 	bl	8ba8 <uart_put_uint32_t>
    8e94:	e1a00006 	mov	r0, r6
    8e98:	ebffff11 	bl	8ae4 <uart_puts>
    8e9c:	e1a00004 	mov	r0, r4
    8ea0:	e3a0100a 	mov	r1, #10
    8ea4:	ebffff3f 	bl	8ba8 <uart_put_uint32_t>
    8ea8:	e1a00005 	mov	r0, r5
    8eac:	ebffff0c 	bl	8ae4 <uart_puts>
    8eb0:	eaffffec 	b	8e68 <prog2+0x44>

00008eb4 <prog3>:
    8eb4:	e92d4010 	push	{r4, lr}
    8eb8:	e24dd008 	sub	sp, sp, #8
    8ebc:	e3a03000 	mov	r3, #0
    8ec0:	e58d3004 	str	r3, [sp, #4]
    8ec4:	e30a4a24 	movw	r4, #43556	; 0xaa24
    8ec8:	e3404000 	movt	r4, #0
    8ecc:	e59d3004 	ldr	r3, [sp, #4]
    8ed0:	e2833001 	add	r3, r3, #1
    8ed4:	e58d3004 	str	r3, [sp, #4]
    8ed8:	e1a00004 	mov	r0, r4
    8edc:	ebffff00 	bl	8ae4 <uart_puts>
    8ee0:	eafffff9 	b	8ecc <prog3+0x18>

00008ee4 <pcb_id_compare>:
    8ee4:	e1500001 	cmp	r0, r1
    8ee8:	13a00000 	movne	r0, #0
    8eec:	03a00001 	moveq	r0, #1
    8ef0:	e12fff1e 	bx	lr

00008ef4 <pcb_insert>:
    8ef4:	e24dd010 	sub	sp, sp, #16
    8ef8:	e92d4010 	push	{r4, lr}
    8efc:	e24dde22 	sub	sp, sp, #544	; 0x220
    8f00:	e28dcf8a 	add	ip, sp, #552	; 0x228
    8f04:	e88c000f 	stm	ip, {r0, r1, r2, r3}
    8f08:	e3a04e22 	mov	r4, #544	; 0x220
    8f0c:	e1a0000d 	mov	r0, sp
    8f10:	e1a0100c 	mov	r1, ip
    8f14:	e1a02004 	mov	r2, r4
    8f18:	fa0004db 	blx	a28c <memcpy>
    8f1c:	e1a00004 	mov	r0, r4
    8f20:	fa000377 	blx	9d04 <malloc>
    8f24:	e2504000 	subs	r4, r0, #0
    8f28:	1a000004 	bne	8f40 <pcb_insert+0x4c>
    8f2c:	e30a0a5c 	movw	r0, #43612	; 0xaa5c
    8f30:	e3400000 	movt	r0, #0
    8f34:	ebfffeea 	bl	8ae4 <uart_puts>
    8f38:	e3e00000 	mvn	r0, #0
    8f3c:	ea000015 	b	8f98 <pcb_insert+0xa4>
    8f40:	e1a00004 	mov	r0, r4
    8f44:	e1a0100d 	mov	r1, sp
    8f48:	e3a02e22 	mov	r2, #544	; 0x220
    8f4c:	fa0004ce 	blx	a28c <memcpy>
    8f50:	e3a03000 	mov	r3, #0
    8f54:	e5843018 	str	r3, [r4, #24]
    8f58:	e5843014 	str	r3, [r4, #20]
    8f5c:	e5843010 	str	r3, [r4, #16]
    8f60:	e30c3010 	movw	r3, #49168	; 0xc010
    8f64:	e3403000 	movt	r3, #0
    8f68:	e5933000 	ldr	r3, [r3]
    8f6c:	e3530000 	cmp	r3, #0
    8f70:	030c3010 	movweq	r3, #49168	; 0xc010
    8f74:	03403000 	movteq	r3, #0
    8f78:	05834000 	streq	r4, [r3]
    8f7c:	05834004 	streq	r4, [r3, #4]
    8f80:	15834014 	strne	r4, [r3, #20]
    8f84:	15843010 	strne	r3, [r4, #16]
    8f88:	130c3010 	movwne	r3, #49168	; 0xc010
    8f8c:	13403000 	movtne	r3, #0
    8f90:	15834000 	strne	r4, [r3]
    8f94:	e3a00001 	mov	r0, #1
    8f98:	e28dde22 	add	sp, sp, #544	; 0x220
    8f9c:	e8bd4010 	pop	{r4, lr}
    8fa0:	e28dd010 	add	sp, sp, #16
    8fa4:	e12fff1e 	bx	lr

00008fa8 <pcb_get>:
    8fa8:	e30c3010 	movw	r3, #49168	; 0xc010
    8fac:	e3403000 	movt	r3, #0
    8fb0:	e5933000 	ldr	r3, [r3]
    8fb4:	e3530000 	cmp	r3, #0
    8fb8:	0a000008 	beq	8fe0 <pcb_get+0x38>
    8fbc:	ea000002 	b	8fcc <pcb_get+0x24>
    8fc0:	e5933010 	ldr	r3, [r3, #16]
    8fc4:	e3530000 	cmp	r3, #0
    8fc8:	0a000006 	beq	8fe8 <pcb_get+0x40>
    8fcc:	e5932000 	ldr	r2, [r3]
    8fd0:	e1520000 	cmp	r2, r0
    8fd4:	1afffff9 	bne	8fc0 <pcb_get+0x18>
    8fd8:	e1a00003 	mov	r0, r3
    8fdc:	e12fff1e 	bx	lr
    8fe0:	e3a00000 	mov	r0, #0
    8fe4:	e12fff1e 	bx	lr
    8fe8:	e3a00000 	mov	r0, #0
    8fec:	e12fff1e 	bx	lr

00008ff0 <save_stack_ptr>:
    8ff0:	e92d4010 	push	{r4, lr}
    8ff4:	e1a04001 	mov	r4, r1
    8ff8:	ebffffea 	bl	8fa8 <pcb_get>
    8ffc:	e3500000 	cmp	r0, #0
    9000:	1580400c 	strne	r4, [r0, #12]
    9004:	18bd8010 	popne	{r4, pc}
    9008:	e30a0a74 	movw	r0, #43636	; 0xaa74
    900c:	e3400000 	movt	r0, #0
    9010:	ebfffeb3 	bl	8ae4 <uart_puts>
    9014:	e8bd8010 	pop	{r4, pc}

00009018 <pcb_print>:
    9018:	e92d4070 	push	{r4, r5, r6, lr}
    901c:	e30c3010 	movw	r3, #49168	; 0xc010
    9020:	e3403000 	movt	r3, #0
    9024:	e5934000 	ldr	r4, [r3]
    9028:	e30a0a98 	movw	r0, #43672	; 0xaa98
    902c:	e3400000 	movt	r0, #0
    9030:	ebfffeab 	bl	8ae4 <uart_puts>
    9034:	e3540000 	cmp	r4, #0
    9038:	0a00000a 	beq	9068 <pcb_print+0x50>
    903c:	e3a0600a 	mov	r6, #10
    9040:	e30a5aac 	movw	r5, #43692	; 0xaaac
    9044:	e3405000 	movt	r5, #0
    9048:	e5940000 	ldr	r0, [r4]
    904c:	e1a01006 	mov	r1, r6
    9050:	ebfffed4 	bl	8ba8 <uart_put_uint32_t>
    9054:	e1a00005 	mov	r0, r5
    9058:	ebfffea1 	bl	8ae4 <uart_puts>
    905c:	e5944010 	ldr	r4, [r4, #16]
    9060:	e3540000 	cmp	r4, #0
    9064:	1afffff7 	bne	9048 <pcb_print+0x30>
    9068:	e30a0b28 	movw	r0, #43816	; 0xab28
    906c:	e3400000 	movt	r0, #0
    9070:	ebfffe9b 	bl	8ae4 <uart_puts>
    9074:	e8bd8070 	pop	{r4, r5, r6, pc}

00009078 <pcb_remove>:
    9078:	e92d4038 	push	{r3, r4, r5, lr}
    907c:	e30c3010 	movw	r3, #49168	; 0xc010
    9080:	e3403000 	movt	r3, #0
    9084:	e5931000 	ldr	r1, [r3]
    9088:	e3510000 	cmp	r1, #0
    908c:	0a000035 	beq	9168 <pcb_remove+0xf0>
    9090:	e1a03001 	mov	r3, r1
    9094:	ea000002 	b	90a4 <pcb_remove+0x2c>
    9098:	e5933010 	ldr	r3, [r3, #16]
    909c:	e3530000 	cmp	r3, #0
    90a0:	0a000032 	beq	9170 <pcb_remove+0xf8>
    90a4:	e5932000 	ldr	r2, [r3]
    90a8:	e1520000 	cmp	r2, r0
    90ac:	1afffff9 	bne	9098 <pcb_remove+0x20>
    90b0:	e30c2010 	movw	r2, #49168	; 0xc010
    90b4:	e3402000 	movt	r2, #0
    90b8:	e5922004 	ldr	r2, [r2, #4]
    90bc:	e1510002 	cmp	r1, r2
    90c0:	1a000008 	bne	90e8 <pcb_remove+0x70>
    90c4:	e1a00003 	mov	r0, r3
    90c8:	fa000311 	blx	9d14 <free>
    90cc:	e30c3010 	movw	r3, #49168	; 0xc010
    90d0:	e3403000 	movt	r3, #0
    90d4:	e3a02000 	mov	r2, #0
    90d8:	e5832000 	str	r2, [r3]
    90dc:	e5832004 	str	r2, [r3, #4]
    90e0:	e3a00001 	mov	r0, #1
    90e4:	e8bd8038 	pop	{r3, r4, r5, pc}
    90e8:	e1530001 	cmp	r3, r1
    90ec:	1a000009 	bne	9118 <pcb_remove+0xa0>
    90f0:	e5934010 	ldr	r4, [r3, #16]
    90f4:	e1a00003 	mov	r0, r3
    90f8:	fa000305 	blx	9d14 <free>
    90fc:	e30c3010 	movw	r3, #49168	; 0xc010
    9100:	e3403000 	movt	r3, #0
    9104:	e5834000 	str	r4, [r3]
    9108:	e3a03000 	mov	r3, #0
    910c:	e5843014 	str	r3, [r4, #20]
    9110:	e3a00001 	mov	r0, #1
    9114:	e8bd8038 	pop	{r3, r4, r5, pc}
    9118:	e1530002 	cmp	r3, r2
    911c:	1a000009 	bne	9148 <pcb_remove+0xd0>
    9120:	e5934014 	ldr	r4, [r3, #20]
    9124:	e1a00003 	mov	r0, r3
    9128:	fa0002f9 	blx	9d14 <free>
    912c:	e30c3010 	movw	r3, #49168	; 0xc010
    9130:	e3403000 	movt	r3, #0
    9134:	e5834004 	str	r4, [r3, #4]
    9138:	e3a03000 	mov	r3, #0
    913c:	e5843010 	str	r3, [r4, #16]
    9140:	e3a00001 	mov	r0, #1
    9144:	e8bd8038 	pop	{r3, r4, r5, pc}
    9148:	e5935014 	ldr	r5, [r3, #20]
    914c:	e5934010 	ldr	r4, [r3, #16]
    9150:	e5940014 	ldr	r0, [r4, #20]
    9154:	fa0002ee 	blx	9d14 <free>
    9158:	e5854010 	str	r4, [r5, #16]
    915c:	e5845014 	str	r5, [r4, #20]
    9160:	e3a00001 	mov	r0, #1
    9164:	e8bd8038 	pop	{r3, r4, r5, pc}
    9168:	e3e00000 	mvn	r0, #0
    916c:	e8bd8038 	pop	{r3, r4, r5, pc}
    9170:	e3e00000 	mvn	r0, #0
    9174:	e8bd8038 	pop	{r3, r4, r5, pc}

00009178 <thread_register>:
    9178:	e92d40f0 	push	{r4, r5, r6, r7, lr}
    917c:	e24dde43 	sub	sp, sp, #1072	; 0x430
    9180:	e24dd004 	sub	sp, sp, #4
    9184:	e1a05000 	mov	r5, r0
    9188:	e1a06001 	mov	r6, r1
    918c:	e1a04002 	mov	r4, r2
    9190:	e1a07003 	mov	r7, r3
    9194:	e28d0e21 	add	r0, sp, #528	; 0x210
    9198:	e3a01000 	mov	r1, #0
    919c:	e3a02e22 	mov	r2, #544	; 0x220
    91a0:	fa000463 	blx	a334 <memset>
    91a4:	e58d7210 	str	r7, [sp, #528]	; 0x210
    91a8:	e3a03001 	mov	r3, #1
    91ac:	e5cd3214 	strb	r3, [sp, #532]	; 0x214
    91b0:	e58d6218 	str	r6, [sp, #536]	; 0x218
    91b4:	e1a00004 	mov	r0, r4
    91b8:	fa0002d1 	blx	9d04 <malloc>
    91bc:	e3500000 	cmp	r0, #0
    91c0:	1a000004 	bne	91d8 <thread_register+0x60>
    91c4:	e30a0ab0 	movw	r0, #43696	; 0xaab0
    91c8:	e3400000 	movt	r0, #0
    91cc:	ebfffe44 	bl	8ae4 <uart_puts>
    91d0:	e3e00000 	mvn	r0, #0
    91d4:	ea00001c 	b	924c <thread_register+0xd4>
    91d8:	e0800004 	add	r0, r0, r4
    91dc:	e1a01005 	mov	r1, r5
    91e0:	e5dd2448 	ldrb	r2, [sp, #1096]	; 0x448
    91e4:	ebfffc5c 	bl	835c <_init_thr_stack>
    91e8:	e1a04000 	mov	r4, r0
    91ec:	e58d021c 	str	r0, [sp, #540]	; 0x21c
    91f0:	e1a0000d 	mov	r0, sp
    91f4:	e28d1e22 	add	r1, sp, #544	; 0x220
    91f8:	e3a02e21 	mov	r2, #528	; 0x210
    91fc:	fa000422 	blx	a28c <memcpy>
    9200:	e28d3e21 	add	r3, sp, #528	; 0x210
    9204:	e893000f 	ldm	r3, {r0, r1, r2, r3}
    9208:	ebffff39 	bl	8ef4 <pcb_insert>
    920c:	e30a0ad4 	movw	r0, #43732	; 0xaad4
    9210:	e3400000 	movt	r0, #0
    9214:	ebfffe32 	bl	8ae4 <uart_puts>
    9218:	e1a00004 	mov	r0, r4
    921c:	e3a01010 	mov	r1, #16
    9220:	ebfffe60 	bl	8ba8 <uart_put_uint32_t>
    9224:	e30a0af0 	movw	r0, #43760	; 0xaaf0
    9228:	e3400000 	movt	r0, #0
    922c:	ebfffe2c 	bl	8ae4 <uart_puts>
    9230:	e1a00005 	mov	r0, r5
    9234:	e3a01010 	mov	r1, #16
    9238:	ebfffe5a 	bl	8ba8 <uart_put_uint32_t>
    923c:	e30a0b28 	movw	r0, #43816	; 0xab28
    9240:	e3400000 	movt	r0, #0
    9244:	ebfffe26 	bl	8ae4 <uart_puts>
    9248:	e3a00001 	mov	r0, #1
    924c:	e28dde43 	add	sp, sp, #1072	; 0x430
    9250:	e28dd004 	add	sp, sp, #4
    9254:	e8bd80f0 	pop	{r4, r5, r6, r7, pc}

00009258 <thread_start>:
    9258:	e92d4010 	push	{r4, lr}
    925c:	e1a04000 	mov	r4, r0
    9260:	ebffff50 	bl	8fa8 <pcb_get>
    9264:	e3500000 	cmp	r0, #0
    9268:	1a000004 	bne	9280 <thread_start+0x28>
    926c:	e30a0b08 	movw	r0, #43784	; 0xab08
    9270:	e3400000 	movt	r0, #0
    9274:	ebfffe1a 	bl	8ae4 <uart_puts>
    9278:	e3e00000 	mvn	r0, #0
    927c:	e8bd8010 	pop	{r4, pc}
    9280:	e1a00004 	mov	r0, r4
    9284:	eb00003a 	bl	9374 <scheduler_enqueue>
    9288:	e8bd8010 	pop	{r4, pc}

0000928c <init_pri_array>:
    928c:	e3a02000 	mov	r2, #0
    9290:	e30c0018 	movw	r0, #49176	; 0xc018
    9294:	e3400000 	movt	r0, #0
    9298:	e1a01002 	mov	r1, r2
    929c:	e1a03000 	mov	r3, r0
    92a0:	e7a31002 	str	r1, [r3, r2]!
    92a4:	e5831004 	str	r1, [r3, #4]
    92a8:	e2822008 	add	r2, r2, #8
    92ac:	e3520c02 	cmp	r2, #512	; 0x200
    92b0:	1afffff9 	bne	929c <init_pri_array+0x10>
    92b4:	e12fff1e 	bx	lr

000092b8 <priority_print_list>:
    92b8:	e92d4ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
    92bc:	e24dd00c 	sub	sp, sp, #12
    92c0:	e30a0b14 	movw	r0, #43796	; 0xab14
    92c4:	e3400000 	movt	r0, #0
    92c8:	ebfffe05 	bl	8ae4 <uart_puts>
    92cc:	e30c9018 	movw	r9, #49176	; 0xc018
    92d0:	e3409000 	movt	r9, #0
    92d4:	e3a0803f 	mov	r8, #63	; 0x3f
    92d8:	e30abb2c 	movw	fp, #43820	; 0xab2c
    92dc:	e340b000 	movt	fp, #0
    92e0:	e3a0600a 	mov	r6, #10
    92e4:	e30aab3c 	movw	sl, #43836	; 0xab3c
    92e8:	e340a000 	movt	sl, #0
    92ec:	e30a7aac 	movw	r7, #43692	; 0xaaac
    92f0:	e3407000 	movt	r7, #0
    92f4:	e30a3b28 	movw	r3, #43816	; 0xab28
    92f8:	e3403000 	movt	r3, #0
    92fc:	e58d3004 	str	r3, [sp, #4]
    9300:	e59941f8 	ldr	r4, [r9, #504]	; 0x1f8
    9304:	e3540000 	cmp	r4, #0
    9308:	0a000013 	beq	935c <priority_print_list+0xa4>
    930c:	e1a0000b 	mov	r0, fp
    9310:	ebfffdf3 	bl	8ae4 <uart_puts>
    9314:	e1a00008 	mov	r0, r8
    9318:	e1a01006 	mov	r1, r6
    931c:	ebfffe21 	bl	8ba8 <uart_put_uint32_t>
    9320:	e1a0000a 	mov	r0, sl
    9324:	ebfffdee 	bl	8ae4 <uart_puts>
    9328:	e3a0500c 	mov	r5, #12
    932c:	e5940000 	ldr	r0, [r4]
    9330:	e1a01006 	mov	r1, r6
    9334:	ebfffe1b 	bl	8ba8 <uart_put_uint32_t>
    9338:	e1a00007 	mov	r0, r7
    933c:	ebfffde8 	bl	8ae4 <uart_puts>
    9340:	e5944004 	ldr	r4, [r4, #4]
    9344:	e3540000 	cmp	r4, #0
    9348:	0a000001 	beq	9354 <priority_print_list+0x9c>
    934c:	e2555001 	subs	r5, r5, #1
    9350:	1afffff5 	bne	932c <priority_print_list+0x74>
    9354:	e59d0004 	ldr	r0, [sp, #4]
    9358:	ebfffde1 	bl	8ae4 <uart_puts>
    935c:	e2488001 	sub	r8, r8, #1
    9360:	e2499008 	sub	r9, r9, #8
    9364:	e3780001 	cmn	r8, #1
    9368:	1affffe4 	bne	9300 <priority_print_list+0x48>
    936c:	e28dd00c 	add	sp, sp, #12
    9370:	e8bd8ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}

00009374 <scheduler_enqueue>:
    9374:	e92d4038 	push	{r3, r4, r5, lr}
    9378:	e1a05000 	mov	r5, r0
    937c:	e3a0000c 	mov	r0, #12
    9380:	fa00025f 	blx	9d04 <malloc>
    9384:	e2504000 	subs	r4, r0, #0
    9388:	15845000 	strne	r5, [r4]
    938c:	13a03000 	movne	r3, #0
    9390:	15843004 	strne	r3, [r4, #4]
    9394:	15843008 	strne	r3, [r4, #8]
    9398:	1a000003 	bne	93ac <scheduler_enqueue+0x38>
    939c:	e30a0b40 	movw	r0, #43840	; 0xab40
    93a0:	e3400000 	movt	r0, #0
    93a4:	ebfffdce 	bl	8ae4 <uart_puts>
    93a8:	eaffffff 	b	93ac <scheduler_enqueue+0x38>
    93ac:	e1a00005 	mov	r0, r5
    93b0:	ebfffefc 	bl	8fa8 <pcb_get>
    93b4:	e3500000 	cmp	r0, #0
    93b8:	0a000025 	beq	9454 <scheduler_enqueue+0xe0>
    93bc:	e5d03004 	ldrb	r3, [r0, #4]
    93c0:	e3530001 	cmp	r3, #1
    93c4:	1a000024 	bne	945c <scheduler_enqueue+0xe8>
    93c8:	e5905008 	ldr	r5, [r0, #8]
    93cc:	e355003f 	cmp	r5, #63	; 0x3f
    93d0:	9a00000a 	bls	9400 <scheduler_enqueue+0x8c>
    93d4:	e30a0b68 	movw	r0, #43880	; 0xab68
    93d8:	e3400000 	movt	r0, #0
    93dc:	ebfffdc0 	bl	8ae4 <uart_puts>
    93e0:	e1a00005 	mov	r0, r5
    93e4:	e3a0100a 	mov	r1, #10
    93e8:	ebfffdee 	bl	8ba8 <uart_put_uint32_t>
    93ec:	e30a0b28 	movw	r0, #43816	; 0xab28
    93f0:	e3400000 	movt	r0, #0
    93f4:	ebfffdba 	bl	8ae4 <uart_puts>
    93f8:	e3e00000 	mvn	r0, #0
    93fc:	e8bd8038 	pop	{r3, r4, r5, pc}
    9400:	e30c3018 	movw	r3, #49176	; 0xc018
    9404:	e3403000 	movt	r3, #0
    9408:	e0833185 	add	r3, r3, r5, lsl #3
    940c:	e5933004 	ldr	r3, [r3, #4]
    9410:	e3530000 	cmp	r3, #0
    9414:	1a000006 	bne	9434 <scheduler_enqueue+0xc0>
    9418:	e30c3018 	movw	r3, #49176	; 0xc018
    941c:	e3403000 	movt	r3, #0
    9420:	e7834185 	str	r4, [r3, r5, lsl #3]
    9424:	e0833185 	add	r3, r3, r5, lsl #3
    9428:	e5834004 	str	r4, [r3, #4]
    942c:	e3a00001 	mov	r0, #1
    9430:	e8bd8038 	pop	{r3, r4, r5, pc}
    9434:	e5834004 	str	r4, [r3, #4]
    9438:	e5843008 	str	r3, [r4, #8]
    943c:	e30c3018 	movw	r3, #49176	; 0xc018
    9440:	e3403000 	movt	r3, #0
    9444:	e0835185 	add	r5, r3, r5, lsl #3
    9448:	e5854004 	str	r4, [r5, #4]
    944c:	e3a00001 	mov	r0, #1
    9450:	e8bd8038 	pop	{r3, r4, r5, pc}
    9454:	e3e00000 	mvn	r0, #0
    9458:	e8bd8038 	pop	{r3, r4, r5, pc}
    945c:	e3a00000 	mov	r0, #0
    9460:	e8bd8038 	pop	{r3, r4, r5, pc}

00009464 <reschedule>:
    9464:	e92d40f8 	push	{r3, r4, r5, r6, r7, lr}
    9468:	e30a3cdc 	movw	r3, #44252	; 0xacdc
    946c:	e3403000 	movt	r3, #0
    9470:	e5930000 	ldr	r0, [r3]
    9474:	e3e01000 	mvn	r1, #0
    9478:	ebfffe99 	bl	8ee4 <pcb_id_compare>
    947c:	e3500000 	cmp	r0, #0
    9480:	1a00002a 	bne	9530 <reschedule+0xcc>
    9484:	e30a3cdc 	movw	r3, #44252	; 0xacdc
    9488:	e3403000 	movt	r3, #0
    948c:	e5930000 	ldr	r0, [r3]
    9490:	ebffffb7 	bl	9374 <scheduler_enqueue>
    9494:	e3700001 	cmn	r0, #1
    9498:	1a000024 	bne	9530 <reschedule+0xcc>
    949c:	e30a0b80 	movw	r0, #43904	; 0xab80
    94a0:	e3400000 	movt	r0, #0
    94a4:	ebfffd8e 	bl	8ae4 <uart_puts>
    94a8:	ea000020 	b	9530 <reschedule+0xcc>
    94ac:	e3540040 	cmp	r4, #64	; 0x40
    94b0:	8a00000e 	bhi	94f0 <reschedule+0x8c>
    94b4:	e59501f8 	ldr	r0, [r5, #504]	; 0x1f8
    94b8:	e3500000 	cmp	r0, #0
    94bc:	0a00000b 	beq	94f0 <reschedule+0x8c>
    94c0:	e59521fc 	ldr	r2, [r5, #508]	; 0x1fc
    94c4:	e1500002 	cmp	r0, r2
    94c8:	058571f8 	streq	r7, [r5, #504]	; 0x1f8
    94cc:	058571fc 	streq	r7, [r5, #508]	; 0x1fc
    94d0:	15902004 	ldrne	r2, [r0, #4]
    94d4:	15827008 	strne	r7, [r2, #8]
    94d8:	15902004 	ldrne	r2, [r0, #4]
    94dc:	158521f8 	strne	r2, [r5, #504]	; 0x1f8
    94e0:	e5906000 	ldr	r6, [r0]
    94e4:	fa00020a 	blx	9d14 <free>
    94e8:	e3560000 	cmp	r6, #0
    94ec:	aa000007 	bge	9510 <reschedule+0xac>
    94f0:	e2444001 	sub	r4, r4, #1
    94f4:	e2455008 	sub	r5, r5, #8
    94f8:	e3740001 	cmn	r4, #1
    94fc:	1affffea 	bne	94ac <reschedule+0x48>
    9500:	e30a0ba4 	movw	r0, #43940	; 0xaba4
    9504:	e3400000 	movt	r0, #0
    9508:	ebfffd75 	bl	8ae4 <uart_puts>
    950c:	e3e06000 	mvn	r6, #0
    9510:	e30c2018 	movw	r2, #49176	; 0xc018
    9514:	e3402000 	movt	r2, #0
    9518:	e30a3cdc 	movw	r3, #44252	; 0xacdc
    951c:	e3403000 	movt	r3, #0
    9520:	e5931000 	ldr	r1, [r3]
    9524:	e5821200 	str	r1, [r2, #512]	; 0x200
    9528:	e5836000 	str	r6, [r3]
    952c:	e8bd80f8 	pop	{r3, r4, r5, r6, r7, pc}
    9530:	e30c5018 	movw	r5, #49176	; 0xc018
    9534:	e3405000 	movt	r5, #0
    9538:	e3a0403f 	mov	r4, #63	; 0x3f
    953c:	e3a07000 	mov	r7, #0
    9540:	eaffffd9 	b	94ac <reschedule+0x48>

00009544 <context_switch_c>:
    9544:	e92d4010 	push	{r4, lr}
    9548:	e1a04000 	mov	r4, r0
    954c:	e30c3018 	movw	r3, #49176	; 0xc018
    9550:	e3403000 	movt	r3, #0
    9554:	e5930200 	ldr	r0, [r3, #512]	; 0x200
    9558:	ebfffe92 	bl	8fa8 <pcb_get>
    955c:	e3500000 	cmp	r0, #0
    9560:	1a000003 	bne	9574 <context_switch_c+0x30>
    9564:	e30a0bd0 	movw	r0, #43984	; 0xabd0
    9568:	e3400000 	movt	r0, #0
    956c:	ebfffd5c 	bl	8ae4 <uart_puts>
    9570:	ea000004 	b	9588 <context_switch_c+0x44>
    9574:	e30c3018 	movw	r3, #49176	; 0xc018
    9578:	e3403000 	movt	r3, #0
    957c:	e5930200 	ldr	r0, [r3, #512]	; 0x200
    9580:	ebfffe88 	bl	8fa8 <pcb_get>
    9584:	e580400c 	str	r4, [r0, #12]
    9588:	e30a3cdc 	movw	r3, #44252	; 0xacdc
    958c:	e3403000 	movt	r3, #0
    9590:	e5930000 	ldr	r0, [r3]
    9594:	ebfffe83 	bl	8fa8 <pcb_get>
    9598:	e3500000 	cmp	r0, #0
    959c:	1a000004 	bne	95b4 <context_switch_c+0x70>
    95a0:	e30a0bfc 	movw	r0, #44028	; 0xabfc
    95a4:	e3400000 	movt	r0, #0
    95a8:	ebfffd4d 	bl	8ae4 <uart_puts>
    95ac:	e3a00000 	mov	r0, #0
    95b0:	e8bd8010 	pop	{r4, pc}
    95b4:	e30a3cdc 	movw	r3, #44252	; 0xacdc
    95b8:	e3403000 	movt	r3, #0
    95bc:	e5930000 	ldr	r0, [r3]
    95c0:	ebfffe78 	bl	8fa8 <pcb_get>
    95c4:	e590000c 	ldr	r0, [r0, #12]
    95c8:	e8bd8010 	pop	{r4, pc}

000095cc <_print_reg>:
    95cc:	e92d4010 	push	{r4, lr}
    95d0:	e1a04000 	mov	r4, r0
    95d4:	e30a0c28 	movw	r0, #44072	; 0xac28
    95d8:	e3400000 	movt	r0, #0
    95dc:	ebfffd40 	bl	8ae4 <uart_puts>
    95e0:	e1a00004 	mov	r0, r4
    95e4:	e3a01010 	mov	r1, #16
    95e8:	ebfffd6e 	bl	8ba8 <uart_put_uint32_t>
    95ec:	e30a0b28 	movw	r0, #43816	; 0xab28
    95f0:	e3400000 	movt	r0, #0
    95f4:	ebfffd3a 	bl	8ae4 <uart_puts>
    95f8:	e8bd8010 	pop	{r4, pc}

000095fc <_get_stack_top>:
    95fc:	e92d4010 	push	{r4, lr}
    9600:	e1a04000 	mov	r4, r0
    9604:	e30a0c34 	movw	r0, #44084	; 0xac34
    9608:	e3400000 	movt	r0, #0
    960c:	ebfffd34 	bl	8ae4 <uart_puts>
    9610:	e5940000 	ldr	r0, [r4]
    9614:	e3a01010 	mov	r1, #16
    9618:	ebfffd62 	bl	8ba8 <uart_put_uint32_t>
    961c:	e30a0b28 	movw	r0, #43816	; 0xab28
    9620:	e3400000 	movt	r0, #0
    9624:	ebfffd2e 	bl	8ae4 <uart_puts>
    9628:	e8bd8010 	pop	{r4, pc}

0000962c <get_current_running_process>:
    962c:	e30a3cdc 	movw	r3, #44252	; 0xacdc
    9630:	e3403000 	movt	r3, #0
    9634:	e5930000 	ldr	r0, [r3]
    9638:	e12fff1e 	bx	lr

0000963c <ipc_msg_enqueue>:
    963c:	e92d40f8 	push	{r3, r4, r5, r6, r7, lr}
    9640:	e1a07000 	mov	r7, r0
    9644:	e1a06001 	mov	r6, r1
    9648:	e1a05002 	mov	r5, r2
    964c:	e281000c 	add	r0, r1, #12
    9650:	fa0001ab 	blx	9d04 <malloc>
    9654:	e2504000 	subs	r4, r0, #0
    9658:	1a000003 	bne	966c <ipc_msg_enqueue+0x30>
    965c:	e30a0c4c 	movw	r0, #44108	; 0xac4c
    9660:	e3400000 	movt	r0, #0
    9664:	ebfffd1e 	bl	8ae4 <uart_puts>
    9668:	ea000008 	b	9690 <ipc_msg_enqueue+0x54>
    966c:	e284000c 	add	r0, r4, #12
    9670:	e1a01007 	mov	r1, r7
    9674:	e1a02006 	mov	r2, r6
    9678:	fa000303 	blx	a28c <memcpy>
    967c:	ebffffea 	bl	962c <get_current_running_process>
    9680:	e5840000 	str	r0, [r4]
    9684:	e3a03000 	mov	r3, #0
    9688:	e5843004 	str	r3, [r4, #4]
    968c:	e5843008 	str	r3, [r4, #8]
    9690:	e1a00005 	mov	r0, r5
    9694:	ebfffe43 	bl	8fa8 <pcb_get>
    9698:	e3500000 	cmp	r0, #0
    969c:	1a00000a 	bne	96cc <ipc_msg_enqueue+0x90>
    96a0:	e30a0c78 	movw	r0, #44152	; 0xac78
    96a4:	e3400000 	movt	r0, #0
    96a8:	ebfffd0d 	bl	8ae4 <uart_puts>
    96ac:	e1a00005 	mov	r0, r5
    96b0:	e3a0100a 	mov	r1, #10
    96b4:	ebfffd3b 	bl	8ba8 <uart_put_uint32_t>
    96b8:	e30a0b28 	movw	r0, #43816	; 0xab28
    96bc:	e3400000 	movt	r0, #0
    96c0:	ebfffd07 	bl	8ae4 <uart_puts>
    96c4:	e3e00000 	mvn	r0, #0
    96c8:	e8bd80f8 	pop	{r3, r4, r5, r6, r7, pc}
    96cc:	e1a00005 	mov	r0, r5
    96d0:	ebfffe34 	bl	8fa8 <pcb_get>
    96d4:	e1a05000 	mov	r5, r0
    96d8:	ebffffd3 	bl	962c <get_current_running_process>
    96dc:	ebfffe31 	bl	8fa8 <pcb_get>
    96e0:	e5903008 	ldr	r3, [r0, #8]
    96e4:	e353003f 	cmp	r3, #63	; 0x3f
    96e8:	9a000004 	bls	9700 <ipc_msg_enqueue+0xc4>
    96ec:	e30a0ca8 	movw	r0, #44200	; 0xaca8
    96f0:	e3400000 	movt	r0, #0
    96f4:	ebfffcfa 	bl	8ae4 <uart_puts>
    96f8:	e3e00000 	mvn	r0, #0
    96fc:	e8bd80f8 	pop	{r3, r4, r5, r6, r7, pc}
    9700:	e0850183 	add	r0, r5, r3, lsl #3
    9704:	e5903024 	ldr	r3, [r0, #36]	; 0x24
    9708:	e3530000 	cmp	r3, #0
    970c:	05804020 	streq	r4, [r0, #32]
    9710:	15834004 	strne	r4, [r3, #4]
    9714:	15843008 	strne	r3, [r4, #8]
    9718:	e5804024 	str	r4, [r0, #36]	; 0x24
    971c:	e3a00001 	mov	r0, #1
    9720:	e8bd80f8 	pop	{r3, r4, r5, r6, r7, pc}

00009724 <ipc_send>:
    9724:	e52de004 	push	{lr}		; (str lr, [sp, #-4]!)
    9728:	e24dd00c 	sub	sp, sp, #12
    972c:	e28d3008 	add	r3, sp, #8
    9730:	e5230004 	str	r0, [r3, #-4]!
    9734:	e3a00000 	mov	r0, #0
    9738:	ebfffafc 	bl	8330 <_SYSTEM_CALL>
    973c:	e3a00001 	mov	r0, #1
    9740:	e28dd00c 	add	sp, sp, #12
    9744:	e49df004 	pop	{pc}		; (ldr pc, [sp], #4)

00009748 <ipc_receive>:
    9748:	e92d4070 	push	{r4, r5, r6, lr}
    974c:	e1a06000 	mov	r6, r0
    9750:	e1a05001 	mov	r5, r1
    9754:	e281000c 	add	r0, r1, #12
    9758:	fa000169 	blx	9d04 <malloc>
    975c:	e1a04000 	mov	r4, r0
    9760:	e3a00001 	mov	r0, #1
    9764:	e1a01004 	mov	r1, r4
    9768:	e1a02005 	mov	r2, r5
    976c:	e3a03000 	mov	r3, #0
    9770:	ebfffaee 	bl	8330 <_SYSTEM_CALL>
    9774:	e1a00006 	mov	r0, r6
    9778:	e284100c 	add	r1, r4, #12
    977c:	e1a02005 	mov	r2, r5
    9780:	fa0002c1 	blx	a28c <memcpy>
    9784:	e5945000 	ldr	r5, [r4]
    9788:	e1a00004 	mov	r0, r4
    978c:	fa000160 	blx	9d14 <free>
    9790:	e1a00005 	mov	r0, r5
    9794:	e8bd8070 	pop	{r4, r5, r6, pc}

00009798 <system_send>:
    9798:	e92d4010 	push	{r4, lr}
    979c:	e1a04002 	mov	r4, r2
    97a0:	ebffffa5 	bl	963c <ipc_msg_enqueue>
    97a4:	ebffffa0 	bl	962c <get_current_running_process>
    97a8:	ebfffdfe 	bl	8fa8 <pcb_get>
    97ac:	e3a03002 	mov	r3, #2
    97b0:	e5c03004 	strb	r3, [r0, #4]
    97b4:	e1a00004 	mov	r0, r4
    97b8:	ebfffdfa 	bl	8fa8 <pcb_get>
    97bc:	e5d03004 	ldrb	r3, [r0, #4]
    97c0:	e3530002 	cmp	r3, #2
    97c4:	18bd8010 	popne	{r4, pc}
    97c8:	e1a00004 	mov	r0, r4
    97cc:	ebfffdf5 	bl	8fa8 <pcb_get>
    97d0:	e3a03001 	mov	r3, #1
    97d4:	e5c03004 	strb	r3, [r0, #4]
    97d8:	e1a00004 	mov	r0, r4
    97dc:	ebfffee4 	bl	9374 <scheduler_enqueue>
    97e0:	e8bd8010 	pop	{r4, pc}

000097e4 <system_receive>:
    97e4:	e92d41f0 	push	{r4, r5, r6, r7, r8, lr}
    97e8:	e1a06000 	mov	r6, r0
    97ec:	e1a07001 	mov	r7, r1
    97f0:	ebffff8d 	bl	962c <get_current_running_process>
    97f4:	ebfffdeb 	bl	8fa8 <pcb_get>
    97f8:	e1a08000 	mov	r8, r0
    97fc:	e3a0503f 	mov	r5, #63	; 0x3f
    9800:	ebffff89 	bl	962c <get_current_running_process>
    9804:	ebfffde7 	bl	8fa8 <pcb_get>
    9808:	e3550040 	cmp	r5, #64	; 0x40
    980c:	8a00000f 	bhi	9850 <system_receive+0x6c>
    9810:	e2853004 	add	r3, r5, #4
    9814:	e7904183 	ldr	r4, [r0, r3, lsl #3]
    9818:	e3540000 	cmp	r4, #0
    981c:	0a00000b 	beq	9850 <system_receive+0x6c>
    9820:	e0805185 	add	r5, r0, r5, lsl #3
    9824:	e5953024 	ldr	r3, [r5, #36]	; 0x24
    9828:	e1540003 	cmp	r4, r3
    982c:	03a03000 	moveq	r3, #0
    9830:	05853020 	streq	r3, [r5, #32]
    9834:	05853024 	streq	r3, [r5, #36]	; 0x24
    9838:	15943004 	ldrne	r3, [r4, #4]
    983c:	13a02000 	movne	r2, #0
    9840:	15832008 	strne	r2, [r3, #8]
    9844:	15943004 	ldrne	r3, [r4, #4]
    9848:	15853020 	strne	r3, [r5, #32]
    984c:	ea000003 	b	9860 <system_receive+0x7c>
    9850:	e2455001 	sub	r5, r5, #1
    9854:	e3750001 	cmn	r5, #1
    9858:	1affffe8 	bne	9800 <system_receive+0x1c>
    985c:	ea00000c 	b	9894 <system_receive+0xb0>
    9860:	e1a00006 	mov	r0, r6
    9864:	e1a01004 	mov	r1, r4
    9868:	e287200c 	add	r2, r7, #12
    986c:	fa000286 	blx	a28c <memcpy>
    9870:	e1a00004 	mov	r0, r4
    9874:	fa000126 	blx	9d14 <free>
    9878:	e5960000 	ldr	r0, [r6]
    987c:	ebfffdc9 	bl	8fa8 <pcb_get>
    9880:	e3a03001 	mov	r3, #1
    9884:	e5c03004 	strb	r3, [r0, #4]
    9888:	e5960000 	ldr	r0, [r6]
    988c:	ebfffeb8 	bl	9374 <scheduler_enqueue>
    9890:	e8bd81f0 	pop	{r4, r5, r6, r7, r8, pc}
    9894:	e3a03002 	mov	r3, #2
    9898:	e5c83004 	strb	r3, [r8, #4]
    989c:	e8bd81f0 	pop	{r4, r5, r6, r7, r8, pc}

000098a0 <jtag_enable>:
    98a0:	e92d4008 	push	{r3, lr}
    98a4:	ebfffbce 	bl	87e4 <get_gpio>
    98a8:	e5903000 	ldr	r3, [r0]
    98ac:	e3c33a07 	bic	r3, r3, #28672	; 0x7000
    98b0:	e5803000 	str	r3, [r0]
    98b4:	e5903000 	ldr	r3, [r0]
    98b8:	e3833a02 	orr	r3, r3, #8192	; 0x2000
    98bc:	e5803000 	str	r3, [r0]
    98c0:	e5902008 	ldr	r2, [r0, #8]
    98c4:	e3003e3f 	movw	r3, #3647	; 0xe3f
    98c8:	e34f3f1c 	movt	r3, #65308	; 0xff1c
    98cc:	e0023003 	and	r3, r2, r3
    98d0:	e5803008 	str	r3, [r0, #8]
    98d4:	e5902008 	ldr	r2, [r0, #8]
    98d8:	e30b30c0 	movw	r3, #45248	; 0xb0c0
    98dc:	e3403061 	movt	r3, #97	; 0x61
    98e0:	e1823003 	orr	r3, r2, r3
    98e4:	e5803008 	str	r3, [r0, #8]
    98e8:	e8bd8008 	pop	{r3, pc}

000098ec <mmu_init_table>:
    98ec:	e3a03000 	mov	r3, #0
    98f0:	e3001000 	movw	r1, #0
    98f4:	e3401001 	movt	r1, #1
    98f8:	e1a02a03 	lsl	r2, r3, #20
    98fc:	e3822b47 	orr	r2, r2, #72704	; 0x11c00
    9900:	e382200e 	orr	r2, r2, #14
    9904:	e7812103 	str	r2, [r1, r3, lsl #2]
    9908:	e2833001 	add	r3, r3, #1
    990c:	e3530e3f 	cmp	r3, #1008	; 0x3f0
    9910:	1afffff8 	bne	98f8 <mmu_init_table+0xc>
    9914:	e3001000 	movw	r1, #0
    9918:	e3401001 	movt	r1, #1
    991c:	e1a02a03 	lsl	r2, r3, #20
    9920:	e3822b43 	orr	r2, r2, #68608	; 0x10c00
    9924:	e3822016 	orr	r2, r2, #22
    9928:	e7812103 	str	r2, [r1, r3, lsl #2]
    992c:	e2833001 	add	r3, r3, #1
    9930:	e3530b01 	cmp	r3, #1024	; 0x400
    9934:	1afffff8 	bne	991c <mmu_init_table+0x30>
    9938:	e3002000 	movw	r2, #0
    993c:	e3402001 	movt	r2, #1
    9940:	e3a01000 	mov	r1, #0
    9944:	e7821103 	str	r1, [r2, r3, lsl #2]
    9948:	e2833001 	add	r3, r3, #1
    994c:	e3530a01 	cmp	r3, #4096	; 0x1000
    9950:	1afffffb 	bne	9944 <mmu_init_table+0x58>
    9954:	e12fff1e 	bx	lr

00009958 <mmu_configure>:
    9958:	ee113f30 	mrc	15, 0, r3, cr1, cr0, {1}
    995c:	e3833040 	orr	r3, r3, #64	; 0x40
    9960:	ee013f30 	mcr	15, 0, r3, cr1, cr0, {1}
    9964:	e3a03003 	mov	r3, #3
    9968:	ee033f10 	mcr	15, 0, r3, cr3, cr0, {0}
    996c:	e3a03000 	mov	r3, #0
    9970:	ee023f50 	mcr	15, 0, r3, cr2, cr0, {2}
    9974:	e3003000 	movw	r3, #0
    9978:	e3403001 	movt	r3, #1
    997c:	e383300b 	orr	r3, r3, #11
    9980:	ee023f10 	mcr	15, 0, r3, cr2, cr0, {0}
    9984:	f57ff06f 	isb	sy
    9988:	e12fff1e 	bx	lr

0000998c <mmu_remap_section>:
    998c:	e1a00a20 	lsr	r0, r0, #20
    9990:	e3003000 	movw	r3, #0
    9994:	e3403001 	movt	r3, #1
    9998:	e3a0c000 	mov	ip, #0
    999c:	e783c100 	str	ip, [r3, r0, lsl #2]
    99a0:	f57ff04f 	dsb	sy
    99a4:	e3a03000 	mov	r3, #0
    99a8:	ee083f15 	mcr	15, 0, r3, cr8, cr5, {0}
    99ac:	e1a01a21 	lsr	r1, r1, #20
    99b0:	e1822a01 	orr	r2, r2, r1, lsl #20
    99b4:	e3003000 	movw	r3, #0
    99b8:	e3403001 	movt	r3, #1
    99bc:	e7832100 	str	r2, [r3, r0, lsl #2]
    99c0:	f57ff04f 	dsb	sy
    99c4:	e12fff1e 	bx	lr

000099c8 <time_for_reschedule>:
    99c8:	e3a00001 	mov	r0, #1
    99cc:	e12fff1e 	bx	lr

000099d0 <time_handler>:
    99d0:	e92d4010 	push	{r4, lr}
    99d4:	ebfffb67 	bl	8778 <arm_timer_irq_ack>
    99d8:	e3044000 	movw	r4, #16384	; 0x4000
    99dc:	e3404001 	movt	r4, #1
    99e0:	e5943000 	ldr	r3, [r4]
    99e4:	e2833001 	add	r3, r3, #1
    99e8:	e5843000 	str	r3, [r4]
    99ec:	ebfffb5d 	bl	8768 <arm_timer_get_freq>
    99f0:	e5943000 	ldr	r3, [r4]
    99f4:	e1500003 	cmp	r0, r3
    99f8:	2a000005 	bcs	9a14 <time_handler+0x44>
    99fc:	e1c420d8 	ldrd	r2, [r4, #8]
    9a00:	e2922001 	adds	r2, r2, #1
    9a04:	e2a33000 	adc	r3, r3, #0
    9a08:	e1c420f8 	strd	r2, [r4, #8]
    9a0c:	e3a03000 	mov	r3, #0
    9a10:	e5843000 	str	r3, [r4]
    9a14:	e30a0cc8 	movw	r0, #44232	; 0xacc8
    9a18:	e3400000 	movt	r0, #0
    9a1c:	ebfffc30 	bl	8ae4 <uart_puts>
    9a20:	ebfffe8f 	bl	9464 <reschedule>
    9a24:	e3a00001 	mov	r0, #1
    9a28:	e8bd8010 	pop	{r4, pc}

00009a2c <time_increments_get>:
    9a2c:	e3043000 	movw	r3, #16384	; 0x4000
    9a30:	e3403001 	movt	r3, #1
    9a34:	e5930000 	ldr	r0, [r3]
    9a38:	e12fff1e 	bx	lr

00009a3c <time_get_seconds>:
    9a3c:	e3043000 	movw	r3, #16384	; 0x4000
    9a40:	e3403001 	movt	r3, #1
    9a44:	e1c300d8 	ldrd	r0, [r3, #8]
    9a48:	e12fff1e 	bx	lr
    9a4c:	00000000 	andeq	r0, r0, r0

00009a50 <__aeabi_idiv>:
    9a50:	2900      	cmp	r1, #0
    9a52:	f000 813e 	beq.w	9cd2 <.divsi3_skip_div0_test+0x27c>

00009a56 <.divsi3_skip_div0_test>:
    9a56:	ea80 0c01 	eor.w	ip, r0, r1
    9a5a:	bf48      	it	mi
    9a5c:	4249      	negmi	r1, r1
    9a5e:	1e4a      	subs	r2, r1, #1
    9a60:	f000 811f 	beq.w	9ca2 <.divsi3_skip_div0_test+0x24c>
    9a64:	0003      	movs	r3, r0
    9a66:	bf48      	it	mi
    9a68:	4243      	negmi	r3, r0
    9a6a:	428b      	cmp	r3, r1
    9a6c:	f240 811e 	bls.w	9cac <.divsi3_skip_div0_test+0x256>
    9a70:	4211      	tst	r1, r2
    9a72:	f000 8123 	beq.w	9cbc <.divsi3_skip_div0_test+0x266>
    9a76:	fab3 f283 	clz	r2, r3
    9a7a:	fab1 f081 	clz	r0, r1
    9a7e:	eba0 0202 	sub.w	r2, r0, r2
    9a82:	f1c2 021f 	rsb	r2, r2, #31
    9a86:	a004      	add	r0, pc, #16	; (adr r0, 9a98 <.divsi3_skip_div0_test+0x42>)
    9a88:	eb00 1202 	add.w	r2, r0, r2, lsl #4
    9a8c:	f04f 0000 	mov.w	r0, #0
    9a90:	4697      	mov	pc, r2
    9a92:	bf00      	nop
    9a94:	f3af 8000 	nop.w
    9a98:	ebb3 7fc1 	cmp.w	r3, r1, lsl #31
    9a9c:	bf00      	nop
    9a9e:	eb40 0000 	adc.w	r0, r0, r0
    9aa2:	bf28      	it	cs
    9aa4:	eba3 73c1 	subcs.w	r3, r3, r1, lsl #31
    9aa8:	ebb3 7f81 	cmp.w	r3, r1, lsl #30
    9aac:	bf00      	nop
    9aae:	eb40 0000 	adc.w	r0, r0, r0
    9ab2:	bf28      	it	cs
    9ab4:	eba3 7381 	subcs.w	r3, r3, r1, lsl #30
    9ab8:	ebb3 7f41 	cmp.w	r3, r1, lsl #29
    9abc:	bf00      	nop
    9abe:	eb40 0000 	adc.w	r0, r0, r0
    9ac2:	bf28      	it	cs
    9ac4:	eba3 7341 	subcs.w	r3, r3, r1, lsl #29
    9ac8:	ebb3 7f01 	cmp.w	r3, r1, lsl #28
    9acc:	bf00      	nop
    9ace:	eb40 0000 	adc.w	r0, r0, r0
    9ad2:	bf28      	it	cs
    9ad4:	eba3 7301 	subcs.w	r3, r3, r1, lsl #28
    9ad8:	ebb3 6fc1 	cmp.w	r3, r1, lsl #27
    9adc:	bf00      	nop
    9ade:	eb40 0000 	adc.w	r0, r0, r0
    9ae2:	bf28      	it	cs
    9ae4:	eba3 63c1 	subcs.w	r3, r3, r1, lsl #27
    9ae8:	ebb3 6f81 	cmp.w	r3, r1, lsl #26
    9aec:	bf00      	nop
    9aee:	eb40 0000 	adc.w	r0, r0, r0
    9af2:	bf28      	it	cs
    9af4:	eba3 6381 	subcs.w	r3, r3, r1, lsl #26
    9af8:	ebb3 6f41 	cmp.w	r3, r1, lsl #25
    9afc:	bf00      	nop
    9afe:	eb40 0000 	adc.w	r0, r0, r0
    9b02:	bf28      	it	cs
    9b04:	eba3 6341 	subcs.w	r3, r3, r1, lsl #25
    9b08:	ebb3 6f01 	cmp.w	r3, r1, lsl #24
    9b0c:	bf00      	nop
    9b0e:	eb40 0000 	adc.w	r0, r0, r0
    9b12:	bf28      	it	cs
    9b14:	eba3 6301 	subcs.w	r3, r3, r1, lsl #24
    9b18:	ebb3 5fc1 	cmp.w	r3, r1, lsl #23
    9b1c:	bf00      	nop
    9b1e:	eb40 0000 	adc.w	r0, r0, r0
    9b22:	bf28      	it	cs
    9b24:	eba3 53c1 	subcs.w	r3, r3, r1, lsl #23
    9b28:	ebb3 5f81 	cmp.w	r3, r1, lsl #22
    9b2c:	bf00      	nop
    9b2e:	eb40 0000 	adc.w	r0, r0, r0
    9b32:	bf28      	it	cs
    9b34:	eba3 5381 	subcs.w	r3, r3, r1, lsl #22
    9b38:	ebb3 5f41 	cmp.w	r3, r1, lsl #21
    9b3c:	bf00      	nop
    9b3e:	eb40 0000 	adc.w	r0, r0, r0
    9b42:	bf28      	it	cs
    9b44:	eba3 5341 	subcs.w	r3, r3, r1, lsl #21
    9b48:	ebb3 5f01 	cmp.w	r3, r1, lsl #20
    9b4c:	bf00      	nop
    9b4e:	eb40 0000 	adc.w	r0, r0, r0
    9b52:	bf28      	it	cs
    9b54:	eba3 5301 	subcs.w	r3, r3, r1, lsl #20
    9b58:	ebb3 4fc1 	cmp.w	r3, r1, lsl #19
    9b5c:	bf00      	nop
    9b5e:	eb40 0000 	adc.w	r0, r0, r0
    9b62:	bf28      	it	cs
    9b64:	eba3 43c1 	subcs.w	r3, r3, r1, lsl #19
    9b68:	ebb3 4f81 	cmp.w	r3, r1, lsl #18
    9b6c:	bf00      	nop
    9b6e:	eb40 0000 	adc.w	r0, r0, r0
    9b72:	bf28      	it	cs
    9b74:	eba3 4381 	subcs.w	r3, r3, r1, lsl #18
    9b78:	ebb3 4f41 	cmp.w	r3, r1, lsl #17
    9b7c:	bf00      	nop
    9b7e:	eb40 0000 	adc.w	r0, r0, r0
    9b82:	bf28      	it	cs
    9b84:	eba3 4341 	subcs.w	r3, r3, r1, lsl #17
    9b88:	ebb3 4f01 	cmp.w	r3, r1, lsl #16
    9b8c:	bf00      	nop
    9b8e:	eb40 0000 	adc.w	r0, r0, r0
    9b92:	bf28      	it	cs
    9b94:	eba3 4301 	subcs.w	r3, r3, r1, lsl #16
    9b98:	ebb3 3fc1 	cmp.w	r3, r1, lsl #15
    9b9c:	bf00      	nop
    9b9e:	eb40 0000 	adc.w	r0, r0, r0
    9ba2:	bf28      	it	cs
    9ba4:	eba3 33c1 	subcs.w	r3, r3, r1, lsl #15
    9ba8:	ebb3 3f81 	cmp.w	r3, r1, lsl #14
    9bac:	bf00      	nop
    9bae:	eb40 0000 	adc.w	r0, r0, r0
    9bb2:	bf28      	it	cs
    9bb4:	eba3 3381 	subcs.w	r3, r3, r1, lsl #14
    9bb8:	ebb3 3f41 	cmp.w	r3, r1, lsl #13
    9bbc:	bf00      	nop
    9bbe:	eb40 0000 	adc.w	r0, r0, r0
    9bc2:	bf28      	it	cs
    9bc4:	eba3 3341 	subcs.w	r3, r3, r1, lsl #13
    9bc8:	ebb3 3f01 	cmp.w	r3, r1, lsl #12
    9bcc:	bf00      	nop
    9bce:	eb40 0000 	adc.w	r0, r0, r0
    9bd2:	bf28      	it	cs
    9bd4:	eba3 3301 	subcs.w	r3, r3, r1, lsl #12
    9bd8:	ebb3 2fc1 	cmp.w	r3, r1, lsl #11
    9bdc:	bf00      	nop
    9bde:	eb40 0000 	adc.w	r0, r0, r0
    9be2:	bf28      	it	cs
    9be4:	eba3 23c1 	subcs.w	r3, r3, r1, lsl #11
    9be8:	ebb3 2f81 	cmp.w	r3, r1, lsl #10
    9bec:	bf00      	nop
    9bee:	eb40 0000 	adc.w	r0, r0, r0
    9bf2:	bf28      	it	cs
    9bf4:	eba3 2381 	subcs.w	r3, r3, r1, lsl #10
    9bf8:	ebb3 2f41 	cmp.w	r3, r1, lsl #9
    9bfc:	bf00      	nop
    9bfe:	eb40 0000 	adc.w	r0, r0, r0
    9c02:	bf28      	it	cs
    9c04:	eba3 2341 	subcs.w	r3, r3, r1, lsl #9
    9c08:	ebb3 2f01 	cmp.w	r3, r1, lsl #8
    9c0c:	bf00      	nop
    9c0e:	eb40 0000 	adc.w	r0, r0, r0
    9c12:	bf28      	it	cs
    9c14:	eba3 2301 	subcs.w	r3, r3, r1, lsl #8
    9c18:	ebb3 1fc1 	cmp.w	r3, r1, lsl #7
    9c1c:	bf00      	nop
    9c1e:	eb40 0000 	adc.w	r0, r0, r0
    9c22:	bf28      	it	cs
    9c24:	eba3 13c1 	subcs.w	r3, r3, r1, lsl #7
    9c28:	ebb3 1f81 	cmp.w	r3, r1, lsl #6
    9c2c:	bf00      	nop
    9c2e:	eb40 0000 	adc.w	r0, r0, r0
    9c32:	bf28      	it	cs
    9c34:	eba3 1381 	subcs.w	r3, r3, r1, lsl #6
    9c38:	ebb3 1f41 	cmp.w	r3, r1, lsl #5
    9c3c:	bf00      	nop
    9c3e:	eb40 0000 	adc.w	r0, r0, r0
    9c42:	bf28      	it	cs
    9c44:	eba3 1341 	subcs.w	r3, r3, r1, lsl #5
    9c48:	ebb3 1f01 	cmp.w	r3, r1, lsl #4
    9c4c:	bf00      	nop
    9c4e:	eb40 0000 	adc.w	r0, r0, r0
    9c52:	bf28      	it	cs
    9c54:	eba3 1301 	subcs.w	r3, r3, r1, lsl #4
    9c58:	ebb3 0fc1 	cmp.w	r3, r1, lsl #3
    9c5c:	bf00      	nop
    9c5e:	eb40 0000 	adc.w	r0, r0, r0
    9c62:	bf28      	it	cs
    9c64:	eba3 03c1 	subcs.w	r3, r3, r1, lsl #3
    9c68:	ebb3 0f81 	cmp.w	r3, r1, lsl #2
    9c6c:	bf00      	nop
    9c6e:	eb40 0000 	adc.w	r0, r0, r0
    9c72:	bf28      	it	cs
    9c74:	eba3 0381 	subcs.w	r3, r3, r1, lsl #2
    9c78:	ebb3 0f41 	cmp.w	r3, r1, lsl #1
    9c7c:	bf00      	nop
    9c7e:	eb40 0000 	adc.w	r0, r0, r0
    9c82:	bf28      	it	cs
    9c84:	eba3 0341 	subcs.w	r3, r3, r1, lsl #1
    9c88:	ebb3 0f01 	cmp.w	r3, r1
    9c8c:	bf00      	nop
    9c8e:	eb40 0000 	adc.w	r0, r0, r0
    9c92:	bf28      	it	cs
    9c94:	eba3 0301 	subcs.w	r3, r3, r1
    9c98:	f1bc 0f00 	cmp.w	ip, #0
    9c9c:	bf48      	it	mi
    9c9e:	4240      	negmi	r0, r0
    9ca0:	4770      	bx	lr
    9ca2:	ea9c 0f00 	teq	ip, r0
    9ca6:	bf48      	it	mi
    9ca8:	4240      	negmi	r0, r0
    9caa:	4770      	bx	lr
    9cac:	bf38      	it	cc
    9cae:	2000      	movcc	r0, #0
    9cb0:	bf04      	itt	eq
    9cb2:	ea4f 70ec 	moveq.w	r0, ip, asr #31
    9cb6:	f040 0001 	orreq.w	r0, r0, #1
    9cba:	4770      	bx	lr
    9cbc:	fab1 f281 	clz	r2, r1
    9cc0:	f1c2 021f 	rsb	r2, r2, #31
    9cc4:	f1bc 0f00 	cmp.w	ip, #0
    9cc8:	fa23 f002 	lsr.w	r0, r3, r2
    9ccc:	bf48      	it	mi
    9cce:	4240      	negmi	r0, r0
    9cd0:	4770      	bx	lr
    9cd2:	2800      	cmp	r0, #0
    9cd4:	bfc8      	it	gt
    9cd6:	f06f 4000 	mvngt.w	r0, #2147483648	; 0x80000000
    9cda:	bfb8      	it	lt
    9cdc:	f04f 4000 	movlt.w	r0, #2147483648	; 0x80000000
    9ce0:	f000 b80e 	b.w	9d00 <__aeabi_idiv0>

00009ce4 <__aeabi_idivmod>:
    9ce4:	2900      	cmp	r1, #0
    9ce6:	d0f4      	beq.n	9cd2 <.divsi3_skip_div0_test+0x27c>
    9ce8:	e92d 4003 	stmdb	sp!, {r0, r1, lr}
    9cec:	f7ff feb3 	bl	9a56 <.divsi3_skip_div0_test>
    9cf0:	e8bd 4006 	ldmia.w	sp!, {r1, r2, lr}
    9cf4:	fb02 f300 	mul.w	r3, r2, r0
    9cf8:	eba1 0103 	sub.w	r1, r1, r3
    9cfc:	4770      	bx	lr
    9cfe:	bf00      	nop

00009d00 <__aeabi_idiv0>:
    9d00:	4770      	bx	lr
    9d02:	bf00      	nop

00009d04 <malloc>:
    9d04:	f24b 5318 	movw	r3, #46360	; 0xb518
    9d08:	f2c0 0300 	movt	r3, #0
    9d0c:	4601      	mov	r1, r0
    9d0e:	6818      	ldr	r0, [r3, #0]
    9d10:	f000 b808 	b.w	9d24 <_malloc_r>

00009d14 <free>:
    9d14:	f24b 5318 	movw	r3, #46360	; 0xb518
    9d18:	f2c0 0300 	movt	r3, #0
    9d1c:	4601      	mov	r1, r0
    9d1e:	6818      	ldr	r0, [r3, #0]
    9d20:	f000 bc48 	b.w	a5b4 <_free_r>

00009d24 <_malloc_r>:
    9d24:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
    9d28:	f101 040b 	add.w	r4, r1, #11
    9d2c:	2c16      	cmp	r4, #22
    9d2e:	b083      	sub	sp, #12
    9d30:	bf88      	it	hi
    9d32:	f024 0407 	bichi.w	r4, r4, #7
    9d36:	4607      	mov	r7, r0
    9d38:	bf9a      	itte	ls
    9d3a:	2300      	movls	r3, #0
    9d3c:	2410      	movls	r4, #16
    9d3e:	0fe3      	lsrhi	r3, r4, #31
    9d40:	428c      	cmp	r4, r1
    9d42:	bf2c      	ite	cs
    9d44:	4619      	movcs	r1, r3
    9d46:	f043 0101 	orrcc.w	r1, r3, #1
    9d4a:	2900      	cmp	r1, #0
    9d4c:	f040 80b4 	bne.w	9eb8 <_malloc_r+0x194>
    9d50:	f000 fb40 	bl	a3d4 <__malloc_lock>
    9d54:	f5b4 7ffc 	cmp.w	r4, #504	; 0x1f8
    9d58:	d220      	bcs.n	9d9c <_malloc_r+0x78>
    9d5a:	ea4f 0cd4 	mov.w	ip, r4, lsr #3
    9d5e:	f64a 46e0 	movw	r6, #44256	; 0xace0
    9d62:	f2c0 0600 	movt	r6, #0
    9d66:	eb06 02cc 	add.w	r2, r6, ip, lsl #3
    9d6a:	68d3      	ldr	r3, [r2, #12]
    9d6c:	4293      	cmp	r3, r2
    9d6e:	f000 81f5 	beq.w	a15c <_malloc_r+0x438>
    9d72:	6859      	ldr	r1, [r3, #4]
    9d74:	f103 0508 	add.w	r5, r3, #8
    9d78:	68da      	ldr	r2, [r3, #12]
    9d7a:	4638      	mov	r0, r7
    9d7c:	f021 0403 	bic.w	r4, r1, #3
    9d80:	6899      	ldr	r1, [r3, #8]
    9d82:	4423      	add	r3, r4
    9d84:	685c      	ldr	r4, [r3, #4]
    9d86:	60ca      	str	r2, [r1, #12]
    9d88:	f044 0401 	orr.w	r4, r4, #1
    9d8c:	6091      	str	r1, [r2, #8]
    9d8e:	605c      	str	r4, [r3, #4]
    9d90:	f000 fb22 	bl	a3d8 <__malloc_unlock>
    9d94:	4628      	mov	r0, r5
    9d96:	b003      	add	sp, #12
    9d98:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    9d9c:	ea5f 2c54 	movs.w	ip, r4, lsr #9
    9da0:	bf04      	itt	eq
    9da2:	257e      	moveq	r5, #126	; 0x7e
    9da4:	f04f 0c3f 	moveq.w	ip, #63	; 0x3f
    9da8:	f040 808d 	bne.w	9ec6 <_malloc_r+0x1a2>
    9dac:	f64a 46e0 	movw	r6, #44256	; 0xace0
    9db0:	f2c0 0600 	movt	r6, #0
    9db4:	eb06 0585 	add.w	r5, r6, r5, lsl #2
    9db8:	68eb      	ldr	r3, [r5, #12]
    9dba:	429d      	cmp	r5, r3
    9dbc:	d106      	bne.n	9dcc <_malloc_r+0xa8>
    9dbe:	e00d      	b.n	9ddc <_malloc_r+0xb8>
    9dc0:	2a00      	cmp	r2, #0
    9dc2:	f280 8162 	bge.w	a08a <_malloc_r+0x366>
    9dc6:	68db      	ldr	r3, [r3, #12]
    9dc8:	429d      	cmp	r5, r3
    9dca:	d007      	beq.n	9ddc <_malloc_r+0xb8>
    9dcc:	6859      	ldr	r1, [r3, #4]
    9dce:	f021 0103 	bic.w	r1, r1, #3
    9dd2:	1b0a      	subs	r2, r1, r4
    9dd4:	2a0f      	cmp	r2, #15
    9dd6:	ddf3      	ble.n	9dc0 <_malloc_r+0x9c>
    9dd8:	f10c 3cff 	add.w	ip, ip, #4294967295	; 0xffffffff
    9ddc:	f10c 0c01 	add.w	ip, ip, #1
    9de0:	f64a 42e0 	movw	r2, #44256	; 0xace0
    9de4:	6933      	ldr	r3, [r6, #16]
    9de6:	f2c0 0200 	movt	r2, #0
    9dea:	f102 0e08 	add.w	lr, r2, #8
    9dee:	4573      	cmp	r3, lr
    9df0:	bf08      	it	eq
    9df2:	6851      	ldreq	r1, [r2, #4]
    9df4:	d021      	beq.n	9e3a <_malloc_r+0x116>
    9df6:	6858      	ldr	r0, [r3, #4]
    9df8:	f020 0003 	bic.w	r0, r0, #3
    9dfc:	1b01      	subs	r1, r0, r4
    9dfe:	290f      	cmp	r1, #15
    9e00:	f300 8190 	bgt.w	a124 <_malloc_r+0x400>
    9e04:	2900      	cmp	r1, #0
    9e06:	f8c2 e014 	str.w	lr, [r2, #20]
    9e0a:	f8c2 e010 	str.w	lr, [r2, #16]
    9e0e:	da65      	bge.n	9edc <_malloc_r+0x1b8>
    9e10:	f5b0 7f00 	cmp.w	r0, #512	; 0x200
    9e14:	f080 815f 	bcs.w	a0d6 <_malloc_r+0x3b2>
    9e18:	08c0      	lsrs	r0, r0, #3
    9e1a:	f04f 0801 	mov.w	r8, #1
    9e1e:	6851      	ldr	r1, [r2, #4]
    9e20:	eb02 05c0 	add.w	r5, r2, r0, lsl #3
    9e24:	1080      	asrs	r0, r0, #2
    9e26:	fa08 f800 	lsl.w	r8, r8, r0
    9e2a:	68a8      	ldr	r0, [r5, #8]
    9e2c:	ea48 0101 	orr.w	r1, r8, r1
    9e30:	60dd      	str	r5, [r3, #12]
    9e32:	6051      	str	r1, [r2, #4]
    9e34:	6098      	str	r0, [r3, #8]
    9e36:	60ab      	str	r3, [r5, #8]
    9e38:	60c3      	str	r3, [r0, #12]
    9e3a:	ea4f 03ac 	mov.w	r3, ip, asr #2
    9e3e:	2001      	movs	r0, #1
    9e40:	4098      	lsls	r0, r3
    9e42:	4288      	cmp	r0, r1
    9e44:	d858      	bhi.n	9ef8 <_malloc_r+0x1d4>
    9e46:	4201      	tst	r1, r0
    9e48:	d106      	bne.n	9e58 <_malloc_r+0x134>
    9e4a:	f02c 0c03 	bic.w	ip, ip, #3
    9e4e:	0040      	lsls	r0, r0, #1
    9e50:	f10c 0c04 	add.w	ip, ip, #4
    9e54:	4201      	tst	r1, r0
    9e56:	d0fa      	beq.n	9e4e <_malloc_r+0x12a>
    9e58:	eb06 08cc 	add.w	r8, r6, ip, lsl #3
    9e5c:	46e1      	mov	r9, ip
    9e5e:	4645      	mov	r5, r8
    9e60:	68ea      	ldr	r2, [r5, #12]
    9e62:	4295      	cmp	r5, r2
    9e64:	d107      	bne.n	9e76 <_malloc_r+0x152>
    9e66:	e171      	b.n	a14c <_malloc_r+0x428>
    9e68:	2900      	cmp	r1, #0
    9e6a:	f280 8181 	bge.w	a170 <_malloc_r+0x44c>
    9e6e:	68d2      	ldr	r2, [r2, #12]
    9e70:	4295      	cmp	r5, r2
    9e72:	f000 816b 	beq.w	a14c <_malloc_r+0x428>
    9e76:	6853      	ldr	r3, [r2, #4]
    9e78:	f023 0303 	bic.w	r3, r3, #3
    9e7c:	1b19      	subs	r1, r3, r4
    9e7e:	290f      	cmp	r1, #15
    9e80:	ddf2      	ble.n	9e68 <_malloc_r+0x144>
    9e82:	4615      	mov	r5, r2
    9e84:	f8d2 c00c 	ldr.w	ip, [r2, #12]
    9e88:	f855 8f08 	ldr.w	r8, [r5, #8]!
    9e8c:	1913      	adds	r3, r2, r4
    9e8e:	4638      	mov	r0, r7
    9e90:	f044 0401 	orr.w	r4, r4, #1
    9e94:	f041 0701 	orr.w	r7, r1, #1
    9e98:	6054      	str	r4, [r2, #4]
    9e9a:	f8c8 c00c 	str.w	ip, [r8, #12]
    9e9e:	f8cc 8008 	str.w	r8, [ip, #8]
    9ea2:	6173      	str	r3, [r6, #20]
    9ea4:	6133      	str	r3, [r6, #16]
    9ea6:	f8c3 e00c 	str.w	lr, [r3, #12]
    9eaa:	f8c3 e008 	str.w	lr, [r3, #8]
    9eae:	605f      	str	r7, [r3, #4]
    9eb0:	5059      	str	r1, [r3, r1]
    9eb2:	f000 fa91 	bl	a3d8 <__malloc_unlock>
    9eb6:	e76d      	b.n	9d94 <_malloc_r+0x70>
    9eb8:	2500      	movs	r5, #0
    9eba:	230c      	movs	r3, #12
    9ebc:	6003      	str	r3, [r0, #0]
    9ebe:	4628      	mov	r0, r5
    9ec0:	b003      	add	sp, #12
    9ec2:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    9ec6:	f1bc 0f04 	cmp.w	ip, #4
    9eca:	f200 80f0 	bhi.w	a0ae <_malloc_r+0x38a>
    9ece:	ea4f 1c94 	mov.w	ip, r4, lsr #6
    9ed2:	f10c 0c38 	add.w	ip, ip, #56	; 0x38
    9ed6:	ea4f 054c 	mov.w	r5, ip, lsl #1
    9eda:	e767      	b.n	9dac <_malloc_r+0x88>
    9edc:	181a      	adds	r2, r3, r0
    9ede:	f103 0508 	add.w	r5, r3, #8
    9ee2:	4638      	mov	r0, r7
    9ee4:	6853      	ldr	r3, [r2, #4]
    9ee6:	f043 0301 	orr.w	r3, r3, #1
    9eea:	6053      	str	r3, [r2, #4]
    9eec:	f000 fa74 	bl	a3d8 <__malloc_unlock>
    9ef0:	4628      	mov	r0, r5
    9ef2:	b003      	add	sp, #12
    9ef4:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    9ef8:	68b5      	ldr	r5, [r6, #8]
    9efa:	686b      	ldr	r3, [r5, #4]
    9efc:	f023 0903 	bic.w	r9, r3, #3
    9f00:	454c      	cmp	r4, r9
    9f02:	d804      	bhi.n	9f0e <_malloc_r+0x1ea>
    9f04:	ebc4 0309 	rsb	r3, r4, r9
    9f08:	2b0f      	cmp	r3, #15
    9f0a:	f300 80ae 	bgt.w	a06a <_malloc_r+0x346>
    9f0e:	f244 0318 	movw	r3, #16408	; 0x4018
    9f12:	f24b 0aec 	movw	sl, #45292	; 0xb0ec
    9f16:	f2c0 0301 	movt	r3, #1
    9f1a:	f2c0 0a00 	movt	sl, #0
    9f1e:	4638      	mov	r0, r7
    9f20:	eb05 0209 	add.w	r2, r5, r9
    9f24:	681b      	ldr	r3, [r3, #0]
    9f26:	f8da 1000 	ldr.w	r1, [sl]
    9f2a:	4423      	add	r3, r4
    9f2c:	3101      	adds	r1, #1
    9f2e:	bf17      	itett	ne
    9f30:	f503 5380 	addne.w	r3, r3, #4096	; 0x1000
    9f34:	f103 0c10 	addeq.w	ip, r3, #16
    9f38:	330f      	addne	r3, #15
    9f3a:	f423 637f 	bicne.w	r3, r3, #4080	; 0xff0
    9f3e:	bf18      	it	ne
    9f40:	f023 0c0f 	bicne.w	ip, r3, #15
    9f44:	e88d 1004 	stmia.w	sp, {r2, ip}
    9f48:	4661      	mov	r1, ip
    9f4a:	f000 fa9d 	bl	a488 <_sbrk_r>
    9f4e:	e89d 1004 	ldmia.w	sp, {r2, ip}
    9f52:	f1b0 3fff 	cmp.w	r0, #4294967295	; 0xffffffff
    9f56:	4680      	mov	r8, r0
    9f58:	f000 8120 	beq.w	a19c <_malloc_r+0x478>
    9f5c:	4282      	cmp	r2, r0
    9f5e:	f200 811a 	bhi.w	a196 <_malloc_r+0x472>
    9f62:	f244 0b1c 	movw	fp, #16412	; 0x401c
    9f66:	f2c0 0b01 	movt	fp, #1
    9f6a:	4542      	cmp	r2, r8
    9f6c:	f8db 3000 	ldr.w	r3, [fp]
    9f70:	4463      	add	r3, ip
    9f72:	f8cb 3000 	str.w	r3, [fp]
    9f76:	f000 815f 	beq.w	a238 <_malloc_r+0x514>
    9f7a:	f8da 0000 	ldr.w	r0, [sl]
    9f7e:	f24b 01ec 	movw	r1, #45292	; 0xb0ec
    9f82:	f2c0 0100 	movt	r1, #0
    9f86:	3001      	adds	r0, #1
    9f88:	4638      	mov	r0, r7
    9f8a:	bf17      	itett	ne
    9f8c:	ebc2 0208 	rsbne	r2, r2, r8
    9f90:	f8c1 8000 	streq.w	r8, [r1]
    9f94:	189b      	addne	r3, r3, r2
    9f96:	f8cb 3000 	strne.w	r3, [fp]
    9f9a:	f018 0307 	ands.w	r3, r8, #7
    9f9e:	bf1f      	itttt	ne
    9fa0:	f1c3 0208 	rsbne	r2, r3, #8
    9fa4:	f5c3 5380 	rsbne	r3, r3, #4096	; 0x1000
    9fa8:	4490      	addne	r8, r2
    9faa:	f103 0a08 	addne.w	sl, r3, #8
    9fae:	eb08 030c 	add.w	r3, r8, ip
    9fb2:	bf08      	it	eq
    9fb4:	f44f 5a80 	moveq.w	sl, #4096	; 0x1000
    9fb8:	f3c3 030b 	ubfx	r3, r3, #0, #12
    9fbc:	ebc3 0a0a 	rsb	sl, r3, sl
    9fc0:	4651      	mov	r1, sl
    9fc2:	f000 fa61 	bl	a488 <_sbrk_r>
    9fc6:	f244 021c 	movw	r2, #16412	; 0x401c
    9fca:	f8c6 8008 	str.w	r8, [r6, #8]
    9fce:	f2c0 0201 	movt	r2, #1
    9fd2:	1c43      	adds	r3, r0, #1
    9fd4:	f8db 3000 	ldr.w	r3, [fp]
    9fd8:	bf1b      	ittet	ne
    9fda:	ebc8 0100 	rsbne	r1, r8, r0
    9fde:	4451      	addne	r1, sl
    9fe0:	2101      	moveq	r1, #1
    9fe2:	f041 0101 	orrne.w	r1, r1, #1
    9fe6:	bf08      	it	eq
    9fe8:	f04f 0a00 	moveq.w	sl, #0
    9fec:	42b5      	cmp	r5, r6
    9fee:	4453      	add	r3, sl
    9ff0:	f8c8 1004 	str.w	r1, [r8, #4]
    9ff4:	f8cb 3000 	str.w	r3, [fp]
    9ff8:	d018      	beq.n	a02c <_malloc_r+0x308>
    9ffa:	f1b9 0f0f 	cmp.w	r9, #15
    9ffe:	f240 80fc 	bls.w	a1fa <_malloc_r+0x4d6>
    a002:	f1a9 010c 	sub.w	r1, r9, #12
    a006:	6868      	ldr	r0, [r5, #4]
    a008:	f021 0107 	bic.w	r1, r1, #7
    a00c:	f04f 0c05 	mov.w	ip, #5
    a010:	eb05 0e01 	add.w	lr, r5, r1
    a014:	290f      	cmp	r1, #15
    a016:	f000 0001 	and.w	r0, r0, #1
    a01a:	ea41 0000 	orr.w	r0, r1, r0
    a01e:	6068      	str	r0, [r5, #4]
    a020:	f8ce c004 	str.w	ip, [lr, #4]
    a024:	f8ce c008 	str.w	ip, [lr, #8]
    a028:	f200 8112 	bhi.w	a250 <_malloc_r+0x52c>
    a02c:	f244 0214 	movw	r2, #16404	; 0x4014
    a030:	f2c0 0201 	movt	r2, #1
    a034:	68b5      	ldr	r5, [r6, #8]
    a036:	6811      	ldr	r1, [r2, #0]
    a038:	428b      	cmp	r3, r1
    a03a:	bf88      	it	hi
    a03c:	6013      	strhi	r3, [r2, #0]
    a03e:	f244 0210 	movw	r2, #16400	; 0x4010
    a042:	f2c0 0201 	movt	r2, #1
    a046:	6811      	ldr	r1, [r2, #0]
    a048:	428b      	cmp	r3, r1
    a04a:	bf88      	it	hi
    a04c:	6013      	strhi	r3, [r2, #0]
    a04e:	686a      	ldr	r2, [r5, #4]
    a050:	f022 0203 	bic.w	r2, r2, #3
    a054:	4294      	cmp	r4, r2
    a056:	ebc4 0302 	rsb	r3, r4, r2
    a05a:	d801      	bhi.n	a060 <_malloc_r+0x33c>
    a05c:	2b0f      	cmp	r3, #15
    a05e:	dc04      	bgt.n	a06a <_malloc_r+0x346>
    a060:	4638      	mov	r0, r7
    a062:	2500      	movs	r5, #0
    a064:	f000 f9b8 	bl	a3d8 <__malloc_unlock>
    a068:	e694      	b.n	9d94 <_malloc_r+0x70>
    a06a:	192a      	adds	r2, r5, r4
    a06c:	f043 0301 	orr.w	r3, r3, #1
    a070:	4638      	mov	r0, r7
    a072:	f044 0401 	orr.w	r4, r4, #1
    a076:	606c      	str	r4, [r5, #4]
    a078:	3508      	adds	r5, #8
    a07a:	60b2      	str	r2, [r6, #8]
    a07c:	6053      	str	r3, [r2, #4]
    a07e:	f000 f9ab 	bl	a3d8 <__malloc_unlock>
    a082:	4628      	mov	r0, r5
    a084:	b003      	add	sp, #12
    a086:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    a08a:	4419      	add	r1, r3
    a08c:	68da      	ldr	r2, [r3, #12]
    a08e:	689c      	ldr	r4, [r3, #8]
    a090:	4638      	mov	r0, r7
    a092:	684e      	ldr	r6, [r1, #4]
    a094:	f103 0508 	add.w	r5, r3, #8
    a098:	60e2      	str	r2, [r4, #12]
    a09a:	f046 0601 	orr.w	r6, r6, #1
    a09e:	6094      	str	r4, [r2, #8]
    a0a0:	604e      	str	r6, [r1, #4]
    a0a2:	f000 f999 	bl	a3d8 <__malloc_unlock>
    a0a6:	4628      	mov	r0, r5
    a0a8:	b003      	add	sp, #12
    a0aa:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
    a0ae:	f1bc 0f14 	cmp.w	ip, #20
    a0b2:	bf9c      	itt	ls
    a0b4:	f10c 0c5b 	addls.w	ip, ip, #91	; 0x5b
    a0b8:	ea4f 054c 	movls.w	r5, ip, lsl #1
    a0bc:	f67f ae76 	bls.w	9dac <_malloc_r+0x88>
    a0c0:	f1bc 0f54 	cmp.w	ip, #84	; 0x54
    a0c4:	f200 808f 	bhi.w	a1e6 <_malloc_r+0x4c2>
    a0c8:	ea4f 3c14 	mov.w	ip, r4, lsr #12
    a0cc:	f10c 0c6e 	add.w	ip, ip, #110	; 0x6e
    a0d0:	ea4f 054c 	mov.w	r5, ip, lsl #1
    a0d4:	e66a      	b.n	9dac <_malloc_r+0x88>
    a0d6:	0a42      	lsrs	r2, r0, #9
    a0d8:	2a04      	cmp	r2, #4
    a0da:	d958      	bls.n	a18e <_malloc_r+0x46a>
    a0dc:	2a14      	cmp	r2, #20
    a0de:	bf9c      	itt	ls
    a0e0:	f102 015b 	addls.w	r1, r2, #91	; 0x5b
    a0e4:	004d      	lslls	r5, r1, #1
    a0e6:	d905      	bls.n	a0f4 <_malloc_r+0x3d0>
    a0e8:	2a54      	cmp	r2, #84	; 0x54
    a0ea:	f200 80ba 	bhi.w	a262 <_malloc_r+0x53e>
    a0ee:	0b01      	lsrs	r1, r0, #12
    a0f0:	316e      	adds	r1, #110	; 0x6e
    a0f2:	004d      	lsls	r5, r1, #1
    a0f4:	eb06 0585 	add.w	r5, r6, r5, lsl #2
    a0f8:	f64a 48e0 	movw	r8, #44256	; 0xace0
    a0fc:	f2c0 0800 	movt	r8, #0
    a100:	68aa      	ldr	r2, [r5, #8]
    a102:	42aa      	cmp	r2, r5
    a104:	d07f      	beq.n	a206 <_malloc_r+0x4e2>
    a106:	6851      	ldr	r1, [r2, #4]
    a108:	f021 0103 	bic.w	r1, r1, #3
    a10c:	4288      	cmp	r0, r1
    a10e:	d202      	bcs.n	a116 <_malloc_r+0x3f2>
    a110:	6892      	ldr	r2, [r2, #8]
    a112:	4295      	cmp	r5, r2
    a114:	d1f7      	bne.n	a106 <_malloc_r+0x3e2>
    a116:	68d0      	ldr	r0, [r2, #12]
    a118:	6871      	ldr	r1, [r6, #4]
    a11a:	60d8      	str	r0, [r3, #12]
    a11c:	609a      	str	r2, [r3, #8]
    a11e:	6083      	str	r3, [r0, #8]
    a120:	60d3      	str	r3, [r2, #12]
    a122:	e68a      	b.n	9e3a <_malloc_r+0x116>
    a124:	191e      	adds	r6, r3, r4
    a126:	4638      	mov	r0, r7
    a128:	f044 0401 	orr.w	r4, r4, #1
    a12c:	f041 0701 	orr.w	r7, r1, #1
    a130:	605c      	str	r4, [r3, #4]
    a132:	f103 0508 	add.w	r5, r3, #8
    a136:	6156      	str	r6, [r2, #20]
    a138:	6116      	str	r6, [r2, #16]
    a13a:	f8c6 e00c 	str.w	lr, [r6, #12]
    a13e:	f8c6 e008 	str.w	lr, [r6, #8]
    a142:	6077      	str	r7, [r6, #4]
    a144:	5071      	str	r1, [r6, r1]
    a146:	f000 f947 	bl	a3d8 <__malloc_unlock>
    a14a:	e623      	b.n	9d94 <_malloc_r+0x70>
    a14c:	f109 0901 	add.w	r9, r9, #1
    a150:	3508      	adds	r5, #8
    a152:	f019 0f03 	tst.w	r9, #3
    a156:	f47f ae83 	bne.w	9e60 <_malloc_r+0x13c>
    a15a:	e028      	b.n	a1ae <_malloc_r+0x48a>
    a15c:	f103 0208 	add.w	r2, r3, #8
    a160:	695b      	ldr	r3, [r3, #20]
    a162:	429a      	cmp	r2, r3
    a164:	bf08      	it	eq
    a166:	f10c 0c02 	addeq.w	ip, ip, #2
    a16a:	f43f ae39 	beq.w	9de0 <_malloc_r+0xbc>
    a16e:	e600      	b.n	9d72 <_malloc_r+0x4e>
    a170:	4413      	add	r3, r2
    a172:	4615      	mov	r5, r2
    a174:	f855 1f08 	ldr.w	r1, [r5, #8]!
    a178:	4638      	mov	r0, r7
    a17a:	68d2      	ldr	r2, [r2, #12]
    a17c:	685c      	ldr	r4, [r3, #4]
    a17e:	f044 0401 	orr.w	r4, r4, #1
    a182:	605c      	str	r4, [r3, #4]
    a184:	60ca      	str	r2, [r1, #12]
    a186:	6091      	str	r1, [r2, #8]
    a188:	f000 f926 	bl	a3d8 <__malloc_unlock>
    a18c:	e602      	b.n	9d94 <_malloc_r+0x70>
    a18e:	0981      	lsrs	r1, r0, #6
    a190:	3138      	adds	r1, #56	; 0x38
    a192:	004d      	lsls	r5, r1, #1
    a194:	e7ae      	b.n	a0f4 <_malloc_r+0x3d0>
    a196:	42b5      	cmp	r5, r6
    a198:	f43f aee3 	beq.w	9f62 <_malloc_r+0x23e>
    a19c:	68b5      	ldr	r5, [r6, #8]
    a19e:	686a      	ldr	r2, [r5, #4]
    a1a0:	f022 0203 	bic.w	r2, r2, #3
    a1a4:	e756      	b.n	a054 <_malloc_r+0x330>
    a1a6:	f8d8 8000 	ldr.w	r8, [r8]
    a1aa:	4598      	cmp	r8, r3
    a1ac:	d16b      	bne.n	a286 <_malloc_r+0x562>
    a1ae:	f01c 0f03 	tst.w	ip, #3
    a1b2:	f1a8 0308 	sub.w	r3, r8, #8
    a1b6:	f10c 3cff 	add.w	ip, ip, #4294967295	; 0xffffffff
    a1ba:	d1f4      	bne.n	a1a6 <_malloc_r+0x482>
    a1bc:	6873      	ldr	r3, [r6, #4]
    a1be:	ea23 0300 	bic.w	r3, r3, r0
    a1c2:	6073      	str	r3, [r6, #4]
    a1c4:	0040      	lsls	r0, r0, #1
    a1c6:	4298      	cmp	r0, r3
    a1c8:	f63f ae96 	bhi.w	9ef8 <_malloc_r+0x1d4>
    a1cc:	2800      	cmp	r0, #0
    a1ce:	f43f ae93 	beq.w	9ef8 <_malloc_r+0x1d4>
    a1d2:	4203      	tst	r3, r0
    a1d4:	46cc      	mov	ip, r9
    a1d6:	f47f ae3f 	bne.w	9e58 <_malloc_r+0x134>
    a1da:	0040      	lsls	r0, r0, #1
    a1dc:	f10c 0c04 	add.w	ip, ip, #4
    a1e0:	4203      	tst	r3, r0
    a1e2:	d0fa      	beq.n	a1da <_malloc_r+0x4b6>
    a1e4:	e638      	b.n	9e58 <_malloc_r+0x134>
    a1e6:	f5bc 7faa 	cmp.w	ip, #340	; 0x154
    a1ea:	d816      	bhi.n	a21a <_malloc_r+0x4f6>
    a1ec:	ea4f 3cd4 	mov.w	ip, r4, lsr #15
    a1f0:	f10c 0c77 	add.w	ip, ip, #119	; 0x77
    a1f4:	ea4f 054c 	mov.w	r5, ip, lsl #1
    a1f8:	e5d8      	b.n	9dac <_malloc_r+0x88>
    a1fa:	2301      	movs	r3, #1
    a1fc:	4645      	mov	r5, r8
    a1fe:	f8c8 3004 	str.w	r3, [r8, #4]
    a202:	2200      	movs	r2, #0
    a204:	e726      	b.n	a054 <_malloc_r+0x330>
    a206:	1088      	asrs	r0, r1, #2
    a208:	2501      	movs	r5, #1
    a20a:	f8d8 1004 	ldr.w	r1, [r8, #4]
    a20e:	4085      	lsls	r5, r0
    a210:	4610      	mov	r0, r2
    a212:	4329      	orrs	r1, r5
    a214:	f8c8 1004 	str.w	r1, [r8, #4]
    a218:	e77f      	b.n	a11a <_malloc_r+0x3f6>
    a21a:	f240 5354 	movw	r3, #1364	; 0x554
    a21e:	459c      	cmp	ip, r3
    a220:	bf99      	ittee	ls
    a222:	ea4f 4c94 	movls.w	ip, r4, lsr #18
    a226:	f10c 0c7c 	addls.w	ip, ip, #124	; 0x7c
    a22a:	25fc      	movhi	r5, #252	; 0xfc
    a22c:	f04f 0c7e 	movhi.w	ip, #126	; 0x7e
    a230:	bf98      	it	ls
    a232:	ea4f 054c 	movls.w	r5, ip, lsl #1
    a236:	e5b9      	b.n	9dac <_malloc_r+0x88>
    a238:	f3c2 010b 	ubfx	r1, r2, #0, #12
    a23c:	2900      	cmp	r1, #0
    a23e:	f47f ae9c 	bne.w	9f7a <_malloc_r+0x256>
    a242:	68b2      	ldr	r2, [r6, #8]
    a244:	eb0c 0109 	add.w	r1, ip, r9
    a248:	f041 0101 	orr.w	r1, r1, #1
    a24c:	6051      	str	r1, [r2, #4]
    a24e:	e6ed      	b.n	a02c <_malloc_r+0x308>
    a250:	f105 0108 	add.w	r1, r5, #8
    a254:	4638      	mov	r0, r7
    a256:	9200      	str	r2, [sp, #0]
    a258:	f000 f9ac 	bl	a5b4 <_free_r>
    a25c:	9a00      	ldr	r2, [sp, #0]
    a25e:	6813      	ldr	r3, [r2, #0]
    a260:	e6e4      	b.n	a02c <_malloc_r+0x308>
    a262:	f5b2 7faa 	cmp.w	r2, #340	; 0x154
    a266:	d803      	bhi.n	a270 <_malloc_r+0x54c>
    a268:	0bc1      	lsrs	r1, r0, #15
    a26a:	3177      	adds	r1, #119	; 0x77
    a26c:	004d      	lsls	r5, r1, #1
    a26e:	e741      	b.n	a0f4 <_malloc_r+0x3d0>
    a270:	f240 5154 	movw	r1, #1364	; 0x554
    a274:	428a      	cmp	r2, r1
    a276:	bf99      	ittee	ls
    a278:	0c81      	lsrls	r1, r0, #18
    a27a:	317c      	addls	r1, #124	; 0x7c
    a27c:	25fc      	movhi	r5, #252	; 0xfc
    a27e:	217e      	movhi	r1, #126	; 0x7e
    a280:	bf98      	it	ls
    a282:	004d      	lslls	r5, r1, #1
    a284:	e736      	b.n	a0f4 <_malloc_r+0x3d0>
    a286:	6873      	ldr	r3, [r6, #4]
    a288:	e79c      	b.n	a1c4 <_malloc_r+0x4a0>
    a28a:	bf00      	nop

0000a28c <memcpy>:
    a28c:	2a0f      	cmp	r2, #15
    a28e:	b4f0      	push	{r4, r5, r6, r7}
    a290:	d945      	bls.n	a31e <memcpy+0x92>
    a292:	ea40 0301 	orr.w	r3, r0, r1
    a296:	079b      	lsls	r3, r3, #30
    a298:	d145      	bne.n	a326 <memcpy+0x9a>
    a29a:	f1a2 0710 	sub.w	r7, r2, #16
    a29e:	460c      	mov	r4, r1
    a2a0:	4603      	mov	r3, r0
    a2a2:	093f      	lsrs	r7, r7, #4
    a2a4:	eb00 1607 	add.w	r6, r0, r7, lsl #4
    a2a8:	3610      	adds	r6, #16
    a2aa:	6825      	ldr	r5, [r4, #0]
    a2ac:	3310      	adds	r3, #16
    a2ae:	3410      	adds	r4, #16
    a2b0:	f843 5c10 	str.w	r5, [r3, #-16]
    a2b4:	f854 5c0c 	ldr.w	r5, [r4, #-12]
    a2b8:	f843 5c0c 	str.w	r5, [r3, #-12]
    a2bc:	f854 5c08 	ldr.w	r5, [r4, #-8]
    a2c0:	f843 5c08 	str.w	r5, [r3, #-8]
    a2c4:	f854 5c04 	ldr.w	r5, [r4, #-4]
    a2c8:	f843 5c04 	str.w	r5, [r3, #-4]
    a2cc:	42b3      	cmp	r3, r6
    a2ce:	d1ec      	bne.n	a2aa <memcpy+0x1e>
    a2d0:	1c7b      	adds	r3, r7, #1
    a2d2:	f002 0c0f 	and.w	ip, r2, #15
    a2d6:	f1bc 0f03 	cmp.w	ip, #3
    a2da:	ea4f 1303 	mov.w	r3, r3, lsl #4
    a2de:	4419      	add	r1, r3
    a2e0:	4403      	add	r3, r0
    a2e2:	d922      	bls.n	a32a <memcpy+0x9e>
    a2e4:	460e      	mov	r6, r1
    a2e6:	461d      	mov	r5, r3
    a2e8:	4664      	mov	r4, ip
    a2ea:	f856 7b04 	ldr.w	r7, [r6], #4
    a2ee:	3c04      	subs	r4, #4
    a2f0:	2c03      	cmp	r4, #3
    a2f2:	f845 7b04 	str.w	r7, [r5], #4
    a2f6:	d8f8      	bhi.n	a2ea <memcpy+0x5e>
    a2f8:	f1ac 0404 	sub.w	r4, ip, #4
    a2fc:	f002 0203 	and.w	r2, r2, #3
    a300:	f024 0403 	bic.w	r4, r4, #3
    a304:	3404      	adds	r4, #4
    a306:	4423      	add	r3, r4
    a308:	4421      	add	r1, r4
    a30a:	b132      	cbz	r2, a31a <memcpy+0x8e>
    a30c:	440a      	add	r2, r1
    a30e:	f811 4b01 	ldrb.w	r4, [r1], #1
    a312:	4291      	cmp	r1, r2
    a314:	f803 4b01 	strb.w	r4, [r3], #1
    a318:	d1f9      	bne.n	a30e <memcpy+0x82>
    a31a:	bcf0      	pop	{r4, r5, r6, r7}
    a31c:	4770      	bx	lr
    a31e:	4603      	mov	r3, r0
    a320:	2a00      	cmp	r2, #0
    a322:	d1f3      	bne.n	a30c <memcpy+0x80>
    a324:	e7f9      	b.n	a31a <memcpy+0x8e>
    a326:	4603      	mov	r3, r0
    a328:	e7f0      	b.n	a30c <memcpy+0x80>
    a32a:	4662      	mov	r2, ip
    a32c:	2a00      	cmp	r2, #0
    a32e:	d1ed      	bne.n	a30c <memcpy+0x80>
    a330:	e7f3      	b.n	a31a <memcpy+0x8e>
    a332:	bf00      	nop

0000a334 <memset>:
    a334:	0783      	lsls	r3, r0, #30
    a336:	b4f0      	push	{r4, r5, r6, r7}
    a338:	d048      	beq.n	a3cc <memset+0x98>
    a33a:	1e54      	subs	r4, r2, #1
    a33c:	2a00      	cmp	r2, #0
    a33e:	d043      	beq.n	a3c8 <memset+0x94>
    a340:	b2cd      	uxtb	r5, r1
    a342:	4603      	mov	r3, r0
    a344:	e002      	b.n	a34c <memset+0x18>
    a346:	2c00      	cmp	r4, #0
    a348:	d03e      	beq.n	a3c8 <memset+0x94>
    a34a:	4614      	mov	r4, r2
    a34c:	f803 5b01 	strb.w	r5, [r3], #1
    a350:	f013 0f03 	tst.w	r3, #3
    a354:	f104 32ff 	add.w	r2, r4, #4294967295	; 0xffffffff
    a358:	d1f5      	bne.n	a346 <memset+0x12>
    a35a:	2c03      	cmp	r4, #3
    a35c:	d92d      	bls.n	a3ba <memset+0x86>
    a35e:	b2cd      	uxtb	r5, r1
    a360:	2c0f      	cmp	r4, #15
    a362:	ea45 2505 	orr.w	r5, r5, r5, lsl #8
    a366:	ea45 4505 	orr.w	r5, r5, r5, lsl #16
    a36a:	d918      	bls.n	a39e <memset+0x6a>
    a36c:	f1a4 0710 	sub.w	r7, r4, #16
    a370:	f103 0610 	add.w	r6, r3, #16
    a374:	461a      	mov	r2, r3
    a376:	093f      	lsrs	r7, r7, #4
    a378:	eb06 1607 	add.w	r6, r6, r7, lsl #4
    a37c:	6015      	str	r5, [r2, #0]
    a37e:	3210      	adds	r2, #16
    a380:	f842 5c0c 	str.w	r5, [r2, #-12]
    a384:	f842 5c08 	str.w	r5, [r2, #-8]
    a388:	f842 5c04 	str.w	r5, [r2, #-4]
    a38c:	42b2      	cmp	r2, r6
    a38e:	d1f5      	bne.n	a37c <memset+0x48>
    a390:	f004 040f 	and.w	r4, r4, #15
    a394:	3701      	adds	r7, #1
    a396:	2c03      	cmp	r4, #3
    a398:	eb03 1307 	add.w	r3, r3, r7, lsl #4
    a39c:	d90d      	bls.n	a3ba <memset+0x86>
    a39e:	461e      	mov	r6, r3
    a3a0:	4622      	mov	r2, r4
    a3a2:	3a04      	subs	r2, #4
    a3a4:	f846 5b04 	str.w	r5, [r6], #4
    a3a8:	2a03      	cmp	r2, #3
    a3aa:	d8fa      	bhi.n	a3a2 <memset+0x6e>
    a3ac:	1f22      	subs	r2, r4, #4
    a3ae:	f004 0403 	and.w	r4, r4, #3
    a3b2:	f022 0203 	bic.w	r2, r2, #3
    a3b6:	3204      	adds	r2, #4
    a3b8:	4413      	add	r3, r2
    a3ba:	b12c      	cbz	r4, a3c8 <memset+0x94>
    a3bc:	b2c9      	uxtb	r1, r1
    a3be:	441c      	add	r4, r3
    a3c0:	f803 1b01 	strb.w	r1, [r3], #1
    a3c4:	42a3      	cmp	r3, r4
    a3c6:	d1fb      	bne.n	a3c0 <memset+0x8c>
    a3c8:	bcf0      	pop	{r4, r5, r6, r7}
    a3ca:	4770      	bx	lr
    a3cc:	4614      	mov	r4, r2
    a3ce:	4603      	mov	r3, r0
    a3d0:	e7c3      	b.n	a35a <memset+0x26>
    a3d2:	bf00      	nop

0000a3d4 <__malloc_lock>:
    a3d4:	4770      	bx	lr
    a3d6:	bf00      	nop

0000a3d8 <__malloc_unlock>:
    a3d8:	4770      	bx	lr
    a3da:	bf00      	nop

0000a3dc <cleanup_glue>:
    a3dc:	b538      	push	{r3, r4, r5, lr}
    a3de:	460c      	mov	r4, r1
    a3e0:	6809      	ldr	r1, [r1, #0]
    a3e2:	4605      	mov	r5, r0
    a3e4:	b109      	cbz	r1, a3ea <cleanup_glue+0xe>
    a3e6:	f7ff fff9 	bl	a3dc <cleanup_glue>
    a3ea:	4628      	mov	r0, r5
    a3ec:	4621      	mov	r1, r4
    a3ee:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
    a3f2:	f000 b8df 	b.w	a5b4 <_free_r>
    a3f6:	bf00      	nop

0000a3f8 <_reclaim_reent>:
    a3f8:	f24b 5318 	movw	r3, #46360	; 0xb518
    a3fc:	f2c0 0300 	movt	r3, #0
    a400:	b570      	push	{r4, r5, r6, lr}
    a402:	4605      	mov	r5, r0
    a404:	681b      	ldr	r3, [r3, #0]
    a406:	4298      	cmp	r0, r3
    a408:	d031      	beq.n	a46e <_reclaim_reent+0x76>
    a40a:	6cc2      	ldr	r2, [r0, #76]	; 0x4c
    a40c:	b1aa      	cbz	r2, a43a <_reclaim_reent+0x42>
    a40e:	2300      	movs	r3, #0
    a410:	461e      	mov	r6, r3
    a412:	f852 1023 	ldr.w	r1, [r2, r3, lsl #2]
    a416:	b909      	cbnz	r1, a41c <_reclaim_reent+0x24>
    a418:	e007      	b.n	a42a <_reclaim_reent+0x32>
    a41a:	4621      	mov	r1, r4
    a41c:	680c      	ldr	r4, [r1, #0]
    a41e:	4628      	mov	r0, r5
    a420:	f000 f8c8 	bl	a5b4 <_free_r>
    a424:	2c00      	cmp	r4, #0
    a426:	d1f8      	bne.n	a41a <_reclaim_reent+0x22>
    a428:	6cea      	ldr	r2, [r5, #76]	; 0x4c
    a42a:	3601      	adds	r6, #1
    a42c:	2e20      	cmp	r6, #32
    a42e:	4633      	mov	r3, r6
    a430:	d1ef      	bne.n	a412 <_reclaim_reent+0x1a>
    a432:	4611      	mov	r1, r2
    a434:	4628      	mov	r0, r5
    a436:	f000 f8bd 	bl	a5b4 <_free_r>
    a43a:	6c29      	ldr	r1, [r5, #64]	; 0x40
    a43c:	b111      	cbz	r1, a444 <_reclaim_reent+0x4c>
    a43e:	4628      	mov	r0, r5
    a440:	f000 f8b8 	bl	a5b4 <_free_r>
    a444:	f8d5 1148 	ldr.w	r1, [r5, #328]	; 0x148
    a448:	b151      	cbz	r1, a460 <_reclaim_reent+0x68>
    a44a:	f505 76a6 	add.w	r6, r5, #332	; 0x14c
    a44e:	42b1      	cmp	r1, r6
    a450:	d006      	beq.n	a460 <_reclaim_reent+0x68>
    a452:	680c      	ldr	r4, [r1, #0]
    a454:	4628      	mov	r0, r5
    a456:	f000 f8ad 	bl	a5b4 <_free_r>
    a45a:	42a6      	cmp	r6, r4
    a45c:	4621      	mov	r1, r4
    a45e:	d1f8      	bne.n	a452 <_reclaim_reent+0x5a>
    a460:	6d69      	ldr	r1, [r5, #84]	; 0x54
    a462:	b111      	cbz	r1, a46a <_reclaim_reent+0x72>
    a464:	4628      	mov	r0, r5
    a466:	f000 f8a5 	bl	a5b4 <_free_r>
    a46a:	6bab      	ldr	r3, [r5, #56]	; 0x38
    a46c:	b903      	cbnz	r3, a470 <_reclaim_reent+0x78>
    a46e:	bd70      	pop	{r4, r5, r6, pc}
    a470:	6beb      	ldr	r3, [r5, #60]	; 0x3c
    a472:	4628      	mov	r0, r5
    a474:	4798      	blx	r3
    a476:	f8d5 12e0 	ldr.w	r1, [r5, #736]	; 0x2e0
    a47a:	2900      	cmp	r1, #0
    a47c:	d0f7      	beq.n	a46e <_reclaim_reent+0x76>
    a47e:	4628      	mov	r0, r5
    a480:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
    a484:	f7ff bfaa 	b.w	a3dc <cleanup_glue>

0000a488 <_sbrk_r>:
    a488:	b538      	push	{r3, r4, r5, lr}
    a48a:	f244 0444 	movw	r4, #16452	; 0x4044
    a48e:	f2c0 0401 	movt	r4, #1
    a492:	4605      	mov	r5, r0
    a494:	4608      	mov	r0, r1
    a496:	2300      	movs	r3, #0
    a498:	6023      	str	r3, [r4, #0]
    a49a:	f7fe e8fe 	blx	8698 <_sbrk>
    a49e:	1c43      	adds	r3, r0, #1
    a4a0:	d000      	beq.n	a4a4 <_sbrk_r+0x1c>
    a4a2:	bd38      	pop	{r3, r4, r5, pc}
    a4a4:	6823      	ldr	r3, [r4, #0]
    a4a6:	2b00      	cmp	r3, #0
    a4a8:	d0fb      	beq.n	a4a2 <_sbrk_r+0x1a>
    a4aa:	602b      	str	r3, [r5, #0]
    a4ac:	bd38      	pop	{r3, r4, r5, pc}
    a4ae:	bf00      	nop

0000a4b0 <strlen>:
    a4b0:	f020 0103 	bic.w	r1, r0, #3
    a4b4:	f010 0003 	ands.w	r0, r0, #3
    a4b8:	f1c0 0000 	rsb	r0, r0, #0
    a4bc:	f851 3b04 	ldr.w	r3, [r1], #4
    a4c0:	f100 0c04 	add.w	ip, r0, #4
    a4c4:	ea4f 0ccc 	mov.w	ip, ip, lsl #3
    a4c8:	f06f 0200 	mvn.w	r2, #0
    a4cc:	bf1c      	itt	ne
    a4ce:	fa22 f20c 	lsrne.w	r2, r2, ip
    a4d2:	4313      	orrne	r3, r2
    a4d4:	f04f 0c01 	mov.w	ip, #1
    a4d8:	ea4c 2c0c 	orr.w	ip, ip, ip, lsl #8
    a4dc:	ea4c 4c0c 	orr.w	ip, ip, ip, lsl #16
    a4e0:	eba3 020c 	sub.w	r2, r3, ip
    a4e4:	ea22 0203 	bic.w	r2, r2, r3
    a4e8:	ea12 12cc 	ands.w	r2, r2, ip, lsl #7
    a4ec:	bf04      	itt	eq
    a4ee:	f851 3b04 	ldreq.w	r3, [r1], #4
    a4f2:	3004      	addeq	r0, #4
    a4f4:	d0f4      	beq.n	a4e0 <strlen+0x30>
    a4f6:	f013 0fff 	tst.w	r3, #255	; 0xff
    a4fa:	bf1f      	itttt	ne
    a4fc:	3001      	addne	r0, #1
    a4fe:	f413 4f7f 	tstne.w	r3, #65280	; 0xff00
    a502:	3001      	addne	r0, #1
    a504:	f413 0f7f 	tstne.w	r3, #16711680	; 0xff0000
    a508:	bf18      	it	ne
    a50a:	3001      	addne	r0, #1
    a50c:	4770      	bx	lr
    a50e:	bf00      	nop

0000a510 <_malloc_trim_r>:
    a510:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
    a512:	f64a 44e0 	movw	r4, #44256	; 0xace0
    a516:	f2c0 0400 	movt	r4, #0
    a51a:	460f      	mov	r7, r1
    a51c:	4605      	mov	r5, r0
    a51e:	f7ff ff59 	bl	a3d4 <__malloc_lock>
    a522:	68a3      	ldr	r3, [r4, #8]
    a524:	685e      	ldr	r6, [r3, #4]
    a526:	f026 0603 	bic.w	r6, r6, #3
    a52a:	1bf7      	subs	r7, r6, r7
    a52c:	f607 77ef 	addw	r7, r7, #4079	; 0xfef
    a530:	0b3f      	lsrs	r7, r7, #12
    a532:	3f01      	subs	r7, #1
    a534:	033f      	lsls	r7, r7, #12
    a536:	f5b7 5f80 	cmp.w	r7, #4096	; 0x1000
    a53a:	db07      	blt.n	a54c <_malloc_trim_r+0x3c>
    a53c:	4628      	mov	r0, r5
    a53e:	2100      	movs	r1, #0
    a540:	f7ff ffa2 	bl	a488 <_sbrk_r>
    a544:	68a3      	ldr	r3, [r4, #8]
    a546:	4433      	add	r3, r6
    a548:	4298      	cmp	r0, r3
    a54a:	d004      	beq.n	a556 <_malloc_trim_r+0x46>
    a54c:	4628      	mov	r0, r5
    a54e:	f7ff ff43 	bl	a3d8 <__malloc_unlock>
    a552:	2000      	movs	r0, #0
    a554:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
    a556:	4628      	mov	r0, r5
    a558:	4279      	negs	r1, r7
    a55a:	f7ff ff95 	bl	a488 <_sbrk_r>
    a55e:	3001      	adds	r0, #1
    a560:	d010      	beq.n	a584 <_malloc_trim_r+0x74>
    a562:	68a1      	ldr	r1, [r4, #8]
    a564:	f244 031c 	movw	r3, #16412	; 0x401c
    a568:	f2c0 0301 	movt	r3, #1
    a56c:	1bf6      	subs	r6, r6, r7
    a56e:	4628      	mov	r0, r5
    a570:	f046 0601 	orr.w	r6, r6, #1
    a574:	681a      	ldr	r2, [r3, #0]
    a576:	604e      	str	r6, [r1, #4]
    a578:	1bd7      	subs	r7, r2, r7
    a57a:	601f      	str	r7, [r3, #0]
    a57c:	f7ff ff2c 	bl	a3d8 <__malloc_unlock>
    a580:	2001      	movs	r0, #1
    a582:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
    a584:	4628      	mov	r0, r5
    a586:	2100      	movs	r1, #0
    a588:	f7ff ff7e 	bl	a488 <_sbrk_r>
    a58c:	68a3      	ldr	r3, [r4, #8]
    a58e:	1ac2      	subs	r2, r0, r3
    a590:	2a0f      	cmp	r2, #15
    a592:	dddb      	ble.n	a54c <_malloc_trim_r+0x3c>
    a594:	f24b 04ec 	movw	r4, #45292	; 0xb0ec
    a598:	f2c0 0400 	movt	r4, #0
    a59c:	f244 011c 	movw	r1, #16412	; 0x401c
    a5a0:	f2c0 0101 	movt	r1, #1
    a5a4:	6824      	ldr	r4, [r4, #0]
    a5a6:	f042 0201 	orr.w	r2, r2, #1
    a5aa:	605a      	str	r2, [r3, #4]
    a5ac:	1b00      	subs	r0, r0, r4
    a5ae:	6008      	str	r0, [r1, #0]
    a5b0:	e7cc      	b.n	a54c <_malloc_trim_r+0x3c>
    a5b2:	bf00      	nop

0000a5b4 <_free_r>:
    a5b4:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    a5b8:	460e      	mov	r6, r1
    a5ba:	4680      	mov	r8, r0
    a5bc:	2900      	cmp	r1, #0
    a5be:	d05e      	beq.n	a67e <_free_r+0xca>
    a5c0:	f7ff ff08 	bl	a3d4 <__malloc_lock>
    a5c4:	f856 1c04 	ldr.w	r1, [r6, #-4]
    a5c8:	f64a 45e0 	movw	r5, #44256	; 0xace0
    a5cc:	f2c0 0500 	movt	r5, #0
    a5d0:	f1a6 0408 	sub.w	r4, r6, #8
    a5d4:	f021 0301 	bic.w	r3, r1, #1
    a5d8:	18e2      	adds	r2, r4, r3
    a5da:	68af      	ldr	r7, [r5, #8]
    a5dc:	6850      	ldr	r0, [r2, #4]
    a5de:	4297      	cmp	r7, r2
    a5e0:	f020 0003 	bic.w	r0, r0, #3
    a5e4:	d061      	beq.n	a6aa <_free_r+0xf6>
    a5e6:	f011 0101 	ands.w	r1, r1, #1
    a5ea:	6050      	str	r0, [r2, #4]
    a5ec:	bf18      	it	ne
    a5ee:	2100      	movne	r1, #0
    a5f0:	d10f      	bne.n	a612 <_free_r+0x5e>
    a5f2:	f856 6c08 	ldr.w	r6, [r6, #-8]
    a5f6:	f105 0c08 	add.w	ip, r5, #8
    a5fa:	1ba4      	subs	r4, r4, r6
    a5fc:	4433      	add	r3, r6
    a5fe:	68a6      	ldr	r6, [r4, #8]
    a600:	4566      	cmp	r6, ip
    a602:	bf17      	itett	ne
    a604:	f8d4 c00c 	ldrne.w	ip, [r4, #12]
    a608:	2101      	moveq	r1, #1
    a60a:	f8c6 c00c 	strne.w	ip, [r6, #12]
    a60e:	f8cc 6008 	strne.w	r6, [ip, #8]
    a612:	1816      	adds	r6, r2, r0
    a614:	6876      	ldr	r6, [r6, #4]
    a616:	07f6      	lsls	r6, r6, #31
    a618:	d408      	bmi.n	a62c <_free_r+0x78>
    a61a:	4403      	add	r3, r0
    a61c:	6890      	ldr	r0, [r2, #8]
    a61e:	b911      	cbnz	r1, a626 <_free_r+0x72>
    a620:	4e49      	ldr	r6, [pc, #292]	; (a748 <_free_r+0x194>)
    a622:	42b0      	cmp	r0, r6
    a624:	d060      	beq.n	a6e8 <_free_r+0x134>
    a626:	68d2      	ldr	r2, [r2, #12]
    a628:	60c2      	str	r2, [r0, #12]
    a62a:	6090      	str	r0, [r2, #8]
    a62c:	f043 0201 	orr.w	r2, r3, #1
    a630:	6062      	str	r2, [r4, #4]
    a632:	50e3      	str	r3, [r4, r3]
    a634:	b9f1      	cbnz	r1, a674 <_free_r+0xc0>
    a636:	f5b3 7f00 	cmp.w	r3, #512	; 0x200
    a63a:	d322      	bcc.n	a682 <_free_r+0xce>
    a63c:	0a5a      	lsrs	r2, r3, #9
    a63e:	2a04      	cmp	r2, #4
    a640:	d85b      	bhi.n	a6fa <_free_r+0x146>
    a642:	0998      	lsrs	r0, r3, #6
    a644:	3038      	adds	r0, #56	; 0x38
    a646:	0041      	lsls	r1, r0, #1
    a648:	eb05 0581 	add.w	r5, r5, r1, lsl #2
    a64c:	f64a 41e0 	movw	r1, #44256	; 0xace0
    a650:	f2c0 0100 	movt	r1, #0
    a654:	68aa      	ldr	r2, [r5, #8]
    a656:	42aa      	cmp	r2, r5
    a658:	d05b      	beq.n	a712 <_free_r+0x15e>
    a65a:	6851      	ldr	r1, [r2, #4]
    a65c:	f021 0103 	bic.w	r1, r1, #3
    a660:	428b      	cmp	r3, r1
    a662:	d202      	bcs.n	a66a <_free_r+0xb6>
    a664:	6892      	ldr	r2, [r2, #8]
    a666:	4295      	cmp	r5, r2
    a668:	d1f7      	bne.n	a65a <_free_r+0xa6>
    a66a:	68d3      	ldr	r3, [r2, #12]
    a66c:	60e3      	str	r3, [r4, #12]
    a66e:	60a2      	str	r2, [r4, #8]
    a670:	609c      	str	r4, [r3, #8]
    a672:	60d4      	str	r4, [r2, #12]
    a674:	4640      	mov	r0, r8
    a676:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
    a67a:	f7ff bead 	b.w	a3d8 <__malloc_unlock>
    a67e:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    a682:	08db      	lsrs	r3, r3, #3
    a684:	2101      	movs	r1, #1
    a686:	6868      	ldr	r0, [r5, #4]
    a688:	eb05 02c3 	add.w	r2, r5, r3, lsl #3
    a68c:	109b      	asrs	r3, r3, #2
    a68e:	fa01 f303 	lsl.w	r3, r1, r3
    a692:	6891      	ldr	r1, [r2, #8]
    a694:	4318      	orrs	r0, r3
    a696:	60e2      	str	r2, [r4, #12]
    a698:	6068      	str	r0, [r5, #4]
    a69a:	4640      	mov	r0, r8
    a69c:	60a1      	str	r1, [r4, #8]
    a69e:	6094      	str	r4, [r2, #8]
    a6a0:	60cc      	str	r4, [r1, #12]
    a6a2:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
    a6a6:	f7ff be97 	b.w	a3d8 <__malloc_unlock>
    a6aa:	07cf      	lsls	r7, r1, #31
    a6ac:	4418      	add	r0, r3
    a6ae:	d407      	bmi.n	a6c0 <_free_r+0x10c>
    a6b0:	f856 3c08 	ldr.w	r3, [r6, #-8]
    a6b4:	1ae4      	subs	r4, r4, r3
    a6b6:	4418      	add	r0, r3
    a6b8:	68a2      	ldr	r2, [r4, #8]
    a6ba:	68e3      	ldr	r3, [r4, #12]
    a6bc:	60d3      	str	r3, [r2, #12]
    a6be:	609a      	str	r2, [r3, #8]
    a6c0:	f24b 02e8 	movw	r2, #45288	; 0xb0e8
    a6c4:	f2c0 0200 	movt	r2, #0
    a6c8:	f040 0301 	orr.w	r3, r0, #1
    a6cc:	6063      	str	r3, [r4, #4]
    a6ce:	6813      	ldr	r3, [r2, #0]
    a6d0:	60ac      	str	r4, [r5, #8]
    a6d2:	4298      	cmp	r0, r3
    a6d4:	d3ce      	bcc.n	a674 <_free_r+0xc0>
    a6d6:	f244 0318 	movw	r3, #16408	; 0x4018
    a6da:	f2c0 0301 	movt	r3, #1
    a6de:	4640      	mov	r0, r8
    a6e0:	6819      	ldr	r1, [r3, #0]
    a6e2:	f7ff ff15 	bl	a510 <_malloc_trim_r>
    a6e6:	e7c5      	b.n	a674 <_free_r+0xc0>
    a6e8:	616c      	str	r4, [r5, #20]
    a6ea:	f043 0201 	orr.w	r2, r3, #1
    a6ee:	612c      	str	r4, [r5, #16]
    a6f0:	60e0      	str	r0, [r4, #12]
    a6f2:	60a0      	str	r0, [r4, #8]
    a6f4:	6062      	str	r2, [r4, #4]
    a6f6:	50e3      	str	r3, [r4, r3]
    a6f8:	e7bc      	b.n	a674 <_free_r+0xc0>
    a6fa:	2a14      	cmp	r2, #20
    a6fc:	bf9c      	itt	ls
    a6fe:	f102 005b 	addls.w	r0, r2, #91	; 0x5b
    a702:	0041      	lslls	r1, r0, #1
    a704:	d9a0      	bls.n	a648 <_free_r+0x94>
    a706:	2a54      	cmp	r2, #84	; 0x54
    a708:	d80c      	bhi.n	a724 <_free_r+0x170>
    a70a:	0b18      	lsrs	r0, r3, #12
    a70c:	306e      	adds	r0, #110	; 0x6e
    a70e:	0041      	lsls	r1, r0, #1
    a710:	e79a      	b.n	a648 <_free_r+0x94>
    a712:	2301      	movs	r3, #1
    a714:	684d      	ldr	r5, [r1, #4]
    a716:	1080      	asrs	r0, r0, #2
    a718:	fa03 f000 	lsl.w	r0, r3, r0
    a71c:	4613      	mov	r3, r2
    a71e:	4305      	orrs	r5, r0
    a720:	604d      	str	r5, [r1, #4]
    a722:	e7a3      	b.n	a66c <_free_r+0xb8>
    a724:	f5b2 7faa 	cmp.w	r2, #340	; 0x154
    a728:	d803      	bhi.n	a732 <_free_r+0x17e>
    a72a:	0bd8      	lsrs	r0, r3, #15
    a72c:	3077      	adds	r0, #119	; 0x77
    a72e:	0041      	lsls	r1, r0, #1
    a730:	e78a      	b.n	a648 <_free_r+0x94>
    a732:	f240 5154 	movw	r1, #1364	; 0x554
    a736:	428a      	cmp	r2, r1
    a738:	bf99      	ittee	ls
    a73a:	0c98      	lsrls	r0, r3, #18
    a73c:	307c      	addls	r0, #124	; 0x7c
    a73e:	21fc      	movhi	r1, #252	; 0xfc
    a740:	207e      	movhi	r0, #126	; 0x7e
    a742:	bf98      	it	ls
    a744:	0041      	lslls	r1, r0, #1
    a746:	e77f      	b.n	a648 <_free_r+0x94>
    a748:	0000ace8 	andeq	sl, r0, r8, ror #25

Disassembly of section .rodata:

0000a74c <_global_impure_ptr-0x584>:
    a74c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
    a750:	73206c65 	teqvc	r0, #25856	; 0x6500
    a754:	74726174 	ldrbtvc	r6, [r2], #-372	; 0x174
    a758:	000a0d21 	andeq	r0, sl, r1, lsr #26
    a75c:	616f7469 	cmnvs	pc, r9, ror #8
    a760:	73657420 	cmnvc	r5, #32, 8	; 0x20000000
    a764:	00203a74 	eoreq	r3, r0, r4, ror sl
    a768:	20202020 	eorcs	r2, r0, r0, lsr #32
    a76c:	6e696220 	cdpvs	2, 6, cr6, cr9, cr0, {1}
    a770:	3a797261 	bcc	1e670fc <_stack+0x1de70fc>
    a774:	00000000 	andeq	r0, r0, r0
    a778:	20202020 	eorcs	r2, r0, r0, lsr #32
    a77c:	63656420 	cmnvs	r5, #32, 8	; 0x20000000
    a780:	6c616d69 	stclvs	13, cr6, [r1], #-420	; 0xfffffe5c
    a784:	0000003a 	andeq	r0, r0, sl, lsr r0
    a788:	20202020 	eorcs	r2, r0, r0, lsr #32
    a78c:	78656820 	stmdavc	r5!, {r5, fp, sp, lr}^
    a790:	63656461 	cmnvs	r5, #1627389952	; 0x61000000
    a794:	6c616d69 	stclvs	13, cr6, [r1], #-420	; 0xfffffe5c
    a798:	0000003a 	andeq	r0, r0, sl, lsr r0
    a79c:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    a7a0:	676e6974 			; <UNDEFINED> instruction: 0x676e6974
    a7a4:	756d6d20 	strbvc	r6, [sp, #-3360]!	; 0xd20
    a7a8:	00000a0d 	andeq	r0, r0, sp, lsl #20
    a7ac:	20756d6d 	rsbscs	r6, r5, sp, ror #26
    a7b0:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    a7b4:	0d646574 	cfstr64eq	mvdx6, [r4, #-464]!	; 0xfffffe30
    a7b8:	0000000a 	andeq	r0, r0, sl
    a7bc:	65686568 	strbvs	r6, [r8, #-1384]!	; 0x568
    a7c0:	00000d0a 	andeq	r0, r0, sl, lsl #26
    a7c4:	69676572 	stmdbvs	r7!, {r1, r4, r5, r6, r8, sl, sp, lr}^
    a7c8:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
    a7cc:	20676e69 	rsbcs	r6, r7, r9, ror #28
    a7d0:	65726874 	ldrbvs	r6, [r2, #-2164]!	; 0x874
    a7d4:	0d736461 	cfldrdeq	mvd6, [r3, #-388]!	; 0xfffffe7c
    a7d8:	0000000a 	andeq	r0, r0, sl
    a7dc:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    a7e0:	676e6974 			; <UNDEFINED> instruction: 0x676e6974
    a7e4:	72687420 	rsbvc	r7, r8, #32, 8	; 0x20000000
    a7e8:	73646165 	cmnvc	r4, #1073741849	; 0x40000019
    a7ec:	00000a0d 	andeq	r0, r0, sp, lsl #20
    a7f0:	65726874 	ldrbvs	r6, [r2, #-2164]!	; 0x874
    a7f4:	5f736461 	svcpl	0x00736461
    a7f8:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    a7fc:	2e646574 	mcrcs	5, 3, r6, cr4, cr4, {3}
    a800:	61747320 	cmnvs	r4, r0, lsr #6
    a804:	6e697472 	mcrvs	4, 3, r7, cr9, cr2, {3}
    a808:	69742067 	ldmdbvs	r4!, {r0, r1, r2, r5, r6, sp}^
    a80c:	2072656d 	rsbscs	r6, r2, sp, ror #10
    a810:	73717269 	cmnvc	r1, #-1879048186	; 0x90000006
    a814:	00000a0d 	andeq	r0, r0, sp, lsl #20
    a818:	524f4241 	subpl	r4, pc, #268435460	; 0x10000004
    a81c:	6e695f54 	mcrvs	15, 3, r5, cr9, cr4, {2}
    a820:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
    a824:	21747075 	cmncs	r4, r5, ror r0
    a828:	000a0d21 	andeq	r0, sl, r1, lsr #26
    a82c:	65646e75 	strbvs	r6, [r4, #-3701]!	; 0xe75
    a830:	656e6966 	strbvs	r6, [lr, #-2406]!	; 0x966
    a834:	6f6d2064 	svcvs	0x006d2064
    a838:	66206564 	strtvs	r6, [r0], -r4, ror #10
    a83c:	3a6d6f72 	bcc	1b6660c <_stack+0x1ae660c>
    a840:	00000020 	andeq	r0, r0, r0, lsr #32
    a844:	4d4d5544 	cfstr64mi	mvdx5, [sp, #-272]	; 0xfffffef0
    a848:	41432059 	qdaddmi	r2, r9, r3
    a84c:	21214c4c 	teqcs	r1, ip, asr #24
    a850:	000a0d21 	andeq	r0, sl, r1, lsr #26
    a854:	66657270 			; <UNDEFINED> instruction: 0x66657270
    a858:	68637465 	stmdavs	r3!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    a85c:	6f626120 	svcvs	0x00626120
    a860:	66207472 			; <UNDEFINED> instruction: 0x66207472
    a864:	3a6d6f72 	bcc	1b66634 <_stack+0x1ae6634>
    a868:	00000020 	andeq	r0, r0, r0, lsr #32
    a86c:	74697720 	strbtvc	r7, [r9], #-1824	; 0x720
    a870:	74732068 	ldrbtvc	r2, [r3], #-104	; 0x68
    a874:	3a6b6361 	bcc	1ae3600 <_stack+0x1a63600>
    a878:	00000020 	andeq	r0, r0, r0, lsr #32
    a87c:	61746164 	cmnvs	r4, r4, ror #2
    a880:	6f626120 	svcvs	0x00626120
    a884:	66207472 			; <UNDEFINED> instruction: 0x66207472
    a888:	3a6d6f72 	bcc	1b66658 <_stack+0x1ae6658>
    a88c:	00000020 	andeq	r0, r0, r0, lsr #32
    a890:	0d514946 	ldcleq	9, cr4, [r1, #-280]	; 0xfffffee8
    a894:	0000000a 	andeq	r0, r0, sl
    a898:	7778797a 			; <UNDEFINED> instruction: 0x7778797a
    a89c:	73747576 	cmnvc	r4, #494927872	; 0x1d800000
    a8a0:	6f707172 	svcvs	0x00707172
    a8a4:	6b6c6d6e 	blvs	1b25e64 <_stack+0x1aa5e64>
    a8a8:	6768696a 	strbvs	r6, [r8, -sl, ror #18]!
    a8ac:	63646566 	cmnvs	r4, #427819008	; 0x19800000
    a8b0:	38396162 	ldmdacc	r9!, {r1, r5, r6, r8, sp, lr}
    a8b4:	34353637 	ldrtcc	r3, [r5], #-1591	; 0x637
    a8b8:	30313233 	eorscc	r3, r1, r3, lsr r2
    a8bc:	34333231 	ldrtcc	r3, [r3], #-561	; 0x231
    a8c0:	38373635 	ldmdacc	r7!, {r0, r2, r4, r5, r9, sl, ip, sp}
    a8c4:	63626139 	cmnvs	r2, #1073741838	; 0x4000000e
    a8c8:	67666564 	strbvs	r6, [r6, -r4, ror #10]!
    a8cc:	6b6a6968 	blvs	1aa4e74 <_stack+0x1a24e74>
    a8d0:	6f6e6d6c 	svcvs	0x006e6d6c
    a8d4:	73727170 	cmnvc	r2, #112, 2
    a8d8:	77767574 			; <UNDEFINED> instruction: 0x77767574
    a8dc:	007a7978 	rsbseq	r7, sl, r8, ror r9
    a8e0:	00007830 	andeq	r7, r0, r0, lsr r8
    a8e4:	00006230 	andeq	r6, r0, r0, lsr r2
    a8e8:	41414141 	cmpmi	r1, r1, asr #2
    a8ec:	41414141 	cmpmi	r1, r1, asr #2
    a8f0:	41414141 	cmpmi	r1, r1, asr #2
    a8f4:	41414141 	cmpmi	r1, r1, asr #2
    a8f8:	41414141 	cmpmi	r1, r1, asr #2
    a8fc:	41414141 	cmpmi	r1, r1, asr #2
    a900:	41414141 	cmpmi	r1, r1, asr #2
    a904:	41414141 	cmpmi	r1, r1, asr #2
    a908:	41414141 	cmpmi	r1, r1, asr #2
    a90c:	41414141 	cmpmi	r1, r1, asr #2
    a910:	41414141 	cmpmi	r1, r1, asr #2
    a914:	41414141 	cmpmi	r1, r1, asr #2
    a918:	41414141 	cmpmi	r1, r1, asr #2
    a91c:	41414141 	cmpmi	r1, r1, asr #2
    a920:	41414141 	cmpmi	r1, r1, asr #2
    a924:	0d414141 	stfeqe	f4, [r1, #-260]	; 0xfffffefc
    a928:	0000000a 	andeq	r0, r0, sl
    a92c:	52535043 	subspl	r5, r3, #67	; 0x43
    a930:	444f4d5f 	strbmi	r4, [pc], #-3423	; a938 <_free_r+0x384>
    a934:	53555f45 	cmppl	r5, #276	; 0x114
    a938:	0a0d5245 	beq	35f254 <_stack+0x2df254>
    a93c:	00000000 	andeq	r0, r0, r0
    a940:	52535043 	subspl	r5, r3, #67	; 0x43
    a944:	444f4d5f 	strbmi	r4, [pc], #-3423	; a94c <_free_r+0x398>
    a948:	49465f45 	stmdbmi	r6, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
    a94c:	000a0d51 	andeq	r0, sl, r1, asr sp
    a950:	52535043 	subspl	r5, r3, #67	; 0x43
    a954:	444f4d5f 	strbmi	r4, [pc], #-3423	; a95c <_free_r+0x3a8>
    a958:	52495f45 	subpl	r5, r9, #276	; 0x114
    a95c:	000a0d51 	andeq	r0, sl, r1, asr sp
    a960:	52535043 	subspl	r5, r3, #67	; 0x43
    a964:	444f4d5f 	strbmi	r4, [pc], #-3423	; a96c <_free_r+0x3b8>
    a968:	56535f45 	ldrbpl	r5, [r3], -r5, asr #30
    a96c:	000a0d52 	andeq	r0, sl, r2, asr sp
    a970:	52535043 	subspl	r5, r3, #67	; 0x43
    a974:	444f4d5f 	strbmi	r4, [pc], #-3423	; a97c <_free_r+0x3c8>
    a978:	42415f45 	submi	r5, r1, #276	; 0x114
    a97c:	0d54524f 	lfmeq	f5, 2, [r4, #-316]	; 0xfffffec4
    a980:	0000000a 	andeq	r0, r0, sl
    a984:	52535043 	subspl	r5, r3, #67	; 0x43
    a988:	444f4d5f 	strbmi	r4, [pc], #-3423	; a990 <_free_r+0x3dc>
    a98c:	4e555f45 	cdpmi	15, 5, cr5, cr5, cr5, {2}
    a990:	49464544 	stmdbmi	r6, {r2, r6, r8, sl, lr}^
    a994:	0d44454e 	cfstr64eq	mvdx4, [r4, #-312]	; 0xfffffec8
    a998:	0000000a 	andeq	r0, r0, sl
    a99c:	52535043 	subspl	r5, r3, #67	; 0x43
    a9a0:	444f4d5f 	strbmi	r4, [pc], #-3423	; a9a8 <_free_r+0x3f4>
    a9a4:	59535f45 	ldmdbpl	r3, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
    a9a8:	4d455453 	cfstrdmi	mvd5, [r5, #-332]	; 0xfffffeb4
    a9ac:	00000a0d 	andeq	r0, r0, sp, lsl #20
    a9b0:	73207461 	teqvc	r0, #1627389952	; 0x61000000
    a9b4:	74726174 	ldrbtvc	r6, [r2], #-372	; 0x174
    a9b8:	20666f20 	rsbcs	r6, r6, r0, lsr #30
    a9bc:	676f7270 			; <UNDEFINED> instruction: 0x676f7270
    a9c0:	0a0d3120 	beq	356e48 <_stack+0x2d6e48>
    a9c4:	00000000 	andeq	r0, r0, r0
    a9c8:	65732031 	ldrbvs	r2, [r3, #-49]!	; 0x31
    a9cc:	6e69646e 	cdpvs	4, 6, cr6, cr9, cr14, {3}
    a9d0:	3a782067 	bcc	1e12b74 <_stack+0x1d92b74>
    a9d4:	00000000 	andeq	r0, r0, r0
    a9d8:	73207461 	teqvc	r0, #1627389952	; 0x61000000
    a9dc:	74726174 	ldrbtvc	r6, [r2], #-372	; 0x174
    a9e0:	20666f20 	rsbcs	r6, r6, r0, lsr #30
    a9e4:	676f7270 			; <UNDEFINED> instruction: 0x676f7270
    a9e8:	0a0d3220 	beq	357270 <_stack+0x2d7270>
    a9ec:	00000000 	andeq	r0, r0, r0
    a9f0:	676f7270 			; <UNDEFINED> instruction: 0x676f7270
    a9f4:	63203220 	teqvs	r0, #32, 4
    a9f8:	696c6c61 	stmdbvs	ip!, {r0, r5, r6, sl, fp, sp, lr}^
    a9fc:	7220676e 	eorvc	r6, r0, #28835840	; 0x1b80000
    aa00:	69656365 	stmdbvs	r5!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    aa04:	0a0d6576 	beq	363fe4 <_stack+0x2e3fe4>
    aa08:	00000000 	andeq	r0, r0, r0
    aa0c:	65722032 	ldrbvs	r2, [r2, #-50]!	; 0x32
    aa10:	76696563 	strbtvc	r6, [r9], -r3, ror #10
    aa14:	78206465 	stmdavc	r0!, {r0, r2, r5, r6, sl, sp, lr}
    aa18:	0000003d 	andeq	r0, r0, sp, lsr r0
    aa1c:	6f726620 	svcvs	0x00726620
    aa20:	0000206d 	andeq	r2, r0, sp, rrx
    aa24:	73692033 	cmnvc	r9, #51	; 0x33
    aa28:	6e757220 	cdpvs	2, 7, cr7, cr5, cr0, {1}
    aa2c:	6969696e 	stmdbvs	r9!, {r1, r2, r3, r5, r6, r8, fp, sp, lr}^
    aa30:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa34:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa38:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa3c:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa40:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa44:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa48:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa4c:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa50:	69696969 	stmdbvs	r9!, {r0, r3, r5, r6, r8, fp, sp, lr}^
    aa54:	0a0d676e 	beq	364814 <_stack+0x2e4814>
    aa58:	00000000 	andeq	r0, r0, r0
    aa5c:	5f626370 	svcpl	0x00626370
    aa60:	2077656e 	rsbscs	r6, r7, lr, ror #10
    aa64:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
    aa68:	6620636f 	strtvs	r6, [r0], -pc, ror #6
    aa6c:	656c6961 	strbvs	r6, [ip, #-2401]!	; 0x961
    aa70:	000a0d64 	andeq	r0, sl, r4, ror #26
    aa74:	65766173 	ldrbvs	r6, [r6, #-371]!	; 0x173
    aa78:	61747320 	cmnvs	r4, r0, lsr #6
    aa7c:	70206b63 	eorvc	r6, r0, r3, ror #22
    aa80:	70207274 	eorvc	r7, r0, r4, ror r2
    aa84:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xf72
    aa88:	6e207373 	mcrvs	3, 1, r7, cr0, cr3, {3}
    aa8c:	6620746f 	strtvs	r7, [r0], -pc, ror #8
    aa90:	646e756f 	strbtvs	r7, [lr], #-1391	; 0x56f
    aa94:	00000a0d 	andeq	r0, r0, sp, lsl #20
    aa98:	20424350 	subcs	r4, r2, r0, asr r3
    aa9c:	7473696c 	ldrbtvc	r6, [r3], #-2412	; 0x96c
    aaa0:	6e6f6320 	cdpvs	3, 6, cr6, cr15, cr0, {1}
    aaa4:	6e696174 	mcrvs	1, 3, r6, cr9, cr4, {3}
    aaa8:	00203a73 	eoreq	r3, r0, r3, ror sl
    aaac:	0000202c 	andeq	r2, r0, ip, lsr #32
    aab0:	63617473 	cmnvs	r1, #1929379840	; 0x73000000
    aab4:	6f70206b 	svcvs	0x0070206b
    aab8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xe69
    aabc:	6c612072 	stclvs	0, cr2, [r1], #-456	; 0xfffffe38
    aac0:	61636f6c 	cmnvs	r3, ip, ror #30
    aac4:	6e6f6974 	mcrvs	9, 3, r6, cr15, cr4, {3}
    aac8:	69616620 	stmdbvs	r1!, {r5, r9, sl, sp, lr}^
    aacc:	0d64656c 	cfstr64eq	mvdx6, [r4, #-432]!	; 0xfffffe50
    aad0:	0000000a 	andeq	r0, r0, sl
    aad4:	65726874 	ldrbvs	r6, [r2, #-2164]!	; 0x874
    aad8:	61206461 	teqvs	r0, r1, ror #8
    aadc:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
    aae0:	64656461 	strbtvs	r6, [r5], #-1121	; 0x461
    aae4:	7473202e 	ldrbtvc	r2, [r3], #-46	; 0x2e
    aae8:	206b6361 	rsbcs	r6, fp, r1, ror #6
    aaec:	00207461 	eoreq	r7, r0, r1, ror #8
    aaf0:	646e6120 	strbtvs	r6, [lr], #-288	; 0x120
    aaf4:	6f727020 	svcvs	0x00727020
    aaf8:	6d617267 	sfmvs	f7, 2, [r1, #-412]!	; 0xfffffe64
    aafc:	61747320 	cmnvs	r4, r0, lsr #6
    ab00:	61207472 	teqvs	r0, r2, ror r4
    ab04:	00002074 	andeq	r2, r0, r4, ror r0
    ab08:	20626370 	rsbcs	r6, r2, r0, ror r3
    ab0c:	4c4c554e 	cfstr64mi	mvdx5, [ip], {78}	; 0x4e
    ab10:	00000a0d 	andeq	r0, r0, sp, lsl #20
    ab14:	6f697270 	svcvs	0x00697270
    ab18:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
    ab1c:	69727020 	ldmdbvs	r2!, {r5, ip, sp, lr}^
    ab20:	6c20746e 	cfstrsvs	mvf7, [r0], #-440	; 0xfffffe48
    ab24:	3a747369 	bcc	1d278d0 <_stack+0x1ca78d0>
    ab28:	00000a0d 	andeq	r0, r0, sp, lsl #20
    ab2c:	6f697270 	svcvs	0x00697270
    ab30:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
    ab34:	69727020 	ldmdbvs	r2!, {r5, ip, sp, lr}^
    ab38:	0020746e 	eoreq	r7, r0, lr, ror #8
    ab3c:	0000203a 	andeq	r2, r0, sl, lsr r0
    ab40:	6c696146 	stfvse	f6, [r9], #-280	; 0xfffffee8
    ab44:	74206465 	strtvc	r6, [r0], #-1125	; 0x465
    ab48:	6c61206f 	stclvs	0, cr2, [r1], #-444	; 0xfffffe44
    ab4c:	61636f6c 	cmnvs	r3, ip, ror #30
    ab50:	6e206574 	mcrvs	5, 1, r6, cr0, cr4, {3}
    ab54:	70207765 	eorvc	r7, r0, r5, ror #14
    ab58:	726f6972 	rsbvc	r6, pc, #1867776	; 0x1c8000
    ab5c:	5f797469 	svcpl	0x00797469
    ab60:	65646f6e 	strbvs	r6, [r4, #-3950]!	; 0xf6e
    ab64:	000a0d21 	andeq	r0, sl, r1, lsr #26
    ab68:	6f697270 	svcvs	0x00697270
    ab6c:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
    ab70:	74756f20 	ldrbtvc	r6, [r5], #-3872	; 0xf20
    ab74:	20666f20 	rsbcs	r6, r6, r0, lsr #30
    ab78:	6e756f62 	cdpvs	15, 7, cr6, cr5, cr2, {3}
    ab7c:	00007364 	andeq	r7, r0, r4, ror #6
    ab80:	4f525245 	svcmi	0x00525245
    ab84:	53203a52 	teqpl	r0, #335872	; 0x52000
    ab88:	64656863 	strbtvs	r6, [r5], #-2147	; 0x863
    ab8c:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
    ab90:	716e6520 	cmnvc	lr, r0, lsr #10
    ab94:	69756575 	ldmdbvs	r5!, {r0, r2, r4, r5, r6, r8, sl, sp, lr}^
    ab98:	6520676e 	strvs	r6, [r0, #-1902]!	; 0x76e
    ab9c:	726f7272 	rsbvc	r7, pc, #536870919	; 0x20000007
    aba0:	00000a0d 	andeq	r0, r0, sp, lsl #20
    aba4:	4e52454b 	cdpmi	5, 5, cr4, cr2, cr11, {2}
    aba8:	52524520 	subspl	r4, r2, #32, 10	; 0x8000000
    abac:	203a524f 	eorscs	r5, sl, pc, asr #4
    abb0:	20746567 	rsbscs	r6, r4, r7, ror #10
    abb4:	68676968 	stmdavs	r7!, {r3, r5, r6, r8, fp, sp, lr}^
    abb8:	20747365 	rsbscs	r7, r4, r5, ror #6
    abbc:	6f697270 	svcvs	0x00697270
    abc0:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
    abc4:	69616620 	stmdbvs	r1!, {r5, r9, sl, sp, lr}^
    abc8:	0d64656c 	cfstr64eq	mvdx6, [r4, #-432]!	; 0xfffffe50
    abcc:	0000000a 	andeq	r0, r0, sl
    abd0:	4e52454b 	cdpmi	5, 5, cr4, cr2, cr11, {2}
    abd4:	72724520 	rsbsvc	r4, r2, #32, 10	; 0x8000000
    abd8:	203a726f 	eorscs	r7, sl, pc, ror #4
    abdc:	65766153 	ldrbvs	r6, [r6, #-339]!	; 0x153
    abe0:	6f727020 	svcvs	0x00727020
    abe4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
    abe8:	6e6f6320 	cdpvs	3, 6, cr6, cr15, cr0, {1}
    abec:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0x574
    abf0:	6977735f 	ldmdbvs	r7!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, sp, lr}^
    abf4:	5f686374 	svcpl	0x00686374
    abf8:	000a0d63 	andeq	r0, sl, r3, ror #26
    abfc:	4e52454b 	cdpmi	5, 5, cr4, cr2, cr11, {2}
    ac00:	72724520 	rsbsvc	r4, r2, #32, 10	; 0x8000000
    ac04:	203a726f 	eorscs	r7, sl, pc, ror #4
    ac08:	64616f4c 	strbtvs	r6, [r1], #-3916	; 0xf4c
    ac0c:	6f727020 	svcvs	0x00727020
    ac10:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
    ac14:	6e6f6320 	cdpvs	3, 6, cr6, cr15, cr0, {1}
    ac18:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0x574
    ac1c:	6977735f 	ldmdbvs	r7!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, sp, lr}^
    ac20:	5f686374 	svcpl	0x00686374
    ac24:	000a0d63 	andeq	r0, sl, r3, ror #26
    ac28:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
    ac2c:	65722074 	ldrbvs	r2, [r2, #-116]!	; 0x74
    ac30:	00203a67 	eoreq	r3, r0, r7, ror #20
    ac34:	20706f74 	rsbscs	r6, r0, r4, ror pc
    ac38:	7320666f 	teqvc	r0, #116391936	; 0x6f00000
    ac3c:	6b636174 	blvs	18e3214 <_stack+0x1863214>
    ac40:	6e6f6320 	cdpvs	3, 6, cr6, cr15, cr0, {1}
    ac44:	6e696174 	mcrvs	1, 3, r6, cr9, cr4, {3}
    ac48:	00203a73 	eoreq	r3, r0, r3, ror sl
    ac4c:	6c696146 	stfvse	f6, [r9], #-280	; 0xfffffee8
    ac50:	74206465 	strtvc	r6, [r0], #-1125	; 0x465
    ac54:	6c61206f 	stclvs	0, cr2, [r1], #-444	; 0xfffffe44
    ac58:	61636f6c 	cmnvs	r3, ip, ror #30
    ac5c:	6e206574 	mcrvs	5, 1, r6, cr0, cr4, {3}
    ac60:	49207765 	stmdbmi	r0!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}
    ac64:	70204350 	eorvc	r4, r0, r0, asr r3
    ac68:	726f6972 	rsbvc	r6, pc, #1867776	; 0x1c8000
    ac6c:	5f797469 	svcpl	0x00797469
    ac70:	65646f6e 	strbvs	r6, [r4, #-3950]!	; 0xf6e
    ac74:	000a0d21 	andeq	r0, sl, r1, lsr #26
    ac78:	20637069 	rsbcs	r7, r3, r9, rrx
    ac7c:	2067736d 	rsbcs	r7, r7, sp, ror #6
    ac80:	75716e65 	ldrbvc	r6, [r1, #-3685]!	; 0xe65
    ac84:	20657565 	rsbcs	r7, r5, r5, ror #10
    ac88:	64696f63 	strbtvs	r6, [r9], #-3939	; 0xf63
    ac8c:	6263705f 	rsbvs	r7, r3, #95	; 0x5f
    ac90:	203d3d20 	eorscs	r3, sp, r0, lsr #26
    ac94:	4c4c554e 	cfstr64mi	mvdx5, [ip], {78}	; 0x4e
    ac98:	20202020 	eorcs	r2, r0, r0, lsr #32
    ac9c:	696f6320 	stmdbvs	pc!, {r5, r8, r9, sp, lr}^	; <UNPREDICTABLE>
    aca0:	3d3d2064 	ldccc	0, cr2, [sp, #-400]!	; 0xfffffe70
    aca4:	00000020 	andeq	r0, r0, r0, lsr #32
    aca8:	20435049 	subcs	r5, r3, r9, asr #32
    acac:	6f697270 	svcvs	0x00697270
    acb0:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
    acb4:	74756f20 	ldrbtvc	r6, [r5], #-3872	; 0xf20
    acb8:	20666f20 	rsbcs	r6, r6, r0, lsr #30
    acbc:	6e756f62 	cdpvs	15, 7, cr6, cr5, cr2, {3}
    acc0:	0a0d7364 	beq	367a58 <_stack+0x2e7a58>
    acc4:	00000000 	andeq	r0, r0, r0
    acc8:	0000007c 	andeq	r0, r0, ip, ror r0
    accc:	00000043 	andeq	r0, r0, r3, asr #32

0000acd0 <_global_impure_ptr>:
    acd0:	0000b0f0 	strdeq	fp, [r0], -r0

Disassembly of section .data:

0000acd8 <__data_start>:
    acd8:	0000c004 	andeq	ip, r0, r4

0000acdc <current_running_process>:
    acdc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000ace0 <__malloc_av_>:
	...
    ace8:	0000ace0 	andeq	sl, r0, r0, ror #25
    acec:	0000ace0 	andeq	sl, r0, r0, ror #25
    acf0:	0000ace8 	andeq	sl, r0, r8, ror #25
    acf4:	0000ace8 	andeq	sl, r0, r8, ror #25
    acf8:	0000acf0 	strdeq	sl, [r0], -r0
    acfc:	0000acf0 	strdeq	sl, [r0], -r0
    ad00:	0000acf8 	strdeq	sl, [r0], -r8
    ad04:	0000acf8 	strdeq	sl, [r0], -r8
    ad08:	0000ad00 	andeq	sl, r0, r0, lsl #26
    ad0c:	0000ad00 	andeq	sl, r0, r0, lsl #26
    ad10:	0000ad08 	andeq	sl, r0, r8, lsl #26
    ad14:	0000ad08 	andeq	sl, r0, r8, lsl #26
    ad18:	0000ad10 	andeq	sl, r0, r0, lsl sp
    ad1c:	0000ad10 	andeq	sl, r0, r0, lsl sp
    ad20:	0000ad18 	andeq	sl, r0, r8, lsl sp
    ad24:	0000ad18 	andeq	sl, r0, r8, lsl sp
    ad28:	0000ad20 	andeq	sl, r0, r0, lsr #26
    ad2c:	0000ad20 	andeq	sl, r0, r0, lsr #26
    ad30:	0000ad28 	andeq	sl, r0, r8, lsr #26
    ad34:	0000ad28 	andeq	sl, r0, r8, lsr #26
    ad38:	0000ad30 	andeq	sl, r0, r0, lsr sp
    ad3c:	0000ad30 	andeq	sl, r0, r0, lsr sp
    ad40:	0000ad38 	andeq	sl, r0, r8, lsr sp
    ad44:	0000ad38 	andeq	sl, r0, r8, lsr sp
    ad48:	0000ad40 	andeq	sl, r0, r0, asr #26
    ad4c:	0000ad40 	andeq	sl, r0, r0, asr #26
    ad50:	0000ad48 	andeq	sl, r0, r8, asr #26
    ad54:	0000ad48 	andeq	sl, r0, r8, asr #26
    ad58:	0000ad50 	andeq	sl, r0, r0, asr sp
    ad5c:	0000ad50 	andeq	sl, r0, r0, asr sp
    ad60:	0000ad58 	andeq	sl, r0, r8, asr sp
    ad64:	0000ad58 	andeq	sl, r0, r8, asr sp
    ad68:	0000ad60 	andeq	sl, r0, r0, ror #26
    ad6c:	0000ad60 	andeq	sl, r0, r0, ror #26
    ad70:	0000ad68 	andeq	sl, r0, r8, ror #26
    ad74:	0000ad68 	andeq	sl, r0, r8, ror #26
    ad78:	0000ad70 	andeq	sl, r0, r0, ror sp
    ad7c:	0000ad70 	andeq	sl, r0, r0, ror sp
    ad80:	0000ad78 	andeq	sl, r0, r8, ror sp
    ad84:	0000ad78 	andeq	sl, r0, r8, ror sp
    ad88:	0000ad80 	andeq	sl, r0, r0, lsl #27
    ad8c:	0000ad80 	andeq	sl, r0, r0, lsl #27
    ad90:	0000ad88 	andeq	sl, r0, r8, lsl #27
    ad94:	0000ad88 	andeq	sl, r0, r8, lsl #27
    ad98:	0000ad90 	muleq	r0, r0, sp
    ad9c:	0000ad90 	muleq	r0, r0, sp
    ada0:	0000ad98 	muleq	r0, r8, sp
    ada4:	0000ad98 	muleq	r0, r8, sp
    ada8:	0000ada0 	andeq	sl, r0, r0, lsr #27
    adac:	0000ada0 	andeq	sl, r0, r0, lsr #27
    adb0:	0000ada8 	andeq	sl, r0, r8, lsr #27
    adb4:	0000ada8 	andeq	sl, r0, r8, lsr #27
    adb8:	0000adb0 			; <UNDEFINED> instruction: 0x0000adb0
    adbc:	0000adb0 			; <UNDEFINED> instruction: 0x0000adb0
    adc0:	0000adb8 			; <UNDEFINED> instruction: 0x0000adb8
    adc4:	0000adb8 			; <UNDEFINED> instruction: 0x0000adb8
    adc8:	0000adc0 	andeq	sl, r0, r0, asr #27
    adcc:	0000adc0 	andeq	sl, r0, r0, asr #27
    add0:	0000adc8 	andeq	sl, r0, r8, asr #27
    add4:	0000adc8 	andeq	sl, r0, r8, asr #27
    add8:	0000add0 	ldrdeq	sl, [r0], -r0
    addc:	0000add0 	ldrdeq	sl, [r0], -r0
    ade0:	0000add8 	ldrdeq	sl, [r0], -r8
    ade4:	0000add8 	ldrdeq	sl, [r0], -r8
    ade8:	0000ade0 	andeq	sl, r0, r0, ror #27
    adec:	0000ade0 	andeq	sl, r0, r0, ror #27
    adf0:	0000ade8 	andeq	sl, r0, r8, ror #27
    adf4:	0000ade8 	andeq	sl, r0, r8, ror #27
    adf8:	0000adf0 	strdeq	sl, [r0], -r0
    adfc:	0000adf0 	strdeq	sl, [r0], -r0
    ae00:	0000adf8 	strdeq	sl, [r0], -r8
    ae04:	0000adf8 	strdeq	sl, [r0], -r8
    ae08:	0000ae00 	andeq	sl, r0, r0, lsl #28
    ae0c:	0000ae00 	andeq	sl, r0, r0, lsl #28
    ae10:	0000ae08 	andeq	sl, r0, r8, lsl #28
    ae14:	0000ae08 	andeq	sl, r0, r8, lsl #28
    ae18:	0000ae10 	andeq	sl, r0, r0, lsl lr
    ae1c:	0000ae10 	andeq	sl, r0, r0, lsl lr
    ae20:	0000ae18 	andeq	sl, r0, r8, lsl lr
    ae24:	0000ae18 	andeq	sl, r0, r8, lsl lr
    ae28:	0000ae20 	andeq	sl, r0, r0, lsr #28
    ae2c:	0000ae20 	andeq	sl, r0, r0, lsr #28
    ae30:	0000ae28 	andeq	sl, r0, r8, lsr #28
    ae34:	0000ae28 	andeq	sl, r0, r8, lsr #28
    ae38:	0000ae30 	andeq	sl, r0, r0, lsr lr
    ae3c:	0000ae30 	andeq	sl, r0, r0, lsr lr
    ae40:	0000ae38 	andeq	sl, r0, r8, lsr lr
    ae44:	0000ae38 	andeq	sl, r0, r8, lsr lr
    ae48:	0000ae40 	andeq	sl, r0, r0, asr #28
    ae4c:	0000ae40 	andeq	sl, r0, r0, asr #28
    ae50:	0000ae48 	andeq	sl, r0, r8, asr #28
    ae54:	0000ae48 	andeq	sl, r0, r8, asr #28
    ae58:	0000ae50 	andeq	sl, r0, r0, asr lr
    ae5c:	0000ae50 	andeq	sl, r0, r0, asr lr
    ae60:	0000ae58 	andeq	sl, r0, r8, asr lr
    ae64:	0000ae58 	andeq	sl, r0, r8, asr lr
    ae68:	0000ae60 	andeq	sl, r0, r0, ror #28
    ae6c:	0000ae60 	andeq	sl, r0, r0, ror #28
    ae70:	0000ae68 	andeq	sl, r0, r8, ror #28
    ae74:	0000ae68 	andeq	sl, r0, r8, ror #28
    ae78:	0000ae70 	andeq	sl, r0, r0, ror lr
    ae7c:	0000ae70 	andeq	sl, r0, r0, ror lr
    ae80:	0000ae78 	andeq	sl, r0, r8, ror lr
    ae84:	0000ae78 	andeq	sl, r0, r8, ror lr
    ae88:	0000ae80 	andeq	sl, r0, r0, lsl #29
    ae8c:	0000ae80 	andeq	sl, r0, r0, lsl #29
    ae90:	0000ae88 	andeq	sl, r0, r8, lsl #29
    ae94:	0000ae88 	andeq	sl, r0, r8, lsl #29
    ae98:	0000ae90 	muleq	r0, r0, lr
    ae9c:	0000ae90 	muleq	r0, r0, lr
    aea0:	0000ae98 	muleq	r0, r8, lr
    aea4:	0000ae98 	muleq	r0, r8, lr
    aea8:	0000aea0 	andeq	sl, r0, r0, lsr #29
    aeac:	0000aea0 	andeq	sl, r0, r0, lsr #29
    aeb0:	0000aea8 	andeq	sl, r0, r8, lsr #29
    aeb4:	0000aea8 	andeq	sl, r0, r8, lsr #29
    aeb8:	0000aeb0 			; <UNDEFINED> instruction: 0x0000aeb0
    aebc:	0000aeb0 			; <UNDEFINED> instruction: 0x0000aeb0
    aec0:	0000aeb8 			; <UNDEFINED> instruction: 0x0000aeb8
    aec4:	0000aeb8 			; <UNDEFINED> instruction: 0x0000aeb8
    aec8:	0000aec0 	andeq	sl, r0, r0, asr #29
    aecc:	0000aec0 	andeq	sl, r0, r0, asr #29
    aed0:	0000aec8 	andeq	sl, r0, r8, asr #29
    aed4:	0000aec8 	andeq	sl, r0, r8, asr #29
    aed8:	0000aed0 	ldrdeq	sl, [r0], -r0
    aedc:	0000aed0 	ldrdeq	sl, [r0], -r0
    aee0:	0000aed8 	ldrdeq	sl, [r0], -r8
    aee4:	0000aed8 	ldrdeq	sl, [r0], -r8
    aee8:	0000aee0 	andeq	sl, r0, r0, ror #29
    aeec:	0000aee0 	andeq	sl, r0, r0, ror #29
    aef0:	0000aee8 	andeq	sl, r0, r8, ror #29
    aef4:	0000aee8 	andeq	sl, r0, r8, ror #29
    aef8:	0000aef0 	strdeq	sl, [r0], -r0
    aefc:	0000aef0 	strdeq	sl, [r0], -r0
    af00:	0000aef8 	strdeq	sl, [r0], -r8
    af04:	0000aef8 	strdeq	sl, [r0], -r8
    af08:	0000af00 	andeq	sl, r0, r0, lsl #30
    af0c:	0000af00 	andeq	sl, r0, r0, lsl #30
    af10:	0000af08 	andeq	sl, r0, r8, lsl #30
    af14:	0000af08 	andeq	sl, r0, r8, lsl #30
    af18:	0000af10 	andeq	sl, r0, r0, lsl pc
    af1c:	0000af10 	andeq	sl, r0, r0, lsl pc
    af20:	0000af18 	andeq	sl, r0, r8, lsl pc
    af24:	0000af18 	andeq	sl, r0, r8, lsl pc
    af28:	0000af20 	andeq	sl, r0, r0, lsr #30
    af2c:	0000af20 	andeq	sl, r0, r0, lsr #30
    af30:	0000af28 	andeq	sl, r0, r8, lsr #30
    af34:	0000af28 	andeq	sl, r0, r8, lsr #30
    af38:	0000af30 	andeq	sl, r0, r0, lsr pc
    af3c:	0000af30 	andeq	sl, r0, r0, lsr pc
    af40:	0000af38 	andeq	sl, r0, r8, lsr pc
    af44:	0000af38 	andeq	sl, r0, r8, lsr pc
    af48:	0000af40 	andeq	sl, r0, r0, asr #30
    af4c:	0000af40 	andeq	sl, r0, r0, asr #30
    af50:	0000af48 	andeq	sl, r0, r8, asr #30
    af54:	0000af48 	andeq	sl, r0, r8, asr #30
    af58:	0000af50 	andeq	sl, r0, r0, asr pc
    af5c:	0000af50 	andeq	sl, r0, r0, asr pc
    af60:	0000af58 	andeq	sl, r0, r8, asr pc
    af64:	0000af58 	andeq	sl, r0, r8, asr pc
    af68:	0000af60 	andeq	sl, r0, r0, ror #30
    af6c:	0000af60 	andeq	sl, r0, r0, ror #30
    af70:	0000af68 	andeq	sl, r0, r8, ror #30
    af74:	0000af68 	andeq	sl, r0, r8, ror #30
    af78:	0000af70 	andeq	sl, r0, r0, ror pc
    af7c:	0000af70 	andeq	sl, r0, r0, ror pc
    af80:	0000af78 	andeq	sl, r0, r8, ror pc
    af84:	0000af78 	andeq	sl, r0, r8, ror pc
    af88:	0000af80 	andeq	sl, r0, r0, lsl #31
    af8c:	0000af80 	andeq	sl, r0, r0, lsl #31
    af90:	0000af88 	andeq	sl, r0, r8, lsl #31
    af94:	0000af88 	andeq	sl, r0, r8, lsl #31
    af98:	0000af90 	muleq	r0, r0, pc	; <UNPREDICTABLE>
    af9c:	0000af90 	muleq	r0, r0, pc	; <UNPREDICTABLE>
    afa0:	0000af98 	muleq	r0, r8, pc	; <UNPREDICTABLE>
    afa4:	0000af98 	muleq	r0, r8, pc	; <UNPREDICTABLE>
    afa8:	0000afa0 	andeq	sl, r0, r0, lsr #31
    afac:	0000afa0 	andeq	sl, r0, r0, lsr #31
    afb0:	0000afa8 	andeq	sl, r0, r8, lsr #31
    afb4:	0000afa8 	andeq	sl, r0, r8, lsr #31
    afb8:	0000afb0 			; <UNDEFINED> instruction: 0x0000afb0
    afbc:	0000afb0 			; <UNDEFINED> instruction: 0x0000afb0
    afc0:	0000afb8 			; <UNDEFINED> instruction: 0x0000afb8
    afc4:	0000afb8 			; <UNDEFINED> instruction: 0x0000afb8
    afc8:	0000afc0 	andeq	sl, r0, r0, asr #31
    afcc:	0000afc0 	andeq	sl, r0, r0, asr #31
    afd0:	0000afc8 	andeq	sl, r0, r8, asr #31
    afd4:	0000afc8 	andeq	sl, r0, r8, asr #31
    afd8:	0000afd0 	ldrdeq	sl, [r0], -r0
    afdc:	0000afd0 	ldrdeq	sl, [r0], -r0
    afe0:	0000afd8 	ldrdeq	sl, [r0], -r8
    afe4:	0000afd8 	ldrdeq	sl, [r0], -r8
    afe8:	0000afe0 	andeq	sl, r0, r0, ror #31
    afec:	0000afe0 	andeq	sl, r0, r0, ror #31
    aff0:	0000afe8 	andeq	sl, r0, r8, ror #31
    aff4:	0000afe8 	andeq	sl, r0, r8, ror #31
    aff8:	0000aff0 	strdeq	sl, [r0], -r0
    affc:	0000aff0 	strdeq	sl, [r0], -r0
    b000:	0000aff8 	strdeq	sl, [r0], -r8
    b004:	0000aff8 	strdeq	sl, [r0], -r8
    b008:	0000b000 	andeq	fp, r0, r0
    b00c:	0000b000 	andeq	fp, r0, r0
    b010:	0000b008 	andeq	fp, r0, r8
    b014:	0000b008 	andeq	fp, r0, r8
    b018:	0000b010 	andeq	fp, r0, r0, lsl r0
    b01c:	0000b010 	andeq	fp, r0, r0, lsl r0
    b020:	0000b018 	andeq	fp, r0, r8, lsl r0
    b024:	0000b018 	andeq	fp, r0, r8, lsl r0
    b028:	0000b020 	andeq	fp, r0, r0, lsr #32
    b02c:	0000b020 	andeq	fp, r0, r0, lsr #32
    b030:	0000b028 	andeq	fp, r0, r8, lsr #32
    b034:	0000b028 	andeq	fp, r0, r8, lsr #32
    b038:	0000b030 	andeq	fp, r0, r0, lsr r0
    b03c:	0000b030 	andeq	fp, r0, r0, lsr r0
    b040:	0000b038 	andeq	fp, r0, r8, lsr r0
    b044:	0000b038 	andeq	fp, r0, r8, lsr r0
    b048:	0000b040 	andeq	fp, r0, r0, asr #32
    b04c:	0000b040 	andeq	fp, r0, r0, asr #32
    b050:	0000b048 	andeq	fp, r0, r8, asr #32
    b054:	0000b048 	andeq	fp, r0, r8, asr #32
    b058:	0000b050 	andeq	fp, r0, r0, asr r0
    b05c:	0000b050 	andeq	fp, r0, r0, asr r0
    b060:	0000b058 	andeq	fp, r0, r8, asr r0
    b064:	0000b058 	andeq	fp, r0, r8, asr r0
    b068:	0000b060 	andeq	fp, r0, r0, rrx
    b06c:	0000b060 	andeq	fp, r0, r0, rrx
    b070:	0000b068 	andeq	fp, r0, r8, rrx
    b074:	0000b068 	andeq	fp, r0, r8, rrx
    b078:	0000b070 	andeq	fp, r0, r0, ror r0
    b07c:	0000b070 	andeq	fp, r0, r0, ror r0
    b080:	0000b078 	andeq	fp, r0, r8, ror r0
    b084:	0000b078 	andeq	fp, r0, r8, ror r0
    b088:	0000b080 	andeq	fp, r0, r0, lsl #1
    b08c:	0000b080 	andeq	fp, r0, r0, lsl #1
    b090:	0000b088 	andeq	fp, r0, r8, lsl #1
    b094:	0000b088 	andeq	fp, r0, r8, lsl #1
    b098:	0000b090 	muleq	r0, r0, r0
    b09c:	0000b090 	muleq	r0, r0, r0
    b0a0:	0000b098 	muleq	r0, r8, r0
    b0a4:	0000b098 	muleq	r0, r8, r0
    b0a8:	0000b0a0 	andeq	fp, r0, r0, lsr #1
    b0ac:	0000b0a0 	andeq	fp, r0, r0, lsr #1
    b0b0:	0000b0a8 	andeq	fp, r0, r8, lsr #1
    b0b4:	0000b0a8 	andeq	fp, r0, r8, lsr #1
    b0b8:	0000b0b0 	strheq	fp, [r0], -r0
    b0bc:	0000b0b0 	strheq	fp, [r0], -r0
    b0c0:	0000b0b8 	strheq	fp, [r0], -r8
    b0c4:	0000b0b8 	strheq	fp, [r0], -r8
    b0c8:	0000b0c0 	andeq	fp, r0, r0, asr #1
    b0cc:	0000b0c0 	andeq	fp, r0, r0, asr #1
    b0d0:	0000b0c8 	andeq	fp, r0, r8, asr #1
    b0d4:	0000b0c8 	andeq	fp, r0, r8, asr #1
    b0d8:	0000b0d0 	ldrdeq	fp, [r0], -r0
    b0dc:	0000b0d0 	ldrdeq	fp, [r0], -r0
    b0e0:	0000b0d8 	ldrdeq	fp, [r0], -r8
    b0e4:	0000b0d8 	ldrdeq	fp, [r0], -r8

0000b0e8 <__malloc_trim_threshold>:
    b0e8:	00020000 	andeq	r0, r2, r0

0000b0ec <__malloc_sbrk_base>:
    b0ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000b0f0 <impure_data>:
    b0f0:	00000000 	andeq	r0, r0, r0
    b0f4:	0000b3dc 	ldrdeq	fp, [r0], -ip
    b0f8:	0000b444 	andeq	fp, r0, r4, asr #8
    b0fc:	0000b4ac 	andeq	fp, r0, ip, lsr #9
	...
    b124:	0000accc 	andeq	sl, r0, ip, asr #25
	...
    b198:	00000001 	andeq	r0, r0, r1
    b19c:	00000000 	andeq	r0, r0, r0
    b1a0:	abcd330e 	blge	ff357de0 <STACK_SVR+0xfb357de0>
    b1a4:	e66d1234 			; <UNDEFINED> instruction: 0xe66d1234
    b1a8:	0005deec 	andeq	sp, r5, ip, ror #29
    b1ac:	0000000b 	andeq	r0, r0, fp
	...

0000b518 <_impure_ptr>:
    b518:	0000b0f0 	strdeq	fp, [r0], -r0

Disassembly of section .bss:

0000c000 <heap_end.5342>:
    c000:	00000000 	andeq	r0, r0, r0

0000c004 <__env>:
    c004:	00000000 	andeq	r0, r0, r0

0000c008 <arm_timer_freq>:
    c008:	00000000 	andeq	r0, r0, r0

0000c00c <lit.5878>:
    c00c:	00000000 	andeq	r0, r0, r0

0000c010 <head>:
    c010:	00000000 	andeq	r0, r0, r0

0000c014 <tail>:
    c014:	00000000 	andeq	r0, r0, r0

0000c018 <priority_array>:
	...

0000c218 <previous_running_process>:
	...

00010000 <page_table>:
	...

00014000 <time_increments>:
	...

00014008 <seconds>:
	...

00014010 <__malloc_max_total_mem>:
   14010:	00000000 	andeq	r0, r0, r0

00014014 <__malloc_max_sbrked_mem>:
   14014:	00000000 	andeq	r0, r0, r0

00014018 <__malloc_top_pad>:
   14018:	00000000 	andeq	r0, r0, r0

0001401c <__malloc_current_mallinfo>:
	...

00014044 <errno>:
   14044:	00000000 	andeq	r0, r0, r0

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
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	00009a50 	andeq	r9, r0, r0, asr sl
  14:	000002ae 	andeq	r0, r0, lr, lsr #5
	...
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	00b00002 	adcseq	r0, r0, r2
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	00009d00 	andeq	r9, r0, r0, lsl #26
  34:	00000002 	andeq	r0, r0, r2
	...
  40:	00000024 	andeq	r0, r0, r4, lsr #32
  44:	01600002 	cmneq	r0, r2
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	00009d04 	andeq	r9, r0, r4, lsl #26
  54:	00000010 	andeq	r0, r0, r0, lsl r0
  58:	00009d14 	andeq	r9, r0, r4, lsl sp
  5c:	00000010 	andeq	r0, r0, r0, lsl r0
	...
  68:	0000001c 	andeq	r0, r0, ip, lsl r0
  6c:	0a750002 	beq	1d4007c <_stack+0x1cc007c>
  70:	00040000 	andeq	r0, r4, r0
  74:	00000000 	andeq	r0, r0, r0
  78:	00009d24 	andeq	r9, r0, r4, lsr #26
  7c:	00000566 	andeq	r0, r0, r6, ror #10
	...
  88:	0000001c 	andeq	r0, r0, ip, lsl r0
  8c:	17f20002 	ldrbne	r0, [r2, r2]!
  90:	00040000 	andeq	r0, r4, r0
  94:	00000000 	andeq	r0, r0, r0
  98:	0000a28c 	andeq	sl, r0, ip, lsl #5
  9c:	000000a6 	andeq	r0, r0, r6, lsr #1
	...
  a8:	0000001c 	andeq	r0, r0, ip, lsl r0
  ac:	19230002 	stmdbne	r3!, {r1}
  b0:	00040000 	andeq	r0, r4, r0
  b4:	00000000 	andeq	r0, r0, r0
  b8:	0000a334 	andeq	sl, r0, r4, lsr r3
  bc:	0000009e 	muleq	r0, lr, r0
	...
  c8:	00000024 	andeq	r0, r0, r4, lsr #32
  cc:	1a3a0002 	bne	e800dc <_stack+0xe000dc>
  d0:	00040000 	andeq	r0, r4, r0
  d4:	00000000 	andeq	r0, r0, r0
  d8:	0000a3d4 	ldrdeq	sl, [r0], -r4
  dc:	00000002 	andeq	r0, r0, r2
  e0:	0000a3d8 	ldrdeq	sl, [r0], -r8
  e4:	00000002 	andeq	r0, r0, r2
	...
  f0:	00000024 	andeq	r0, r0, r4, lsr #32
  f4:	22ee0002 	rsccs	r0, lr, #2
  f8:	00040000 	andeq	r0, r4, r0
  fc:	00000000 	andeq	r0, r0, r0
 100:	0000a3dc 	ldrdeq	sl, [r0], -ip
 104:	0000001a 	andeq	r0, r0, sl, lsl r0
 108:	0000a3f8 	strdeq	sl, [r0], -r8
 10c:	00000090 	muleq	r0, r0, r0
	...
 118:	0000001c 	andeq	r0, r0, ip, lsl r0
 11c:	2ce90002 	stclcs	0, cr0, [r9], #8
 120:	00040000 	andeq	r0, r4, r0
 124:	00000000 	andeq	r0, r0, r0
 128:	0000a488 	andeq	sl, r0, r8, lsl #9
 12c:	00000026 	andeq	r0, r0, r6, lsr #32
	...
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	35dd0002 	ldrbcc	r0, [sp, #2]
 140:	00040000 	andeq	r0, r4, r0
 144:	00000000 	andeq	r0, r0, r0
 148:	0000a4b0 			; <UNDEFINED> instruction: 0x0000a4b0
 14c:	0000005e 	andeq	r0, r0, lr, asr r0
	...
 158:	00000024 	andeq	r0, r0, r4, lsr #32
 15c:	36920002 	ldrcc	r0, [r2], r2
 160:	00040000 	andeq	r0, r4, r0
 164:	00000000 	andeq	r0, r0, r0
 168:	0000a510 	andeq	sl, r0, r0, lsl r5
 16c:	000000a2 	andeq	r0, r0, r2, lsr #1
 170:	0000a5b4 			; <UNDEFINED> instruction: 0x0000a5b4
 174:	00000198 	muleq	r0, r8, r1
	...
 180:	00000014 	andeq	r0, r0, r4, lsl r0
 184:	42ae0002 	adcmi	r0, lr, #2
 188:	00040000 	andeq	r0, r4, r0
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	000000ac 	andeq	r0, r0, ip, lsr #1
       4:	00000002 	andeq	r0, r0, r2
       8:	01040000 	mrseq	r0, (UNDEF: 4)
       c:	00000000 	andeq	r0, r0, r0
      10:	00009a50 	andeq	r9, r0, r0, asr sl
      14:	00009cfe 	strdeq	r9, [r0], -lr
      18:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
      1c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
      20:	2f2e2e2f 	svccs	0x002e2e2f
      24:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
      28:	63672f2e 	cmnvs	r7, #46, 30	; 0xb8
      2c:	2e342d63 	cdpcs	13, 3, cr2, cr4, cr3, {3}
      30:	2f322e38 	svccs	0x00322e38
      34:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
      38:	632f6363 	teqvs	pc, #-1946157055	; 0x8c000001
      3c:	69666e6f 	stmdbvs	r6!, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}^
      40:	72612f67 	rsbvc	r2, r1, #412	; 0x19c
      44:	696c2f6d 	stmdbvs	ip!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, sp}^
      48:	75663162 	strbvc	r3, [r6, #-354]!	; 0x162
      4c:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
      50:	622f0053 	eorvs	r0, pc, #83	; 0x53
      54:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
      58:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
      5c:	2f64646c 	svccs	0x0064646c
      60:	2d636367 	stclcs	3, cr6, [r3, #-412]!	; 0xfffffe64
      64:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
      68:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
      6c:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
      70:	2f362d69 	svccs	0x00362d69
      74:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
      78:	72612f64 	rsbvc	r2, r1, #100, 30	; 0x190
      7c:	6f6e2d6d 	svcvs	0x006e2d6d
      80:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
      84:	2f696261 	svccs	0x00696261
      88:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
      8c:	72612d37 	rsbvc	r2, r1, #3520	; 0xdc0
      90:	7568742f 	strbvc	r7, [r8, #-1071]!	; 0x42f
      94:	662f626d 	strtvs	r6, [pc], -sp, ror #4
      98:	6c2f7570 	cfstr32vs	mvfx7, [pc], #-448	; fffffee0 <STACK_SVR+0xfbfffee0>
      9c:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
      a0:	4e470063 	cdpmi	0, 4, cr0, cr7, cr3, {3}
      a4:	53412055 	movtpl	r2, #4181	; 0x1055
      a8:	322e3220 	eorcc	r3, lr, #32, 4
      ac:	80010034 	andhi	r0, r1, r4, lsr r0
      b0:	000000ac 	andeq	r0, r0, ip, lsr #1
      b4:	00140002 	andseq	r0, r4, r2
      b8:	01040000 	mrseq	r0, (UNDEF: 4)
      bc:	0000009e 	muleq	r0, lr, r0
      c0:	00009d00 	andeq	r9, r0, r0, lsl #26
      c4:	00009d02 	andeq	r9, r0, r2, lsl #26
      c8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
      cc:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
      d0:	2f2e2e2f 	svccs	0x002e2e2f
      d4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
      d8:	63672f2e 	cmnvs	r7, #46, 30	; 0xb8
      dc:	2e342d63 	cdpcs	13, 3, cr2, cr4, cr3, {3}
      e0:	2f322e38 	svccs	0x00322e38
      e4:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
      e8:	632f6363 	teqvs	pc, #-1946157055	; 0x8c000001
      ec:	69666e6f 	stmdbvs	r6!, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}^
      f0:	72612f67 	rsbvc	r2, r1, #412	; 0x19c
      f4:	696c2f6d 	stmdbvs	ip!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, sp}^
      f8:	75663162 	strbvc	r3, [r6, #-354]!	; 0x162
      fc:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
     100:	622f0053 	eorvs	r0, pc, #83	; 0x53
     104:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
     108:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     10c:	2f64646c 	svccs	0x0064646c
     110:	2d636367 	stclcs	3, cr6, [r3, #-412]!	; 0xfffffe64
     114:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
     118:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
     11c:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
     120:	2f362d69 	svccs	0x00362d69
     124:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
     128:	72612f64 	rsbvc	r2, r1, #100, 30	; 0x190
     12c:	6f6e2d6d 	svcvs	0x006e2d6d
     130:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
     134:	2f696261 	svccs	0x00696261
     138:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     13c:	72612d37 	rsbvc	r2, r1, #3520	; 0xdc0
     140:	7568742f 	strbvc	r7, [r8, #-1071]!	; 0x42f
     144:	662f626d 	strtvs	r6, [pc], -sp, ror #4
     148:	6c2f7570 	cfstr32vs	mvfx7, [pc], #-448	; ffffff90 <STACK_SVR+0xfbffff90>
     14c:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
     150:	4e470063 	cdpmi	0, 4, cr0, cr7, cr3, {3}
     154:	53412055 	movtpl	r2, #4181	; 0x1055
     158:	322e3220 	eorcc	r3, lr, #32, 4
     15c:	80010034 	andhi	r0, r1, r4, lsr r0
     160:	00000911 	andeq	r0, r0, r1, lsl r9
     164:	00280004 	eoreq	r0, r8, r4
     168:	01040000 	mrseq	r0, (UNDEF: 4)
     16c:	00000141 	andeq	r0, r0, r1, asr #2
     170:	00036101 	andeq	r6, r3, r1, lsl #2
     174:	00024c00 	andeq	r4, r2, r0, lsl #24
	...
     180:	00010800 	andeq	r0, r1, r0, lsl #16
     184:	05040200 	streq	r0, [r4, #-512]	; 0x200
     188:	00746e69 	rsbseq	r6, r4, r9, ror #28
     18c:	00000c03 	andeq	r0, r0, r3, lsl #24
     190:	37d40200 	ldrbcc	r0, [r4, r0, lsl #4]
     194:	04000000 	streq	r0, [r0], #-0
     198:	00550704 	subseq	r0, r5, r4, lsl #14
     19c:	01040000 	mrseq	r0, (UNDEF: 4)
     1a0:	00039f06 	andeq	r9, r3, r6, lsl #30
     1a4:	08010400 	stmdaeq	r1, {sl}
     1a8:	0000039d 	muleq	r0, sp, r3
     1ac:	b9050204 	stmdblt	r5, {r2, r9}
     1b0:	04000003 	streq	r0, [r0], #-3
     1b4:	02a80702 	adceq	r0, r8, #524288	; 0x80000
     1b8:	04040000 	streq	r0, [r4], #-0
     1bc:	00009b05 	andeq	r9, r0, r5, lsl #22
     1c0:	07040400 	streq	r0, [r4, -r0, lsl #8]
     1c4:	00000050 	andeq	r0, r0, r0, asr r0
     1c8:	96050804 	strls	r0, [r5], -r4, lsl #16
     1cc:	04000000 	streq	r0, [r0], #-0
     1d0:	004b0708 	subeq	r0, fp, r8, lsl #14
     1d4:	4f030000 	svcmi	0x00030000
     1d8:	03000003 	movweq	r0, #3
     1dc:	00002507 	andeq	r2, r0, r7, lsl #10
     1e0:	03370300 	teqeq	r7, #0, 6
     1e4:	10040000 	andne	r0, r4, r0
     1e8:	0000005a 	andeq	r0, r0, sl, asr r0
     1ec:	00046703 	andeq	r6, r4, r3, lsl #14
     1f0:	5a270400 	bpl	9c11f8 <_stack+0x9411f8>
     1f4:	05000000 	streq	r0, [r0, #-0]
     1f8:	000002eb 	andeq	r0, r0, fp, ror #5
     1fc:	37016102 	strcc	r6, [r1, -r2, lsl #2]
     200:	06000000 	streq	r0, [r0], -r0
     204:	c24a0404 	subgt	r0, sl, #4, 8	; 0x4000000
     208:	07000000 	streq	r0, [r0, -r0]
     20c:	000002e5 	andeq	r0, r0, r5, ror #5
     210:	00974c04 	addseq	r4, r7, r4, lsl #24
     214:	2f070000 	svccs	0x00070000
     218:	04000002 	streq	r0, [r0], #-2
     21c:	0000c24d 	andeq	ip, r0, sp, asr #4
     220:	45080000 	strmi	r0, [r8, #-0]
     224:	d2000000 	andle	r0, r0, #0
     228:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     22c:	000000d2 	ldrdeq	r0, [r0], -r2
     230:	04040003 	streq	r0, [r4], #-3
     234:	00030b07 	andeq	r0, r3, r7, lsl #22
     238:	04080a00 	streq	r0, [r8], #-2560	; 0xa00
     23c:	0000fa47 	andeq	pc, r0, r7, asr #20
     240:	04510b00 	ldrbeq	r0, [r1], #-2816	; 0xb00
     244:	49040000 	stmdbmi	r4, {}	; <UNPREDICTABLE>
     248:	00000025 	andeq	r0, r0, r5, lsr #32
     24c:	04590b00 	ldrbeq	r0, [r9], #-2816	; 0xb00
     250:	4e040000 	cdpmi	0, 0, cr0, cr4, cr0, {0}
     254:	000000a3 	andeq	r0, r0, r3, lsr #1
     258:	e1030004 	tst	r3, r4
     25c:	04000003 	streq	r0, [r0], #-3
     260:	0000d94f 	andeq	sp, r0, pc, asr #18
     264:	01380300 	teqeq	r8, r0, lsl #6
     268:	53040000 	movwpl	r0, #16384	; 0x4000
     26c:	00000076 	andeq	r0, r0, r6, ror r0
     270:	a103040c 	tstge	r3, ip, lsl #8
     274:	05000004 	streq	r0, [r0, #-4]
     278:	00006116 	andeq	r6, r0, r6, lsl r1
     27c:	02030d00 	andeq	r0, r3, #0, 26
     280:	05180000 	ldreq	r0, [r8, #-0]
     284:	0001702d 	andeq	r7, r1, sp, lsr #32
     288:	04020b00 	streq	r0, [r2], #-2816	; 0xb00
     28c:	2f050000 	svccs	0x00050000
     290:	00000170 	andeq	r0, r0, r0, ror r1
     294:	6b5f0e00 	blvs	17c3a9c <_stack+0x1743a9c>
     298:	25300500 	ldrcs	r0, [r0, #-1280]!	; 0x500
     29c:	04000000 	streq	r0, [r0], #-0
     2a0:	0004430b 	andeq	r4, r4, fp, lsl #6
     2a4:	25300500 	ldrcs	r0, [r0, #-1280]!	; 0x500
     2a8:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     2ac:	0001320b 	andeq	r3, r1, fp, lsl #4
     2b0:	25300500 	ldrcs	r0, [r0, #-1280]!	; 0x500
     2b4:	0c000000 	stceq	0, cr0, [r0], {-0}
     2b8:	0004d50b 	andeq	sp, r4, fp, lsl #10
     2bc:	25300500 	ldrcs	r0, [r0, #-1280]!	; 0x500
     2c0:	10000000 	andne	r0, r0, r0
     2c4:	00785f0e 	rsbseq	r5, r8, lr, lsl #30
     2c8:	01763105 	cmneq	r6, r5, lsl #2
     2cc:	00140000 	andseq	r0, r4, r0
     2d0:	011d040f 	tsteq	sp, pc, lsl #8
     2d4:	12080000 	andne	r0, r8, #0
     2d8:	86000001 	strhi	r0, [r0], -r1
     2dc:	09000001 	stmdbeq	r0, {r0}
     2e0:	000000d2 	ldrdeq	r0, [r0], -r2
     2e4:	2a0d0000 	bcs	3402ec <_stack+0x2c02ec>
     2e8:	24000002 	strcs	r0, [r0], #-2
     2ec:	01ff3505 	mvnseq	r3, r5, lsl #10
     2f0:	8d0b0000 	stchi	0, cr0, [fp, #-0]
     2f4:	05000000 	streq	r0, [r0, #-0]
     2f8:	00002537 	andeq	r2, r0, r7, lsr r5
     2fc:	6f0b0000 	svcvs	0x000b0000
     300:	05000004 	streq	r0, [r0, #-4]
     304:	00002538 	andeq	r2, r0, r8, lsr r5
     308:	aa0b0400 	bge	2c1310 <_stack+0x241310>
     30c:	05000000 	streq	r0, [r0, #-0]
     310:	00002539 	andeq	r2, r0, r9, lsr r5
     314:	480b0800 	stmdami	fp, {fp}
     318:	05000005 	streq	r0, [r0, #-5]
     31c:	0000253a 	andeq	r2, r0, sl, lsr r5
     320:	1b0b0c00 	blne	2c3328 <_stack+0x243328>
     324:	05000003 	streq	r0, [r0, #-3]
     328:	0000253b 	andeq	r2, r0, fp, lsr r5
     32c:	010b1000 	mrseq	r1, (UNDEF: 11)
     330:	05000003 	streq	r0, [r0, #-3]
     334:	0000253c 	andeq	r2, r0, ip, lsr r5
     338:	da0b1400 	ble	2c5340 <_stack+0x245340>
     33c:	05000004 	streq	r0, [r0, #-4]
     340:	0000253d 	andeq	r2, r0, sp, lsr r5
     344:	c30b1800 	movwgt	r1, #47104	; 0xb800
     348:	05000003 	streq	r0, [r0, #-3]
     34c:	0000253e 	andeq	r2, r0, lr, lsr r5
     350:	0f0b1c00 	svceq	0x000b1c00
     354:	05000005 	streq	r0, [r0, #-5]
     358:	0000253f 	andeq	r2, r0, pc, lsr r5
     35c:	10002000 	andne	r2, r0, r0
     360:	000000b9 	strheq	r0, [r0], -r9
     364:	48050108 	stmdami	r5, {r3, r8}
     368:	0000023f 	andeq	r0, r0, pc, lsr r2
     36c:	0001250b 	andeq	r2, r1, fp, lsl #10
     370:	3f490500 	svccc	0x00490500
     374:	00000002 	andeq	r0, r0, r2
     378:	0000000b 	andeq	r0, r0, fp
     37c:	3f4a0500 	svccc	0x004a0500
     380:	80000002 	andhi	r0, r0, r2
     384:	00049311 	andeq	r9, r4, r1, lsl r3
     388:	124c0500 	subne	r0, ip, #0, 10
     38c:	00000001 	andeq	r0, r0, r1
     390:	00de1101 	sbcseq	r1, lr, r1, lsl #2
     394:	4f050000 	svcmi	0x00050000
     398:	00000112 	andeq	r0, r0, r2, lsl r1
     39c:	08000104 	stmdaeq	r0, {r2, r8}
     3a0:	00000110 	andeq	r0, r0, r0, lsl r1
     3a4:	0000024f 	andeq	r0, r0, pc, asr #4
     3a8:	0000d209 	andeq	sp, r0, r9, lsl #4
     3ac:	10001f00 	andne	r1, r0, r0, lsl #30
     3b0:	00000324 	andeq	r0, r0, r4, lsr #6
     3b4:	5b050190 	blpl	1409fc <_stack+0xc09fc>
     3b8:	0000028d 	andeq	r0, r0, sp, lsl #5
     3bc:	0004020b 	andeq	r0, r4, fp, lsl #4
     3c0:	8d5c0500 	cfldr64hi	mvdx0, [ip, #-0]
     3c4:	00000002 	andeq	r0, r0, r2
     3c8:	00041a0b 	andeq	r1, r4, fp, lsl #20
     3cc:	255d0500 	ldrbcs	r0, [sp, #-1280]	; 0x500
     3d0:	04000000 	streq	r0, [r0], #-0
     3d4:	00012d0b 	andeq	r2, r1, fp, lsl #26
     3d8:	935f0500 	cmpls	pc, #0, 10
     3dc:	08000002 	stmdaeq	r0, {r1}
     3e0:	0000b90b 	andeq	fp, r0, fp, lsl #18
     3e4:	ff600500 			; <UNDEFINED> instruction: 0xff600500
     3e8:	88000001 	stmdahi	r0, {r0}
     3ec:	4f040f00 	svcmi	0x00040f00
     3f0:	08000002 	stmdaeq	r0, {r1}
     3f4:	000002a3 	andeq	r0, r0, r3, lsr #5
     3f8:	000002a3 	andeq	r0, r0, r3, lsr #5
     3fc:	0000d209 	andeq	sp, r0, r9, lsl #4
     400:	0f001f00 	svceq	0x00001f00
     404:	0002a904 	andeq	sl, r2, r4, lsl #18
     408:	cd0d1200 	sfmgt	f1, 4, [sp, #-0]
     40c:	08000003 	stmdaeq	r0, {r0, r1}
     410:	02cf7305 	sbceq	r7, pc, #335544320	; 0x14000000
     414:	610b0000 	mrsvs	r0, (UNDEF: 11)
     418:	05000007 	streq	r0, [r0, #-7]
     41c:	0002cf74 	andeq	ip, r2, r4, ror pc
     420:	180b0000 	stmdane	fp, {}	; <UNPREDICTABLE>
     424:	05000006 	streq	r0, [r0, #-6]
     428:	00002575 	andeq	r2, r0, r5, ror r5
     42c:	0f000400 	svceq	0x00000400
     430:	00004504 	andeq	r4, r0, r4, lsl #10
     434:	03ec0d00 	mvneq	r0, #0, 26
     438:	05680000 	strbeq	r0, [r8, #-0]!
     43c:	0003ffb3 			; <UNDEFINED> instruction: 0x0003ffb3
     440:	705f0e00 	subsvc	r0, pc, r0, lsl #28
     444:	cfb40500 	svcgt	0x00b40500
     448:	00000002 	andeq	r0, r0, r2
     44c:	00725f0e 	rsbseq	r5, r2, lr, lsl #30
     450:	0025b505 	eoreq	fp, r5, r5, lsl #10
     454:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     458:	0500775f 	streq	r7, [r0, #-1887]	; 0x75f
     45c:	000025b6 			; <UNDEFINED> instruction: 0x000025b6
     460:	d70b0800 	strle	r0, [fp, -r0, lsl #16]
     464:	05000000 	streq	r0, [r0, #-0]
     468:	00004cb7 			; <UNDEFINED> instruction: 0x00004cb7
     46c:	460b0c00 	strmi	r0, [fp], -r0, lsl #24
     470:	05000002 	streq	r0, [r0, #-2]
     474:	00004cb8 			; <UNDEFINED> instruction: 0x00004cb8
     478:	5f0e0e00 	svcpl	0x000e0e00
     47c:	05006662 	streq	r6, [r0, #-1634]	; 0x662
     480:	0002aab9 			; <UNDEFINED> instruction: 0x0002aab9
     484:	620b1000 	andvs	r1, fp, #0
     488:	05000000 	streq	r0, [r0, #-0]
     48c:	000025ba 			; <UNDEFINED> instruction: 0x000025ba
     490:	c70b1800 	strgt	r1, [fp, -r0, lsl #16]
     494:	05000000 	streq	r0, [r0, #-0]
     498:	000110c1 	andeq	r1, r1, r1, asr #1
     49c:	1a0b1c00 	bne	2c74a4 <_stack+0x2474a4>
     4a0:	05000002 	streq	r0, [r0, #-2]
     4a4:	000562c3 	andeq	r6, r5, r3, asr #5
     4a8:	fa0b2000 	blx	2c84b0 <_stack+0x2484b0>
     4ac:	05000002 	streq	r0, [r0, #-2]
     4b0:	000591c5 	andeq	r9, r5, r5, asr #3
     4b4:	610b2400 	tstvs	fp, r0, lsl #8
     4b8:	05000004 	streq	r0, [r0, #-4]
     4bc:	0005b5c8 	andeq	fp, r5, r8, asr #11
     4c0:	290b2800 	stmdbcs	fp, {fp, sp}
     4c4:	05000005 	streq	r0, [r0, #-5]
     4c8:	0005cfc9 	andeq	ip, r5, r9, asr #31
     4cc:	5f0e2c00 	svcpl	0x000e2c00
     4d0:	05006275 	streq	r6, [r0, #-629]	; 0x275
     4d4:	0002aacc 	andeq	sl, r2, ip, asr #21
     4d8:	5f0e3000 	svcpl	0x000e3000
     4dc:	05007075 	streq	r7, [r0, #-117]	; 0x75
     4e0:	0002cfcd 	andeq	ip, r2, sp, asr #31
     4e4:	5f0e3800 	svcpl	0x000e3800
     4e8:	05007275 	streq	r7, [r0, #-629]	; 0x275
     4ec:	000025ce 	andeq	r2, r0, lr, asr #11
     4f0:	a40b3c00 	strge	r3, [fp], #-3072	; 0xc00
     4f4:	05000000 	streq	r0, [r0, #-0]
     4f8:	0005d5d1 	ldrdeq	sp, [r5], -r1
     4fc:	010b4000 	mrseq	r4, (UNDEF: 11)
     500:	05000005 	streq	r0, [r0, #-5]
     504:	0005e5d2 	ldrdeq	lr, [r5], -r2
     508:	5f0e4300 	svcpl	0x000e4300
     50c:	0500626c 	streq	r6, [r0, #-620]	; 0x26c
     510:	0002aad5 	ldrdeq	sl, [r2], -r5
     514:	ed0b4400 	cfstrs	mvf4, [fp, #-0]
     518:	05000000 	streq	r0, [r0, #-0]
     51c:	000025d8 	ldrdeq	r2, [r0], -r8
     520:	fe0b4c00 	cdp2	12, 0, cr4, cr11, cr0, {0}
     524:	05000000 	streq	r0, [r0, #-0]
     528:	000081d9 	ldrdeq	r8, [r0], -r9
     52c:	9a0b5000 	bls	2d4534 <_stack+0x254534>
     530:	0500000a 	streq	r0, [r0, #-10]
     534:	00041ddc 	ldrdeq	r1, [r4], -ip
     538:	fb0b5400 	blx	2d5542 <_stack+0x255542>
     53c:	05000005 	streq	r0, [r0, #-5]
     540:	000105e0 	andeq	r0, r1, r0, ror #11
     544:	f40b5800 	vst2.8	{d5-d6}, [fp], r0
     548:	05000003 	streq	r0, [r0, #-3]
     54c:	0000fae2 	andeq	pc, r0, r2, ror #21
     550:	f20b5c00 			; <UNDEFINED> instruction: 0xf20b5c00
     554:	05000002 	streq	r0, [r0, #-2]
     558:	000025e3 	andeq	r2, r0, r3, ror #11
     55c:	13006400 	movwne	r6, #1024	; 0x400
     560:	00000025 	andeq	r0, r0, r5, lsr #32
     564:	0000041d 	andeq	r0, r0, sp, lsl r4
     568:	00041d14 	andeq	r1, r4, r4, lsl sp
     56c:	01101400 	tsteq	r0, r0, lsl #8
     570:	55140000 	ldrpl	r0, [r4, #-0]
     574:	14000005 	strne	r0, [r0], #-5
     578:	00000025 	andeq	r0, r0, r5, lsr #32
     57c:	23040f00 	movwcs	r0, #20224	; 0x4f00
     580:	15000004 	strne	r0, [r0, #-4]
     584:	000009d9 	ldrdeq	r0, [r0], -r9
     588:	39050428 	stmdbcc	r5, {r3, r5, sl}
     58c:	00055502 	andeq	r5, r5, r2, lsl #10
     590:	03b21600 			; <UNDEFINED> instruction: 0x03b21600
     594:	3b050000 	blcc	14059c <_stack+0xc059c>
     598:	00002502 	andeq	r2, r0, r2, lsl #10
     59c:	e6160000 	ldr	r0, [r6], -r0
     5a0:	05000000 	streq	r0, [r0, #-0]
     5a4:	063c0240 	ldrteq	r0, [ip], -r0, asr #4
     5a8:	16040000 	strne	r0, [r4], -r0
     5ac:	00000236 	andeq	r0, r0, r6, lsr r2
     5b0:	3c024005 	stccc	0, cr4, [r2], {5}
     5b4:	08000006 	stmdaeq	r0, {r1, r2}
     5b8:	00047e16 	andeq	r7, r4, r6, lsl lr
     5bc:	02400500 	subeq	r0, r0, #0, 10
     5c0:	0000063c 	andeq	r0, r0, ip, lsr r6
     5c4:	0415160c 	ldreq	r1, [r5], #-1548	; 0x60c
     5c8:	42050000 	andmi	r0, r5, #0
     5cc:	00002502 	andeq	r2, r0, r2, lsl #10
     5d0:	20161000 	andscs	r1, r6, r0
     5d4:	05000000 	streq	r0, [r0, #-0]
     5d8:	081e0243 	ldmdaeq	lr, {r0, r1, r6, r9}
     5dc:	16140000 	ldrne	r0, [r4], -r0
     5e0:	000004b6 			; <UNDEFINED> instruction: 0x000004b6
     5e4:	25024505 	strcs	r4, [r2, #-1285]	; 0x505
     5e8:	30000000 	andcc	r0, r0, r0
     5ec:	00041f16 	andeq	r1, r4, r6, lsl pc
     5f0:	02460500 	subeq	r0, r6, #0, 10
     5f4:	00000586 	andeq	r0, r0, r6, lsl #11
     5f8:	032c1634 	teqeq	ip, #52, 12	; 0x3400000
     5fc:	48050000 	stmdami	r5, {}	; <UNPREDICTABLE>
     600:	00002502 	andeq	r2, r0, r2, lsl #10
     604:	39163800 	ldmdbcc	r6, {fp, ip, sp}
     608:	05000004 	streq	r0, [r0, #-4]
     60c:	0839024a 	ldmdaeq	r9!, {r1, r3, r6, r9}
     610:	163c0000 	ldrtne	r0, [ip], -r0
     614:	000002dd 	ldrdeq	r0, [r0], -sp
     618:	70024d05 	andvc	r4, r2, r5, lsl #26
     61c:	40000001 	andmi	r0, r0, r1
     620:	00022016 	andeq	r2, r2, r6, lsl r0
     624:	024e0500 	subeq	r0, lr, #0, 10
     628:	00000025 	andeq	r0, r0, r5, lsr #32
     62c:	05431644 	strbeq	r1, [r3, #-1604]	; 0x644
     630:	4f050000 	svcmi	0x00050000
     634:	00017002 	andeq	r7, r1, r2
     638:	3e164800 	cdpcc	8, 1, cr4, cr6, cr0, {0}
     63c:	05000003 	streq	r0, [r0, #-3]
     640:	083f0250 	ldmdaeq	pc!, {r4, r6, r9}	; <UNPREDICTABLE>
     644:	164c0000 	strbne	r0, [ip], -r0
     648:	0000023e 	andeq	r0, r0, lr, lsr r2
     64c:	25025305 	strcs	r5, [r2, #-773]	; 0x305
     650:	50000000 	andpl	r0, r0, r0
     654:	0000f616 	andeq	pc, r0, r6, lsl r6	; <UNPREDICTABLE>
     658:	02540500 	subseq	r0, r4, #0, 10
     65c:	00000555 	andeq	r0, r0, r5, asr r5
     660:	03ab1654 			; <UNDEFINED> instruction: 0x03ab1654
     664:	77050000 	strvc	r0, [r5, -r0]
     668:	0007fc02 	andeq	pc, r7, r2, lsl #24
     66c:	24175800 	ldrcs	r5, [r7], #-2048	; 0x800
     670:	05000003 	streq	r0, [r0, #-3]
     674:	028d027b 	addeq	r0, sp, #-1342177273	; 0xb0000007
     678:	01480000 	mrseq	r0, (UNDEF: 72)
     67c:	0002bb17 	andeq	fp, r2, r7, lsl fp
     680:	027c0500 	rsbseq	r0, ip, #0, 10
     684:	0000024f 	andeq	r0, r0, pc, asr #4
     688:	f717014c 			; <UNDEFINED> instruction: 0xf717014c
     68c:	05000004 	streq	r0, [r0, #-4]
     690:	08500280 	ldmdaeq	r0, {r7, r9}^
     694:	02dc0000 	sbcseq	r0, ip, #0
     698:	0000cf17 	andeq	ip, r0, r7, lsl pc
     69c:	02850500 	addeq	r0, r5, #0, 10
     6a0:	00000601 	andeq	r0, r0, r1, lsl #12
     6a4:	b41702e0 	ldrlt	r0, [r7], #-736	; 0x2e0
     6a8:	05000000 	streq	r0, [r0, #-0]
     6ac:	085c0286 	ldmdaeq	ip, {r1, r2, r7, r9}^
     6b0:	02ec0000 	rsceq	r0, ip, #0
     6b4:	5b040f00 	blpl	1042bc <_stack+0x842bc>
     6b8:	04000005 	streq	r0, [r0], #-5
     6bc:	03a60801 			; <UNDEFINED> instruction: 0x03a60801
     6c0:	040f0000 	streq	r0, [pc], #-0	; 6c8 <CPSR_IRQ_INHIBIT+0x648>
     6c4:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     6c8:	00002513 	andeq	r2, r0, r3, lsl r5
     6cc:	00058600 	andeq	r8, r5, r0, lsl #12
     6d0:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
     6d4:	10140000 	andsne	r0, r4, r0
     6d8:	14000001 	strne	r0, [r0], #-1
     6dc:	00000586 	andeq	r0, r0, r6, lsl #11
     6e0:	00002514 	andeq	r2, r0, r4, lsl r5
     6e4:	040f0000 	streq	r0, [pc], #-0	; 6ec <CPSR_IRQ_INHIBIT+0x66c>
     6e8:	0000058c 	andeq	r0, r0, ip, lsl #11
     6ec:	00055b18 	andeq	r5, r5, r8, lsl fp
     6f0:	68040f00 	stmdavs	r4, {r8, r9, sl, fp}
     6f4:	13000005 	movwne	r0, #5
     6f8:	0000008c 	andeq	r0, r0, ip, lsl #1
     6fc:	000005b5 			; <UNDEFINED> instruction: 0x000005b5
     700:	00041d14 	andeq	r1, r4, r4, lsl sp
     704:	01101400 	tsteq	r0, r0, lsl #8
     708:	8c140000 	ldchi	0, cr0, [r4], {-0}
     70c:	14000000 	strne	r0, [r0], #-0
     710:	00000025 	andeq	r0, r0, r5, lsr #32
     714:	97040f00 	strls	r0, [r4, -r0, lsl #30]
     718:	13000005 	movwne	r0, #5
     71c:	00000025 	andeq	r0, r0, r5, lsr #32
     720:	000005cf 	andeq	r0, r0, pc, asr #11
     724:	00041d14 	andeq	r1, r4, r4, lsl sp
     728:	01101400 	tsteq	r0, r0, lsl #8
     72c:	0f000000 	svceq	0x00000000
     730:	0005bb04 	andeq	fp, r5, r4, lsl #22
     734:	00450800 	subeq	r0, r5, r0, lsl #16
     738:	05e50000 	strbeq	r0, [r5, #0]!
     73c:	d2090000 	andle	r0, r9, #0
     740:	02000000 	andeq	r0, r0, #0
     744:	00450800 	subeq	r0, r5, r0, lsl #16
     748:	05f50000 	ldrbeq	r0, [r5, #0]!
     74c:	d2090000 	andle	r0, r9, #0
     750:	00000000 	andeq	r0, r0, r0
     754:	03da0500 	bicseq	r0, sl, #0, 10
     758:	1d050000 	stcne	0, cr0, [r5, #-0]
     75c:	0002d501 	andeq	sp, r2, r1, lsl #10
     760:	093d1900 	ldmdbeq	sp!, {r8, fp, ip}
     764:	050c0000 	streq	r0, [ip, #-0]
     768:	06360121 	ldrteq	r0, [r6], -r1, lsr #2
     76c:	02160000 	andseq	r0, r6, #0
     770:	05000004 	streq	r0, [r0, #-4]
     774:	06360123 	ldrteq	r0, [r6], -r3, lsr #2
     778:	16000000 	strne	r0, [r0], -r0
     77c:	000002a1 	andeq	r0, r0, r1, lsr #5
     780:	25012405 	strcs	r2, [r1, #-1029]	; 0x405
     784:	04000000 	streq	r0, [r0], #-0
     788:	0003d416 	andeq	sp, r3, r6, lsl r4
     78c:	01250500 	teqeq	r5, r0, lsl #10
     790:	0000063c 	andeq	r0, r0, ip, lsr r6
     794:	040f0008 	streq	r0, [pc], #-8	; 79c <CPSR_IRQ_INHIBIT+0x71c>
     798:	00000601 	andeq	r0, r0, r1, lsl #12
     79c:	05f5040f 	ldrbeq	r0, [r5, #1039]!	; 0x40f
     7a0:	13190000 	tstne	r9, #0
     7a4:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     7a8:	77013d05 	strvc	r3, [r1, -r5, lsl #26]
     7ac:	16000006 	strne	r0, [r0], -r6
     7b0:	0000044b 	andeq	r0, r0, fp, asr #8
     7b4:	77013e05 	strvc	r3, [r1, -r5, lsl #28]
     7b8:	00000006 	andeq	r0, r0, r6
     7bc:	00047816 	andeq	r7, r4, r6, lsl r8
     7c0:	013f0500 	teqeq	pc, r0, lsl #10
     7c4:	00000677 	andeq	r0, r0, r7, ror r6
     7c8:	049c1606 	ldreq	r1, [ip], #1542	; 0x606
     7cc:	40050000 	andmi	r0, r5, r0
     7d0:	00005301 	andeq	r5, r0, r1, lsl #6
     7d4:	08000c00 	stmdaeq	r0, {sl, fp}
     7d8:	00000053 	andeq	r0, r0, r3, asr r0
     7dc:	00000687 	andeq	r0, r0, r7, lsl #13
     7e0:	0000d209 	andeq	sp, r0, r9, lsl #4
     7e4:	1a000200 	bne	fec <CPSR_IRQ_INHIBIT+0xf6c>
     7e8:	025805d0 	subseq	r0, r8, #208, 10	; 0x34000000
     7ec:	00000788 	andeq	r0, r0, r8, lsl #15
     7f0:	0004c816 	andeq	ip, r4, r6, lsl r8
     7f4:	025a0500 	subseq	r0, sl, #0, 10
     7f8:	00000037 	andeq	r0, r0, r7, lsr r0
     7fc:	04861600 	streq	r1, [r6], #1536	; 0x600
     800:	5b050000 	blpl	140808 <_stack+0xc0808>
     804:	00055502 	andeq	r5, r5, r2, lsl #10
     808:	d0160400 	andsle	r0, r6, r0, lsl #8
     80c:	05000002 	streq	r0, [r0, #-2]
     810:	0788025c 			; <UNDEFINED> instruction: 0x0788025c
     814:	16080000 	strne	r0, [r8], -r0
     818:	0000051a 	andeq	r0, r0, sl, lsl r5
     81c:	86025d05 	strhi	r5, [r2], -r5, lsl #26
     820:	24000001 	strcs	r0, [r0], #-1
     824:	00020b16 	andeq	r0, r2, r6, lsl fp
     828:	025e0500 	subseq	r0, lr, #0, 10
     82c:	00000025 	andeq	r0, r0, r5, lsr #32
     830:	03fd1648 	mvnseq	r1, #72, 12	; 0x4800000
     834:	5f050000 	svcpl	0x00050000
     838:	00006f02 	andeq	r6, r0, r2, lsl #30
     83c:	30165000 	andscc	r5, r6, r0
     840:	05000005 	streq	r0, [r0, #-5]
     844:	06420260 	strbeq	r0, [r2], -r0, ror #4
     848:	16580000 	ldrbne	r0, [r8], -r0
     84c:	00000408 	andeq	r0, r0, r8, lsl #8
     850:	fa026105 	blx	98c6c <_stack+0x18c6c>
     854:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     858:	00053516 	andeq	r3, r5, r6, lsl r5
     85c:	02620500 	rsbeq	r0, r2, #0, 10
     860:	000000fa 	strdeq	r0, [r0], -sl
     864:	007f1670 	rsbseq	r1, pc, r0, ror r6	; <UNPREDICTABLE>
     868:	63050000 	movwvs	r0, #20480	; 0x5000
     86c:	0000fa02 	andeq	pc, r0, r2, lsl #20
     870:	ed167800 	ldc	8, cr7, [r6, #-0]
     874:	05000004 	streq	r0, [r0, #-4]
     878:	07980264 	ldreq	r0, [r8, r4, ror #4]
     87c:	16800000 	strne	r0, [r0], r0
     880:	000002c4 	andeq	r0, r0, r4, asr #5
     884:	a8026505 	stmdage	r2, {r0, r2, r8, sl, sp, lr}
     888:	88000007 	stmdahi	r0, {r0, r1, r2}
     88c:	0004a916 	andeq	sl, r4, r6, lsl r9
     890:	02660500 	rsbeq	r0, r6, #0, 10
     894:	00000025 	andeq	r0, r0, r5, lsr #32
     898:	011716a0 	tsteq	r7, r0, lsr #13
     89c:	67050000 	strvs	r0, [r5, -r0]
     8a0:	0000fa02 	andeq	pc, r0, r2, lsl #20
     8a4:	6b16a400 	blvs	5a98ac <_stack+0x5298ac>
     8a8:	05000000 	streq	r0, [r0, #-0]
     8ac:	00fa0268 	rscseq	r0, sl, r8, ror #4
     8b0:	16ac0000 	strtne	r0, [ip], r0
     8b4:	00000106 	andeq	r0, r0, r6, lsl #2
     8b8:	fa026905 	blx	9acd4 <_stack+0x1acd4>
     8bc:	b4000000 	strlt	r0, [r0], #-0
     8c0:	00002b16 	andeq	r2, r0, r6, lsl fp
     8c4:	026a0500 	rsbeq	r0, sl, #0, 10
     8c8:	000000fa 	strdeq	r0, [r0], -sl
     8cc:	003a16bc 	ldrhteq	r1, [sl], -ip
     8d0:	6b050000 	blvs	1408d8 <_stack+0xc08d8>
     8d4:	0000fa02 	andeq	pc, r0, r2, lsl #20
     8d8:	b016c400 	andslt	ip, r6, r0, lsl #8
     8dc:	05000003 	streq	r0, [r0, #-3]
     8e0:	0025026c 	eoreq	r0, r5, ip, ror #4
     8e4:	00cc0000 	sbceq	r0, ip, r0
     8e8:	00055b08 	andeq	r5, r5, r8, lsl #22
     8ec:	00079800 	andeq	r9, r7, r0, lsl #16
     8f0:	00d20900 	sbcseq	r0, r2, r0, lsl #18
     8f4:	00190000 	andseq	r0, r9, r0
     8f8:	00055b08 	andeq	r5, r5, r8, lsl #22
     8fc:	0007a800 	andeq	sl, r7, r0, lsl #16
     900:	00d20900 	sbcseq	r0, r2, r0, lsl #18
     904:	00070000 	andeq	r0, r7, r0
     908:	00055b08 	andeq	r5, r5, r8, lsl #22
     90c:	0007b800 	andeq	fp, r7, r0, lsl #16
     910:	00d20900 	sbcseq	r0, r2, r0, lsl #18
     914:	00170000 	andseq	r0, r7, r0
     918:	7105f01a 	tstvc	r5, sl, lsl r0
     91c:	0007dc02 	andeq	sp, r7, r2, lsl #24
     920:	03141600 	tsteq	r4, #0, 12
     924:	74050000 	strvc	r0, [r5], #-0
     928:	0007dc02 	andeq	sp, r7, r2, lsl #24
     92c:	e4160000 	ldr	r0, [r6], #-0
     930:	05000004 	streq	r0, [r0, #-4]
     934:	07ec0275 			; <UNDEFINED> instruction: 0x07ec0275
     938:	00780000 	rsbseq	r0, r8, r0
     93c:	0002cf08 	andeq	ip, r2, r8, lsl #30
     940:	0007ec00 	andeq	lr, r7, r0, lsl #24
     944:	00d20900 	sbcseq	r0, r2, r0, lsl #18
     948:	001d0000 	andseq	r0, sp, r0
     94c:	00003708 	andeq	r3, r0, r8, lsl #14
     950:	0007fc00 	andeq	pc, r7, r0, lsl #24
     954:	00d20900 	sbcseq	r0, r2, r0, lsl #18
     958:	001d0000 	andseq	r0, sp, r0
     95c:	5605f01b 			; <UNDEFINED> instruction: 0x5605f01b
     960:	00081e02 	andeq	r1, r8, r2, lsl #28
     964:	09d91c00 	ldmibeq	r9, {sl, fp, ip}^
     968:	6d050000 	stcvs	0, cr0, [r5, #-0]
     96c:	00068702 	andeq	r8, r6, r2, lsl #14
     970:	05071c00 	streq	r1, [r7, #-3072]	; 0xc00
     974:	76050000 	strvc	r0, [r5], -r0
     978:	0007b802 	andeq	fp, r7, r2, lsl #16
     97c:	5b080000 	blpl	200984 <_stack+0x180984>
     980:	2e000005 	cdpcs	0, 0, cr0, cr0, cr5, {0}
     984:	09000008 	stmdbeq	r0, {r3}
     988:	000000d2 	ldrdeq	r0, [r0], -r2
     98c:	391d0018 	ldmdbcc	sp, {r3, r4}
     990:	14000008 	strne	r0, [r0], #-8
     994:	0000041d 	andeq	r0, r0, sp, lsl r4
     998:	2e040f00 	cdpcs	15, 0, cr0, cr4, cr0, {0}
     99c:	0f000008 	svceq	0x00000008
     9a0:	00017004 	andeq	r7, r1, r4
     9a4:	08501d00 	ldmdaeq	r0, {r8, sl, fp, ip}^
     9a8:	25140000 	ldrcs	r0, [r4, #-0]
     9ac:	00000000 	andeq	r0, r0, r0
     9b0:	0856040f 	ldmdaeq	r6, {r0, r1, r2, r3, sl}^
     9b4:	040f0000 	streq	r0, [pc], #-0	; 9bc <CPSR_IRQ_INHIBIT+0x93c>
     9b8:	00000845 	andeq	r0, r0, r5, asr #16
     9bc:	0005f508 	andeq	pc, r5, r8, lsl #10
     9c0:	00086c00 	andeq	r6, r8, r0, lsl #24
     9c4:	00d20900 	sbcseq	r0, r2, r0, lsl #18
     9c8:	00020000 	andeq	r0, r2, r0
     9cc:	0004e61e 	andeq	lr, r4, lr, lsl r6
     9d0:	10250600 	eorne	r0, r5, r0, lsl #12
     9d4:	04000001 	streq	r0, [r0], #-1
     9d8:	1000009d 	mulne	r0, sp, r0
     9dc:	01000000 	mrseq	r0, (UNDEF: 0)
     9e0:	0008a69c 	muleq	r8, ip, r6
     9e4:	03481f00 	movteq	r1, #36608	; 0x8f00
     9e8:	d4010000 	strle	r0, [r1], #-0
     9ec:	0000002c 	andeq	r0, r0, ip, lsr #32
     9f0:	00000000 	andeq	r0, r0, r0
     9f4:	009d1420 	addseq	r1, sp, r0, lsr #8
     9f8:	0008e800 	andeq	lr, r8, r0, lsl #16
     9fc:	51012100 	mrspl	r2, (UNDEF: 17)
     a00:	5001f303 	andpl	pc, r1, r3, lsl #6
     a04:	7a220000 	bvc	880a0c <_stack+0x800a0c>
     a08:	06000000 	streq	r0, [r0], -r0
     a0c:	009d142d 	addseq	r1, sp, sp, lsr #8
     a10:	00001000 	andeq	r1, r0, r0
     a14:	dc9c0100 	ldfles	f0, [ip], {0}
     a18:	1f000008 	svcne	0x00000008
     a1c:	0000001b 	andeq	r0, r0, fp, lsl r0
     a20:	0110db01 	tsteq	r0, r1, lsl #22
     a24:	002c0000 	eoreq	r0, ip, r0
     a28:	24200000 	strtcs	r0, [r0], #-0
     a2c:	0200009d 	andeq	r0, r0, #157	; 0x9d
     a30:	21000009 	tstcs	r0, r9
     a34:	f3035101 	vrhadd.u8	d5, d3, d1
     a38:	00005001 	andeq	r5, r0, r1
     a3c:	000ada23 	andeq	sp, sl, r3, lsr #20
     a40:	02fa0500 	rscseq	r0, sl, #0, 10
     a44:	0000041d 	andeq	r0, r0, sp, lsl r4
     a48:	00042f24 	andeq	r2, r4, r4, lsr #30
     a4c:	102a0600 	eorne	r0, sl, r0, lsl #12
     a50:	02000001 	andeq	r0, r0, #1
     a54:	14000009 	strne	r0, [r0], #-9
     a58:	0000041d 	andeq	r0, r0, sp, lsl r4
     a5c:	00002c14 	andeq	r2, r0, r4, lsl ip
     a60:	95250000 	strls	r0, [r5, #-0]!
     a64:	06000003 	streq	r0, [r0], -r3
     a68:	041d1432 	ldreq	r1, [sp], #-1074	; 0x432
     a6c:	10140000 	andsne	r0, r4, r0
     a70:	00000001 	andeq	r0, r0, r1
     a74:	000d7900 	andeq	r7, sp, r0, lsl #18
     a78:	22000400 	andcs	r0, r0, #0, 8
     a7c:	04000002 	streq	r0, [r0], #-2
     a80:	00014101 	andeq	r4, r1, r1, lsl #2
     a84:	06e50100 	strbteq	r0, [r5], r0, lsl #2
     a88:	024c0000 	subeq	r0, ip, #0
     a8c:	00400000 	subeq	r0, r0, r0
     a90:	00000000 	andeq	r0, r0, r0
     a94:	02460000 	subeq	r0, r6, #0
     a98:	01020000 	mrseq	r0, (UNDEF: 2)
     a9c:	02000006 	andeq	r0, r0, #6
     aa0:	00003093 	muleq	r0, r3, r0
     aa4:	05040300 	streq	r0, [r4, #-768]	; 0x300
     aa8:	00746e69 	rsbseq	r6, r4, r9, ror #28
     aac:	00000c02 	andeq	r0, r0, r2, lsl #24
     ab0:	42d40200 	sbcsmi	r0, r4, #0, 4
     ab4:	04000000 	streq	r0, [r0], #-0
     ab8:	00550704 	subseq	r0, r5, r4, lsl #14
     abc:	04050000 	streq	r0, [r5], #-0
     ac0:	9f060104 	svcls	0x00060104
     ac4:	04000003 	streq	r0, [r0], #-3
     ac8:	039d0801 	orrseq	r0, sp, #65536	; 0x10000
     acc:	02040000 	andeq	r0, r4, #0
     ad0:	0003b905 	andeq	fp, r3, r5, lsl #18
     ad4:	07020400 	streq	r0, [r2, -r0, lsl #8]
     ad8:	000002a8 	andeq	r0, r0, r8, lsr #5
     adc:	9b050404 	blls	141af4 <_stack+0xc1af4>
     ae0:	04000000 	streq	r0, [r0], #-0
     ae4:	00500704 	subseq	r0, r0, r4, lsl #14
     ae8:	08040000 	stmdaeq	r4, {}	; <UNPREDICTABLE>
     aec:	00009605 	andeq	r9, r0, r5, lsl #12
     af0:	07080400 	streq	r0, [r8, -r0, lsl #8]
     af4:	0000004b 	andeq	r0, r0, fp, asr #32
     af8:	00034f02 	andeq	r4, r3, r2, lsl #30
     afc:	30070300 	andcc	r0, r7, r0, lsl #6
     b00:	02000000 	andeq	r0, r0, #0
     b04:	00000337 	andeq	r0, r0, r7, lsr r3
     b08:	00671004 	rsbeq	r1, r7, r4
     b0c:	67020000 	strvs	r0, [r2, -r0]
     b10:	04000004 	streq	r0, [r0], #-4
     b14:	00006727 	andeq	r6, r0, r7, lsr #14
     b18:	02eb0600 	rsceq	r0, fp, #0, 12
     b1c:	61020000 	mrsvs	r0, (UNDEF: 2)
     b20:	00004201 	andeq	r4, r0, r1, lsl #4
     b24:	04040700 	streq	r0, [r4], #-1792	; 0x700
     b28:	0000cf4a 	andeq	ip, r0, sl, asr #30
     b2c:	02e50800 	rsceq	r0, r5, #0, 16
     b30:	4c040000 	stcmi	0, cr0, [r4], {-0}
     b34:	000000a4 	andeq	r0, r0, r4, lsr #1
     b38:	00022f08 	andeq	r2, r2, r8, lsl #30
     b3c:	cf4d0400 	svcgt	0x004d0400
     b40:	00000000 	andeq	r0, r0, r0
     b44:	00005209 	andeq	r5, r0, r9, lsl #4
     b48:	0000df00 	andeq	sp, r0, r0, lsl #30
     b4c:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
     b50:	00030000 	andeq	r0, r3, r0
     b54:	0b070404 	bleq	1c1b6c <_stack+0x141b6c>
     b58:	0b000003 	bleq	b6c <CPSR_IRQ_INHIBIT+0xaec>
     b5c:	07470408 	strbeq	r0, [r7, -r8, lsl #8]
     b60:	0c000001 	stceq	0, cr0, [r0], {1}
     b64:	00000451 	andeq	r0, r0, r1, asr r4
     b68:	00304904 	eorseq	r4, r0, r4, lsl #18
     b6c:	0c000000 	stceq	0, cr0, [r0], {-0}
     b70:	00000459 	andeq	r0, r0, r9, asr r4
     b74:	00b04e04 	adcseq	r4, r0, r4, lsl #28
     b78:	00040000 	andeq	r0, r4, r0
     b7c:	0003e102 	andeq	lr, r3, r2, lsl #2
     b80:	e64f0400 	strb	r0, [pc], -r0, lsl #8
     b84:	02000000 	andeq	r0, r0, #0
     b88:	00000138 	andeq	r0, r0, r8, lsr r1
     b8c:	00835304 	addeq	r5, r3, r4, lsl #6
     b90:	a1020000 	mrsge	r0, (UNDEF: 2)
     b94:	05000004 	streq	r0, [r0, #-4]
     b98:	00006e16 	andeq	r6, r0, r6, lsl lr
     b9c:	02030d00 	andeq	r0, r3, #0, 26
     ba0:	05180000 	ldreq	r0, [r8, #-0]
     ba4:	00017b2d 	andeq	r7, r1, sp, lsr #22
     ba8:	04020c00 	streq	r0, [r2], #-3072	; 0xc00
     bac:	2f050000 	svccs	0x00050000
     bb0:	0000017b 	andeq	r0, r0, fp, ror r1
     bb4:	6b5f0e00 	blvs	17c43bc <_stack+0x17443bc>
     bb8:	30300500 	eorscc	r0, r0, r0, lsl #10
     bbc:	04000000 	streq	r0, [r0], #-0
     bc0:	0004430c 	andeq	r4, r4, ip, lsl #6
     bc4:	30300500 	eorscc	r0, r0, r0, lsl #10
     bc8:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     bcc:	0001320c 	andeq	r3, r1, ip, lsl #4
     bd0:	30300500 	eorscc	r0, r0, r0, lsl #10
     bd4:	0c000000 	stceq	0, cr0, [r0], {-0}
     bd8:	0004d50c 	andeq	sp, r4, ip, lsl #10
     bdc:	30300500 	eorscc	r0, r0, r0, lsl #10
     be0:	10000000 	andne	r0, r0, r0
     be4:	00785f0e 	rsbseq	r5, r8, lr, lsl #30
     be8:	01813105 	orreq	r3, r1, r5, lsl #2
     bec:	00140000 	andseq	r0, r4, r0
     bf0:	0128040f 	teqeq	r8, pc, lsl #8
     bf4:	1d090000 	stcne	0, cr0, [r9, #-0]
     bf8:	91000001 	tstls	r0, r1
     bfc:	0a000001 	beq	c08 <CPSR_IRQ_INHIBIT+0xb88>
     c00:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     c04:	2a0d0000 	bcs	340c0c <_stack+0x2c0c0c>
     c08:	24000002 	strcs	r0, [r0], #-2
     c0c:	020a3505 	andeq	r3, sl, #20971520	; 0x1400000
     c10:	8d0c0000 	stchi	0, cr0, [ip, #-0]
     c14:	05000000 	streq	r0, [r0, #-0]
     c18:	00003037 	andeq	r3, r0, r7, lsr r0
     c1c:	6f0c0000 	svcvs	0x000c0000
     c20:	05000004 	streq	r0, [r0, #-4]
     c24:	00003038 	andeq	r3, r0, r8, lsr r0
     c28:	aa0c0400 	bge	301c30 <_stack+0x281c30>
     c2c:	05000000 	streq	r0, [r0, #-0]
     c30:	00003039 	andeq	r3, r0, r9, lsr r0
     c34:	480c0800 	stmdami	ip, {fp}
     c38:	05000005 	streq	r0, [r0, #-5]
     c3c:	0000303a 	andeq	r3, r0, sl, lsr r0
     c40:	1b0c0c00 	blne	303c48 <_stack+0x283c48>
     c44:	05000003 	streq	r0, [r0, #-3]
     c48:	0000303b 	andeq	r3, r0, fp, lsr r0
     c4c:	010c1000 	mrseq	r1, (UNDEF: 12)
     c50:	05000003 	streq	r0, [r0, #-3]
     c54:	0000303c 	andeq	r3, r0, ip, lsr r0
     c58:	da0c1400 	ble	305c60 <_stack+0x285c60>
     c5c:	05000004 	streq	r0, [r0, #-4]
     c60:	0000303d 	andeq	r3, r0, sp, lsr r0
     c64:	c30c1800 	movwgt	r1, #51200	; 0xc800
     c68:	05000003 	streq	r0, [r0, #-3]
     c6c:	0000303e 	andeq	r3, r0, lr, lsr r0
     c70:	0f0c1c00 	svceq	0x000c1c00
     c74:	05000005 	streq	r0, [r0, #-5]
     c78:	0000303f 	andeq	r3, r0, pc, lsr r0
     c7c:	10002000 	andne	r2, r0, r0
     c80:	000000b9 	strheq	r0, [r0], -r9
     c84:	48050108 	stmdami	r5, {r3, r8}
     c88:	0000024a 	andeq	r0, r0, sl, asr #4
     c8c:	0001250c 	andeq	r2, r1, ip, lsl #10
     c90:	4a490500 	bmi	1242098 <_stack+0x11c2098>
     c94:	00000002 	andeq	r0, r0, r2
     c98:	0000000c 	andeq	r0, r0, ip
     c9c:	4a4a0500 	bmi	12820a4 <_stack+0x12020a4>
     ca0:	80000002 	andhi	r0, r0, r2
     ca4:	00049311 	andeq	r9, r4, r1, lsl r3
     ca8:	1d4c0500 	cfstr64ne	mvdx0, [ip, #-0]
     cac:	00000001 	andeq	r0, r0, r1
     cb0:	00de1101 	sbcseq	r1, lr, r1, lsl #2
     cb4:	4f050000 	svcmi	0x00050000
     cb8:	0000011d 	andeq	r0, r0, sp, lsl r1
     cbc:	09000104 	stmdbeq	r0, {r2, r8}
     cc0:	00000049 	andeq	r0, r0, r9, asr #32
     cc4:	0000025a 	andeq	r0, r0, sl, asr r2
     cc8:	0000df0a 	andeq	sp, r0, sl, lsl #30
     ccc:	10001f00 	andne	r1, r0, r0, lsl #30
     cd0:	00000324 	andeq	r0, r0, r4, lsr #6
     cd4:	5b050190 	blpl	14131c <_stack+0xc131c>
     cd8:	00000298 	muleq	r0, r8, r2
     cdc:	0004020c 	andeq	r0, r4, ip, lsl #4
     ce0:	985c0500 	ldmdals	ip, {r8, sl}^
     ce4:	00000002 	andeq	r0, r0, r2
     ce8:	00041a0c 	andeq	r1, r4, ip, lsl #20
     cec:	305d0500 	subscc	r0, sp, r0, lsl #10
     cf0:	04000000 	streq	r0, [r0], #-0
     cf4:	00012d0c 	andeq	r2, r1, ip, lsl #26
     cf8:	9e5f0500 	cdpls	5, 5, cr0, cr15, cr0, {0}
     cfc:	08000002 	stmdaeq	r0, {r1}
     d00:	0000b90c 	andeq	fp, r0, ip, lsl #18
     d04:	0a600500 	beq	180210c <_stack+0x178210c>
     d08:	88000002 	stmdahi	r0, {r1}
     d0c:	5a040f00 	bpl	104914 <_stack+0x84914>
     d10:	09000002 	stmdbeq	r0, {r1}
     d14:	000002ae 	andeq	r0, r0, lr, lsr #5
     d18:	000002ae 	andeq	r0, r0, lr, lsr #5
     d1c:	0000df0a 	andeq	sp, r0, sl, lsl #30
     d20:	0f001f00 	svceq	0x00001f00
     d24:	0002b404 	andeq	fp, r2, r4, lsl #8
     d28:	cd0d1200 	sfmgt	f1, 4, [sp, #-0]
     d2c:	08000003 	stmdaeq	r0, {r0, r1}
     d30:	02da7305 	sbcseq	r7, sl, #335544320	; 0x14000000
     d34:	610c0000 	mrsvs	r0, (UNDEF: 12)
     d38:	05000007 	streq	r0, [r0, #-7]
     d3c:	0002da74 	andeq	sp, r2, r4, ror sl
     d40:	180c0000 	stmdane	ip, {}	; <UNPREDICTABLE>
     d44:	05000006 	streq	r0, [r0, #-6]
     d48:	00003075 	andeq	r3, r0, r5, ror r0
     d4c:	0f000400 	svceq	0x00000400
     d50:	00005204 	andeq	r5, r0, r4, lsl #4
     d54:	03ec0d00 	mvneq	r0, #0, 26
     d58:	05680000 	strbeq	r0, [r8, #-0]!
     d5c:	00040ab3 			; <UNDEFINED> instruction: 0x00040ab3
     d60:	705f0e00 	subsvc	r0, pc, r0, lsl #28
     d64:	dab40500 	ble	fed0216c <STACK_SVR+0xfad0216c>
     d68:	00000002 	andeq	r0, r0, r2
     d6c:	00725f0e 	rsbseq	r5, r2, lr, lsl #30
     d70:	0030b505 	eorseq	fp, r0, r5, lsl #10
     d74:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     d78:	0500775f 	streq	r7, [r0, #-1887]	; 0x75f
     d7c:	000030b6 	strheq	r3, [r0], -r6
     d80:	d70c0800 	strle	r0, [ip, -r0, lsl #16]
     d84:	05000000 	streq	r0, [r0, #-0]
     d88:	000059b7 			; <UNDEFINED> instruction: 0x000059b7
     d8c:	460c0c00 	strmi	r0, [ip], -r0, lsl #24
     d90:	05000002 	streq	r0, [r0, #-2]
     d94:	000059b8 			; <UNDEFINED> instruction: 0x000059b8
     d98:	5f0e0e00 	svcpl	0x000e0e00
     d9c:	05006662 	streq	r6, [r0, #-1634]	; 0x662
     da0:	0002b5b9 			; <UNDEFINED> instruction: 0x0002b5b9
     da4:	620c1000 	andvs	r1, ip, #0
     da8:	05000000 	streq	r0, [r0, #-0]
     dac:	000030ba 	strheq	r3, [r0], -sl
     db0:	c70c1800 	strgt	r1, [ip, -r0, lsl #16]
     db4:	05000000 	streq	r0, [r0, #-0]
     db8:	000049c1 	andeq	r4, r0, r1, asr #19
     dbc:	1a0c1c00 	bne	307dc4 <_stack+0x287dc4>
     dc0:	05000002 	streq	r0, [r0, #-2]
     dc4:	00056dc3 	andeq	r6, r5, r3, asr #27
     dc8:	fa0c2000 	blx	308dd0 <_stack+0x288dd0>
     dcc:	05000002 	streq	r0, [r0, #-2]
     dd0:	00059cc5 	andeq	r9, r5, r5, asr #25
     dd4:	610c2400 	tstvs	ip, r0, lsl #8
     dd8:	05000004 	streq	r0, [r0, #-4]
     ddc:	0005c0c8 	andeq	ip, r5, r8, asr #1
     de0:	290c2800 	stmdbcs	ip, {fp, sp}
     de4:	05000005 	streq	r0, [r0, #-5]
     de8:	0005dac9 	andeq	sp, r5, r9, asr #21
     dec:	5f0e2c00 	svcpl	0x000e2c00
     df0:	05006275 	streq	r6, [r0, #-629]	; 0x275
     df4:	0002b5cc 	andeq	fp, r2, ip, asr #11
     df8:	5f0e3000 	svcpl	0x000e3000
     dfc:	05007075 	streq	r7, [r0, #-117]	; 0x75
     e00:	0002dacd 	andeq	sp, r2, sp, asr #21
     e04:	5f0e3800 	svcpl	0x000e3800
     e08:	05007275 	streq	r7, [r0, #-629]	; 0x275
     e0c:	000030ce 	andeq	r3, r0, lr, asr #1
     e10:	a40c3c00 	strge	r3, [ip], #-3072	; 0xc00
     e14:	05000000 	streq	r0, [r0, #-0]
     e18:	0005e0d1 	ldrdeq	lr, [r5], -r1
     e1c:	010c4000 	mrseq	r4, (UNDEF: 12)
     e20:	05000005 	streq	r0, [r0, #-5]
     e24:	0005f0d2 	ldrdeq	pc, [r5], -r2
     e28:	5f0e4300 	svcpl	0x000e4300
     e2c:	0500626c 	streq	r6, [r0, #-620]	; 0x26c
     e30:	0002b5d5 	ldrdeq	fp, [r2], -r5
     e34:	ed0c4400 	cfstrs	mvf4, [ip, #-0]
     e38:	05000000 	streq	r0, [r0, #-0]
     e3c:	000030d8 	ldrdeq	r3, [r0], -r8
     e40:	fe0c4c00 	cdp2	12, 0, cr4, cr12, cr0, {0}
     e44:	05000000 	streq	r0, [r0, #-0]
     e48:	00008ed9 	ldrdeq	r8, [r0], -r9
     e4c:	9a0c5000 	bls	314e54 <_stack+0x294e54>
     e50:	0500000a 	streq	r0, [r0, #-10]
     e54:	000428dc 	ldrdeq	r2, [r4], -ip
     e58:	fb0c5400 	blx	315e62 <_stack+0x295e62>
     e5c:	05000005 	streq	r0, [r0, #-5]
     e60:	000112e0 	andeq	r1, r1, r0, ror #5
     e64:	f40c5800 	vst2.8	{d5-d6}, [ip], r0
     e68:	05000003 	streq	r0, [r0, #-3]
     e6c:	000107e2 	andeq	r0, r1, r2, ror #15
     e70:	f20c5c00 			; <UNDEFINED> instruction: 0xf20c5c00
     e74:	05000002 	streq	r0, [r0, #-2]
     e78:	000030e3 	andeq	r3, r0, r3, ror #1
     e7c:	13006400 	movwne	r6, #1024	; 0x400
     e80:	00000030 	andeq	r0, r0, r0, lsr r0
     e84:	00000428 	andeq	r0, r0, r8, lsr #8
     e88:	00042814 	andeq	r2, r4, r4, lsl r8
     e8c:	00491400 	subeq	r1, r9, r0, lsl #8
     e90:	60140000 	andsvs	r0, r4, r0
     e94:	14000005 	strne	r0, [r0], #-5
     e98:	00000030 	andeq	r0, r0, r0, lsr r0
     e9c:	2e040f00 	cdpcs	15, 0, cr0, cr4, cr0, {0}
     ea0:	15000004 	strne	r0, [r0, #-4]
     ea4:	000009d9 	ldrdeq	r0, [r0], -r9
     ea8:	39050428 	stmdbcc	r5, {r3, r5, sl}
     eac:	00056002 	andeq	r6, r5, r2
     eb0:	03b21600 			; <UNDEFINED> instruction: 0x03b21600
     eb4:	3b050000 	blcc	140ebc <_stack+0xc0ebc>
     eb8:	00003002 	andeq	r3, r0, r2
     ebc:	e6160000 	ldr	r0, [r6], -r0
     ec0:	05000000 	streq	r0, [r0, #-0]
     ec4:	06470240 	strbeq	r0, [r7], -r0, asr #4
     ec8:	16040000 	strne	r0, [r4], -r0
     ecc:	00000236 	andeq	r0, r0, r6, lsr r2
     ed0:	47024005 	strmi	r4, [r2, -r5]
     ed4:	08000006 	stmdaeq	r0, {r1, r2}
     ed8:	00047e16 	andeq	r7, r4, r6, lsl lr
     edc:	02400500 	subeq	r0, r0, #0, 10
     ee0:	00000647 	andeq	r0, r0, r7, asr #12
     ee4:	0415160c 	ldreq	r1, [r5], #-1548	; 0x60c
     ee8:	42050000 	andmi	r0, r5, #0
     eec:	00003002 	andeq	r3, r0, r2
     ef0:	20161000 	andscs	r1, r6, r0
     ef4:	05000000 	streq	r0, [r0, #-0]
     ef8:	08290243 	stmdaeq	r9!, {r0, r1, r6, r9}
     efc:	16140000 	ldrne	r0, [r4], -r0
     f00:	000004b6 			; <UNDEFINED> instruction: 0x000004b6
     f04:	30024505 	andcc	r4, r2, r5, lsl #10
     f08:	30000000 	andcc	r0, r0, r0
     f0c:	00041f16 	andeq	r1, r4, r6, lsl pc
     f10:	02460500 	subeq	r0, r6, #0, 10
     f14:	00000591 	muleq	r0, r1, r5
     f18:	032c1634 	teqeq	ip, #52, 12	; 0x3400000
     f1c:	48050000 	stmdami	r5, {}	; <UNPREDICTABLE>
     f20:	00003002 	andeq	r3, r0, r2
     f24:	39163800 	ldmdbcc	r6, {fp, ip, sp}
     f28:	05000004 	streq	r0, [r0, #-4]
     f2c:	0844024a 	stmdaeq	r4, {r1, r3, r6, r9}^
     f30:	163c0000 	ldrtne	r0, [ip], -r0
     f34:	000002dd 	ldrdeq	r0, [r0], -sp
     f38:	7b024d05 	blvc	94354 <_stack+0x14354>
     f3c:	40000001 	andmi	r0, r0, r1
     f40:	00022016 	andeq	r2, r2, r6, lsl r0
     f44:	024e0500 	subeq	r0, lr, #0, 10
     f48:	00000030 	andeq	r0, r0, r0, lsr r0
     f4c:	05431644 	strbeq	r1, [r3, #-1604]	; 0x644
     f50:	4f050000 	svcmi	0x00050000
     f54:	00017b02 	andeq	r7, r1, r2, lsl #22
     f58:	3e164800 	cdpcc	8, 1, cr4, cr6, cr0, {0}
     f5c:	05000003 	streq	r0, [r0, #-3]
     f60:	084a0250 	stmdaeq	sl, {r4, r6, r9}^
     f64:	164c0000 	strbne	r0, [ip], -r0
     f68:	0000023e 	andeq	r0, r0, lr, lsr r2
     f6c:	30025305 	andcc	r5, r2, r5, lsl #6
     f70:	50000000 	andpl	r0, r0, r0
     f74:	0000f616 	andeq	pc, r0, r6, lsl r6	; <UNPREDICTABLE>
     f78:	02540500 	subseq	r0, r4, #0, 10
     f7c:	00000560 	andeq	r0, r0, r0, ror #10
     f80:	03ab1654 			; <UNDEFINED> instruction: 0x03ab1654
     f84:	77050000 	strvc	r0, [r5, -r0]
     f88:	00080702 	andeq	r0, r8, r2, lsl #14
     f8c:	24175800 	ldrcs	r5, [r7], #-2048	; 0x800
     f90:	05000003 	streq	r0, [r0, #-3]
     f94:	0298027b 	addseq	r0, r8, #-1342177273	; 0xb0000007
     f98:	01480000 	mrseq	r0, (UNDEF: 72)
     f9c:	0002bb17 	andeq	fp, r2, r7, lsl fp
     fa0:	027c0500 	rsbseq	r0, ip, #0, 10
     fa4:	0000025a 	andeq	r0, r0, sl, asr r2
     fa8:	f717014c 			; <UNDEFINED> instruction: 0xf717014c
     fac:	05000004 	streq	r0, [r0, #-4]
     fb0:	085b0280 	ldmdaeq	fp, {r7, r9}^
     fb4:	02dc0000 	sbcseq	r0, ip, #0
     fb8:	0000cf17 	andeq	ip, r0, r7, lsl pc
     fbc:	02850500 	addeq	r0, r5, #0, 10
     fc0:	0000060c 	andeq	r0, r0, ip, lsl #12
     fc4:	b41702e0 	ldrlt	r0, [r7], #-736	; 0x2e0
     fc8:	05000000 	streq	r0, [r0, #-0]
     fcc:	08670286 	stmdaeq	r7!, {r1, r2, r7, r9}^
     fd0:	02ec0000 	rsceq	r0, ip, #0
     fd4:	66040f00 	strvs	r0, [r4], -r0, lsl #30
     fd8:	04000005 	streq	r0, [r0], #-5
     fdc:	03a60801 			; <UNDEFINED> instruction: 0x03a60801
     fe0:	040f0000 	streq	r0, [pc], #-0	; fe8 <CPSR_IRQ_INHIBIT+0xf68>
     fe4:	0000040a 	andeq	r0, r0, sl, lsl #8
     fe8:	00003013 	andeq	r3, r0, r3, lsl r0
     fec:	00059100 	andeq	r9, r5, r0, lsl #2
     ff0:	04281400 	strteq	r1, [r8], #-1024	; 0x400
     ff4:	49140000 	ldmdbmi	r4, {}	; <UNPREDICTABLE>
     ff8:	14000000 	strne	r0, [r0], #-0
     ffc:	00000591 	muleq	r0, r1, r5
    1000:	00003014 	andeq	r3, r0, r4, lsl r0
    1004:	040f0000 	streq	r0, [pc], #-0	; 100c <CPSR_IRQ_INHIBIT+0xf8c>
    1008:	00000597 	muleq	r0, r7, r5
    100c:	00056618 	andeq	r6, r5, r8, lsl r6
    1010:	73040f00 	movwvc	r0, #20224	; 0x4f00
    1014:	13000005 	movwne	r0, #5
    1018:	00000099 	muleq	r0, r9, r0
    101c:	000005c0 	andeq	r0, r0, r0, asr #11
    1020:	00042814 	andeq	r2, r4, r4, lsl r8
    1024:	00491400 	subeq	r1, r9, r0, lsl #8
    1028:	99140000 	ldmdbls	r4, {}	; <UNPREDICTABLE>
    102c:	14000000 	strne	r0, [r0], #-0
    1030:	00000030 	andeq	r0, r0, r0, lsr r0
    1034:	a2040f00 	andge	r0, r4, #0, 30
    1038:	13000005 	movwne	r0, #5
    103c:	00000030 	andeq	r0, r0, r0, lsr r0
    1040:	000005da 	ldrdeq	r0, [r0], -sl
    1044:	00042814 	andeq	r2, r4, r4, lsl r8
    1048:	00491400 	subeq	r1, r9, r0, lsl #8
    104c:	0f000000 	svceq	0x00000000
    1050:	0005c604 	andeq	ip, r5, r4, lsl #12
    1054:	00520900 	subseq	r0, r2, r0, lsl #18
    1058:	05f00000 	ldrbeq	r0, [r0, #0]!
    105c:	df0a0000 	svcle	0x000a0000
    1060:	02000000 	andeq	r0, r0, #0
    1064:	00520900 	subseq	r0, r2, r0, lsl #18
    1068:	06000000 	streq	r0, [r0], -r0
    106c:	df0a0000 	svcle	0x000a0000
    1070:	00000000 	andeq	r0, r0, r0
    1074:	03da0600 	bicseq	r0, sl, #0, 12
    1078:	1d050000 	stcne	0, cr0, [r5, #-0]
    107c:	0002e001 	andeq	lr, r2, r1
    1080:	093d1900 	ldmdbeq	sp!, {r8, fp, ip}
    1084:	050c0000 	streq	r0, [ip, #-0]
    1088:	06410121 	strbeq	r0, [r1], -r1, lsr #2
    108c:	02160000 	andseq	r0, r6, #0
    1090:	05000004 	streq	r0, [r0, #-4]
    1094:	06410123 	strbeq	r0, [r1], -r3, lsr #2
    1098:	16000000 	strne	r0, [r0], -r0
    109c:	000002a1 	andeq	r0, r0, r1, lsr #5
    10a0:	30012405 	andcc	r2, r1, r5, lsl #8
    10a4:	04000000 	streq	r0, [r0], #-0
    10a8:	0003d416 	andeq	sp, r3, r6, lsl r4
    10ac:	01250500 	teqeq	r5, r0, lsl #10
    10b0:	00000647 	andeq	r0, r0, r7, asr #12
    10b4:	040f0008 	streq	r0, [pc], #-8	; 10bc <CPSR_IRQ_INHIBIT+0x103c>
    10b8:	0000060c 	andeq	r0, r0, ip, lsl #12
    10bc:	0600040f 	streq	r0, [r0], -pc, lsl #8
    10c0:	13190000 	tstne	r9, #0
    10c4:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    10c8:	82013d05 	andhi	r3, r1, #320	; 0x140
    10cc:	16000006 	strne	r0, [r0], -r6
    10d0:	0000044b 	andeq	r0, r0, fp, asr #8
    10d4:	82013e05 	andhi	r3, r1, #5, 28	; 0x50
    10d8:	00000006 	andeq	r0, r0, r6
    10dc:	00047816 	andeq	r7, r4, r6, lsl r8
    10e0:	013f0500 	teqeq	pc, r0, lsl #10
    10e4:	00000682 	andeq	r0, r0, r2, lsl #13
    10e8:	049c1606 	ldreq	r1, [ip], #1542	; 0x606
    10ec:	40050000 	andmi	r0, r5, r0
    10f0:	00006001 	andeq	r6, r0, r1
    10f4:	09000c00 	stmdbeq	r0, {sl, fp}
    10f8:	00000060 	andeq	r0, r0, r0, rrx
    10fc:	00000692 	muleq	r0, r2, r6
    1100:	0000df0a 	andeq	sp, r0, sl, lsl #30
    1104:	1a000200 	bne	190c <CPSR_IRQ_INHIBIT+0x188c>
    1108:	025805d0 	subseq	r0, r8, #208, 10	; 0x34000000
    110c:	00000793 	muleq	r0, r3, r7
    1110:	0004c816 	andeq	ip, r4, r6, lsl r8
    1114:	025a0500 	subseq	r0, sl, #0, 10
    1118:	00000042 	andeq	r0, r0, r2, asr #32
    111c:	04861600 	streq	r1, [r6], #1536	; 0x600
    1120:	5b050000 	blpl	141128 <_stack+0xc1128>
    1124:	00056002 	andeq	r6, r5, r2
    1128:	d0160400 	andsle	r0, r6, r0, lsl #8
    112c:	05000002 	streq	r0, [r0, #-2]
    1130:	0793025c 			; <UNDEFINED> instruction: 0x0793025c
    1134:	16080000 	strne	r0, [r8], -r0
    1138:	0000051a 	andeq	r0, r0, sl, lsl r5
    113c:	91025d05 	tstls	r2, r5, lsl #26
    1140:	24000001 	strcs	r0, [r0], #-1
    1144:	00020b16 	andeq	r0, r2, r6, lsl fp
    1148:	025e0500 	subseq	r0, lr, #0, 10
    114c:	00000030 	andeq	r0, r0, r0, lsr r0
    1150:	03fd1648 	mvnseq	r1, #72, 12	; 0x4800000
    1154:	5f050000 	svcpl	0x00050000
    1158:	00007c02 	andeq	r7, r0, r2, lsl #24
    115c:	30165000 	andscc	r5, r6, r0
    1160:	05000005 	streq	r0, [r0, #-5]
    1164:	064d0260 	strbeq	r0, [sp], -r0, ror #4
    1168:	16580000 	ldrbne	r0, [r8], -r0
    116c:	00000408 	andeq	r0, r0, r8, lsl #8
    1170:	07026105 	streq	r6, [r2, -r5, lsl #2]
    1174:	68000001 	stmdavs	r0, {r0}
    1178:	00053516 	andeq	r3, r5, r6, lsl r5
    117c:	02620500 	rsbeq	r0, r2, #0, 10
    1180:	00000107 	andeq	r0, r0, r7, lsl #2
    1184:	007f1670 	rsbseq	r1, pc, r0, ror r6	; <UNPREDICTABLE>
    1188:	63050000 	movwvs	r0, #20480	; 0x5000
    118c:	00010702 	andeq	r0, r1, r2, lsl #14
    1190:	ed167800 	ldc	8, cr7, [r6, #-0]
    1194:	05000004 	streq	r0, [r0, #-4]
    1198:	07a30264 	streq	r0, [r3, r4, ror #4]!
    119c:	16800000 	strne	r0, [r0], r0
    11a0:	000002c4 	andeq	r0, r0, r4, asr #5
    11a4:	b3026505 	movwlt	r6, #9477	; 0x2505
    11a8:	88000007 	stmdahi	r0, {r0, r1, r2}
    11ac:	0004a916 	andeq	sl, r4, r6, lsl r9
    11b0:	02660500 	rsbeq	r0, r6, #0, 10
    11b4:	00000030 	andeq	r0, r0, r0, lsr r0
    11b8:	011716a0 	tsteq	r7, r0, lsr #13
    11bc:	67050000 	strvs	r0, [r5, -r0]
    11c0:	00010702 	andeq	r0, r1, r2, lsl #14
    11c4:	6b16a400 	blvs	5aa1cc <_stack+0x52a1cc>
    11c8:	05000000 	streq	r0, [r0, #-0]
    11cc:	01070268 	tsteq	r7, r8, ror #4
    11d0:	16ac0000 	strtne	r0, [ip], r0
    11d4:	00000106 	andeq	r0, r0, r6, lsl #2
    11d8:	07026905 	streq	r6, [r2, -r5, lsl #18]
    11dc:	b4000001 	strlt	r0, [r0], #-1
    11e0:	00002b16 	andeq	r2, r0, r6, lsl fp
    11e4:	026a0500 	rsbeq	r0, sl, #0, 10
    11e8:	00000107 	andeq	r0, r0, r7, lsl #2
    11ec:	003a16bc 	ldrhteq	r1, [sl], -ip
    11f0:	6b050000 	blvs	1411f8 <_stack+0xc11f8>
    11f4:	00010702 	andeq	r0, r1, r2, lsl #14
    11f8:	b016c400 	andslt	ip, r6, r0, lsl #8
    11fc:	05000003 	streq	r0, [r0, #-3]
    1200:	0030026c 	eorseq	r0, r0, ip, ror #4
    1204:	00cc0000 	sbceq	r0, ip, r0
    1208:	00056609 	andeq	r6, r5, r9, lsl #12
    120c:	0007a300 	andeq	sl, r7, r0, lsl #6
    1210:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    1214:	00190000 	andseq	r0, r9, r0
    1218:	00056609 	andeq	r6, r5, r9, lsl #12
    121c:	0007b300 	andeq	fp, r7, r0, lsl #6
    1220:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    1224:	00070000 	andeq	r0, r7, r0
    1228:	00056609 	andeq	r6, r5, r9, lsl #12
    122c:	0007c300 	andeq	ip, r7, r0, lsl #6
    1230:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    1234:	00170000 	andseq	r0, r7, r0
    1238:	7105f01a 	tstvc	r5, sl, lsl r0
    123c:	0007e702 	andeq	lr, r7, r2, lsl #14
    1240:	03141600 	tsteq	r4, #0, 12
    1244:	74050000 	strvc	r0, [r5], #-0
    1248:	0007e702 	andeq	lr, r7, r2, lsl #14
    124c:	e4160000 	ldr	r0, [r6], #-0
    1250:	05000004 	streq	r0, [r0, #-4]
    1254:	07f70275 			; <UNDEFINED> instruction: 0x07f70275
    1258:	00780000 	rsbseq	r0, r8, r0
    125c:	0002da09 	andeq	sp, r2, r9, lsl #20
    1260:	0007f700 	andeq	pc, r7, r0, lsl #14
    1264:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    1268:	001d0000 	andseq	r0, sp, r0
    126c:	00004209 	andeq	r4, r0, r9, lsl #4
    1270:	00080700 	andeq	r0, r8, r0, lsl #14
    1274:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    1278:	001d0000 	andseq	r0, sp, r0
    127c:	5605f01b 			; <UNDEFINED> instruction: 0x5605f01b
    1280:	00082902 	andeq	r2, r8, r2, lsl #18
    1284:	09d91c00 	ldmibeq	r9, {sl, fp, ip}^
    1288:	6d050000 	stcvs	0, cr0, [r5, #-0]
    128c:	00069202 	andeq	r9, r6, r2, lsl #4
    1290:	05071c00 	streq	r1, [r7, #-3072]	; 0xc00
    1294:	76050000 	strvc	r0, [r5], -r0
    1298:	0007c302 	andeq	ip, r7, r2, lsl #6
    129c:	66090000 	strvs	r0, [r9], -r0
    12a0:	39000005 	stmdbcc	r0, {r0, r2}
    12a4:	0a000008 	beq	12cc <CPSR_IRQ_INHIBIT+0x124c>
    12a8:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    12ac:	441d0018 	ldrmi	r0, [sp], #-24
    12b0:	14000008 	strne	r0, [r0], #-8
    12b4:	00000428 	andeq	r0, r0, r8, lsr #8
    12b8:	39040f00 	stmdbcc	r4, {r8, r9, sl, fp}
    12bc:	0f000008 	svceq	0x00000008
    12c0:	00017b04 	andeq	r7, r1, r4, lsl #22
    12c4:	085b1d00 	ldmdaeq	fp, {r8, sl, fp, ip}^
    12c8:	30140000 	andscc	r0, r4, r0
    12cc:	00000000 	andeq	r0, r0, r0
    12d0:	0861040f 	stmdaeq	r1!, {r0, r1, r2, r3, sl}^
    12d4:	040f0000 	streq	r0, [pc], #-0	; 12dc <CPSR_IRQ_INHIBIT+0x125c>
    12d8:	00000850 	andeq	r0, r0, r0, asr r8
    12dc:	00060009 	andeq	r0, r6, r9
    12e0:	00087700 	andeq	r7, r8, r0, lsl #14
    12e4:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    12e8:	00020000 	andeq	r0, r2, r0
    12ec:	00069b19 	andeq	r9, r6, r9, lsl fp
    12f0:	d8012800 	stmdale	r1, {fp, sp}
    12f4:	00090702 	andeq	r0, r9, r2, lsl #14
    12f8:	057a1600 	ldrbeq	r1, [sl, #-1536]!	; 0x600
    12fc:	d9010000 	stmdble	r1, {}	; <UNPREDICTABLE>
    1300:	00003002 	andeq	r3, r0, r2
    1304:	dc160000 	ldcle	0, cr0, [r6], {-0}
    1308:	01000005 	tsteq	r0, r5
    130c:	003002da 	ldrsbteq	r0, [r0], -sl
    1310:	16040000 	strne	r0, [r4], -r0
    1314:	0000064f 	andeq	r0, r0, pc, asr #12
    1318:	3002db01 	andcc	sp, r2, r1, lsl #22
    131c:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    1320:	00056d16 	andeq	r6, r5, r6, lsl sp
    1324:	02dc0100 	sbcseq	r0, ip, #0, 2
    1328:	00000030 	andeq	r0, r0, r0, lsr r0
    132c:	0772160c 	ldrbeq	r1, [r2, -ip, lsl #12]!
    1330:	dd010000 	stcle	0, cr0, [r1, #-0]
    1334:	00003002 	andeq	r3, r0, r2
    1338:	7b161000 	blvc	585340 <_stack+0x505340>
    133c:	01000006 	tsteq	r0, r6
    1340:	003002de 	ldrsbteq	r0, [r0], -lr
    1344:	16140000 	ldrne	r0, [r4], -r0
    1348:	0000064e 	andeq	r0, r0, lr, asr #12
    134c:	3002df01 	andcc	sp, r2, r1, lsl #30
    1350:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1354:	00060b16 	andeq	r0, r6, r6, lsl fp
    1358:	02e00100 	rsceq	r0, r0, #0, 2
    135c:	00000030 	andeq	r0, r0, r0, lsr r0
    1360:	05db161c 	ldrbeq	r1, [fp, #1564]	; 0x61c
    1364:	e1010000 	mrs	r0, (UNDEF: 1)
    1368:	00003002 	andeq	r3, r0, r2
    136c:	4b162000 	blmi	589374 <_stack+0x509374>
    1370:	01000007 	tsteq	r0, r7
    1374:	003002e2 	eorseq	r0, r0, r2, ror #5
    1378:	00240000 	eoreq	r0, r4, r0
    137c:	00065619 	andeq	r5, r6, r9, lsl r6
    1380:	e9011000 	stmdb	r1, {ip}
    1384:	00094704 	andeq	r4, r9, r4, lsl #14
    1388:	05521600 	ldrbeq	r1, [r2, #-1536]	; 0x600
    138c:	eb010000 	bl	41394 <__bss_end__+0x2d34c>
    1390:	00003704 	andeq	r3, r0, r4, lsl #14
    1394:	19160000 	ldmdbne	r6, {}	; <UNPREDICTABLE>
    1398:	01000006 	tsteq	r0, r6
    139c:	003704ec 	eorseq	r0, r7, ip, ror #9
    13a0:	1e040000 	cdpne	0, 0, cr0, cr4, cr0, {0}
    13a4:	01006466 	tsteq	r0, r6, ror #8
    13a8:	094704ed 	stmdbeq	r7, {r0, r2, r3, r5, r6, r7, sl}^
    13ac:	1e080000 	cdpne	0, 0, cr0, cr8, cr0, {0}
    13b0:	01006b62 	tsteq	r0, r2, ror #22
    13b4:	094704ee 	stmdbeq	r7, {r1, r2, r3, r5, r6, r7, sl}^
    13b8:	000c0000 	andeq	r0, ip, r0
    13bc:	0907040f 	stmdbeq	r7, {r0, r1, r2, r3, sl}
    13c0:	34060000 	strcc	r0, [r6], #-0
    13c4:	01000007 	tsteq	r0, r7
    13c8:	094704f1 	stmdbeq	r7, {r0, r4, r5, r6, r7, sl}^
    13cc:	ad060000 	stcge	0, cr0, [r6, #-0]
    13d0:	01000005 	tsteq	r0, r5
    13d4:	0947061d 	stmdbeq	r7, {r0, r2, r3, r4, r9, sl}^
    13d8:	c91f0000 	ldmdbgt	pc, {}	; <UNPREDICTABLE>
    13dc:	01000005 	tsteq	r0, r5
    13e0:	0e010859 	mcreq	8, 0, r0, cr1, cr9, {2}
    13e4:	2000000a 	andcs	r0, r0, sl
    13e8:	000006c3 	andeq	r0, r0, r3, asr #13
    13ec:	28085901 	stmdacs	r8, {r0, r8, fp, ip, lr}
    13f0:	21000004 	tstcs	r0, r4
    13f4:	0100626e 	tsteq	r0, lr, ror #4
    13f8:	00370859 	eorseq	r0, r7, r9, asr r8
    13fc:	62220000 	eorvs	r0, r2, #0
    1400:	01006b72 	tsteq	r0, r2, ror fp
    1404:	0560085e 	strbeq	r0, [r0, #-2142]!	; 0x85e
    1408:	e4230000 	strt	r0, [r3], #-0
    140c:	01000005 	tsteq	r0, r5
    1410:	0037085f 	eorseq	r0, r7, pc, asr r8
    1414:	67230000 	strvs	r0, [r3, -r0]!
    1418:	01000007 	tsteq	r0, r7
    141c:	00370860 	eorseq	r0, r7, r0, ror #16
    1420:	22230000 	eorcs	r0, r3, #0
    1424:	01000007 	tsteq	r0, r7
    1428:	00300861 	eorseq	r0, r0, r1, ror #16
    142c:	b5230000 	strlt	r0, [r3, #-0]!
    1430:	01000005 	tsteq	r0, r5
    1434:	05600862 	strbeq	r0, [r0, #-2146]!	; 0x862
    1438:	42230000 	eormi	r0, r3, #0
    143c:	01000007 	tsteq	r0, r7
    1440:	00370863 	eorseq	r0, r7, r3, ror #16
    1444:	ae230000 	cdpge	0, 2, cr0, cr3, cr0, {0}
    1448:	01000006 	tsteq	r0, r6
    144c:	094d0865 	stmdbeq	sp, {r0, r2, r5, r6, fp}^
    1450:	3e230000 	cdpcc	0, 2, cr0, cr3, cr0, {0}
    1454:	01000007 	tsteq	r0, r7
    1458:	00370866 	eorseq	r0, r7, r6, ror #16
    145c:	8f230000 	svchi	0x00230000
    1460:	01000005 	tsteq	r0, r5
    1464:	05600867 	strbeq	r0, [r0, #-2151]!	; 0x867
    1468:	14230000 	strtne	r0, [r3], #-0
    146c:	01000006 	tsteq	r0, r6
    1470:	0037086b 	eorseq	r0, r7, fp, ror #16
    1474:	83230000 	teqhi	r3, #0
    1478:	01000006 	tsteq	r0, r6
    147c:	006e086c 	rsbeq	r0, lr, ip, ror #16
    1480:	24000000 	strcs	r0, [r0], #-0
    1484:	0000042f 	andeq	r0, r0, pc, lsr #8
    1488:	49091401 	stmdbmi	r9, {r0, sl, ip}
    148c:	24000000 	strcs	r0, [r0], #-0
    1490:	6600009d 			; <UNDEFINED> instruction: 0x6600009d
    1494:	01000005 	tsteq	r0, r5
    1498:	000c9c9c 	muleq	ip, ip, ip
    149c:	06c32500 	strbeq	r2, [r3], r0, lsl #10
    14a0:	14010000 	strne	r0, [r1], #-0
    14a4:	00042809 	andeq	r2, r4, r9, lsl #16
    14a8:	00005800 	andeq	r5, r0, r0, lsl #16
    14ac:	03492500 	movteq	r2, #38144	; 0x9500
    14b0:	14010000 	strne	r0, [r1], #-0
    14b4:	00003709 	andeq	r3, r0, r9, lsl #14
    14b8:	0000e200 	andeq	lr, r0, r0, lsl #4
    14bc:	05732600 	ldrbeq	r2, [r3, #-1536]!	; 0x600
    14c0:	1f010000 	svcne	0x00010000
    14c4:	00094d09 	andeq	r4, r9, r9, lsl #26
    14c8:	00010300 	andeq	r0, r1, r0, lsl #6
    14cc:	05bd2600 	ldreq	r2, [sp, #1536]!	; 0x600
    14d0:	20010000 	andcs	r0, r1, r0
    14d4:	00003709 	andeq	r3, r0, r9, lsl #14
    14d8:	00021a00 	andeq	r1, r2, r0, lsl #20
    14dc:	64692700 	strbtvs	r2, [r9], #-1792	; 0x700
    14e0:	21010078 	tstcs	r1, r8, ror r0
    14e4:	00003009 	andeq	r3, r0, r9
    14e8:	00037d00 	andeq	r7, r3, r0, lsl #26
    14ec:	69622700 	stmdbvs	r2!, {r8, r9, sl, sp}^
    14f0:	2201006e 	andcs	r0, r1, #110	; 0x6e
    14f4:	00095909 	andeq	r5, r9, r9, lsl #18
    14f8:	0004ae00 	andeq	sl, r4, r0, lsl #28
    14fc:	06a42600 	strteq	r2, [r4], r0, lsl #12
    1500:	23010000 	movwcs	r0, #4096	; 0x1000
    1504:	00094d09 	andeq	r4, r9, r9, lsl #26
    1508:	00050e00 	andeq	r0, r5, r0, lsl #28
    150c:	05802600 	streq	r2, [r0, #1536]	; 0x600
    1510:	24010000 	strcs	r0, [r1], #-0
    1514:	00006709 	andeq	r6, r0, r9, lsl #14
    1518:	00057200 	andeq	r7, r5, r0, lsl #4
    151c:	061e2600 	ldreq	r2, [lr], -r0, lsl #12
    1520:	25010000 	strcs	r0, [r1, #-0]
    1524:	00003009 	andeq	r3, r0, r9
    1528:	0007ac00 	andeq	sl, r7, r0, lsl #24
    152c:	05972600 	ldreq	r2, [r7, #1536]	; 0x600
    1530:	26010000 	strcs	r0, [r1], -r0
    1534:	00006e09 	andeq	r6, r0, r9, lsl #28
    1538:	0007e800 	andeq	lr, r7, r0, lsl #16
    153c:	06452600 	strbeq	r2, [r5], -r0, lsl #12
    1540:	27010000 	strcs	r0, [r1, -r0]
    1544:	00003009 	andeq	r3, r0, r9
    1548:	00084800 	andeq	r4, r8, r0, lsl #16
    154c:	77662700 	strbvc	r2, [r6, -r0, lsl #14]!
    1550:	28010064 	stmdacs	r1, {r2, r5, r6}
    1554:	00094d09 	andeq	r4, r9, r9, lsl #26
    1558:	00088700 	andeq	r8, r8, r0, lsl #14
    155c:	63622700 	cmnvs	r2, #0, 14
    1560:	2901006b 	stmdbcs	r1, {r0, r1, r3, r5, r6}
    1564:	00094d09 	andeq	r4, r9, r9, lsl #26
    1568:	0008dc00 	andeq	sp, r8, r0, lsl #24
    156c:	00712700 	rsbseq	r2, r1, r0, lsl #14
    1570:	59092a01 	stmdbpl	r9, {r0, r9, fp, sp}
    1574:	3c000009 	stccc	0, cr0, [r0], {9}
    1578:	27000009 	strcs	r0, [r0, -r9]
    157c:	0100626e 	tsteq	r0, lr, ror #4
    1580:	0037092c 	eorseq	r0, r7, ip, lsr #18
    1584:	09b40000 	ldmibeq	r4!, {}	; <UNPREDICTABLE>
    1588:	65280000 	strvs	r0, [r8, #-0]!
    158c:	0e000009 	cdpeq	0, 0, cr0, cr0, cr9, {0}
    1590:	1800009f 	stmdane	r0, {r0, r1, r2, r3, r4, r7}
    1594:	01000000 	mrseq	r0, (UNDEF: 0)
    1598:	0be90a0f 	bleq	ffa43ddc <STACK_SVR+0xfba43ddc>
    159c:	7e290000 	cdpvc	0, 2, cr0, cr9, cr0, {0}
    15a0:	8f000009 	svchi	0x00000009
    15a4:	2900000b 	stmdbcs	r0, {r0, r1, r3}
    15a8:	00000972 	andeq	r0, r0, r2, ror r9
    15ac:	00000bc3 	andeq	r0, r0, r3, asr #23
    15b0:	0000182a 	andeq	r1, r0, sl, lsr #16
    15b4:	09892b00 	stmibeq	r9, {r8, r9, fp, sp}
    15b8:	0bf70000 	bleq	ffdc15c0 <STACK_SVR+0xfbdc15c0>
    15bc:	952b0000 	strls	r0, [fp, #-0]!
    15c0:	41000009 	tstmi	r0, r9
    15c4:	2b00000c 	blcs	15fc <CPSR_IRQ_INHIBIT+0x157c>
    15c8:	000009a1 	andeq	r0, r0, r1, lsr #19
    15cc:	00000c81 	andeq	r0, r0, r1, lsl #25
    15d0:	0009ad2b 	andeq	sl, r9, fp, lsr #26
    15d4:	000cca00 	andeq	ip, ip, r0, lsl #20
    15d8:	09b92b00 	ldmibeq	r9!, {r8, r9, fp, sp}
    15dc:	0d020000 	stceq	0, cr0, [r2, #-0]
    15e0:	c52b0000 	strgt	r0, [fp, #-0]!
    15e4:	15000009 	strne	r0, [r0, #-9]
    15e8:	2b00000d 	blcs	1624 <CPSR_IRQ_INHIBIT+0x15a4>
    15ec:	000009d1 	ldrdeq	r0, [r0], -r1
    15f0:	00000d48 	andeq	r0, r0, r8, asr #26
    15f4:	0009dd2b 	andeq	sp, r9, fp, lsr #26
    15f8:	000d7c00 	andeq	r7, sp, r0, lsl #24
    15fc:	09e92b00 	stmibeq	r9!, {r8, r9, fp, sp}^
    1600:	0dd60000 	ldcleq	0, cr0, [r6]
    1604:	f52b0000 			; <UNDEFINED> instruction: 0xf52b0000
    1608:	29000009 	stmdbcs	r0, {r0, r3}
    160c:	2b00000e 	blcs	164c <CPSR_IRQ_INHIBIT+0x15cc>
    1610:	00000a01 	andeq	r0, r0, r1, lsl #20
    1614:	00000e5f 	andeq	r0, r0, pc, asr lr
    1618:	009f4e2c 	addseq	r4, pc, ip, lsr #28
    161c:	000d2b00 	andeq	r2, sp, r0, lsl #22
    1620:	000bb700 	andeq	fp, fp, r0, lsl #14
    1624:	50012d00 	andpl	r2, r1, r0, lsl #26
    1628:	00007702 	andeq	r7, r0, r2, lsl #14
    162c:	009fc62c 	addseq	ip, pc, ip, lsr #12
    1630:	000d2b00 	andeq	r2, sp, r0, lsl #22
    1634:	000bd100 	andeq	sp, fp, r0, lsl #2
    1638:	51012d00 	tstpl	r1, r0, lsl #26
    163c:	2d007a02 	vstrcs	s14, [r0, #-8]
    1640:	77025001 	strvc	r5, [r2, -r1]
    1644:	5c2e0000 	stcpl	0, cr0, [lr], #-0
    1648:	450000a2 	strmi	r0, [r0, #-162]	; 0xa2
    164c:	2d00000d 	stccs	0, cr0, [r0, #-52]	; 0xffffffcc
    1650:	75025101 	strvc	r5, [r2, #-257]	; 0x101
    1654:	50012d08 	andpl	r2, r1, r8, lsl #26
    1658:	00007702 	andeq	r7, r0, r2, lsl #14
    165c:	542c0000 	strtpl	r0, [ip], #-0
    1660:	5c00009d 	stcpl	0, cr0, [r0], {157}	; 0x9d
    1664:	fd00000d 	stc2	0, cr0, [r0, #-52]	; 0xffffffcc
    1668:	2d00000b 	stccs	0, cr0, [r0, #-44]	; 0xffffffd4
    166c:	77025001 	strvc	r5, [r2, -r1]
    1670:	942c0000 	strtls	r0, [ip], #-0
    1674:	6e00009d 	mcrvs	0, 0, r0, cr0, cr13, {4}
    1678:	1100000d 	tstne	r0, sp
    167c:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    1680:	77025001 	strvc	r5, [r2, -r1]
    1684:	b62c0000 	strtlt	r0, [ip], -r0
    1688:	6e00009e 	mcrvs	0, 0, r0, cr0, cr14, {4}
    168c:	2600000d 	strcs	r0, [r0], -sp
    1690:	2d00000c 	stccs	0, cr0, [r0, #-48]	; 0xffffffd0
    1694:	f3035001 	vhadd.u8	d5, d3, d1
    1698:	2c005001 	stccs	0, cr5, [r0], {1}
    169c:	00009ef0 	strdeq	r9, [r0], -r0
    16a0:	00000d6e 	andeq	r0, r0, lr, ror #26
    16a4:	00000c3a 	andeq	r0, r0, sl, lsr ip
    16a8:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    16ac:	2c000077 	stccs	0, cr0, [r0], {119}	; 0x77
    16b0:	0000a068 	andeq	sl, r0, r8, rrx
    16b4:	00000d6e 	andeq	r0, r0, lr, ror #26
    16b8:	00000c4e 	andeq	r0, r0, lr, asr #24
    16bc:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    16c0:	2c000077 	stccs	0, cr0, [r0], {119}	; 0x77
    16c4:	0000a082 	andeq	sl, r0, r2, lsl #1
    16c8:	00000d6e 	andeq	r0, r0, lr, ror #26
    16cc:	00000c62 	andeq	r0, r0, r2, ror #24
    16d0:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    16d4:	2c000077 	stccs	0, cr0, [r0], {119}	; 0x77
    16d8:	0000a0a6 	andeq	sl, r0, r6, lsr #1
    16dc:	00000d6e 	andeq	r0, r0, lr, ror #26
    16e0:	00000c76 	andeq	r0, r0, r6, ror ip
    16e4:	0250012d 	subseq	r0, r0, #1073741835	; 0x4000000b
    16e8:	2c000077 	stccs	0, cr0, [r0], {119}	; 0x77
    16ec:	0000a14a 	andeq	sl, r0, sl, asr #2
    16f0:	00000d6e 	andeq	r0, r0, lr, ror #26
    16f4:	00000c8b 	andeq	r0, r0, fp, lsl #25
    16f8:	0350012d 	cmpeq	r0, #1073741835	; 0x4000000b
    16fc:	005001f3 	ldrsheq	r0, [r0], #-19	; 0xffffffed
    1700:	00a18c2e 	adceq	r8, r1, lr, lsr #24
    1704:	000d6e00 	andeq	r6, sp, r0, lsl #28
    1708:	50012d00 	andpl	r2, r1, r0, lsl #26
    170c:	00007702 	andeq	r7, r0, r2, lsl #14
    1710:	09590900 	ldmdbeq	r9, {r8, fp}^
    1714:	0cad0000 	stceq	0, cr0, [sp]
    1718:	df2f0000 	svcle	0x002f0000
    171c:	01000000 	mrseq	r0, (UNDEF: 0)
    1720:	b6300001 	ldrtlt	r0, [r0], -r1
    1724:	01000006 	tsteq	r0, r6
    1728:	0c9c063d 	ldceq	6, cr0, [ip], {61}	; 0x3d
    172c:	03050000 	movweq	r0, #20480	; 0x5000
    1730:	0000ace0 	andeq	sl, r0, r0, ror #25
    1734:	00066330 	andeq	r6, r6, r0, lsr r3
    1738:	06a80100 	strteq	r0, [r8], r0, lsl #2
    173c:	0000006e 	andeq	r0, r0, lr, rrx
    1740:	b0e80305 	rsclt	r0, r8, r5, lsl #6
    1744:	5c300000 	ldcpl	0, cr0, [r0], #-0
    1748:	01000005 	tsteq	r0, r5
    174c:	006e06a9 	rsbeq	r0, lr, r9, lsr #13
    1750:	03050000 	movweq	r0, #20480	; 0x5000
    1754:	00014018 	andeq	r4, r1, r8, lsl r0
    1758:	00075430 	andeq	r5, r7, r0, lsr r4
    175c:	06b00100 	ldrteq	r0, [r0], r0, lsl #2
    1760:	00000560 	andeq	r0, r0, r0, ror #10
    1764:	b0ec0305 	rsclt	r0, ip, r5, lsl #6
    1768:	cd300000 	ldcgt	0, cr0, [r0, #-0]
    176c:	01000006 	tsteq	r0, r6
    1770:	006e06b3 	strhteq	r0, [lr], #-99	; 0xffffff9d
    1774:	03050000 	movweq	r0, #20480	; 0x5000
    1778:	00014014 	andeq	r4, r1, r4, lsl r0
    177c:	00062e30 	andeq	r2, r6, r0, lsr lr
    1780:	06b60100 	ldrteq	r0, [r6], r0, lsl #2
    1784:	0000006e 	andeq	r0, r0, lr, rrx
    1788:	40100305 	andsmi	r0, r0, r5, lsl #6
    178c:	8a300001 	bhi	c01798 <_stack+0xb81798>
    1790:	01000006 	tsteq	r0, r6
    1794:	087706b9 	ldmdaeq	r7!, {r0, r3, r4, r5, r7, r9, sl}^
    1798:	03050000 	movweq	r0, #20480	; 0x5000
    179c:	0001401c 	andeq	r4, r1, ip, lsl r0
    17a0:	00071a31 	andeq	r1, r7, r1, lsr sl
    17a4:	499a0600 	ldmibmi	sl, {r9, sl}
    17a8:	45000000 	strmi	r0, [r0, #-0]
    17ac:	1400000d 	strne	r0, [r0], #-13
    17b0:	00000428 	andeq	r0, r0, r8, lsr #8
    17b4:	00002514 	andeq	r2, r0, r4, lsl r5
    17b8:	95320000 	ldrls	r0, [r2, #-0]!
    17bc:	01000003 	tsteq	r0, r3
    17c0:	0d5c0419 	cfldrdeq	mvd0, [ip, #-100]	; 0xffffff9c
    17c4:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
    17c8:	14000004 	strne	r0, [r0], #-4
    17cc:	00000049 	andeq	r0, r0, r9, asr #32
    17d0:	05f33200 	ldrbeq	r3, [r3, #512]!	; 0x200
    17d4:	48010000 	stmdami	r1, {}	; <UNPREDICTABLE>
    17d8:	000d6e01 	andeq	r6, sp, r1, lsl #28
    17dc:	04281400 	strteq	r1, [r8], #-1024	; 0x400
    17e0:	33000000 	movwcc	r0, #0
    17e4:	0000059d 	muleq	r0, sp, r5
    17e8:	14014901 	strne	r4, [r1], #-2305	; 0x901
    17ec:	00000428 	andeq	r0, r0, r8, lsr #8
    17f0:	012d0000 	teqeq	sp, r0
    17f4:	00040000 	andeq	r0, r4, r0
    17f8:	000004c4 	andeq	r0, r0, r4, asr #9
    17fc:	01410104 	cmpeq	r1, r4, lsl #2
    1800:	8f010000 	svchi	0x00010000
    1804:	d0000007 	andle	r0, r0, r7
    1808:	50000007 	andpl	r0, r0, r7
    180c:	00000000 	andeq	r0, r0, r0
    1810:	82000000 	andhi	r0, r0, #0
    1814:	02000005 	andeq	r0, r0, #5
    1818:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    181c:	0c030074 	stceq	0, cr0, [r3], {116}	; 0x74
    1820:	02000000 	andeq	r0, r0, #0
    1824:	000037d4 	ldrdeq	r3, [r0], -r4
    1828:	07040400 	streq	r0, [r4, -r0, lsl #8]
    182c:	00000055 	andeq	r0, r0, r5, asr r0
    1830:	9f060104 	svcls	0x00060104
    1834:	04000003 	streq	r0, [r0], #-3
    1838:	039d0801 	orrseq	r0, sp, #65536	; 0x10000
    183c:	02040000 	andeq	r0, r4, #0
    1840:	0003b905 	andeq	fp, r3, r5, lsl #18
    1844:	07020400 	streq	r0, [r2, -r0, lsl #8]
    1848:	000002a8 	andeq	r0, r0, r8, lsr #5
    184c:	9b050404 	blls	142864 <_stack+0xc2864>
    1850:	04000000 	streq	r0, [r0], #-0
    1854:	00500704 	subseq	r0, r0, r4, lsl #14
    1858:	08040000 	stmdaeq	r4, {}	; <UNPREDICTABLE>
    185c:	00009605 	andeq	r9, r0, r5, lsl #12
    1860:	07080400 	streq	r0, [r8, -r0, lsl #8]
    1864:	0000004b 	andeq	r0, r0, fp, asr #32
    1868:	0b070404 	bleq	1c2880 <_stack+0x142880>
    186c:	05000003 	streq	r0, [r0, #-3]
    1870:	85040604 	strhi	r0, [r4, #-1540]	; 0x604
    1874:	04000000 	streq	r0, [r0], #-0
    1878:	03a60801 			; <UNDEFINED> instruction: 0x03a60801
    187c:	04060000 	streq	r0, [r6], #-0
    1880:	00000092 	muleq	r0, r2, r0
    1884:	00008507 	andeq	r8, r0, r7, lsl #10
    1888:	08360800 	ldmdaeq	r6!, {fp}
    188c:	17030000 	strne	r0, [r3, -r0]
    1890:	0000007d 	andeq	r0, r0, sp, ror r0
    1894:	0000a28c 	andeq	sl, r0, ip, lsl #5
    1898:	000000a6 	andeq	r0, r0, r6, lsr #1
    189c:	01189c01 	tsteq	r8, r1, lsl #24
    18a0:	8a090000 	bhi	2418a8 <_stack+0x1c18a8>
    18a4:	01000007 	tsteq	r0, r7
    18a8:	00007d36 	andeq	r7, r0, r6, lsr sp
    18ac:	0a500100 	beq	1401cb4 <_stack+0x1381cb4>
    18b0:	00000785 	andeq	r0, r0, r5, lsl #15
    18b4:	01183601 	tsteq	r8, r1, lsl #12
    18b8:	0e9f0000 	cdpeq	0, 9, cr0, cr15, cr0, {0}
    18bc:	3d0a0000 	stccc	0, cr0, [sl, #-0]
    18c0:	01000008 	tsteq	r0, r8
    18c4:	00002c36 	andeq	r2, r0, r6, lsr ip
    18c8:	000ed900 	andeq	sp, lr, r0, lsl #18
    18cc:	73640b00 	cmnvc	r4, #0, 22
    18d0:	48010074 	stmdami	r1, {r2, r4, r5, r6}
    18d4:	0000007f 	andeq	r0, r0, pc, ror r0
    18d8:	00000f55 	andeq	r0, r0, r5, asr pc
    18dc:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    18e0:	8c490100 	stfhie	f0, [r9], {-0}
    18e4:	9f000000 	svcls	0x00000000
    18e8:	0c00000f 	stceq	0, cr0, [r0], {15}
    18ec:	00000779 	andeq	r0, r0, r9, ror r7
    18f0:	011f4a01 	tsteq	pc, r1, lsl #20
    18f4:	0ffc0000 	svceq	0x00fc0000
    18f8:	2a0c0000 	bcs	301900 <_stack+0x281900>
    18fc:	01000008 	tsteq	r0, r8
    1900:	0001254b 	andeq	r2, r1, fp, asr #10
    1904:	00102500 	andseq	r2, r0, r0, lsl #10
    1908:	04060000 	streq	r0, [r6], #-0
    190c:	0000011e 	andeq	r0, r0, lr, lsl r1
    1910:	5a04060d 	bpl	10314c <_stack+0x8314c>
    1914:	06000000 	streq	r0, [r0], -r0
    1918:	00012b04 	andeq	r2, r1, r4, lsl #22
    191c:	005a0700 	subseq	r0, sl, r0, lsl #14
    1920:	13000000 	movwne	r0, #0
    1924:	04000001 	streq	r0, [r0], #-1
    1928:	00056f00 	andeq	r6, r5, r0, lsl #30
    192c:	41010400 	tstmi	r1, r0, lsl #8
    1930:	01000001 	tsteq	r0, r1
    1934:	000008a4 	andeq	r0, r0, r4, lsr #17
    1938:	00000842 	andeq	r0, r0, r2, asr #16
    193c:	00000060 	andeq	r0, r0, r0, rrx
    1940:	00000000 	andeq	r0, r0, r0
    1944:	000006a5 	andeq	r0, r0, r5, lsr #13
    1948:	69050402 	stmdbvs	r5, {r1, sl}
    194c:	0300746e 	movweq	r7, #1134	; 0x46e
    1950:	0000000c 	andeq	r0, r0, ip
    1954:	0037d402 	eorseq	sp, r7, r2, lsl #8
    1958:	04040000 	streq	r0, [r4], #-0
    195c:	00005507 	andeq	r5, r0, r7, lsl #10
    1960:	06010400 	streq	r0, [r1], -r0, lsl #8
    1964:	0000039f 	muleq	r0, pc, r3	; <UNPREDICTABLE>
    1968:	9d080104 	stflss	f0, [r8, #-16]
    196c:	04000003 	streq	r0, [r0], #-3
    1970:	03b90502 			; <UNDEFINED> instruction: 0x03b90502
    1974:	02040000 	andeq	r0, r4, #0
    1978:	0002a807 	andeq	sl, r2, r7, lsl #16
    197c:	05040400 	streq	r0, [r4, #-1024]	; 0x400
    1980:	0000009b 	muleq	r0, fp, r0
    1984:	50070404 	andpl	r0, r7, r4, lsl #8
    1988:	04000000 	streq	r0, [r0], #-0
    198c:	00960508 	addseq	r0, r6, r8, lsl #10
    1990:	08040000 	stmdaeq	r4, {}	; <UNPREDICTABLE>
    1994:	00004b07 	andeq	r4, r0, r7, lsl #22
    1998:	07040400 	streq	r0, [r4, -r0, lsl #8]
    199c:	0000030b 	andeq	r0, r0, fp, lsl #6
    19a0:	04060405 	streq	r0, [r6], #-1029	; 0x405
    19a4:	00000085 	andeq	r0, r0, r5, lsl #1
    19a8:	a6080104 	strge	r0, [r8], -r4, lsl #2
    19ac:	07000003 	streq	r0, [r0, -r3]
    19b0:	000008d8 	ldrdeq	r0, [r0], -r8
    19b4:	007d1903 	rsbseq	r1, sp, r3, lsl #18
    19b8:	a3340000 	teqge	r4, #0
    19bc:	009e0000 	addseq	r0, lr, r0
    19c0:	9c010000 	stcls	0, cr0, [r1], {-0}
    19c4:	00000110 	andeq	r0, r0, r0, lsl r1
    19c8:	01006d08 	tsteq	r0, r8, lsl #26
    19cc:	00007d2d 	andeq	r7, r0, sp, lsr #26
    19d0:	09500100 	ldmdbeq	r0, {r8}^
    19d4:	2d010063 	stccs	0, cr0, [r1, #-396]	; 0xfffffe74
    19d8:	00000025 	andeq	r0, r0, r5, lsr #32
    19dc:	0000109a 	muleq	r0, sl, r0
    19e0:	01006e09 	tsteq	r0, r9, lsl #28
    19e4:	00002c2d 	andeq	r2, r0, sp, lsr #24
    19e8:	0010c600 	andseq	ip, r0, r0, lsl #12
    19ec:	00730a00 	rsbseq	r0, r3, r0, lsl #20
    19f0:	007f3201 	rsbseq	r3, pc, r1, lsl #4
    19f4:	11330000 	teqne	r3, r0
    19f8:	690a0000 	stmdbvs	sl, {}	; <UNPREDICTABLE>
    19fc:	25350100 	ldrcs	r0, [r5, #-256]!	; 0x100
    1a00:	67000000 	strvs	r0, [r0, -r0]
    1a04:	0b000011 	bleq	1a50 <CPSR_IRQ_INHIBIT+0x19d0>
    1a08:	000008df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1a0c:	00613601 	rsbeq	r3, r1, r1, lsl #12
    1a10:	117c0000 	cmnne	ip, r0
    1a14:	970b0000 	strls	r0, [fp, -r0]
    1a18:	01000008 	tsteq	r0, r8
    1a1c:	00011037 	andeq	r1, r1, r7, lsr r0
    1a20:	00118f00 	andseq	r8, r1, r0, lsl #30
    1a24:	00640a00 	rsbeq	r0, r4, r0, lsl #20
    1a28:	00373801 	eorseq	r3, r7, r1, lsl #16
    1a2c:	11ec0000 	mvnne	r0, r0
    1a30:	06000000 	streq	r0, [r0], -r0
    1a34:	00006104 	andeq	r6, r0, r4, lsl #2
    1a38:	08b00000 	ldmeq	r0!, {}	; <UNPREDICTABLE>
    1a3c:	00040000 	andeq	r0, r4, r0
    1a40:	0000060e 	andeq	r0, r0, lr, lsl #12
    1a44:	01410104 	cmpeq	r1, r4, lsl #2
    1a48:	fb010000 	blx	41a52 <__bss_end__+0x2da0a>
    1a4c:	4c000008 	stcmi	0, cr0, [r0], {8}
    1a50:	70000002 	andvc	r0, r0, r2
    1a54:	00000000 	andeq	r0, r0, r0
    1a58:	b3000000 	movwlt	r0, #0
    1a5c:	02000007 	andeq	r0, r0, #7
    1a60:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1a64:	04030074 	streq	r0, [r3], #-116	; 0x74
    1a68:	00005507 	andeq	r5, r0, r7, lsl #10
    1a6c:	06010300 	streq	r0, [r1], -r0, lsl #6
    1a70:	0000039f 	muleq	r0, pc, r3	; <UNPREDICTABLE>
    1a74:	9d080103 	stflss	f0, [r8, #-12]
    1a78:	03000003 	movweq	r0, #3
    1a7c:	03b90502 			; <UNDEFINED> instruction: 0x03b90502
    1a80:	02030000 	andeq	r0, r3, #0
    1a84:	0002a807 	andeq	sl, r2, r7, lsl #16
    1a88:	05040300 	streq	r0, [r4, #-768]	; 0x300
    1a8c:	0000009b 	muleq	r0, fp, r0
    1a90:	50070403 	andpl	r0, r7, r3, lsl #8
    1a94:	03000000 	movweq	r0, #0
    1a98:	00960508 	addseq	r0, r6, r8, lsl #10
    1a9c:	08030000 	stmdaeq	r3, {}	; <UNPREDICTABLE>
    1aa0:	00004b07 	andeq	r4, r0, r7, lsl #22
    1aa4:	034f0400 	movteq	r0, #62464	; 0xf400
    1aa8:	07020000 	streq	r0, [r2, -r0]
    1aac:	00000025 	andeq	r0, r0, r5, lsr #32
    1ab0:	00033704 	andeq	r3, r3, r4, lsl #14
    1ab4:	4f100300 	svcmi	0x00100300
    1ab8:	04000000 	streq	r0, [r0], #-0
    1abc:	00000467 	andeq	r0, r0, r7, ror #8
    1ac0:	004f2703 	subeq	r2, pc, r3, lsl #14
    1ac4:	eb050000 	bl	141acc <_stack+0xc1acc>
    1ac8:	04000002 	streq	r0, [r0], #-2
    1acc:	002c0161 	eoreq	r0, ip, r1, ror #2
    1ad0:	04060000 	streq	r0, [r6], #-0
    1ad4:	00b74a03 	adcseq	r4, r7, r3, lsl #20
    1ad8:	e5070000 	str	r0, [r7, #-0]
    1adc:	03000002 	movweq	r0, #2
    1ae0:	00008c4c 	andeq	r8, r0, ip, asr #24
    1ae4:	022f0700 	eoreq	r0, pc, #0, 14
    1ae8:	4d030000 	stcmi	0, cr0, [r3, #-0]
    1aec:	000000b7 	strheq	r0, [r0], -r7
    1af0:	003a0800 	eorseq	r0, sl, r0, lsl #16
    1af4:	00c70000 	sbceq	r0, r7, r0
    1af8:	c7090000 	strgt	r0, [r9, -r0]
    1afc:	03000000 	movweq	r0, #0
    1b00:	07040300 	streq	r0, [r4, -r0, lsl #6]
    1b04:	0000030b 	andeq	r0, r0, fp, lsl #6
    1b08:	4703080a 	strmi	r0, [r3, -sl, lsl #16]
    1b0c:	000000ef 	andeq	r0, r0, pc, ror #1
    1b10:	0004510b 	andeq	r5, r4, fp, lsl #2
    1b14:	25490300 	strbcs	r0, [r9, #-768]	; 0x300
    1b18:	00000000 	andeq	r0, r0, r0
    1b1c:	0004590b 	andeq	r5, r4, fp, lsl #18
    1b20:	984e0300 	stmdals	lr, {r8, r9}^
    1b24:	04000000 	streq	r0, [r0], #-0
    1b28:	03e10400 	mvneq	r0, #0, 8
    1b2c:	4f030000 	svcmi	0x00030000
    1b30:	000000ce 	andeq	r0, r0, lr, asr #1
    1b34:	00013804 	andeq	r3, r1, r4, lsl #16
    1b38:	6b530300 	blvs	14c2740 <_stack+0x1442740>
    1b3c:	0c000000 	stceq	0, cr0, [r0], {-0}
    1b40:	04a10404 	strteq	r0, [r1], #1028	; 0x404
    1b44:	16050000 	strne	r0, [r5], -r0
    1b48:	00000056 	andeq	r0, r0, r6, asr r0
    1b4c:	0002030d 	andeq	r0, r2, sp, lsl #6
    1b50:	2d051800 	stccs	8, cr1, [r5, #-0]
    1b54:	00000165 	andeq	r0, r0, r5, ror #2
    1b58:	0004020b 	andeq	r0, r4, fp, lsl #4
    1b5c:	652f0500 	strvs	r0, [pc, #-1280]!	; 1664 <CPSR_IRQ_INHIBIT+0x15e4>
    1b60:	00000001 	andeq	r0, r0, r1
    1b64:	006b5f0e 	rsbeq	r5, fp, lr, lsl #30
    1b68:	00253005 	eoreq	r3, r5, r5
    1b6c:	0b040000 	bleq	101b74 <_stack+0x81b74>
    1b70:	00000443 	andeq	r0, r0, r3, asr #8
    1b74:	00253005 	eoreq	r3, r5, r5
    1b78:	0b080000 	bleq	201b80 <_stack+0x181b80>
    1b7c:	00000132 	andeq	r0, r0, r2, lsr r1
    1b80:	00253005 	eoreq	r3, r5, r5
    1b84:	0b0c0000 	bleq	301b8c <_stack+0x281b8c>
    1b88:	000004d5 	ldrdeq	r0, [r0], -r5
    1b8c:	00253005 	eoreq	r3, r5, r5
    1b90:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
    1b94:	0500785f 	streq	r7, [r0, #-2143]	; 0x85f
    1b98:	00016b31 	andeq	r6, r1, r1, lsr fp
    1b9c:	0f001400 	svceq	0x00001400
    1ba0:	00011204 	andeq	r1, r1, r4, lsl #4
    1ba4:	01070800 	tsteq	r7, r0, lsl #16
    1ba8:	017b0000 	cmneq	fp, r0
    1bac:	c7090000 	strgt	r0, [r9, -r0]
    1bb0:	00000000 	andeq	r0, r0, r0
    1bb4:	022a0d00 	eoreq	r0, sl, #0, 26
    1bb8:	05240000 	streq	r0, [r4, #-0]!
    1bbc:	0001f435 	andeq	pc, r1, r5, lsr r4	; <UNPREDICTABLE>
    1bc0:	008d0b00 	addeq	r0, sp, r0, lsl #22
    1bc4:	37050000 	strcc	r0, [r5, -r0]
    1bc8:	00000025 	andeq	r0, r0, r5, lsr #32
    1bcc:	046f0b00 	strbteq	r0, [pc], #-2816	; 1bd4 <CPSR_IRQ_INHIBIT+0x1b54>
    1bd0:	38050000 	stmdacc	r5, {}	; <UNPREDICTABLE>
    1bd4:	00000025 	andeq	r0, r0, r5, lsr #32
    1bd8:	00aa0b04 	adceq	r0, sl, r4, lsl #22
    1bdc:	39050000 	stmdbcc	r5, {}	; <UNPREDICTABLE>
    1be0:	00000025 	andeq	r0, r0, r5, lsr #32
    1be4:	05480b08 	strbeq	r0, [r8, #-2824]	; 0xb08
    1be8:	3a050000 	bcc	141bf0 <_stack+0xc1bf0>
    1bec:	00000025 	andeq	r0, r0, r5, lsr #32
    1bf0:	031b0b0c 	tsteq	fp, #12, 22	; 0x3000
    1bf4:	3b050000 	blcc	141bfc <_stack+0xc1bfc>
    1bf8:	00000025 	andeq	r0, r0, r5, lsr #32
    1bfc:	03010b10 	movweq	r0, #6928	; 0x1b10
    1c00:	3c050000 	stccc	0, cr0, [r5], {-0}
    1c04:	00000025 	andeq	r0, r0, r5, lsr #32
    1c08:	04da0b14 	ldrbeq	r0, [sl], #2836	; 0xb14
    1c0c:	3d050000 	stccc	0, cr0, [r5, #-0]
    1c10:	00000025 	andeq	r0, r0, r5, lsr #32
    1c14:	03c30b18 	biceq	r0, r3, #24, 22	; 0x6000
    1c18:	3e050000 	cdpcc	0, 0, cr0, cr5, cr0, {0}
    1c1c:	00000025 	andeq	r0, r0, r5, lsr #32
    1c20:	050f0b1c 	streq	r0, [pc, #-2844]	; 110c <CPSR_IRQ_INHIBIT+0x108c>
    1c24:	3f050000 	svccc	0x00050000
    1c28:	00000025 	andeq	r0, r0, r5, lsr #32
    1c2c:	b9100020 	ldmdblt	r0, {r5}
    1c30:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    1c34:	34480501 	strbcc	r0, [r8], #-1281	; 0x501
    1c38:	0b000002 	bleq	1c48 <CPSR_IRQ_INHIBIT+0x1bc8>
    1c3c:	00000125 	andeq	r0, r0, r5, lsr #2
    1c40:	02344905 	eorseq	r4, r4, #81920	; 0x14000
    1c44:	0b000000 	bleq	1c4c <CPSR_IRQ_INHIBIT+0x1bcc>
    1c48:	00000000 	andeq	r0, r0, r0
    1c4c:	02344a05 	eorseq	r4, r4, #20480	; 0x5000
    1c50:	11800000 	orrne	r0, r0, r0
    1c54:	00000493 	muleq	r0, r3, r4
    1c58:	01074c05 	tsteq	r7, r5, lsl #24
    1c5c:	01000000 	mrseq	r0, (UNDEF: 0)
    1c60:	0000de11 	andeq	sp, r0, r1, lsl lr
    1c64:	074f0500 	strbeq	r0, [pc, -r0, lsl #10]
    1c68:	04000001 	streq	r0, [r0], #-1
    1c6c:	05080001 	streq	r0, [r8, #-1]
    1c70:	44000001 	strmi	r0, [r0], #-1
    1c74:	09000002 	stmdbeq	r0, {r1}
    1c78:	000000c7 	andeq	r0, r0, r7, asr #1
    1c7c:	2410001f 	ldrcs	r0, [r0], #-31
    1c80:	90000003 	andls	r0, r0, r3
    1c84:	825b0501 	subshi	r0, fp, #4194304	; 0x400000
    1c88:	0b000002 	bleq	1c98 <CPSR_IRQ_INHIBIT+0x1c18>
    1c8c:	00000402 	andeq	r0, r0, r2, lsl #8
    1c90:	02825c05 	addeq	r5, r2, #1280	; 0x500
    1c94:	0b000000 	bleq	1c9c <CPSR_IRQ_INHIBIT+0x1c1c>
    1c98:	0000041a 	andeq	r0, r0, sl, lsl r4
    1c9c:	00255d05 	eoreq	r5, r5, r5, lsl #26
    1ca0:	0b040000 	bleq	101ca8 <_stack+0x81ca8>
    1ca4:	0000012d 	andeq	r0, r0, sp, lsr #2
    1ca8:	02885f05 	addeq	r5, r8, #5, 30
    1cac:	0b080000 	bleq	201cb4 <_stack+0x181cb4>
    1cb0:	000000b9 	strheq	r0, [r0], -r9
    1cb4:	01f46005 	mvnseq	r6, r5
    1cb8:	00880000 	addeq	r0, r8, r0
    1cbc:	0244040f 	subeq	r0, r4, #251658240	; 0xf000000
    1cc0:	98080000 	stmdals	r8, {}	; <UNPREDICTABLE>
    1cc4:	98000002 	stmdals	r0, {r1}
    1cc8:	09000002 	stmdbeq	r0, {r1}
    1ccc:	000000c7 	andeq	r0, r0, r7, asr #1
    1cd0:	040f001f 	streq	r0, [pc], #-31	; 1cd8 <CPSR_IRQ_INHIBIT+0x1c58>
    1cd4:	0000029e 	muleq	r0, lr, r2
    1cd8:	03cd0d12 	biceq	r0, sp, #1152	; 0x480
    1cdc:	05080000 	streq	r0, [r8, #-0]
    1ce0:	0002c473 	andeq	ip, r2, r3, ror r4
    1ce4:	07610b00 	strbeq	r0, [r1, -r0, lsl #22]!
    1ce8:	74050000 	strvc	r0, [r5], #-0
    1cec:	000002c4 	andeq	r0, r0, r4, asr #5
    1cf0:	06180b00 	ldreq	r0, [r8], -r0, lsl #22
    1cf4:	75050000 	strvc	r0, [r5, #-0]
    1cf8:	00000025 	andeq	r0, r0, r5, lsr #32
    1cfc:	040f0004 	streq	r0, [pc], #-4	; 1d04 <CPSR_IRQ_INHIBIT+0x1c84>
    1d00:	0000003a 	andeq	r0, r0, sl, lsr r0
    1d04:	0003ec0d 	andeq	lr, r3, sp, lsl #24
    1d08:	b3056800 	movwlt	r6, #22528	; 0x5800
    1d0c:	000003f4 	strdeq	r0, [r0], -r4
    1d10:	00705f0e 	rsbseq	r5, r0, lr, lsl #30
    1d14:	02c4b405 	sbceq	fp, r4, #83886080	; 0x5000000
    1d18:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1d1c:	0500725f 	streq	r7, [r0, #-607]	; 0x25f
    1d20:	000025b5 			; <UNDEFINED> instruction: 0x000025b5
    1d24:	5f0e0400 	svcpl	0x000e0400
    1d28:	b6050077 			; <UNDEFINED> instruction: 0xb6050077
    1d2c:	00000025 	andeq	r0, r0, r5, lsr #32
    1d30:	00d70b08 	sbcseq	r0, r7, r8, lsl #22
    1d34:	b7050000 	strlt	r0, [r5, -r0]
    1d38:	00000041 	andeq	r0, r0, r1, asr #32
    1d3c:	02460b0c 	subeq	r0, r6, #12, 22	; 0x3000
    1d40:	b8050000 	stmdalt	r5, {}	; <UNPREDICTABLE>
    1d44:	00000041 	andeq	r0, r0, r1, asr #32
    1d48:	625f0e0e 	subsvs	r0, pc, #14, 28	; 0xe0
    1d4c:	b9050066 	stmdblt	r5, {r1, r2, r5, r6}
    1d50:	0000029f 	muleq	r0, pc, r2	; <UNPREDICTABLE>
    1d54:	00620b10 	rsbeq	r0, r2, r0, lsl fp
    1d58:	ba050000 	blt	141d60 <_stack+0xc1d60>
    1d5c:	00000025 	andeq	r0, r0, r5, lsr #32
    1d60:	00c70b18 	sbceq	r0, r7, r8, lsl fp
    1d64:	c1050000 	mrsgt	r0, (UNDEF: 5)
    1d68:	00000105 	andeq	r0, r0, r5, lsl #2
    1d6c:	021a0b1c 	andseq	r0, sl, #28, 22	; 0x7000
    1d70:	c3050000 	movwgt	r0, #20480	; 0x5000
    1d74:	00000557 	andeq	r0, r0, r7, asr r5
    1d78:	02fa0b20 	rscseq	r0, sl, #32, 22	; 0x8000
    1d7c:	c5050000 	strgt	r0, [r5, #-0]
    1d80:	00000586 	andeq	r0, r0, r6, lsl #11
    1d84:	04610b24 	strbteq	r0, [r1], #-2852	; 0xb24
    1d88:	c8050000 	stmdagt	r5, {}	; <UNPREDICTABLE>
    1d8c:	000005aa 	andeq	r0, r0, sl, lsr #11
    1d90:	05290b28 	streq	r0, [r9, #-2856]!	; 0xb28
    1d94:	c9050000 	stmdbgt	r5, {}	; <UNPREDICTABLE>
    1d98:	000005c4 	andeq	r0, r0, r4, asr #11
    1d9c:	755f0e2c 	ldrbvc	r0, [pc, #-3628]	; f78 <CPSR_IRQ_INHIBIT+0xef8>
    1da0:	cc050062 	stcgt	0, cr0, [r5], {98}	; 0x62
    1da4:	0000029f 	muleq	r0, pc, r2	; <UNPREDICTABLE>
    1da8:	755f0e30 	ldrbvc	r0, [pc, #-3632]	; f80 <CPSR_IRQ_INHIBIT+0xf00>
    1dac:	cd050070 	stcgt	0, cr0, [r5, #-448]	; 0xfffffe40
    1db0:	000002c4 	andeq	r0, r0, r4, asr #5
    1db4:	755f0e38 	ldrbvc	r0, [pc, #-3640]	; f84 <CPSR_IRQ_INHIBIT+0xf04>
    1db8:	ce050072 	mcrgt	0, 0, r0, cr5, cr2, {3}
    1dbc:	00000025 	andeq	r0, r0, r5, lsr #32
    1dc0:	00a40b3c 	adceq	r0, r4, ip, lsr fp
    1dc4:	d1050000 	mrsle	r0, (UNDEF: 5)
    1dc8:	000005ca 	andeq	r0, r0, sl, asr #11
    1dcc:	05010b40 	streq	r0, [r1, #-2880]	; 0xb40
    1dd0:	d2050000 	andle	r0, r5, #0
    1dd4:	000005da 	ldrdeq	r0, [r0], -sl
    1dd8:	6c5f0e43 	mrrcvs	14, 4, r0, pc, cr3	; <UNPREDICTABLE>
    1ddc:	d5050062 	strle	r0, [r5, #-98]	; 0x62
    1de0:	0000029f 	muleq	r0, pc, r2	; <UNPREDICTABLE>
    1de4:	00ed0b44 	rsceq	r0, sp, r4, asr #22
    1de8:	d8050000 	stmdale	r5, {}	; <UNPREDICTABLE>
    1dec:	00000025 	andeq	r0, r0, r5, lsr #32
    1df0:	00fe0b4c 	rscseq	r0, lr, ip, asr #22
    1df4:	d9050000 	stmdble	r5, {}	; <UNPREDICTABLE>
    1df8:	00000076 	andeq	r0, r0, r6, ror r0
    1dfc:	0a9a0b50 	beq	fe684b44 <STACK_SVR+0xfa684b44>
    1e00:	dc050000 	stcle	0, cr0, [r5], {-0}
    1e04:	00000412 	andeq	r0, r0, r2, lsl r4
    1e08:	05fb0b54 	ldrbeq	r0, [fp, #2900]!	; 0xb54
    1e0c:	e0050000 	and	r0, r5, r0
    1e10:	000000fa 	strdeq	r0, [r0], -sl
    1e14:	03f40b58 	mvnseq	r0, #88, 22	; 0x16000
    1e18:	e2050000 	and	r0, r5, #0
    1e1c:	000000ef 	andeq	r0, r0, pc, ror #1
    1e20:	02f20b5c 	rscseq	r0, r2, #92, 22	; 0x17000
    1e24:	e3050000 	movw	r0, #20480	; 0x5000
    1e28:	00000025 	andeq	r0, r0, r5, lsr #32
    1e2c:	25130064 	ldrcs	r0, [r3, #-100]	; 0x64
    1e30:	12000000 	andne	r0, r0, #0
    1e34:	14000004 	strne	r0, [r0], #-4
    1e38:	00000412 	andeq	r0, r0, r2, lsl r4
    1e3c:	00010514 	andeq	r0, r1, r4, lsl r5
    1e40:	054a1400 	strbeq	r1, [sl, #-1024]	; 0x400
    1e44:	25140000 	ldrcs	r0, [r4, #-0]
    1e48:	00000000 	andeq	r0, r0, r0
    1e4c:	0418040f 	ldreq	r0, [r8], #-1039	; 0x40f
    1e50:	d9150000 	ldmdble	r5, {}	; <UNPREDICTABLE>
    1e54:	28000009 	stmdacs	r0, {r0, r3}
    1e58:	02390504 	eorseq	r0, r9, #4, 10	; 0x1000000
    1e5c:	0000054a 	andeq	r0, r0, sl, asr #10
    1e60:	0003b216 	andeq	fp, r3, r6, lsl r2
    1e64:	023b0500 	eorseq	r0, fp, #0, 10
    1e68:	00000025 	andeq	r0, r0, r5, lsr #32
    1e6c:	00e61600 	rsceq	r1, r6, r0, lsl #12
    1e70:	40050000 	andmi	r0, r5, r0
    1e74:	00063102 	andeq	r3, r6, r2, lsl #2
    1e78:	36160400 	ldrcc	r0, [r6], -r0, lsl #8
    1e7c:	05000002 	streq	r0, [r0, #-2]
    1e80:	06310240 	ldrteq	r0, [r1], -r0, asr #4
    1e84:	16080000 	strne	r0, [r8], -r0
    1e88:	0000047e 	andeq	r0, r0, lr, ror r4
    1e8c:	31024005 	tstcc	r2, r5
    1e90:	0c000006 	stceq	0, cr0, [r0], {6}
    1e94:	00041516 	andeq	r1, r4, r6, lsl r5
    1e98:	02420500 	subeq	r0, r2, #0, 10
    1e9c:	00000025 	andeq	r0, r0, r5, lsr #32
    1ea0:	00201610 	eoreq	r1, r0, r0, lsl r6
    1ea4:	43050000 	movwmi	r0, #20480	; 0x5000
    1ea8:	00081302 	andeq	r1, r8, r2, lsl #6
    1eac:	b6161400 	ldrlt	r1, [r6], -r0, lsl #8
    1eb0:	05000004 	streq	r0, [r0, #-4]
    1eb4:	00250245 	eoreq	r0, r5, r5, asr #4
    1eb8:	16300000 	ldrtne	r0, [r0], -r0
    1ebc:	0000041f 	andeq	r0, r0, pc, lsl r4
    1ec0:	7b024605 	blvc	936dc <_stack+0x136dc>
    1ec4:	34000005 	strcc	r0, [r0], #-5
    1ec8:	00032c16 	andeq	r2, r3, r6, lsl ip
    1ecc:	02480500 	subeq	r0, r8, #0, 10
    1ed0:	00000025 	andeq	r0, r0, r5, lsr #32
    1ed4:	04391638 	ldrteq	r1, [r9], #-1592	; 0x638
    1ed8:	4a050000 	bmi	141ee0 <_stack+0xc1ee0>
    1edc:	00082e02 	andeq	r2, r8, r2, lsl #28
    1ee0:	dd163c00 	ldcle	12, cr3, [r6, #-0]
    1ee4:	05000002 	streq	r0, [r0, #-2]
    1ee8:	0165024d 	cmneq	r5, sp, asr #4
    1eec:	16400000 	strbne	r0, [r0], -r0
    1ef0:	00000220 	andeq	r0, r0, r0, lsr #4
    1ef4:	25024e05 	strcs	r4, [r2, #-3589]	; 0xe05
    1ef8:	44000000 	strmi	r0, [r0], #-0
    1efc:	00054316 	andeq	r4, r5, r6, lsl r3
    1f00:	024f0500 	subeq	r0, pc, #0, 10
    1f04:	00000165 	andeq	r0, r0, r5, ror #2
    1f08:	033e1648 	teqeq	lr, #72, 12	; 0x4800000
    1f0c:	50050000 	andpl	r0, r5, r0
    1f10:	00083402 	andeq	r3, r8, r2, lsl #8
    1f14:	3e164c00 	cdpcc	12, 1, cr4, cr6, cr0, {0}
    1f18:	05000002 	streq	r0, [r0, #-2]
    1f1c:	00250253 	eoreq	r0, r5, r3, asr r2
    1f20:	16500000 	ldrbne	r0, [r0], -r0
    1f24:	000000f6 	strdeq	r0, [r0], -r6
    1f28:	4a025405 	bmi	96f44 <_stack+0x16f44>
    1f2c:	54000005 	strpl	r0, [r0], #-5
    1f30:	0003ab16 	andeq	sl, r3, r6, lsl fp
    1f34:	02770500 	rsbseq	r0, r7, #0, 10
    1f38:	000007f1 	strdeq	r0, [r0], -r1
    1f3c:	03241758 	teqeq	r4, #88, 14	; 0x1600000
    1f40:	7b050000 	blvc	141f48 <_stack+0xc1f48>
    1f44:	00028202 	andeq	r8, r2, r2, lsl #4
    1f48:	17014800 	strne	r4, [r1, -r0, lsl #16]
    1f4c:	000002bb 			; <UNDEFINED> instruction: 0x000002bb
    1f50:	44027c05 	strmi	r7, [r2], #-3077	; 0xc05
    1f54:	4c000002 	stcmi	0, cr0, [r0], {2}
    1f58:	04f71701 	ldrbteq	r1, [r7], #1793	; 0x701
    1f5c:	80050000 	andhi	r0, r5, r0
    1f60:	00084502 	andeq	r4, r8, r2, lsl #10
    1f64:	1702dc00 	strne	sp, [r2, -r0, lsl #24]
    1f68:	000000cf 	andeq	r0, r0, pc, asr #1
    1f6c:	f6028505 			; <UNDEFINED> instruction: 0xf6028505
    1f70:	e0000005 	and	r0, r0, r5
    1f74:	00b41702 	adcseq	r1, r4, r2, lsl #14
    1f78:	86050000 	strhi	r0, [r5], -r0
    1f7c:	00085102 	andeq	r5, r8, r2, lsl #2
    1f80:	0002ec00 	andeq	lr, r2, r0, lsl #24
    1f84:	0550040f 	ldrbeq	r0, [r0, #-1039]	; 0x40f
    1f88:	01030000 	mrseq	r0, (UNDEF: 3)
    1f8c:	0003a608 	andeq	sl, r3, r8, lsl #12
    1f90:	f4040f00 			; <UNDEFINED> instruction: 0xf4040f00
    1f94:	13000003 	movwne	r0, #3
    1f98:	00000025 	andeq	r0, r0, r5, lsr #32
    1f9c:	0000057b 	andeq	r0, r0, fp, ror r5
    1fa0:	00041214 	andeq	r1, r4, r4, lsl r2
    1fa4:	01051400 	tsteq	r5, r0, lsl #8
    1fa8:	7b140000 	blvc	501fb0 <_stack+0x481fb0>
    1fac:	14000005 	strne	r0, [r0], #-5
    1fb0:	00000025 	andeq	r0, r0, r5, lsr #32
    1fb4:	81040f00 	tsthi	r4, r0, lsl #30
    1fb8:	18000005 	stmdane	r0, {r0, r2}
    1fbc:	00000550 	andeq	r0, r0, r0, asr r5
    1fc0:	055d040f 	ldrbeq	r0, [sp, #-1039]	; 0x40f
    1fc4:	81130000 	tsthi	r3, r0
    1fc8:	aa000000 	bge	1fd0 <CPSR_IRQ_INHIBIT+0x1f50>
    1fcc:	14000005 	strne	r0, [r0], #-5
    1fd0:	00000412 	andeq	r0, r0, r2, lsl r4
    1fd4:	00010514 	andeq	r0, r1, r4, lsl r5
    1fd8:	00811400 	addeq	r1, r1, r0, lsl #8
    1fdc:	25140000 	ldrcs	r0, [r4, #-0]
    1fe0:	00000000 	andeq	r0, r0, r0
    1fe4:	058c040f 	streq	r0, [ip, #1039]	; 0x40f
    1fe8:	25130000 	ldrcs	r0, [r3, #-0]
    1fec:	c4000000 	strgt	r0, [r0], #-0
    1ff0:	14000005 	strne	r0, [r0], #-5
    1ff4:	00000412 	andeq	r0, r0, r2, lsl r4
    1ff8:	00010514 	andeq	r0, r1, r4, lsl r5
    1ffc:	040f0000 	streq	r0, [pc], #-0	; 2004 <CPSR_IRQ_INHIBIT+0x1f84>
    2000:	000005b0 			; <UNDEFINED> instruction: 0x000005b0
    2004:	00003a08 	andeq	r3, r0, r8, lsl #20
    2008:	0005da00 	andeq	sp, r5, r0, lsl #20
    200c:	00c70900 	sbceq	r0, r7, r0, lsl #18
    2010:	00020000 	andeq	r0, r2, r0
    2014:	00003a08 	andeq	r3, r0, r8, lsl #20
    2018:	0005ea00 	andeq	lr, r5, r0, lsl #20
    201c:	00c70900 	sbceq	r0, r7, r0, lsl #18
    2020:	00000000 	andeq	r0, r0, r0
    2024:	0003da05 	andeq	sp, r3, r5, lsl #20
    2028:	011d0500 	tsteq	sp, r0, lsl #10
    202c:	000002ca 	andeq	r0, r0, sl, asr #5
    2030:	00093d19 	andeq	r3, r9, r9, lsl sp
    2034:	21050c00 	tstcs	r5, r0, lsl #24
    2038:	00062b01 	andeq	r2, r6, r1, lsl #22
    203c:	04021600 	streq	r1, [r2], #-1536	; 0x600
    2040:	23050000 	movwcs	r0, #20480	; 0x5000
    2044:	00062b01 	andeq	r2, r6, r1, lsl #22
    2048:	a1160000 	tstge	r6, r0
    204c:	05000002 	streq	r0, [r0, #-2]
    2050:	00250124 	eoreq	r0, r5, r4, lsr #2
    2054:	16040000 	strne	r0, [r4], -r0
    2058:	000003d4 	ldrdeq	r0, [r0], -r4
    205c:	31012505 	tstcc	r1, r5, lsl #10
    2060:	08000006 	stmdaeq	r0, {r1, r2}
    2064:	f6040f00 			; <UNDEFINED> instruction: 0xf6040f00
    2068:	0f000005 	svceq	0x00000005
    206c:	0005ea04 	andeq	lr, r5, r4, lsl #20
    2070:	00131900 	andseq	r1, r3, r0, lsl #18
    2074:	050e0000 	streq	r0, [lr, #-0]
    2078:	066c013d 			; <UNDEFINED> instruction: 0x066c013d
    207c:	4b160000 	blmi	582084 <_stack+0x502084>
    2080:	05000004 	streq	r0, [r0, #-4]
    2084:	066c013e 			; <UNDEFINED> instruction: 0x066c013e
    2088:	16000000 	strne	r0, [r0], -r0
    208c:	00000478 	andeq	r0, r0, r8, ror r4
    2090:	6c013f05 	stcvs	15, cr3, [r1], {5}
    2094:	06000006 	streq	r0, [r0], -r6
    2098:	00049c16 	andeq	r9, r4, r6, lsl ip
    209c:	01400500 	cmpeq	r0, r0, lsl #10
    20a0:	00000048 	andeq	r0, r0, r8, asr #32
    20a4:	4808000c 	stmdami	r8, {r2, r3}
    20a8:	7c000000 	stcvc	0, cr0, [r0], {-0}
    20ac:	09000006 	stmdbeq	r0, {r1, r2}
    20b0:	000000c7 	andeq	r0, r0, r7, asr #1
    20b4:	d01a0002 	andsle	r0, sl, r2
    20b8:	7d025805 	stcvc	8, cr5, [r2, #-20]	; 0xffffffec
    20bc:	16000007 	strne	r0, [r0], -r7
    20c0:	000004c8 	andeq	r0, r0, r8, asr #9
    20c4:	2c025a05 	stccs	10, cr5, [r2], {5}
    20c8:	00000000 	andeq	r0, r0, r0
    20cc:	00048616 	andeq	r8, r4, r6, lsl r6
    20d0:	025b0500 	subseq	r0, fp, #0, 10
    20d4:	0000054a 	andeq	r0, r0, sl, asr #10
    20d8:	02d01604 	sbcseq	r1, r0, #4, 12	; 0x400000
    20dc:	5c050000 	stcpl	0, cr0, [r5], {-0}
    20e0:	00077d02 	andeq	r7, r7, r2, lsl #26
    20e4:	1a160800 	bne	5840ec <_stack+0x5040ec>
    20e8:	05000005 	streq	r0, [r0, #-5]
    20ec:	017b025d 	cmneq	fp, sp, asr r2
    20f0:	16240000 	strtne	r0, [r4], -r0
    20f4:	0000020b 	andeq	r0, r0, fp, lsl #4
    20f8:	25025e05 	strcs	r5, [r2, #-3589]	; 0xe05
    20fc:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
    2100:	0003fd16 	andeq	pc, r3, r6, lsl sp	; <UNPREDICTABLE>
    2104:	025f0500 	subseq	r0, pc, #0, 10
    2108:	00000064 	andeq	r0, r0, r4, rrx
    210c:	05301650 	ldreq	r1, [r0, #-1616]!	; 0x650
    2110:	60050000 	andvs	r0, r5, r0
    2114:	00063702 	andeq	r3, r6, r2, lsl #14
    2118:	08165800 	ldmdaeq	r6, {fp, ip, lr}
    211c:	05000004 	streq	r0, [r0, #-4]
    2120:	00ef0261 	rsceq	r0, pc, r1, ror #4
    2124:	16680000 	strbtne	r0, [r8], -r0
    2128:	00000535 	andeq	r0, r0, r5, lsr r5
    212c:	ef026205 	svc	0x00026205
    2130:	70000000 	andvc	r0, r0, r0
    2134:	00007f16 	andeq	r7, r0, r6, lsl pc
    2138:	02630500 	rsbeq	r0, r3, #0, 10
    213c:	000000ef 	andeq	r0, r0, pc, ror #1
    2140:	04ed1678 	strbteq	r1, [sp], #1656	; 0x678
    2144:	64050000 	strvs	r0, [r5], #-0
    2148:	00078d02 	andeq	r8, r7, r2, lsl #26
    214c:	c4168000 	ldrgt	r8, [r6], #-0
    2150:	05000002 	streq	r0, [r0, #-2]
    2154:	079d0265 	ldreq	r0, [sp, r5, ror #4]
    2158:	16880000 	strne	r0, [r8], r0
    215c:	000004a9 	andeq	r0, r0, r9, lsr #9
    2160:	25026605 	strcs	r6, [r2, #-1541]	; 0x605
    2164:	a0000000 	andge	r0, r0, r0
    2168:	00011716 	andeq	r1, r1, r6, lsl r7
    216c:	02670500 	rsbeq	r0, r7, #0, 10
    2170:	000000ef 	andeq	r0, r0, pc, ror #1
    2174:	006b16a4 	rsbeq	r1, fp, r4, lsr #13
    2178:	68050000 	stmdavs	r5, {}	; <UNPREDICTABLE>
    217c:	0000ef02 	andeq	lr, r0, r2, lsl #30
    2180:	0616ac00 	ldreq	sl, [r6], -r0, lsl #24
    2184:	05000001 	streq	r0, [r0, #-1]
    2188:	00ef0269 	rsceq	r0, pc, r9, ror #4
    218c:	16b40000 	ldrtne	r0, [r4], r0
    2190:	0000002b 	andeq	r0, r0, fp, lsr #32
    2194:	ef026a05 	svc	0x00026a05
    2198:	bc000000 	stclt	0, cr0, [r0], {-0}
    219c:	00003a16 	andeq	r3, r0, r6, lsl sl
    21a0:	026b0500 	rsbeq	r0, fp, #0, 10
    21a4:	000000ef 	andeq	r0, r0, pc, ror #1
    21a8:	03b016c4 	movseq	r1, #196, 12	; 0xc400000
    21ac:	6c050000 	stcvs	0, cr0, [r5], {-0}
    21b0:	00002502 	andeq	r2, r0, r2, lsl #10
    21b4:	0800cc00 	stmdaeq	r0, {sl, fp, lr, pc}
    21b8:	00000550 	andeq	r0, r0, r0, asr r5
    21bc:	0000078d 	andeq	r0, r0, sp, lsl #15
    21c0:	0000c709 	andeq	ip, r0, r9, lsl #14
    21c4:	08001900 	stmdaeq	r0, {r8, fp, ip}
    21c8:	00000550 	andeq	r0, r0, r0, asr r5
    21cc:	0000079d 	muleq	r0, sp, r7
    21d0:	0000c709 	andeq	ip, r0, r9, lsl #14
    21d4:	08000700 	stmdaeq	r0, {r8, r9, sl}
    21d8:	00000550 	andeq	r0, r0, r0, asr r5
    21dc:	000007ad 	andeq	r0, r0, sp, lsr #15
    21e0:	0000c709 	andeq	ip, r0, r9, lsl #14
    21e4:	1a001700 	bne	7dec <CPSR_IRQ_INHIBIT+0x7d6c>
    21e8:	027105f0 	rsbseq	r0, r1, #240, 10	; 0x3c000000
    21ec:	000007d1 	ldrdeq	r0, [r0], -r1
    21f0:	00031416 	andeq	r1, r3, r6, lsl r4
    21f4:	02740500 	rsbseq	r0, r4, #0, 10
    21f8:	000007d1 	ldrdeq	r0, [r0], -r1
    21fc:	04e41600 	strbteq	r1, [r4], #1536	; 0x600
    2200:	75050000 	strvc	r0, [r5, #-0]
    2204:	0007e102 	andeq	lr, r7, r2, lsl #2
    2208:	08007800 	stmdaeq	r0, {fp, ip, sp, lr}
    220c:	000002c4 	andeq	r0, r0, r4, asr #5
    2210:	000007e1 	andeq	r0, r0, r1, ror #15
    2214:	0000c709 	andeq	ip, r0, r9, lsl #14
    2218:	08001d00 	stmdaeq	r0, {r8, sl, fp, ip}
    221c:	0000002c 	andeq	r0, r0, ip, lsr #32
    2220:	000007f1 	strdeq	r0, [r0], -r1
    2224:	0000c709 	andeq	ip, r0, r9, lsl #14
    2228:	1b001d00 	blne	9630 <get_current_running_process+0x4>
    222c:	025605f0 	subseq	r0, r6, #240, 10	; 0x3c000000
    2230:	00000813 	andeq	r0, r0, r3, lsl r8
    2234:	0009d91c 	andeq	sp, r9, ip, lsl r9
    2238:	026d0500 	rsbeq	r0, sp, #0, 10
    223c:	0000067c 	andeq	r0, r0, ip, ror r6
    2240:	0005071c 	andeq	r0, r5, ip, lsl r7
    2244:	02760500 	rsbseq	r0, r6, #0, 10
    2248:	000007ad 	andeq	r0, r0, sp, lsr #15
    224c:	05500800 	ldrbeq	r0, [r0, #-2048]	; 0x800
    2250:	08230000 	stmdaeq	r3!, {}	; <UNPREDICTABLE>
    2254:	c7090000 	strgt	r0, [r9, -r0]
    2258:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    225c:	082e1d00 	stmdaeq	lr!, {r8, sl, fp, ip}
    2260:	12140000 	andsne	r0, r4, #0
    2264:	00000004 	andeq	r0, r0, r4
    2268:	0823040f 	stmdaeq	r3!, {r0, r1, r2, r3, sl}
    226c:	040f0000 	streq	r0, [pc], #-0	; 2274 <CPSR_IRQ_INHIBIT+0x21f4>
    2270:	00000165 	andeq	r0, r0, r5, ror #2
    2274:	0008451d 	andeq	r4, r8, sp, lsl r5
    2278:	00251400 	eoreq	r1, r5, r0, lsl #8
    227c:	0f000000 	svceq	0x00000000
    2280:	00084b04 	andeq	r4, r8, r4, lsl #22
    2284:	3a040f00 	bcc	105e8c <_stack+0x85e8c>
    2288:	08000008 	stmdaeq	r0, {r3}
    228c:	000005ea 	andeq	r0, r0, sl, ror #11
    2290:	00000861 	andeq	r0, r0, r1, ror #16
    2294:	0000c709 	andeq	ip, r0, r9, lsl #14
    2298:	1e000200 	cdpne	2, 0, cr0, cr0, cr0, {0}
    229c:	000005f3 	strdeq	r0, [r0], -r3
    22a0:	a3d42f01 	bicsge	r2, r4, #1, 30
    22a4:	00020000 	andeq	r0, r2, r0
    22a8:	9c010000 	stcls	0, cr0, [r1], {-0}
    22ac:	00000884 	andeq	r0, r0, r4, lsl #17
    22b0:	7274701f 	rsbsvc	r7, r4, #31
    22b4:	12300100 	eorsne	r0, r0, #0, 2
    22b8:	01000004 	tsteq	r0, r4
    22bc:	9d1e0050 	ldcls	0, cr0, [lr, #-320]	; 0xfffffec0
    22c0:	01000005 	tsteq	r0, r5
    22c4:	00a3d838 	adceq	sp, r3, r8, lsr r8
    22c8:	00000200 	andeq	r0, r0, r0, lsl #4
    22cc:	a79c0100 	ldrge	r0, [ip, r0, lsl #2]
    22d0:	1f000008 	svcne	0x00000008
    22d4:	00727470 	rsbseq	r7, r2, r0, ror r4
    22d8:	04123901 	ldreq	r3, [r2], #-2305	; 0x901
    22dc:	50010000 	andpl	r0, r1, r0
    22e0:	08e62000 	stmiaeq	r6!, {sp}^
    22e4:	2b010000 	blcs	422ec <__bss_end__+0x2e2a4>
    22e8:	00000025 	andeq	r0, r0, r5, lsr #32
    22ec:	09f70000 	ldmibeq	r7!, {}^	; <UNPREDICTABLE>
    22f0:	00040000 	andeq	r0, r4, r0
    22f4:	000007a8 	andeq	r0, r0, r8, lsr #15
    22f8:	01410104 	cmpeq	r1, r4, lsl #2
    22fc:	43010000 	movwmi	r0, #4096	; 0x1000
    2300:	75000009 	strvc	r0, [r0, #-9]
    2304:	a0000009 	andge	r0, r0, r9
    2308:	00000000 	andeq	r0, r0, r0
    230c:	ad000000 	stcge	0, cr0, [r0, #-0]
    2310:	02000008 	andeq	r0, r0, #8
    2314:	00550704 	subseq	r0, r5, r4, lsl #14
    2318:	04030000 	streq	r0, [r3], #-0
    231c:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
    2320:	06010200 	streq	r0, [r1], -r0, lsl #4
    2324:	0000039f 	muleq	r0, pc, r3	; <UNPREDICTABLE>
    2328:	9d080102 	stflss	f0, [r8, #-8]
    232c:	02000003 	andeq	r0, r0, #3
    2330:	03b90502 			; <UNDEFINED> instruction: 0x03b90502
    2334:	02020000 	andeq	r0, r2, #0
    2338:	0002a807 	andeq	sl, r2, r7, lsl #16
    233c:	05040200 	streq	r0, [r4, #-512]	; 0x200
    2340:	0000009b 	muleq	r0, fp, r0
    2344:	50070402 	andpl	r0, r7, r2, lsl #8
    2348:	02000000 	andeq	r0, r0, #0
    234c:	00960508 	addseq	r0, r6, r8, lsl #10
    2350:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    2354:	00004b07 	andeq	r4, r0, r7, lsl #22
    2358:	034f0400 	movteq	r0, #62464	; 0xf400
    235c:	07020000 	streq	r0, [r2, -r0]
    2360:	0000002c 	andeq	r0, r0, ip, lsr #32
    2364:	00033704 	andeq	r3, r3, r4, lsl #14
    2368:	4f100300 	svcmi	0x00100300
    236c:	04000000 	streq	r0, [r0], #-0
    2370:	00000467 	andeq	r0, r0, r7, ror #8
    2374:	004f2703 	subeq	r2, pc, r3, lsl #14
    2378:	eb050000 	bl	142380 <_stack+0xc2380>
    237c:	04000002 	streq	r0, [r0], #-2
    2380:	00250161 	eoreq	r0, r5, r1, ror #2
    2384:	04060000 	streq	r0, [r6], #-0
    2388:	00b74a03 	adcseq	r4, r7, r3, lsl #20
    238c:	e5070000 	str	r0, [r7, #-0]
    2390:	03000002 	movweq	r0, #2
    2394:	00008c4c 	andeq	r8, r0, ip, asr #24
    2398:	022f0700 	eoreq	r0, pc, #0, 14
    239c:	4d030000 	stcmi	0, cr0, [r3, #-0]
    23a0:	000000b7 	strheq	r0, [r0], -r7
    23a4:	003a0800 	eorseq	r0, sl, r0, lsl #16
    23a8:	00c70000 	sbceq	r0, r7, r0
    23ac:	c7090000 	strgt	r0, [r9, -r0]
    23b0:	03000000 	movweq	r0, #0
    23b4:	07040200 	streq	r0, [r4, -r0, lsl #4]
    23b8:	0000030b 	andeq	r0, r0, fp, lsl #6
    23bc:	4703080a 	strmi	r0, [r3, -sl, lsl #16]
    23c0:	000000ef 	andeq	r0, r0, pc, ror #1
    23c4:	0004510b 	andeq	r5, r4, fp, lsl #2
    23c8:	2c490300 	mcrrcs	3, 0, r0, r9, cr0
    23cc:	00000000 	andeq	r0, r0, r0
    23d0:	0004590b 	andeq	r5, r4, fp, lsl #18
    23d4:	984e0300 	stmdals	lr, {r8, r9}^
    23d8:	04000000 	streq	r0, [r0], #-0
    23dc:	03e10400 	mvneq	r0, #0, 8
    23e0:	4f030000 	svcmi	0x00030000
    23e4:	000000ce 	andeq	r0, r0, lr, asr #1
    23e8:	00013804 	andeq	r3, r1, r4, lsl #16
    23ec:	6b530300 	blvs	14c2ff4 <_stack+0x1442ff4>
    23f0:	0c000000 	stceq	0, cr0, [r0], {-0}
    23f4:	04a10404 	strteq	r0, [r1], #1028	; 0x404
    23f8:	16050000 	strne	r0, [r5], -r0
    23fc:	00000056 	andeq	r0, r0, r6, asr r0
    2400:	0002030d 	andeq	r0, r2, sp, lsl #6
    2404:	2d051800 	stccs	8, cr1, [r5, #-0]
    2408:	00000165 	andeq	r0, r0, r5, ror #2
    240c:	0004020b 	andeq	r0, r4, fp, lsl #4
    2410:	652f0500 	strvs	r0, [pc, #-1280]!	; 1f18 <CPSR_IRQ_INHIBIT+0x1e98>
    2414:	00000001 	andeq	r0, r0, r1
    2418:	006b5f0e 	rsbeq	r5, fp, lr, lsl #30
    241c:	002c3005 	eoreq	r3, ip, r5
    2420:	0b040000 	bleq	102428 <_stack+0x82428>
    2424:	00000443 	andeq	r0, r0, r3, asr #8
    2428:	002c3005 	eoreq	r3, ip, r5
    242c:	0b080000 	bleq	202434 <_stack+0x182434>
    2430:	00000132 	andeq	r0, r0, r2, lsr r1
    2434:	002c3005 	eoreq	r3, ip, r5
    2438:	0b0c0000 	bleq	302440 <_stack+0x282440>
    243c:	000004d5 	ldrdeq	r0, [r0], -r5
    2440:	002c3005 	eoreq	r3, ip, r5
    2444:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
    2448:	0500785f 	streq	r7, [r0, #-2143]	; 0x85f
    244c:	00016b31 	andeq	r6, r1, r1, lsr fp
    2450:	0f001400 	svceq	0x00001400
    2454:	00011204 	andeq	r1, r1, r4, lsl #4
    2458:	01070800 	tsteq	r7, r0, lsl #16
    245c:	017b0000 	cmneq	fp, r0
    2460:	c7090000 	strgt	r0, [r9, -r0]
    2464:	00000000 	andeq	r0, r0, r0
    2468:	022a0d00 	eoreq	r0, sl, #0, 26
    246c:	05240000 	streq	r0, [r4, #-0]!
    2470:	0001f435 	andeq	pc, r1, r5, lsr r4	; <UNPREDICTABLE>
    2474:	008d0b00 	addeq	r0, sp, r0, lsl #22
    2478:	37050000 	strcc	r0, [r5, -r0]
    247c:	0000002c 	andeq	r0, r0, ip, lsr #32
    2480:	046f0b00 	strbteq	r0, [pc], #-2816	; 2488 <CPSR_IRQ_INHIBIT+0x2408>
    2484:	38050000 	stmdacc	r5, {}	; <UNPREDICTABLE>
    2488:	0000002c 	andeq	r0, r0, ip, lsr #32
    248c:	00aa0b04 	adceq	r0, sl, r4, lsl #22
    2490:	39050000 	stmdbcc	r5, {}	; <UNPREDICTABLE>
    2494:	0000002c 	andeq	r0, r0, ip, lsr #32
    2498:	05480b08 	strbeq	r0, [r8, #-2824]	; 0xb08
    249c:	3a050000 	bcc	1424a4 <_stack+0xc24a4>
    24a0:	0000002c 	andeq	r0, r0, ip, lsr #32
    24a4:	031b0b0c 	tsteq	fp, #12, 22	; 0x3000
    24a8:	3b050000 	blcc	1424b0 <_stack+0xc24b0>
    24ac:	0000002c 	andeq	r0, r0, ip, lsr #32
    24b0:	03010b10 	movweq	r0, #6928	; 0x1b10
    24b4:	3c050000 	stccc	0, cr0, [r5], {-0}
    24b8:	0000002c 	andeq	r0, r0, ip, lsr #32
    24bc:	04da0b14 	ldrbeq	r0, [sl], #2836	; 0xb14
    24c0:	3d050000 	stccc	0, cr0, [r5, #-0]
    24c4:	0000002c 	andeq	r0, r0, ip, lsr #32
    24c8:	03c30b18 	biceq	r0, r3, #24, 22	; 0x6000
    24cc:	3e050000 	cdpcc	0, 0, cr0, cr5, cr0, {0}
    24d0:	0000002c 	andeq	r0, r0, ip, lsr #32
    24d4:	050f0b1c 	streq	r0, [pc, #-2844]	; 19c0 <CPSR_IRQ_INHIBIT+0x1940>
    24d8:	3f050000 	svccc	0x00050000
    24dc:	0000002c 	andeq	r0, r0, ip, lsr #32
    24e0:	b9100020 	ldmdblt	r0, {r5}
    24e4:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    24e8:	34480501 	strbcc	r0, [r8], #-1281	; 0x501
    24ec:	0b000002 	bleq	24fc <CPSR_IRQ_INHIBIT+0x247c>
    24f0:	00000125 	andeq	r0, r0, r5, lsr #2
    24f4:	02344905 	eorseq	r4, r4, #81920	; 0x14000
    24f8:	0b000000 	bleq	2500 <CPSR_IRQ_INHIBIT+0x2480>
    24fc:	00000000 	andeq	r0, r0, r0
    2500:	02344a05 	eorseq	r4, r4, #20480	; 0x5000
    2504:	11800000 	orrne	r0, r0, r0
    2508:	00000493 	muleq	r0, r3, r4
    250c:	01074c05 	tsteq	r7, r5, lsl #24
    2510:	01000000 	mrseq	r0, (UNDEF: 0)
    2514:	0000de11 	andeq	sp, r0, r1, lsl lr
    2518:	074f0500 	strbeq	r0, [pc, -r0, lsl #10]
    251c:	04000001 	streq	r0, [r0], #-1
    2520:	05080001 	streq	r0, [r8, #-1]
    2524:	44000001 	strmi	r0, [r0], #-1
    2528:	09000002 	stmdbeq	r0, {r1}
    252c:	000000c7 	andeq	r0, r0, r7, asr #1
    2530:	2410001f 	ldrcs	r0, [r0], #-31
    2534:	90000003 	andls	r0, r0, r3
    2538:	825b0501 	subshi	r0, fp, #4194304	; 0x400000
    253c:	0b000002 	bleq	254c <CPSR_IRQ_INHIBIT+0x24cc>
    2540:	00000402 	andeq	r0, r0, r2, lsl #8
    2544:	02825c05 	addeq	r5, r2, #1280	; 0x500
    2548:	0b000000 	bleq	2550 <CPSR_IRQ_INHIBIT+0x24d0>
    254c:	0000041a 	andeq	r0, r0, sl, lsl r4
    2550:	002c5d05 	eoreq	r5, ip, r5, lsl #26
    2554:	0b040000 	bleq	10255c <_stack+0x8255c>
    2558:	0000012d 	andeq	r0, r0, sp, lsr #2
    255c:	02885f05 	addeq	r5, r8, #5, 30
    2560:	0b080000 	bleq	202568 <_stack+0x182568>
    2564:	000000b9 	strheq	r0, [r0], -r9
    2568:	01f46005 	mvnseq	r6, r5
    256c:	00880000 	addeq	r0, r8, r0
    2570:	0244040f 	subeq	r0, r4, #251658240	; 0xf000000
    2574:	98080000 	stmdals	r8, {}	; <UNPREDICTABLE>
    2578:	98000002 	stmdals	r0, {r1}
    257c:	09000002 	stmdbeq	r0, {r1}
    2580:	000000c7 	andeq	r0, r0, r7, asr #1
    2584:	040f001f 	streq	r0, [pc], #-31	; 258c <CPSR_IRQ_INHIBIT+0x250c>
    2588:	0000029e 	muleq	r0, lr, r2
    258c:	03cd0d12 	biceq	r0, sp, #1152	; 0x480
    2590:	05080000 	streq	r0, [r8, #-0]
    2594:	0002c473 	andeq	ip, r2, r3, ror r4
    2598:	07610b00 	strbeq	r0, [r1, -r0, lsl #22]!
    259c:	74050000 	strvc	r0, [r5], #-0
    25a0:	000002c4 	andeq	r0, r0, r4, asr #5
    25a4:	06180b00 	ldreq	r0, [r8], -r0, lsl #22
    25a8:	75050000 	strvc	r0, [r5, #-0]
    25ac:	0000002c 	andeq	r0, r0, ip, lsr #32
    25b0:	040f0004 	streq	r0, [pc], #-4	; 25b8 <CPSR_IRQ_INHIBIT+0x2538>
    25b4:	0000003a 	andeq	r0, r0, sl, lsr r0
    25b8:	0003ec0d 	andeq	lr, r3, sp, lsl #24
    25bc:	b3056800 	movwlt	r6, #22528	; 0x5800
    25c0:	000003f4 	strdeq	r0, [r0], -r4
    25c4:	00705f0e 	rsbseq	r5, r0, lr, lsl #30
    25c8:	02c4b405 	sbceq	fp, r4, #83886080	; 0x5000000
    25cc:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    25d0:	0500725f 	streq	r7, [r0, #-607]	; 0x25f
    25d4:	00002cb5 			; <UNDEFINED> instruction: 0x00002cb5
    25d8:	5f0e0400 	svcpl	0x000e0400
    25dc:	b6050077 			; <UNDEFINED> instruction: 0xb6050077
    25e0:	0000002c 	andeq	r0, r0, ip, lsr #32
    25e4:	00d70b08 	sbcseq	r0, r7, r8, lsl #22
    25e8:	b7050000 	strlt	r0, [r5, -r0]
    25ec:	00000041 	andeq	r0, r0, r1, asr #32
    25f0:	02460b0c 	subeq	r0, r6, #12, 22	; 0x3000
    25f4:	b8050000 	stmdalt	r5, {}	; <UNPREDICTABLE>
    25f8:	00000041 	andeq	r0, r0, r1, asr #32
    25fc:	625f0e0e 	subsvs	r0, pc, #14, 28	; 0xe0
    2600:	b9050066 	stmdblt	r5, {r1, r2, r5, r6}
    2604:	0000029f 	muleq	r0, pc, r2	; <UNPREDICTABLE>
    2608:	00620b10 	rsbeq	r0, r2, r0, lsl fp
    260c:	ba050000 	blt	142614 <_stack+0xc2614>
    2610:	0000002c 	andeq	r0, r0, ip, lsr #32
    2614:	00c70b18 	sbceq	r0, r7, r8, lsl fp
    2618:	c1050000 	mrsgt	r0, (UNDEF: 5)
    261c:	00000105 	andeq	r0, r0, r5, lsl #2
    2620:	021a0b1c 	andseq	r0, sl, #28, 22	; 0x7000
    2624:	c3050000 	movwgt	r0, #20480	; 0x5000
    2628:	00000557 	andeq	r0, r0, r7, asr r5
    262c:	02fa0b20 	rscseq	r0, sl, #32, 22	; 0x8000
    2630:	c5050000 	strgt	r0, [r5, #-0]
    2634:	00000586 	andeq	r0, r0, r6, lsl #11
    2638:	04610b24 	strbteq	r0, [r1], #-2852	; 0xb24
    263c:	c8050000 	stmdagt	r5, {}	; <UNPREDICTABLE>
    2640:	000005aa 	andeq	r0, r0, sl, lsr #11
    2644:	05290b28 	streq	r0, [r9, #-2856]!	; 0xb28
    2648:	c9050000 	stmdbgt	r5, {}	; <UNPREDICTABLE>
    264c:	000005c4 	andeq	r0, r0, r4, asr #11
    2650:	755f0e2c 	ldrbvc	r0, [pc, #-3628]	; 182c <CPSR_IRQ_INHIBIT+0x17ac>
    2654:	cc050062 	stcgt	0, cr0, [r5], {98}	; 0x62
    2658:	0000029f 	muleq	r0, pc, r2	; <UNPREDICTABLE>
    265c:	755f0e30 	ldrbvc	r0, [pc, #-3632]	; 1834 <CPSR_IRQ_INHIBIT+0x17b4>
    2660:	cd050070 	stcgt	0, cr0, [r5, #-448]	; 0xfffffe40
    2664:	000002c4 	andeq	r0, r0, r4, asr #5
    2668:	755f0e38 	ldrbvc	r0, [pc, #-3640]	; 1838 <CPSR_IRQ_INHIBIT+0x17b8>
    266c:	ce050072 	mcrgt	0, 0, r0, cr5, cr2, {3}
    2670:	0000002c 	andeq	r0, r0, ip, lsr #32
    2674:	00a40b3c 	adceq	r0, r4, ip, lsr fp
    2678:	d1050000 	mrsle	r0, (UNDEF: 5)
    267c:	000005ca 	andeq	r0, r0, sl, asr #11
    2680:	05010b40 	streq	r0, [r1, #-2880]	; 0xb40
    2684:	d2050000 	andle	r0, r5, #0
    2688:	000005da 	ldrdeq	r0, [r0], -sl
    268c:	6c5f0e43 	mrrcvs	14, 4, r0, pc, cr3	; <UNPREDICTABLE>
    2690:	d5050062 	strle	r0, [r5, #-98]	; 0x62
    2694:	0000029f 	muleq	r0, pc, r2	; <UNPREDICTABLE>
    2698:	00ed0b44 	rsceq	r0, sp, r4, asr #22
    269c:	d8050000 	stmdale	r5, {}	; <UNPREDICTABLE>
    26a0:	0000002c 	andeq	r0, r0, ip, lsr #32
    26a4:	00fe0b4c 	rscseq	r0, lr, ip, asr #22
    26a8:	d9050000 	stmdble	r5, {}	; <UNPREDICTABLE>
    26ac:	00000076 	andeq	r0, r0, r6, ror r0
    26b0:	0a9a0b50 	beq	fe6853f8 <STACK_SVR+0xfa6853f8>
    26b4:	dc050000 	stcle	0, cr0, [r5], {-0}
    26b8:	00000412 	andeq	r0, r0, r2, lsl r4
    26bc:	05fb0b54 	ldrbeq	r0, [fp, #2900]!	; 0xb54
    26c0:	e0050000 	and	r0, r5, r0
    26c4:	000000fa 	strdeq	r0, [r0], -sl
    26c8:	03f40b58 	mvnseq	r0, #88, 22	; 0x16000
    26cc:	e2050000 	and	r0, r5, #0
    26d0:	000000ef 	andeq	r0, r0, pc, ror #1
    26d4:	02f20b5c 	rscseq	r0, r2, #92, 22	; 0x17000
    26d8:	e3050000 	movw	r0, #20480	; 0x5000
    26dc:	0000002c 	andeq	r0, r0, ip, lsr #32
    26e0:	2c130064 	ldccs	0, cr0, [r3], {100}	; 0x64
    26e4:	12000000 	andne	r0, r0, #0
    26e8:	14000004 	strne	r0, [r0], #-4
    26ec:	00000412 	andeq	r0, r0, r2, lsl r4
    26f0:	00010514 	andeq	r0, r1, r4, lsl r5
    26f4:	054a1400 	strbeq	r1, [sl, #-1024]	; 0x400
    26f8:	2c140000 	ldccs	0, cr0, [r4], {-0}
    26fc:	00000000 	andeq	r0, r0, r0
    2700:	0418040f 	ldreq	r0, [r8], #-1039	; 0x40f
    2704:	d9150000 	ldmdble	r5, {}	; <UNPREDICTABLE>
    2708:	28000009 	stmdacs	r0, {r0, r3}
    270c:	02390504 	eorseq	r0, r9, #4, 10	; 0x1000000
    2710:	0000054a 	andeq	r0, r0, sl, asr #10
    2714:	0003b216 	andeq	fp, r3, r6, lsl r2
    2718:	023b0500 	eorseq	r0, fp, #0, 10
    271c:	0000002c 	andeq	r0, r0, ip, lsr #32
    2720:	00e61600 	rsceq	r1, r6, r0, lsl #12
    2724:	40050000 	andmi	r0, r5, r0
    2728:	00063102 	andeq	r3, r6, r2, lsl #2
    272c:	36160400 	ldrcc	r0, [r6], -r0, lsl #8
    2730:	05000002 	streq	r0, [r0, #-2]
    2734:	06310240 	ldrteq	r0, [r1], -r0, asr #4
    2738:	16080000 	strne	r0, [r8], -r0
    273c:	0000047e 	andeq	r0, r0, lr, ror r4
    2740:	31024005 	tstcc	r2, r5
    2744:	0c000006 	stceq	0, cr0, [r0], {6}
    2748:	00041516 	andeq	r1, r4, r6, lsl r5
    274c:	02420500 	subeq	r0, r2, #0, 10
    2750:	0000002c 	andeq	r0, r0, ip, lsr #32
    2754:	00201610 	eoreq	r1, r0, r0, lsl r6
    2758:	43050000 	movwmi	r0, #20480	; 0x5000
    275c:	00081302 	andeq	r1, r8, r2, lsl #6
    2760:	b6161400 	ldrlt	r1, [r6], -r0, lsl #8
    2764:	05000004 	streq	r0, [r0, #-4]
    2768:	002c0245 	eoreq	r0, ip, r5, asr #4
    276c:	16300000 	ldrtne	r0, [r0], -r0
    2770:	0000041f 	andeq	r0, r0, pc, lsl r4
    2774:	7b024605 	blvc	93f90 <_stack+0x13f90>
    2778:	34000005 	strcc	r0, [r0], #-5
    277c:	00032c16 	andeq	r2, r3, r6, lsl ip
    2780:	02480500 	subeq	r0, r8, #0, 10
    2784:	0000002c 	andeq	r0, r0, ip, lsr #32
    2788:	04391638 	ldrteq	r1, [r9], #-1592	; 0x638
    278c:	4a050000 	bmi	142794 <_stack+0xc2794>
    2790:	00082e02 	andeq	r2, r8, r2, lsl #28
    2794:	dd163c00 	ldcle	12, cr3, [r6, #-0]
    2798:	05000002 	streq	r0, [r0, #-2]
    279c:	0165024d 	cmneq	r5, sp, asr #4
    27a0:	16400000 	strbne	r0, [r0], -r0
    27a4:	00000220 	andeq	r0, r0, r0, lsr #4
    27a8:	2c024e05 	stccs	14, cr4, [r2], {5}
    27ac:	44000000 	strmi	r0, [r0], #-0
    27b0:	00054316 	andeq	r4, r5, r6, lsl r3
    27b4:	024f0500 	subeq	r0, pc, #0, 10
    27b8:	00000165 	andeq	r0, r0, r5, ror #2
    27bc:	033e1648 	teqeq	lr, #72, 12	; 0x4800000
    27c0:	50050000 	andpl	r0, r5, r0
    27c4:	00083402 	andeq	r3, r8, r2, lsl #8
    27c8:	3e164c00 	cdpcc	12, 1, cr4, cr6, cr0, {0}
    27cc:	05000002 	streq	r0, [r0, #-2]
    27d0:	002c0253 	eoreq	r0, ip, r3, asr r2
    27d4:	16500000 	ldrbne	r0, [r0], -r0
    27d8:	000000f6 	strdeq	r0, [r0], -r6
    27dc:	4a025405 	bmi	977f8 <_stack+0x177f8>
    27e0:	54000005 	strpl	r0, [r0], #-5
    27e4:	0003ab16 	andeq	sl, r3, r6, lsl fp
    27e8:	02770500 	rsbseq	r0, r7, #0, 10
    27ec:	000007f1 	strdeq	r0, [r0], -r1
    27f0:	03241758 	teqeq	r4, #88, 14	; 0x1600000
    27f4:	7b050000 	blvc	1427fc <_stack+0xc27fc>
    27f8:	00028202 	andeq	r8, r2, r2, lsl #4
    27fc:	17014800 	strne	r4, [r1, -r0, lsl #16]
    2800:	000002bb 			; <UNDEFINED> instruction: 0x000002bb
    2804:	44027c05 	strmi	r7, [r2], #-3077	; 0xc05
    2808:	4c000002 	stcmi	0, cr0, [r0], {2}
    280c:	04f71701 	ldrbteq	r1, [r7], #1793	; 0x701
    2810:	80050000 	andhi	r0, r5, r0
    2814:	00084502 	andeq	r4, r8, r2, lsl #10
    2818:	1702dc00 	strne	sp, [r2, -r0, lsl #24]
    281c:	000000cf 	andeq	r0, r0, pc, asr #1
    2820:	f6028505 			; <UNDEFINED> instruction: 0xf6028505
    2824:	e0000005 	and	r0, r0, r5
    2828:	00b41702 	adcseq	r1, r4, r2, lsl #14
    282c:	86050000 	strhi	r0, [r5], -r0
    2830:	00085102 	andeq	r5, r8, r2, lsl #2
    2834:	0002ec00 	andeq	lr, r2, r0, lsl #24
    2838:	0550040f 	ldrbeq	r0, [r0, #-1039]	; 0x40f
    283c:	01020000 	mrseq	r0, (UNDEF: 2)
    2840:	0003a608 	andeq	sl, r3, r8, lsl #12
    2844:	f4040f00 			; <UNDEFINED> instruction: 0xf4040f00
    2848:	13000003 	movwne	r0, #3
    284c:	0000002c 	andeq	r0, r0, ip, lsr #32
    2850:	0000057b 	andeq	r0, r0, fp, ror r5
    2854:	00041214 	andeq	r1, r4, r4, lsl r2
    2858:	01051400 	tsteq	r5, r0, lsl #8
    285c:	7b140000 	blvc	502864 <_stack+0x482864>
    2860:	14000005 	strne	r0, [r0], #-5
    2864:	0000002c 	andeq	r0, r0, ip, lsr #32
    2868:	81040f00 	tsthi	r4, r0, lsl #30
    286c:	18000005 	stmdane	r0, {r0, r2}
    2870:	00000550 	andeq	r0, r0, r0, asr r5
    2874:	055d040f 	ldrbeq	r0, [sp, #-1039]	; 0x40f
    2878:	81130000 	tsthi	r3, r0
    287c:	aa000000 	bge	2884 <CPSR_IRQ_INHIBIT+0x2804>
    2880:	14000005 	strne	r0, [r0], #-5
    2884:	00000412 	andeq	r0, r0, r2, lsl r4
    2888:	00010514 	andeq	r0, r1, r4, lsl r5
    288c:	00811400 	addeq	r1, r1, r0, lsl #8
    2890:	2c140000 	ldccs	0, cr0, [r4], {-0}
    2894:	00000000 	andeq	r0, r0, r0
    2898:	058c040f 	streq	r0, [ip, #1039]	; 0x40f
    289c:	2c130000 	ldccs	0, cr0, [r3], {-0}
    28a0:	c4000000 	strgt	r0, [r0], #-0
    28a4:	14000005 	strne	r0, [r0], #-5
    28a8:	00000412 	andeq	r0, r0, r2, lsl r4
    28ac:	00010514 	andeq	r0, r1, r4, lsl r5
    28b0:	040f0000 	streq	r0, [pc], #-0	; 28b8 <CPSR_IRQ_INHIBIT+0x2838>
    28b4:	000005b0 			; <UNDEFINED> instruction: 0x000005b0
    28b8:	00003a08 	andeq	r3, r0, r8, lsl #20
    28bc:	0005da00 	andeq	sp, r5, r0, lsl #20
    28c0:	00c70900 	sbceq	r0, r7, r0, lsl #18
    28c4:	00020000 	andeq	r0, r2, r0
    28c8:	00003a08 	andeq	r3, r0, r8, lsl #20
    28cc:	0005ea00 	andeq	lr, r5, r0, lsl #20
    28d0:	00c70900 	sbceq	r0, r7, r0, lsl #18
    28d4:	00000000 	andeq	r0, r0, r0
    28d8:	0003da05 	andeq	sp, r3, r5, lsl #20
    28dc:	011d0500 	tsteq	sp, r0, lsl #10
    28e0:	000002ca 	andeq	r0, r0, sl, asr #5
    28e4:	00093d19 	andeq	r3, r9, r9, lsl sp
    28e8:	21050c00 	tstcs	r5, r0, lsl #24
    28ec:	00062b01 	andeq	r2, r6, r1, lsl #22
    28f0:	04021600 	streq	r1, [r2], #-1536	; 0x600
    28f4:	23050000 	movwcs	r0, #20480	; 0x5000
    28f8:	00062b01 	andeq	r2, r6, r1, lsl #22
    28fc:	a1160000 	tstge	r6, r0
    2900:	05000002 	streq	r0, [r0, #-2]
    2904:	002c0124 	eoreq	r0, ip, r4, lsr #2
    2908:	16040000 	strne	r0, [r4], -r0
    290c:	000003d4 	ldrdeq	r0, [r0], -r4
    2910:	31012505 	tstcc	r1, r5, lsl #10
    2914:	08000006 	stmdaeq	r0, {r1, r2}
    2918:	f6040f00 			; <UNDEFINED> instruction: 0xf6040f00
    291c:	0f000005 	svceq	0x00000005
    2920:	0005ea04 	andeq	lr, r5, r4, lsl #20
    2924:	00131900 	andseq	r1, r3, r0, lsl #18
    2928:	050e0000 	streq	r0, [lr, #-0]
    292c:	066c013d 			; <UNDEFINED> instruction: 0x066c013d
    2930:	4b160000 	blmi	582938 <_stack+0x502938>
    2934:	05000004 	streq	r0, [r0, #-4]
    2938:	066c013e 			; <UNDEFINED> instruction: 0x066c013e
    293c:	16000000 	strne	r0, [r0], -r0
    2940:	00000478 	andeq	r0, r0, r8, ror r4
    2944:	6c013f05 	stcvs	15, cr3, [r1], {5}
    2948:	06000006 	streq	r0, [r0], -r6
    294c:	00049c16 	andeq	r9, r4, r6, lsl ip
    2950:	01400500 	cmpeq	r0, r0, lsl #10
    2954:	00000048 	andeq	r0, r0, r8, asr #32
    2958:	4808000c 	stmdami	r8, {r2, r3}
    295c:	7c000000 	stcvc	0, cr0, [r0], {-0}
    2960:	09000006 	stmdbeq	r0, {r1, r2}
    2964:	000000c7 	andeq	r0, r0, r7, asr #1
    2968:	d01a0002 	andsle	r0, sl, r2
    296c:	7d025805 	stcvc	8, cr5, [r2, #-20]	; 0xffffffec
    2970:	16000007 	strne	r0, [r0], -r7
    2974:	000004c8 	andeq	r0, r0, r8, asr #9
    2978:	25025a05 	strcs	r5, [r2, #-2565]	; 0xa05
    297c:	00000000 	andeq	r0, r0, r0
    2980:	00048616 	andeq	r8, r4, r6, lsl r6
    2984:	025b0500 	subseq	r0, fp, #0, 10
    2988:	0000054a 	andeq	r0, r0, sl, asr #10
    298c:	02d01604 	sbcseq	r1, r0, #4, 12	; 0x400000
    2990:	5c050000 	stcpl	0, cr0, [r5], {-0}
    2994:	00077d02 	andeq	r7, r7, r2, lsl #26
    2998:	1a160800 	bne	5849a0 <_stack+0x5049a0>
    299c:	05000005 	streq	r0, [r0, #-5]
    29a0:	017b025d 	cmneq	fp, sp, asr r2
    29a4:	16240000 	strtne	r0, [r4], -r0
    29a8:	0000020b 	andeq	r0, r0, fp, lsl #4
    29ac:	2c025e05 	stccs	14, cr5, [r2], {5}
    29b0:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
    29b4:	0003fd16 	andeq	pc, r3, r6, lsl sp	; <UNPREDICTABLE>
    29b8:	025f0500 	subseq	r0, pc, #0, 10
    29bc:	00000064 	andeq	r0, r0, r4, rrx
    29c0:	05301650 	ldreq	r1, [r0, #-1616]!	; 0x650
    29c4:	60050000 	andvs	r0, r5, r0
    29c8:	00063702 	andeq	r3, r6, r2, lsl #14
    29cc:	08165800 	ldmdaeq	r6, {fp, ip, lr}
    29d0:	05000004 	streq	r0, [r0, #-4]
    29d4:	00ef0261 	rsceq	r0, pc, r1, ror #4
    29d8:	16680000 	strbtne	r0, [r8], -r0
    29dc:	00000535 	andeq	r0, r0, r5, lsr r5
    29e0:	ef026205 	svc	0x00026205
    29e4:	70000000 	andvc	r0, r0, r0
    29e8:	00007f16 	andeq	r7, r0, r6, lsl pc
    29ec:	02630500 	rsbeq	r0, r3, #0, 10
    29f0:	000000ef 	andeq	r0, r0, pc, ror #1
    29f4:	04ed1678 	strbteq	r1, [sp], #1656	; 0x678
    29f8:	64050000 	strvs	r0, [r5], #-0
    29fc:	00078d02 	andeq	r8, r7, r2, lsl #26
    2a00:	c4168000 	ldrgt	r8, [r6], #-0
    2a04:	05000002 	streq	r0, [r0, #-2]
    2a08:	079d0265 	ldreq	r0, [sp, r5, ror #4]
    2a0c:	16880000 	strne	r0, [r8], r0
    2a10:	000004a9 	andeq	r0, r0, r9, lsr #9
    2a14:	2c026605 	stccs	6, cr6, [r2], {5}
    2a18:	a0000000 	andge	r0, r0, r0
    2a1c:	00011716 	andeq	r1, r1, r6, lsl r7
    2a20:	02670500 	rsbeq	r0, r7, #0, 10
    2a24:	000000ef 	andeq	r0, r0, pc, ror #1
    2a28:	006b16a4 	rsbeq	r1, fp, r4, lsr #13
    2a2c:	68050000 	stmdavs	r5, {}	; <UNPREDICTABLE>
    2a30:	0000ef02 	andeq	lr, r0, r2, lsl #30
    2a34:	0616ac00 	ldreq	sl, [r6], -r0, lsl #24
    2a38:	05000001 	streq	r0, [r0, #-1]
    2a3c:	00ef0269 	rsceq	r0, pc, r9, ror #4
    2a40:	16b40000 	ldrtne	r0, [r4], r0
    2a44:	0000002b 	andeq	r0, r0, fp, lsr #32
    2a48:	ef026a05 	svc	0x00026a05
    2a4c:	bc000000 	stclt	0, cr0, [r0], {-0}
    2a50:	00003a16 	andeq	r3, r0, r6, lsl sl
    2a54:	026b0500 	rsbeq	r0, fp, #0, 10
    2a58:	000000ef 	andeq	r0, r0, pc, ror #1
    2a5c:	03b016c4 	movseq	r1, #196, 12	; 0xc400000
    2a60:	6c050000 	stcvs	0, cr0, [r5], {-0}
    2a64:	00002c02 	andeq	r2, r0, r2, lsl #24
    2a68:	0800cc00 	stmdaeq	r0, {sl, fp, lr, pc}
    2a6c:	00000550 	andeq	r0, r0, r0, asr r5
    2a70:	0000078d 	andeq	r0, r0, sp, lsl #15
    2a74:	0000c709 	andeq	ip, r0, r9, lsl #14
    2a78:	08001900 	stmdaeq	r0, {r8, fp, ip}
    2a7c:	00000550 	andeq	r0, r0, r0, asr r5
    2a80:	0000079d 	muleq	r0, sp, r7
    2a84:	0000c709 	andeq	ip, r0, r9, lsl #14
    2a88:	08000700 	stmdaeq	r0, {r8, r9, sl}
    2a8c:	00000550 	andeq	r0, r0, r0, asr r5
    2a90:	000007ad 	andeq	r0, r0, sp, lsr #15
    2a94:	0000c709 	andeq	ip, r0, r9, lsl #14
    2a98:	1a001700 	bne	86a0 <_sbrk+0x8>
    2a9c:	027105f0 	rsbseq	r0, r1, #240, 10	; 0x3c000000
    2aa0:	000007d1 	ldrdeq	r0, [r0], -r1
    2aa4:	00031416 	andeq	r1, r3, r6, lsl r4
    2aa8:	02740500 	rsbseq	r0, r4, #0, 10
    2aac:	000007d1 	ldrdeq	r0, [r0], -r1
    2ab0:	04e41600 	strbteq	r1, [r4], #1536	; 0x600
    2ab4:	75050000 	strvc	r0, [r5, #-0]
    2ab8:	0007e102 	andeq	lr, r7, r2, lsl #2
    2abc:	08007800 	stmdaeq	r0, {fp, ip, sp, lr}
    2ac0:	000002c4 	andeq	r0, r0, r4, asr #5
    2ac4:	000007e1 	andeq	r0, r0, r1, ror #15
    2ac8:	0000c709 	andeq	ip, r0, r9, lsl #14
    2acc:	08001d00 	stmdaeq	r0, {r8, sl, fp, ip}
    2ad0:	00000025 	andeq	r0, r0, r5, lsr #32
    2ad4:	000007f1 	strdeq	r0, [r0], -r1
    2ad8:	0000c709 	andeq	ip, r0, r9, lsl #14
    2adc:	1b001d00 	blne	9ee4 <_malloc_r+0x1c0>
    2ae0:	025605f0 	subseq	r0, r6, #240, 10	; 0x3c000000
    2ae4:	00000813 	andeq	r0, r0, r3, lsl r8
    2ae8:	0009d91c 	andeq	sp, r9, ip, lsl r9
    2aec:	026d0500 	rsbeq	r0, sp, #0, 10
    2af0:	0000067c 	andeq	r0, r0, ip, ror r6
    2af4:	0005071c 	andeq	r0, r5, ip, lsl r7
    2af8:	02760500 	rsbseq	r0, r6, #0, 10
    2afc:	000007ad 	andeq	r0, r0, sp, lsr #15
    2b00:	05500800 	ldrbeq	r0, [r0, #-2048]	; 0x800
    2b04:	08230000 	stmdaeq	r3!, {}	; <UNPREDICTABLE>
    2b08:	c7090000 	strgt	r0, [r9, -r0]
    2b0c:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    2b10:	082e1d00 	stmdaeq	lr!, {r8, sl, fp, ip}
    2b14:	12140000 	andsne	r0, r4, #0
    2b18:	00000004 	andeq	r0, r0, r4
    2b1c:	0823040f 	stmdaeq	r3!, {r0, r1, r2, r3, sl}
    2b20:	040f0000 	streq	r0, [pc], #-0	; 2b28 <CPSR_IRQ_INHIBIT+0x2aa8>
    2b24:	00000165 	andeq	r0, r0, r5, ror #2
    2b28:	0008451d 	andeq	r4, r8, sp, lsl r5
    2b2c:	002c1400 	eoreq	r1, ip, r0, lsl #8
    2b30:	0f000000 	svceq	0x00000000
    2b34:	00084b04 	andeq	r4, r8, r4, lsl #22
    2b38:	3a040f00 	bcc	106740 <_stack+0x86740>
    2b3c:	08000008 	stmdaeq	r0, {r3}
    2b40:	000005ea 	andeq	r0, r0, sl, ror #11
    2b44:	00000861 	andeq	r0, r0, r1, ror #16
    2b48:	0000c709 	andeq	ip, r0, r9, lsl #14
    2b4c:	1e000200 	cdpne	2, 0, cr0, cr0, cr0, {0}
    2b50:	00000936 	andeq	r0, r0, r6, lsr r9
    2b54:	a3dc2101 	bicsge	r2, ip, #1073741824	; 0x40000000
    2b58:	001a0000 	andseq	r0, sl, r0
    2b5c:	9c010000 	stcls	0, cr0, [r1], {-0}
    2b60:	000008c1 	andeq	r0, r0, r1, asr #17
    2b64:	7274701f 	rsbsvc	r7, r4, #31
    2b68:	12210100 	eorne	r0, r1, #0, 2
    2b6c:	25000004 	strcs	r0, [r0, #-4]
    2b70:	20000012 	andcs	r0, r0, r2, lsl r0
    2b74:	0000093e 	andeq	r0, r0, lr, lsr r9
    2b78:	062b2101 	strteq	r2, [fp], -r1, lsl #2
    2b7c:	125c0000 	subsne	r0, ip, #0
    2b80:	ea210000 	b	842b88 <_stack+0x7c2b88>
    2b84:	610000a3 	smlatbvs	r0, r3, r0, r0
    2b88:	a8000008 	stmdage	r0, {r3}
    2b8c:	22000008 	andcs	r0, r0, #8
    2b90:	75025001 	strvc	r5, [r2, #-1]
    2b94:	f6230000 			; <UNDEFINED> instruction: 0xf6230000
    2b98:	e80000a3 	stmda	r0, {r0, r1, r5, r7}
    2b9c:	22000009 	andcs	r0, r0, #9
    2ba0:	f3035101 	vrhadd.u8	d5, d3, d1
    2ba4:	01225101 	teqeq	r2, r1, lsl #2
    2ba8:	01f30350 	mvnseq	r0, r0, asr r3
    2bac:	24000050 	strcs	r0, [r0], #-80	; 0x50
    2bb0:	000009d1 	ldrdeq	r0, [r0], -r1
    2bb4:	f802fd05 			; <UNDEFINED> instruction: 0xf802fd05
    2bb8:	900000a3 	andls	r0, r0, r3, lsr #1
    2bbc:	01000000 	mrseq	r0, (UNDEF: 0)
    2bc0:	0009cb9c 	muleq	r9, ip, fp
    2bc4:	74701f00 	ldrbtvc	r1, [r0], #-3840	; 0xf00
    2bc8:	2d010072 	stccs	0, cr0, [r1, #-456]	; 0xfffffe38
    2bcc:	00000412 	andeq	r0, r0, r2, lsl r4
    2bd0:	00001293 	muleq	r0, r3, r2
    2bd4:	00008825 	andeq	r8, r0, r5, lsr #16
    2bd8:	00094900 	andeq	r4, r9, r0, lsl #18
    2bdc:	00692600 	rsbeq	r2, r9, r0, lsl #12
    2be0:	002c3901 	eoreq	r3, ip, r1, lsl #18
    2be4:	12ca0000 	sbcne	r0, sl, #0
    2be8:	12270000 	eorne	r0, r7, #0
    2bec:	180000a4 	stmdane	r0, {r2, r5, r7}
    2bf0:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
    2bf4:	28000009 	stmdacs	r0, {r0, r3}
    2bf8:	000009c9 	andeq	r0, r0, r9, asr #19
    2bfc:	01653c01 	cmneq	r5, r1, lsl #24
    2c00:	12dd0000 	sbcsne	r0, sp, #0
    2c04:	2e280000 	cdpcs	0, 2, cr0, cr8, cr0, {0}
    2c08:	01000009 	tsteq	r0, r9
    2c0c:	0001653c 	andeq	r6, r1, ip, lsr r5
    2c10:	0012f000 	andseq	pc, r2, r0
    2c14:	a4242900 	strtge	r2, [r4], #-2304	; 0x900
    2c18:	09e80000 	stmibeq	r8!, {}^	; <UNPREDICTABLE>
    2c1c:	01220000 	teqeq	r2, r0
    2c20:	00750250 	rsbseq	r0, r5, r0, asr r2
    2c24:	3a290000 	bcc	a42c2c <_stack+0x9c2c2c>
    2c28:	e80000a4 	stmda	r0, {r2, r5, r7}
    2c2c:	22000009 	andcs	r0, r0, #9
    2c30:	75025001 	strvc	r5, [r2, #-1]
    2c34:	27000000 	strcs	r0, [r0, -r0]
    2c38:	0000a452 	andeq	sl, r0, r2, asr r4
    2c3c:	0000000e 	andeq	r0, r0, lr
    2c40:	00000981 	andeq	r0, r0, r1, lsl #19
    2c44:	01007026 	tsteq	r0, r6, lsr #32
    2c48:	00028268 	andeq	r8, r2, r8, ror #4
    2c4c:	00132400 	andseq	r2, r3, r0, lsl #8
    2c50:	00712600 	rsbseq	r2, r1, r0, lsl #12
    2c54:	02826801 	addeq	r6, r2, #65536	; 0x10000
    2c58:	13420000 	movtne	r0, #8192	; 0x2000
    2c5c:	5a290000 	bpl	a42c64 <_stack+0x9c2c64>
    2c60:	e80000a4 	stmda	r0, {r2, r5, r7}
    2c64:	22000009 	andcs	r0, r0, #9
    2c68:	75025001 	strvc	r5, [r2, #-1]
    2c6c:	21000000 	mrscs	r0, (UNDEF: 0)
    2c70:	0000a444 	andeq	sl, r0, r4, asr #8
    2c74:	000009e8 	andeq	r0, r0, r8, ror #19
    2c78:	00000995 	muleq	r0, r5, r9
    2c7c:	02500122 	subseq	r0, r0, #-2147483640	; 0x80000008
    2c80:	21000075 	tstcs	r0, r5, ror r0
    2c84:	0000a46a 	andeq	sl, r0, sl, ror #8
    2c88:	000009e8 	andeq	r0, r0, r8, ror #19
    2c8c:	000009a9 	andeq	r0, r0, r9, lsr #19
    2c90:	02500122 	subseq	r0, r0, #-2147483640	; 0x80000008
    2c94:	2a000075 	bcs	2e70 <CPSR_IRQ_INHIBIT+0x2df0>
    2c98:	0000a476 	andeq	sl, r0, r6, ror r4
    2c9c:	000009b9 			; <UNDEFINED> instruction: 0x000009b9
    2ca0:	02500122 	subseq	r0, r0, #-2147483640	; 0x80000008
    2ca4:	23000075 	movwcs	r0, #117	; 0x75
    2ca8:	0000a488 	andeq	sl, r0, r8, lsl #9
    2cac:	00000861 	andeq	r0, r0, r1, ror #16
    2cb0:	03500122 	cmpeq	r0, #-2147483640	; 0x80000008
    2cb4:	005001f3 	ldrsheq	r0, [r0], #-19	; 0xffffffed
    2cb8:	0ada2b00 	beq	ff68d8c0 <STACK_SVR+0xfb68d8c0>
    2cbc:	fa050000 	blx	142cc4 <_stack+0xc2cc4>
    2cc0:	00041202 	andeq	r1, r4, r2, lsl #4
    2cc4:	03b32c00 			; <UNDEFINED> instruction: 0x03b32c00
    2cc8:	1a010000 	bne	42cd0 <__bss_end__+0x2ec88>
    2ccc:	0000002c 	andeq	r0, r0, ip, lsr #32
    2cd0:	40440305 	submi	r0, r4, r5, lsl #6
    2cd4:	952d0001 	strls	r0, [sp, #-1]!
    2cd8:	06000003 	streq	r0, [r0], -r3
    2cdc:	041214e1 	ldreq	r1, [r2], #-1249	; 0x4e1
    2ce0:	05140000 	ldreq	r0, [r4, #-0]
    2ce4:	00000001 	andeq	r0, r0, r1
    2ce8:	0008f000 	andeq	pc, r8, r0
    2cec:	00000400 	andeq	r0, r0, r0, lsl #8
    2cf0:	0400000a 	streq	r0, [r0], #-10
    2cf4:	00014101 	andeq	r4, r1, r1, lsl #2
    2cf8:	09e50100 	stmibeq	r5!, {r8}^
    2cfc:	09750000 	ldmdbeq	r5!, {}^	; <UNPREDICTABLE>
    2d00:	00b80000 	adcseq	r0, r8, r0
    2d04:	00000000 	andeq	r0, r0, r0
    2d08:	0a160000 	beq	582d10 <_stack+0x502d10>
    2d0c:	01020000 	mrseq	r0, (UNDEF: 2)
    2d10:	02000006 	andeq	r0, r0, #6
    2d14:	00003093 	muleq	r0, r3, r0
    2d18:	05040300 	streq	r0, [r4, #-768]	; 0x300
    2d1c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    2d20:	55070404 	strpl	r0, [r7, #-1028]	; 0x404
    2d24:	04000000 	streq	r0, [r0], #-0
    2d28:	039f0601 	orrseq	r0, pc, #1048576	; 0x100000
    2d2c:	01040000 	mrseq	r0, (UNDEF: 4)
    2d30:	00039d08 	andeq	r9, r3, r8, lsl #26
    2d34:	05020400 	streq	r0, [r2, #-1024]	; 0x400
    2d38:	000003b9 			; <UNDEFINED> instruction: 0x000003b9
    2d3c:	a8070204 	stmdage	r7, {r2, r9}
    2d40:	04000002 	streq	r0, [r0], #-2
    2d44:	009b0504 	addseq	r0, fp, r4, lsl #10
    2d48:	04040000 	streq	r0, [r4], #-0
    2d4c:	00005007 	andeq	r5, r0, r7
    2d50:	05080400 	streq	r0, [r8, #-1024]	; 0x400
    2d54:	00000096 	muleq	r0, r6, r0
    2d58:	4b070804 	blmi	1c4d70 <_stack+0x144d70>
    2d5c:	02000000 	andeq	r0, r0, #0
    2d60:	0000034f 	andeq	r0, r0, pc, asr #6
    2d64:	00300703 	eorseq	r0, r0, r3, lsl #14
    2d68:	37020000 	strcc	r0, [r2, -r0]
    2d6c:	04000003 	streq	r0, [r0], #-3
    2d70:	00005a10 	andeq	r5, r0, r0, lsl sl
    2d74:	04670200 	strbteq	r0, [r7], #-512	; 0x200
    2d78:	27040000 	strcs	r0, [r4, -r0]
    2d7c:	0000005a 	andeq	r0, r0, sl, asr r0
    2d80:	0002eb05 	andeq	lr, r2, r5, lsl #22
    2d84:	01610200 	cmneq	r1, r0, lsl #4
    2d88:	00000037 	andeq	r0, r0, r7, lsr r0
    2d8c:	4a040406 	bmi	103dac <_stack+0x83dac>
    2d90:	000000c2 	andeq	r0, r0, r2, asr #1
    2d94:	0002e507 	andeq	lr, r2, r7, lsl #10
    2d98:	974c0400 	strbls	r0, [ip, -r0, lsl #8]
    2d9c:	07000000 	streq	r0, [r0, -r0]
    2da0:	0000022f 	andeq	r0, r0, pc, lsr #4
    2da4:	00c24d04 	sbceq	r4, r2, r4, lsl #26
    2da8:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    2dac:	00000045 	andeq	r0, r0, r5, asr #32
    2db0:	000000d2 	ldrdeq	r0, [r0], -r2
    2db4:	0000d209 	andeq	sp, r0, r9, lsl #4
    2db8:	04000300 	streq	r0, [r0], #-768	; 0x300
    2dbc:	030b0704 	movweq	r0, #46852	; 0xb704
    2dc0:	080a0000 	stmdaeq	sl, {}	; <UNPREDICTABLE>
    2dc4:	00fa4704 	rscseq	r4, sl, r4, lsl #14
    2dc8:	510b0000 	mrspl	r0, (UNDEF: 11)
    2dcc:	04000004 	streq	r0, [r0], #-4
    2dd0:	00003049 	andeq	r3, r0, r9, asr #32
    2dd4:	590b0000 	stmdbpl	fp, {}	; <UNPREDICTABLE>
    2dd8:	04000004 	streq	r0, [r0], #-4
    2ddc:	0000a34e 	andeq	sl, r0, lr, asr #6
    2de0:	02000400 	andeq	r0, r0, #0, 8
    2de4:	000003e1 	andeq	r0, r0, r1, ror #7
    2de8:	00d94f04 	sbcseq	r4, r9, r4, lsl #30
    2dec:	38020000 	stmdacc	r2, {}	; <UNPREDICTABLE>
    2df0:	04000001 	streq	r0, [r0], #-1
    2df4:	00007653 	andeq	r7, r0, r3, asr r6
    2df8:	02040c00 	andeq	r0, r4, #0, 24
    2dfc:	000004a1 	andeq	r0, r0, r1, lsr #9
    2e00:	00611605 	rsbeq	r1, r1, r5, lsl #12
    2e04:	030d0000 	movweq	r0, #53248	; 0xd000
    2e08:	18000002 	stmdane	r0, {r1}
    2e0c:	01702d05 	cmneq	r0, r5, lsl #26
    2e10:	020b0000 	andeq	r0, fp, #0
    2e14:	05000004 	streq	r0, [r0, #-4]
    2e18:	0001702f 	andeq	r7, r1, pc, lsr #32
    2e1c:	5f0e0000 	svcpl	0x000e0000
    2e20:	3005006b 	andcc	r0, r5, fp, rrx
    2e24:	00000030 	andeq	r0, r0, r0, lsr r0
    2e28:	04430b04 	strbeq	r0, [r3], #-2820	; 0xb04
    2e2c:	30050000 	andcc	r0, r5, r0
    2e30:	00000030 	andeq	r0, r0, r0, lsr r0
    2e34:	01320b08 	teqeq	r2, r8, lsl #22
    2e38:	30050000 	andcc	r0, r5, r0
    2e3c:	00000030 	andeq	r0, r0, r0, lsr r0
    2e40:	04d50b0c 	ldrbeq	r0, [r5], #2828	; 0xb0c
    2e44:	30050000 	andcc	r0, r5, r0
    2e48:	00000030 	andeq	r0, r0, r0, lsr r0
    2e4c:	785f0e10 	ldmdavc	pc, {r4, r9, sl, fp}^	; <UNPREDICTABLE>
    2e50:	76310500 	ldrtvc	r0, [r1], -r0, lsl #10
    2e54:	14000001 	strne	r0, [r0], #-1
    2e58:	1d040f00 	stcne	15, cr0, [r4, #-0]
    2e5c:	08000001 	stmdaeq	r0, {r0}
    2e60:	00000112 	andeq	r0, r0, r2, lsl r1
    2e64:	00000186 	andeq	r0, r0, r6, lsl #3
    2e68:	0000d209 	andeq	sp, r0, r9, lsl #4
    2e6c:	0d000000 	stceq	0, cr0, [r0, #-0]
    2e70:	0000022a 	andeq	r0, r0, sl, lsr #4
    2e74:	ff350524 			; <UNDEFINED> instruction: 0xff350524
    2e78:	0b000001 	bleq	2e84 <CPSR_IRQ_INHIBIT+0x2e04>
    2e7c:	0000008d 	andeq	r0, r0, sp, lsl #1
    2e80:	00303705 	eorseq	r3, r0, r5, lsl #14
    2e84:	0b000000 	bleq	2e8c <CPSR_IRQ_INHIBIT+0x2e0c>
    2e88:	0000046f 	andeq	r0, r0, pc, ror #8
    2e8c:	00303805 	eorseq	r3, r0, r5, lsl #16
    2e90:	0b040000 	bleq	102e98 <_stack+0x82e98>
    2e94:	000000aa 	andeq	r0, r0, sl, lsr #1
    2e98:	00303905 	eorseq	r3, r0, r5, lsl #18
    2e9c:	0b080000 	bleq	202ea4 <_stack+0x182ea4>
    2ea0:	00000548 	andeq	r0, r0, r8, asr #10
    2ea4:	00303a05 	eorseq	r3, r0, r5, lsl #20
    2ea8:	0b0c0000 	bleq	302eb0 <_stack+0x282eb0>
    2eac:	0000031b 	andeq	r0, r0, fp, lsl r3
    2eb0:	00303b05 	eorseq	r3, r0, r5, lsl #22
    2eb4:	0b100000 	bleq	402ebc <_stack+0x382ebc>
    2eb8:	00000301 	andeq	r0, r0, r1, lsl #6
    2ebc:	00303c05 	eorseq	r3, r0, r5, lsl #24
    2ec0:	0b140000 	bleq	502ec8 <_stack+0x482ec8>
    2ec4:	000004da 	ldrdeq	r0, [r0], -sl
    2ec8:	00303d05 	eorseq	r3, r0, r5, lsl #26
    2ecc:	0b180000 	bleq	602ed4 <_stack+0x582ed4>
    2ed0:	000003c3 	andeq	r0, r0, r3, asr #7
    2ed4:	00303e05 	eorseq	r3, r0, r5, lsl #28
    2ed8:	0b1c0000 	bleq	702ee0 <_stack+0x682ee0>
    2edc:	0000050f 	andeq	r0, r0, pc, lsl #10
    2ee0:	00303f05 	eorseq	r3, r0, r5, lsl #30
    2ee4:	00200000 	eoreq	r0, r0, r0
    2ee8:	0000b910 	andeq	fp, r0, r0, lsl r9
    2eec:	05010800 	streq	r0, [r1, #-2048]	; 0x800
    2ef0:	00023f48 	andeq	r3, r2, r8, asr #30
    2ef4:	01250b00 	teqeq	r5, r0, lsl #22
    2ef8:	49050000 	stmdbmi	r5, {}	; <UNPREDICTABLE>
    2efc:	0000023f 	andeq	r0, r0, pc, lsr r2
    2f00:	00000b00 	andeq	r0, r0, r0, lsl #22
    2f04:	4a050000 	bmi	142f0c <_stack+0xc2f0c>
    2f08:	0000023f 	andeq	r0, r0, pc, lsr r2
    2f0c:	04931180 	ldreq	r1, [r3], #384	; 0x180
    2f10:	4c050000 	stcmi	0, cr0, [r5], {-0}
    2f14:	00000112 	andeq	r0, r0, r2, lsl r1
    2f18:	de110100 	mufles	f0, f1, f0
    2f1c:	05000000 	streq	r0, [r0, #-0]
    2f20:	0001124f 	andeq	r1, r1, pc, asr #4
    2f24:	00010400 	andeq	r0, r1, r0, lsl #8
    2f28:	00011008 	andeq	r1, r1, r8
    2f2c:	00024f00 	andeq	r4, r2, r0, lsl #30
    2f30:	00d20900 	sbcseq	r0, r2, r0, lsl #18
    2f34:	001f0000 	andseq	r0, pc, r0
    2f38:	00032410 	andeq	r2, r3, r0, lsl r4
    2f3c:	05019000 	streq	r9, [r1, #-0]
    2f40:	00028d5b 	andeq	r8, r2, fp, asr sp
    2f44:	04020b00 	streq	r0, [r2], #-2816	; 0xb00
    2f48:	5c050000 	stcpl	0, cr0, [r5], {-0}
    2f4c:	0000028d 	andeq	r0, r0, sp, lsl #5
    2f50:	041a0b00 	ldreq	r0, [sl], #-2816	; 0xb00
    2f54:	5d050000 	stcpl	0, cr0, [r5, #-0]
    2f58:	00000030 	andeq	r0, r0, r0, lsr r0
    2f5c:	012d0b04 	teqeq	sp, r4, lsl #22
    2f60:	5f050000 	svcpl	0x00050000
    2f64:	00000293 	muleq	r0, r3, r2
    2f68:	00b90b08 	adcseq	r0, r9, r8, lsl #22
    2f6c:	60050000 	andvs	r0, r5, r0
    2f70:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    2f74:	040f0088 	streq	r0, [pc], #-136	; 2f7c <CPSR_IRQ_INHIBIT+0x2efc>
    2f78:	0000024f 	andeq	r0, r0, pc, asr #4
    2f7c:	0002a308 	andeq	sl, r2, r8, lsl #6
    2f80:	0002a300 	andeq	sl, r2, r0, lsl #6
    2f84:	00d20900 	sbcseq	r0, r2, r0, lsl #18
    2f88:	001f0000 	andseq	r0, pc, r0
    2f8c:	02a9040f 	adceq	r0, r9, #251658240	; 0xf000000
    2f90:	0d120000 	ldceq	0, cr0, [r2, #-0]
    2f94:	000003cd 	andeq	r0, r0, sp, asr #7
    2f98:	cf730508 	svcgt	0x00730508
    2f9c:	0b000002 	bleq	2fac <CPSR_IRQ_INHIBIT+0x2f2c>
    2fa0:	00000761 	andeq	r0, r0, r1, ror #14
    2fa4:	02cf7405 	sbceq	r7, pc, #83886080	; 0x5000000
    2fa8:	0b000000 	bleq	2fb0 <CPSR_IRQ_INHIBIT+0x2f30>
    2fac:	00000618 	andeq	r0, r0, r8, lsl r6
    2fb0:	00307505 	eorseq	r7, r0, r5, lsl #10
    2fb4:	00040000 	andeq	r0, r4, r0
    2fb8:	0045040f 	subeq	r0, r5, pc, lsl #8
    2fbc:	ec0d0000 	stc	0, cr0, [sp], {-0}
    2fc0:	68000003 	stmdavs	r0, {r0, r1}
    2fc4:	03ffb305 	mvnseq	fp, #335544320	; 0x14000000
    2fc8:	5f0e0000 	svcpl	0x000e0000
    2fcc:	b4050070 	strlt	r0, [r5], #-112	; 0x70
    2fd0:	000002cf 	andeq	r0, r0, pc, asr #5
    2fd4:	725f0e00 	subsvc	r0, pc, #0, 28
    2fd8:	30b50500 	adcscc	r0, r5, r0, lsl #10
    2fdc:	04000000 	streq	r0, [r0], #-0
    2fe0:	00775f0e 	rsbseq	r5, r7, lr, lsl #30
    2fe4:	0030b605 	eorseq	fp, r0, r5, lsl #12
    2fe8:	0b080000 	bleq	202ff0 <_stack+0x182ff0>
    2fec:	000000d7 	ldrdeq	r0, [r0], -r7
    2ff0:	004cb705 	subeq	fp, ip, r5, lsl #14
    2ff4:	0b0c0000 	bleq	302ffc <_stack+0x282ffc>
    2ff8:	00000246 	andeq	r0, r0, r6, asr #4
    2ffc:	004cb805 	subeq	fp, ip, r5, lsl #16
    3000:	0e0e0000 	cdpeq	0, 0, cr0, cr14, cr0, {0}
    3004:	0066625f 	rsbeq	r6, r6, pc, asr r2
    3008:	02aab905 	adceq	fp, sl, #81920	; 0x14000
    300c:	0b100000 	bleq	403014 <_stack+0x383014>
    3010:	00000062 	andeq	r0, r0, r2, rrx
    3014:	0030ba05 	eorseq	fp, r0, r5, lsl #20
    3018:	0b180000 	bleq	603020 <_stack+0x583020>
    301c:	000000c7 	andeq	r0, r0, r7, asr #1
    3020:	0110c105 	tsteq	r0, r5, lsl #2
    3024:	0b1c0000 	bleq	70302c <_stack+0x68302c>
    3028:	0000021a 	andeq	r0, r0, sl, lsl r2
    302c:	0562c305 	strbeq	ip, [r2, #-773]!	; 0x305
    3030:	0b200000 	bleq	803038 <_stack+0x783038>
    3034:	000002fa 	strdeq	r0, [r0], -sl
    3038:	0591c505 	ldreq	ip, [r1, #1285]	; 0x505
    303c:	0b240000 	bleq	903044 <_stack+0x883044>
    3040:	00000461 	andeq	r0, r0, r1, ror #8
    3044:	05b5c805 	ldreq	ip, [r5, #2053]!	; 0x805
    3048:	0b280000 	bleq	a03050 <_stack+0x983050>
    304c:	00000529 	andeq	r0, r0, r9, lsr #10
    3050:	05cfc905 	strbeq	ip, [pc, #2309]	; 395d <CPSR_IRQ_INHIBIT+0x38dd>
    3054:	0e2c0000 	cdpeq	0, 2, cr0, cr12, cr0, {0}
    3058:	0062755f 	rsbeq	r7, r2, pc, asr r5
    305c:	02aacc05 	adceq	ip, sl, #1280	; 0x500
    3060:	0e300000 	cdpeq	0, 3, cr0, cr0, cr0, {0}
    3064:	0070755f 	rsbseq	r7, r0, pc, asr r5
    3068:	02cfcd05 	sbceq	ip, pc, #320	; 0x140
    306c:	0e380000 	cdpeq	0, 3, cr0, cr8, cr0, {0}
    3070:	0072755f 	rsbseq	r7, r2, pc, asr r5
    3074:	0030ce05 	eorseq	ip, r0, r5, lsl #28
    3078:	0b3c0000 	bleq	f03080 <_stack+0xe83080>
    307c:	000000a4 	andeq	r0, r0, r4, lsr #1
    3080:	05d5d105 	ldrbeq	sp, [r5, #261]	; 0x105
    3084:	0b400000 	bleq	100308c <_stack+0xf8308c>
    3088:	00000501 	andeq	r0, r0, r1, lsl #10
    308c:	05e5d205 	strbeq	sp, [r5, #517]!	; 0x205
    3090:	0e430000 	cdpeq	0, 4, cr0, cr3, cr0, {0}
    3094:	00626c5f 	rsbeq	r6, r2, pc, asr ip
    3098:	02aad505 	adceq	sp, sl, #20971520	; 0x1400000
    309c:	0b440000 	bleq	11030a4 <_stack+0x10830a4>
    30a0:	000000ed 	andeq	r0, r0, sp, ror #1
    30a4:	0030d805 	eorseq	sp, r0, r5, lsl #16
    30a8:	0b4c0000 	bleq	13030b0 <_stack+0x12830b0>
    30ac:	000000fe 	strdeq	r0, [r0], -lr
    30b0:	0081d905 	addeq	sp, r1, r5, lsl #18
    30b4:	0b500000 	bleq	14030bc <_stack+0x13830bc>
    30b8:	00000a9a 	muleq	r0, sl, sl
    30bc:	041ddc05 	ldreq	sp, [sp], #-3077	; 0xc05
    30c0:	0b540000 	bleq	15030c8 <_stack+0x14830c8>
    30c4:	000005fb 	strdeq	r0, [r0], -fp
    30c8:	0105e005 	tsteq	r5, r5
    30cc:	0b580000 	bleq	16030d4 <_stack+0x15830d4>
    30d0:	000003f4 	strdeq	r0, [r0], -r4
    30d4:	00fae205 	rscseq	lr, sl, r5, lsl #4
    30d8:	0b5c0000 	bleq	17030e0 <_stack+0x16830e0>
    30dc:	000002f2 	strdeq	r0, [r0], -r2
    30e0:	0030e305 	eorseq	lr, r0, r5, lsl #6
    30e4:	00640000 	rsbeq	r0, r4, r0
    30e8:	00003013 	andeq	r3, r0, r3, lsl r0
    30ec:	00041d00 	andeq	r1, r4, r0, lsl #26
    30f0:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
    30f4:	10140000 	andsne	r0, r4, r0
    30f8:	14000001 	strne	r0, [r0], #-1
    30fc:	00000555 	andeq	r0, r0, r5, asr r5
    3100:	00003014 	andeq	r3, r0, r4, lsl r0
    3104:	040f0000 	streq	r0, [pc], #-0	; 310c <CPSR_IRQ_INHIBIT+0x308c>
    3108:	00000423 	andeq	r0, r0, r3, lsr #8
    310c:	0009d915 	andeq	sp, r9, r5, lsl r9
    3110:	05042800 	streq	r2, [r4, #-2048]	; 0x800
    3114:	05550239 	ldrbeq	r0, [r5, #-569]	; 0x239
    3118:	b2160000 	andslt	r0, r6, #0
    311c:	05000003 	streq	r0, [r0, #-3]
    3120:	0030023b 	eorseq	r0, r0, fp, lsr r2
    3124:	16000000 	strne	r0, [r0], -r0
    3128:	000000e6 	andeq	r0, r0, r6, ror #1
    312c:	3c024005 	stccc	0, cr4, [r2], {5}
    3130:	04000006 	streq	r0, [r0], #-6
    3134:	00023616 	andeq	r3, r2, r6, lsl r6
    3138:	02400500 	subeq	r0, r0, #0, 10
    313c:	0000063c 	andeq	r0, r0, ip, lsr r6
    3140:	047e1608 	ldrbteq	r1, [lr], #-1544	; 0x608
    3144:	40050000 	andmi	r0, r5, r0
    3148:	00063c02 	andeq	r3, r6, r2, lsl #24
    314c:	15160c00 	ldrne	r0, [r6, #-3072]	; 0xc00
    3150:	05000004 	streq	r0, [r0, #-4]
    3154:	00300242 	eorseq	r0, r0, r2, asr #4
    3158:	16100000 	ldrne	r0, [r0], -r0
    315c:	00000020 	andeq	r0, r0, r0, lsr #32
    3160:	1e024305 	cdpne	3, 0, cr4, cr2, cr5, {0}
    3164:	14000008 	strne	r0, [r0], #-8
    3168:	0004b616 	andeq	fp, r4, r6, lsl r6
    316c:	02450500 	subeq	r0, r5, #0, 10
    3170:	00000030 	andeq	r0, r0, r0, lsr r0
    3174:	041f1630 	ldreq	r1, [pc], #-1584	; 317c <CPSR_IRQ_INHIBIT+0x30fc>
    3178:	46050000 	strmi	r0, [r5], -r0
    317c:	00058602 	andeq	r8, r5, r2, lsl #12
    3180:	2c163400 	cfldrscs	mvf3, [r6], {-0}
    3184:	05000003 	streq	r0, [r0, #-3]
    3188:	00300248 	eorseq	r0, r0, r8, asr #4
    318c:	16380000 	ldrtne	r0, [r8], -r0
    3190:	00000439 	andeq	r0, r0, r9, lsr r4
    3194:	39024a05 	stmdbcc	r2, {r0, r2, r9, fp, lr}
    3198:	3c000008 	stccc	0, cr0, [r0], {8}
    319c:	0002dd16 	andeq	sp, r2, r6, lsl sp
    31a0:	024d0500 	subeq	r0, sp, #0, 10
    31a4:	00000170 	andeq	r0, r0, r0, ror r1
    31a8:	02201640 	eoreq	r1, r0, #64, 12	; 0x4000000
    31ac:	4e050000 	cdpmi	0, 0, cr0, cr5, cr0, {0}
    31b0:	00003002 	andeq	r3, r0, r2
    31b4:	43164400 	tstmi	r6, #0, 8
    31b8:	05000005 	streq	r0, [r0, #-5]
    31bc:	0170024f 	cmneq	r0, pc, asr #4
    31c0:	16480000 	strbne	r0, [r8], -r0
    31c4:	0000033e 	andeq	r0, r0, lr, lsr r3
    31c8:	3f025005 	svccc	0x00025005
    31cc:	4c000008 	stcmi	0, cr0, [r0], {8}
    31d0:	00023e16 	andeq	r3, r2, r6, lsl lr
    31d4:	02530500 	subseq	r0, r3, #0, 10
    31d8:	00000030 	andeq	r0, r0, r0, lsr r0
    31dc:	00f61650 	rscseq	r1, r6, r0, asr r6
    31e0:	54050000 	strpl	r0, [r5], #-0
    31e4:	00055502 	andeq	r5, r5, r2, lsl #10
    31e8:	ab165400 	blge	5981f0 <_stack+0x5181f0>
    31ec:	05000003 	streq	r0, [r0, #-3]
    31f0:	07fc0277 			; <UNDEFINED> instruction: 0x07fc0277
    31f4:	17580000 	ldrbne	r0, [r8, -r0]
    31f8:	00000324 	andeq	r0, r0, r4, lsr #6
    31fc:	8d027b05 	vstrhi	d7, [r2, #-20]	; 0xffffffec
    3200:	48000002 	stmdami	r0, {r1}
    3204:	02bb1701 	adcseq	r1, fp, #262144	; 0x40000
    3208:	7c050000 	stcvc	0, cr0, [r5], {-0}
    320c:	00024f02 	andeq	r4, r2, r2, lsl #30
    3210:	17014c00 	strne	r4, [r1, -r0, lsl #24]
    3214:	000004f7 	strdeq	r0, [r0], -r7
    3218:	50028005 	andpl	r8, r2, r5
    321c:	dc000008 	stcle	0, cr0, [r0], {8}
    3220:	00cf1702 	sbceq	r1, pc, r2, lsl #14
    3224:	85050000 	strhi	r0, [r5, #-0]
    3228:	00060102 	andeq	r0, r6, r2, lsl #2
    322c:	1702e000 	strne	lr, [r2, -r0]
    3230:	000000b4 	strheq	r0, [r0], -r4
    3234:	5c028605 	stcpl	6, cr8, [r2], {5}
    3238:	ec000008 	stc	0, cr0, [r0], {8}
    323c:	040f0002 	streq	r0, [pc], #-2	; 3244 <CPSR_IRQ_INHIBIT+0x31c4>
    3240:	0000055b 	andeq	r0, r0, fp, asr r5
    3244:	a6080104 	strge	r0, [r8], -r4, lsl #2
    3248:	0f000003 	svceq	0x00000003
    324c:	0003ff04 	andeq	pc, r3, r4, lsl #30
    3250:	00301300 	eorseq	r1, r0, r0, lsl #6
    3254:	05860000 	streq	r0, [r6]
    3258:	1d140000 	ldcne	0, cr0, [r4, #-0]
    325c:	14000004 	strne	r0, [r0], #-4
    3260:	00000110 	andeq	r0, r0, r0, lsl r1
    3264:	00058614 	andeq	r8, r5, r4, lsl r6
    3268:	00301400 	eorseq	r1, r0, r0, lsl #8
    326c:	0f000000 	svceq	0x00000000
    3270:	00058c04 	andeq	r8, r5, r4, lsl #24
    3274:	055b1800 	ldrbeq	r1, [fp, #-2048]	; 0x800
    3278:	040f0000 	streq	r0, [pc], #-0	; 3280 <CPSR_IRQ_INHIBIT+0x3200>
    327c:	00000568 	andeq	r0, r0, r8, ror #10
    3280:	00008c13 	andeq	r8, r0, r3, lsl ip
    3284:	0005b500 	andeq	fp, r5, r0, lsl #10
    3288:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
    328c:	10140000 	andsne	r0, r4, r0
    3290:	14000001 	strne	r0, [r0], #-1
    3294:	0000008c 	andeq	r0, r0, ip, lsl #1
    3298:	00003014 	andeq	r3, r0, r4, lsl r0
    329c:	040f0000 	streq	r0, [pc], #-0	; 32a4 <CPSR_IRQ_INHIBIT+0x3224>
    32a0:	00000597 	muleq	r0, r7, r5
    32a4:	00003013 	andeq	r3, r0, r3, lsl r0
    32a8:	0005cf00 	andeq	ip, r5, r0, lsl #30
    32ac:	041d1400 	ldreq	r1, [sp], #-1024	; 0x400
    32b0:	10140000 	andsne	r0, r4, r0
    32b4:	00000001 	andeq	r0, r0, r1
    32b8:	05bb040f 	ldreq	r0, [fp, #1039]!	; 0x40f
    32bc:	45080000 	strmi	r0, [r8, #-0]
    32c0:	e5000000 	str	r0, [r0, #-0]
    32c4:	09000005 	stmdbeq	r0, {r0, r2}
    32c8:	000000d2 	ldrdeq	r0, [r0], -r2
    32cc:	45080002 	strmi	r0, [r8, #-2]
    32d0:	f5000000 			; <UNDEFINED> instruction: 0xf5000000
    32d4:	09000005 	stmdbeq	r0, {r0, r2}
    32d8:	000000d2 	ldrdeq	r0, [r0], -r2
    32dc:	da050000 	ble	1432e4 <_stack+0xc32e4>
    32e0:	05000003 	streq	r0, [r0, #-3]
    32e4:	02d5011d 	sbcseq	r0, r5, #1073741831	; 0x40000007
    32e8:	3d190000 	ldccc	0, cr0, [r9, #-0]
    32ec:	0c000009 	stceq	0, cr0, [r0], {9}
    32f0:	36012105 	strcc	r2, [r1], -r5, lsl #2
    32f4:	16000006 	strne	r0, [r0], -r6
    32f8:	00000402 	andeq	r0, r0, r2, lsl #8
    32fc:	36012305 	strcc	r2, [r1], -r5, lsl #6
    3300:	00000006 	andeq	r0, r0, r6
    3304:	0002a116 	andeq	sl, r2, r6, lsl r1
    3308:	01240500 	teqeq	r4, r0, lsl #10
    330c:	00000030 	andeq	r0, r0, r0, lsr r0
    3310:	03d41604 	bicseq	r1, r4, #4, 12	; 0x400000
    3314:	25050000 	strcs	r0, [r5, #-0]
    3318:	00063c01 	andeq	r3, r6, r1, lsl #24
    331c:	0f000800 	svceq	0x00000800
    3320:	00060104 	andeq	r0, r6, r4, lsl #2
    3324:	f5040f00 			; <UNDEFINED> instruction: 0xf5040f00
    3328:	19000005 	stmdbne	r0, {r0, r2}
    332c:	00000013 	andeq	r0, r0, r3, lsl r0
    3330:	013d050e 	teqeq	sp, lr, lsl #10
    3334:	00000677 	andeq	r0, r0, r7, ror r6
    3338:	00044b16 	andeq	r4, r4, r6, lsl fp
    333c:	013e0500 	teqeq	lr, r0, lsl #10
    3340:	00000677 	andeq	r0, r0, r7, ror r6
    3344:	04781600 	ldrbteq	r1, [r8], #-1536	; 0x600
    3348:	3f050000 	svccc	0x00050000
    334c:	00067701 	andeq	r7, r6, r1, lsl #14
    3350:	9c160600 	ldcls	6, cr0, [r6], {-0}
    3354:	05000004 	streq	r0, [r0, #-4]
    3358:	00530140 	subseq	r0, r3, r0, asr #2
    335c:	000c0000 	andeq	r0, ip, r0
    3360:	00005308 	andeq	r5, r0, r8, lsl #6
    3364:	00068700 	andeq	r8, r6, r0, lsl #14
    3368:	00d20900 	sbcseq	r0, r2, r0, lsl #18
    336c:	00020000 	andeq	r0, r2, r0
    3370:	5805d01a 	stmdapl	r5, {r1, r3, r4, ip, lr, pc}
    3374:	00078802 	andeq	r8, r7, r2, lsl #16
    3378:	04c81600 	strbeq	r1, [r8], #1536	; 0x600
    337c:	5a050000 	bpl	143384 <_stack+0xc3384>
    3380:	00003702 	andeq	r3, r0, r2, lsl #14
    3384:	86160000 	ldrhi	r0, [r6], -r0
    3388:	05000004 	streq	r0, [r0, #-4]
    338c:	0555025b 	ldrbeq	r0, [r5, #-603]	; 0x25b
    3390:	16040000 	strne	r0, [r4], -r0
    3394:	000002d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    3398:	88025c05 	stmdahi	r2, {r0, r2, sl, fp, ip, lr}
    339c:	08000007 	stmdaeq	r0, {r0, r1, r2}
    33a0:	00051a16 	andeq	r1, r5, r6, lsl sl
    33a4:	025d0500 	subseq	r0, sp, #0, 10
    33a8:	00000186 	andeq	r0, r0, r6, lsl #3
    33ac:	020b1624 	andeq	r1, fp, #36, 12	; 0x2400000
    33b0:	5e050000 	cdppl	0, 0, cr0, cr5, cr0, {0}
    33b4:	00003002 	andeq	r3, r0, r2
    33b8:	fd164800 	ldc2	8, cr4, [r6, #-0]
    33bc:	05000003 	streq	r0, [r0, #-3]
    33c0:	006f025f 	rsbeq	r0, pc, pc, asr r2	; <UNPREDICTABLE>
    33c4:	16500000 	ldrbne	r0, [r0], -r0
    33c8:	00000530 	andeq	r0, r0, r0, lsr r5
    33cc:	42026005 	andmi	r6, r2, #5
    33d0:	58000006 	stmdapl	r0, {r1, r2}
    33d4:	00040816 	andeq	r0, r4, r6, lsl r8
    33d8:	02610500 	rsbeq	r0, r1, #0, 10
    33dc:	000000fa 	strdeq	r0, [r0], -sl
    33e0:	05351668 	ldreq	r1, [r5, #-1640]!	; 0x668
    33e4:	62050000 	andvs	r0, r5, #0
    33e8:	0000fa02 	andeq	pc, r0, r2, lsl #20
    33ec:	7f167000 	svcvc	0x00167000
    33f0:	05000000 	streq	r0, [r0, #-0]
    33f4:	00fa0263 	rscseq	r0, sl, r3, ror #4
    33f8:	16780000 	ldrbtne	r0, [r8], -r0
    33fc:	000004ed 	andeq	r0, r0, sp, ror #9
    3400:	98026405 	stmdals	r2, {r0, r2, sl, sp, lr}
    3404:	80000007 	andhi	r0, r0, r7
    3408:	0002c416 	andeq	ip, r2, r6, lsl r4
    340c:	02650500 	rsbeq	r0, r5, #0, 10
    3410:	000007a8 	andeq	r0, r0, r8, lsr #15
    3414:	04a91688 	strteq	r1, [r9], #1672	; 0x688
    3418:	66050000 	strvs	r0, [r5], -r0
    341c:	00003002 	andeq	r3, r0, r2
    3420:	1716a000 	ldrne	sl, [r6, -r0]
    3424:	05000001 	streq	r0, [r0, #-1]
    3428:	00fa0267 	rscseq	r0, sl, r7, ror #4
    342c:	16a40000 	strtne	r0, [r4], r0
    3430:	0000006b 	andeq	r0, r0, fp, rrx
    3434:	fa026805 	blx	9d450 <_stack+0x1d450>
    3438:	ac000000 	stcge	0, cr0, [r0], {-0}
    343c:	00010616 	andeq	r0, r1, r6, lsl r6
    3440:	02690500 	rsbeq	r0, r9, #0, 10
    3444:	000000fa 	strdeq	r0, [r0], -sl
    3448:	002b16b4 	strhteq	r1, [fp], -r4
    344c:	6a050000 	bvs	143454 <_stack+0xc3454>
    3450:	0000fa02 	andeq	pc, r0, r2, lsl #20
    3454:	3a16bc00 	bcc	5b245c <_stack+0x53245c>
    3458:	05000000 	streq	r0, [r0, #-0]
    345c:	00fa026b 	rscseq	r0, sl, fp, ror #4
    3460:	16c40000 	strbne	r0, [r4], r0
    3464:	000003b0 			; <UNDEFINED> instruction: 0x000003b0
    3468:	30026c05 	andcc	r6, r2, r5, lsl #24
    346c:	cc000000 	stcgt	0, cr0, [r0], {-0}
    3470:	055b0800 	ldrbeq	r0, [fp, #-2048]	; 0x800
    3474:	07980000 	ldreq	r0, [r8, r0]
    3478:	d2090000 	andle	r0, r9, #0
    347c:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    3480:	055b0800 	ldrbeq	r0, [fp, #-2048]	; 0x800
    3484:	07a80000 	streq	r0, [r8, r0]!
    3488:	d2090000 	andle	r0, r9, #0
    348c:	07000000 	streq	r0, [r0, -r0]
    3490:	055b0800 	ldrbeq	r0, [fp, #-2048]	; 0x800
    3494:	07b80000 	ldreq	r0, [r8, r0]!
    3498:	d2090000 	andle	r0, r9, #0
    349c:	17000000 	strne	r0, [r0, -r0]
    34a0:	05f01a00 	ldrbeq	r1, [r0, #2560]!	; 0xa00
    34a4:	07dc0271 			; <UNDEFINED> instruction: 0x07dc0271
    34a8:	14160000 	ldrne	r0, [r6], #-0
    34ac:	05000003 	streq	r0, [r0, #-3]
    34b0:	07dc0274 			; <UNDEFINED> instruction: 0x07dc0274
    34b4:	16000000 	strne	r0, [r0], -r0
    34b8:	000004e4 	andeq	r0, r0, r4, ror #9
    34bc:	ec027505 	cfstr32	mvfx7, [r2], {5}
    34c0:	78000007 	stmdavc	r0, {r0, r1, r2}
    34c4:	02cf0800 	sbceq	r0, pc, #0, 16
    34c8:	07ec0000 	strbeq	r0, [ip, r0]!
    34cc:	d2090000 	andle	r0, r9, #0
    34d0:	1d000000 	stcne	0, cr0, [r0, #-0]
    34d4:	00370800 	eorseq	r0, r7, r0, lsl #16
    34d8:	07fc0000 	ldrbeq	r0, [ip, r0]!
    34dc:	d2090000 	andle	r0, r9, #0
    34e0:	1d000000 	stcne	0, cr0, [r0, #-0]
    34e4:	05f01b00 	ldrbeq	r1, [r0, #2816]!	; 0xb00
    34e8:	081e0256 	ldmdaeq	lr, {r1, r2, r4, r6, r9}
    34ec:	d91c0000 	ldmdble	ip, {}	; <UNPREDICTABLE>
    34f0:	05000009 	streq	r0, [r0, #-9]
    34f4:	0687026d 	streq	r0, [r7], sp, ror #4
    34f8:	071c0000 	ldreq	r0, [ip, -r0]
    34fc:	05000005 	streq	r0, [r0, #-5]
    3500:	07b80276 			; <UNDEFINED> instruction: 0x07b80276
    3504:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    3508:	0000055b 	andeq	r0, r0, fp, asr r5
    350c:	0000082e 	andeq	r0, r0, lr, lsr #16
    3510:	0000d209 	andeq	sp, r0, r9, lsl #4
    3514:	1d001800 	stcne	8, cr1, [r0, #-0]
    3518:	00000839 	andeq	r0, r0, r9, lsr r8
    351c:	00041d14 	andeq	r1, r4, r4, lsl sp
    3520:	040f0000 	streq	r0, [pc], #-0	; 3528 <CPSR_IRQ_INHIBIT+0x34a8>
    3524:	0000082e 	andeq	r0, r0, lr, lsr #16
    3528:	0170040f 	cmneq	r0, pc, lsl #8
    352c:	501d0000 	andspl	r0, sp, r0
    3530:	14000008 	strne	r0, [r0], #-8
    3534:	00000030 	andeq	r0, r0, r0, lsr r0
    3538:	56040f00 	strpl	r0, [r4], -r0, lsl #30
    353c:	0f000008 	svceq	0x00000008
    3540:	00084504 	andeq	r4, r8, r4, lsl #10
    3544:	05f50800 	ldrbeq	r0, [r5, #2048]!	; 0x800
    3548:	086c0000 	stmdaeq	ip!, {}^	; <UNPREDICTABLE>
    354c:	d2090000 	andle	r0, r9, #0
    3550:	02000000 	andeq	r0, r0, #0
    3554:	071a1e00 	ldreq	r1, [sl, -r0, lsl #28]
    3558:	9a060000 	bls	183560 <_stack+0x103560>
    355c:	00000110 	andeq	r0, r0, r0, lsl r1
    3560:	0000a488 	andeq	sl, r0, r8, lsl #9
    3564:	00000026 	andeq	r0, r0, r6, lsr #32
    3568:	08d79c01 	ldmeq	r7, {r0, sl, fp, ip, pc}^
    356c:	701f0000 	andsvc	r0, pc, r0
    3570:	01007274 	tsteq	r0, r4, ror r2
    3574:	00041d32 	andeq	r1, r4, r2, lsr sp
    3578:	00135500 	andseq	r5, r3, r0, lsl #10
    357c:	09e02000 	stmibeq	r0!, {sp}^
    3580:	32010000 	andcc	r0, r1, #0
    3584:	00000025 	andeq	r0, r0, r5, lsr #32
    3588:	00001373 	andeq	r1, r0, r3, ror r3
    358c:	74657221 	strbtvc	r7, [r5], #-545	; 0x221
    3590:	55360100 	ldrpl	r0, [r6, #-256]!	; 0x100
    3594:	01000005 	tsteq	r0, r5
    3598:	0a172250 	beq	5cbee0 <_stack+0x54bee0>
    359c:	37010000 	strcc	r0, [r1, -r0]
    35a0:	00000110 	andeq	r0, r0, r0, lsl r1
    35a4:	000008c5 	andeq	r0, r0, r5, asr #17
    35a8:	00002514 	andeq	r2, r0, r4, lsl r5
    35ac:	9e230000 	cdpls	0, 2, cr0, cr3, cr0, {0}
    35b0:	e20000a4 	and	r0, r0, #164	; 0xa4
    35b4:	24000008 	strcs	r0, [r0], #-8
    35b8:	f3035001 	vhadd.u8	d5, d3, d1
    35bc:	00005101 	andeq	r5, r0, r1, lsl #2
    35c0:	0003b325 	andeq	fp, r3, r5, lsr #6
    35c4:	30180100 	andscc	r0, r8, r0, lsl #2
    35c8:	26000000 	strcs	r0, [r0], -r0
    35cc:	00000a17 	andeq	r0, r0, r7, lsl sl
    35d0:	01103701 	tsteq	r0, r1, lsl #14
    35d4:	25140000 	ldrcs	r0, [r4, #-0]
    35d8:	00000000 	andeq	r0, r0, r0
    35dc:	0000b100 	andeq	fp, r0, r0, lsl #2
    35e0:	fd000400 	stc2	4, cr0, [r0, #-0]
    35e4:	0400000b 	streq	r0, [r0], #-11
    35e8:	00014101 	andeq	r4, r1, r1, lsl #2
    35ec:	0a240100 	beq	9039f4 <_stack+0x8839f4>
    35f0:	07d00000 	ldrbeq	r0, [r0, r0]
    35f4:	00c80000 	sbceq	r0, r8, r0
    35f8:	00000000 	andeq	r0, r0, r0
    35fc:	0b470000 	bleq	11c3604 <_stack+0x1143604>
    3600:	04020000 	streq	r0, [r2], #-0
    3604:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
    3608:	000c0300 	andeq	r0, ip, r0, lsl #6
    360c:	d4020000 	strle	r0, [r2], #-0
    3610:	00000037 	andeq	r0, r0, r7, lsr r0
    3614:	55070404 	strpl	r0, [r7, #-1028]	; 0x404
    3618:	04000000 	streq	r0, [r0], #-0
    361c:	039f0601 	orrseq	r0, pc, #1048576	; 0x100000
    3620:	01040000 	mrseq	r0, (UNDEF: 4)
    3624:	00039d08 	andeq	r9, r3, r8, lsl #26
    3628:	05020400 	streq	r0, [r2, #-1024]	; 0x400
    362c:	000003b9 			; <UNDEFINED> instruction: 0x000003b9
    3630:	a8070204 	stmdage	r7, {r2, r9}
    3634:	04000002 	streq	r0, [r0], #-2
    3638:	009b0504 	addseq	r0, fp, r4, lsl #10
    363c:	04040000 	streq	r0, [r4], #-0
    3640:	00005007 	andeq	r5, r0, r7
    3644:	05080400 	streq	r0, [r8, #-1024]	; 0x400
    3648:	00000096 	muleq	r0, r6, r0
    364c:	4b070804 	blmi	1c5664 <_stack+0x145664>
    3650:	04000000 	streq	r0, [r0], #-0
    3654:	030b0704 	movweq	r0, #46852	; 0xb704
    3658:	01040000 	mrseq	r0, (UNDEF: 4)
    365c:	0003a608 	andeq	sl, r3, r8, lsl #12
    3660:	8a040500 	bhi	104a68 <_stack+0x84a68>
    3664:	06000000 	streq	r0, [r0], -r0
    3668:	0000007d 	andeq	r0, r0, sp, ror r0
    366c:	000a1d07 	andeq	r1, sl, r7, lsl #26
    3670:	2c210300 	stccs	3, cr0, [r1], #-0
    3674:	b0000000 	andlt	r0, r0, r0
    3678:	5e0000a4 	cdppl	0, 0, cr0, cr0, cr4, {5}
    367c:	01000000 	mrseq	r0, (UNDEF: 0)
    3680:	7473089c 	ldrbtvc	r0, [r3], #-2204	; 0x89c
    3684:	42010072 	andmi	r0, r1, #114	; 0x72
    3688:	00000084 	andeq	r0, r0, r4, lsl #1
    368c:	00001394 	muleq	r0, r4, r3
    3690:	0c180000 	ldceq	0, cr0, [r8], {-0}
    3694:	00040000 	andeq	r0, r4, r0
    3698:	00000c6d 	andeq	r0, r0, sp, ror #24
    369c:	01410104 	cmpeq	r1, r4, lsl #2
    36a0:	e5010000 	str	r0, [r1, #-0]
    36a4:	4c000006 	stcmi	0, cr0, [r0], {6}
    36a8:	d8000002 	stmdale	r0, {r1}
    36ac:	00000000 	andeq	r0, r0, r0
    36b0:	24000000 	strcs	r0, [r0], #-0
    36b4:	0200000c 	andeq	r0, r0, #12
    36b8:	00000601 	andeq	r0, r0, r1, lsl #12
    36bc:	00309302 	eorseq	r9, r0, r2, lsl #6
    36c0:	04030000 	streq	r0, [r3], #-0
    36c4:	746e6905 	strbtvc	r6, [lr], #-2309	; 0x905
    36c8:	000c0200 	andeq	r0, ip, r0, lsl #4
    36cc:	d4020000 	strle	r0, [r2], #-0
    36d0:	00000042 	andeq	r0, r0, r2, asr #32
    36d4:	55070404 	strpl	r0, [r7, #-1028]	; 0x404
    36d8:	05000000 	streq	r0, [r0, #-0]
    36dc:	06010404 	streq	r0, [r1], -r4, lsl #8
    36e0:	0000039f 	muleq	r0, pc, r3	; <UNPREDICTABLE>
    36e4:	9d080104 	stflss	f0, [r8, #-16]
    36e8:	04000003 	streq	r0, [r0], #-3
    36ec:	03b90502 			; <UNDEFINED> instruction: 0x03b90502
    36f0:	02040000 	andeq	r0, r4, #0
    36f4:	0002a807 	andeq	sl, r2, r7, lsl #16
    36f8:	05040400 	streq	r0, [r4, #-1024]	; 0x400
    36fc:	0000009b 	muleq	r0, fp, r0
    3700:	50070404 	andpl	r0, r7, r4, lsl #8
    3704:	04000000 	streq	r0, [r0], #-0
    3708:	00960508 	addseq	r0, r6, r8, lsl #10
    370c:	08040000 	stmdaeq	r4, {}	; <UNPREDICTABLE>
    3710:	00004b07 	andeq	r4, r0, r7, lsl #22
    3714:	034f0200 	movteq	r0, #61952	; 0xf200
    3718:	07030000 	streq	r0, [r3, -r0]
    371c:	00000030 	andeq	r0, r0, r0, lsr r0
    3720:	00033702 	andeq	r3, r3, r2, lsl #14
    3724:	67100400 	ldrvs	r0, [r0, -r0, lsl #8]
    3728:	02000000 	andeq	r0, r0, #0
    372c:	00000467 	andeq	r0, r0, r7, ror #8
    3730:	00672704 	rsbeq	r2, r7, r4, lsl #14
    3734:	eb060000 	bl	18373c <_stack+0x10373c>
    3738:	02000002 	andeq	r0, r0, #2
    373c:	00420161 	subeq	r0, r2, r1, ror #2
    3740:	04070000 	streq	r0, [r7], #-0
    3744:	00cf4a04 	sbceq	r4, pc, r4, lsl #20
    3748:	e5080000 	str	r0, [r8, #-0]
    374c:	04000002 	streq	r0, [r0], #-2
    3750:	0000a44c 	andeq	sl, r0, ip, asr #8
    3754:	022f0800 	eoreq	r0, pc, #0, 16
    3758:	4d040000 	stcmi	0, cr0, [r4, #-0]
    375c:	000000cf 	andeq	r0, r0, pc, asr #1
    3760:	00520900 	subseq	r0, r2, r0, lsl #18
    3764:	00df0000 	sbcseq	r0, pc, r0
    3768:	df0a0000 	svcle	0x000a0000
    376c:	03000000 	movweq	r0, #0
    3770:	07040400 	streq	r0, [r4, -r0, lsl #8]
    3774:	0000030b 	andeq	r0, r0, fp, lsl #6
    3778:	4704080b 	strmi	r0, [r4, -fp, lsl #16]
    377c:	00000107 	andeq	r0, r0, r7, lsl #2
    3780:	0004510c 	andeq	r5, r4, ip, lsl #2
    3784:	30490400 	subcc	r0, r9, r0, lsl #8
    3788:	00000000 	andeq	r0, r0, r0
    378c:	0004590c 	andeq	r5, r4, ip, lsl #18
    3790:	b04e0400 	sublt	r0, lr, r0, lsl #8
    3794:	04000000 	streq	r0, [r0], #-0
    3798:	03e10200 	mvneq	r0, #0, 4
    379c:	4f040000 	svcmi	0x00040000
    37a0:	000000e6 	andeq	r0, r0, r6, ror #1
    37a4:	00013802 	andeq	r3, r1, r2, lsl #16
    37a8:	83530400 	cmphi	r3, #0, 8
    37ac:	02000000 	andeq	r0, r0, #0
    37b0:	000004a1 	andeq	r0, r0, r1, lsr #9
    37b4:	006e1605 	rsbeq	r1, lr, r5, lsl #12
    37b8:	030d0000 	movweq	r0, #53248	; 0xd000
    37bc:	18000002 	stmdane	r0, {r1}
    37c0:	017b2d05 	cmneq	fp, r5, lsl #26
    37c4:	020c0000 	andeq	r0, ip, #0
    37c8:	05000004 	streq	r0, [r0, #-4]
    37cc:	00017b2f 	andeq	r7, r1, pc, lsr #22
    37d0:	5f0e0000 	svcpl	0x000e0000
    37d4:	3005006b 	andcc	r0, r5, fp, rrx
    37d8:	00000030 	andeq	r0, r0, r0, lsr r0
    37dc:	04430c04 	strbeq	r0, [r3], #-3076	; 0xc04
    37e0:	30050000 	andcc	r0, r5, r0
    37e4:	00000030 	andeq	r0, r0, r0, lsr r0
    37e8:	01320c08 	teqeq	r2, r8, lsl #24
    37ec:	30050000 	andcc	r0, r5, r0
    37f0:	00000030 	andeq	r0, r0, r0, lsr r0
    37f4:	04d50c0c 	ldrbeq	r0, [r5], #3084	; 0xc0c
    37f8:	30050000 	andcc	r0, r5, r0
    37fc:	00000030 	andeq	r0, r0, r0, lsr r0
    3800:	785f0e10 	ldmdavc	pc, {r4, r9, sl, fp}^	; <UNPREDICTABLE>
    3804:	81310500 	teqhi	r1, r0, lsl #10
    3808:	14000001 	strne	r0, [r0], #-1
    380c:	28040f00 	stmdacs	r4, {r8, r9, sl, fp}
    3810:	09000001 	stmdbeq	r0, {r0}
    3814:	0000011d 	andeq	r0, r0, sp, lsl r1
    3818:	00000191 	muleq	r0, r1, r1
    381c:	0000df0a 	andeq	sp, r0, sl, lsl #30
    3820:	0d000000 	stceq	0, cr0, [r0, #-0]
    3824:	0000022a 	andeq	r0, r0, sl, lsr #4
    3828:	0a350524 	beq	d44cc0 <_stack+0xcc4cc0>
    382c:	0c000002 	stceq	0, cr0, [r0], {2}
    3830:	0000008d 	andeq	r0, r0, sp, lsl #1
    3834:	00303705 	eorseq	r3, r0, r5, lsl #14
    3838:	0c000000 	stceq	0, cr0, [r0], {-0}
    383c:	0000046f 	andeq	r0, r0, pc, ror #8
    3840:	00303805 	eorseq	r3, r0, r5, lsl #16
    3844:	0c040000 	stceq	0, cr0, [r4], {-0}
    3848:	000000aa 	andeq	r0, r0, sl, lsr #1
    384c:	00303905 	eorseq	r3, r0, r5, lsl #18
    3850:	0c080000 	stceq	0, cr0, [r8], {-0}
    3854:	00000548 	andeq	r0, r0, r8, asr #10
    3858:	00303a05 	eorseq	r3, r0, r5, lsl #20
    385c:	0c0c0000 	stceq	0, cr0, [ip], {-0}
    3860:	0000031b 	andeq	r0, r0, fp, lsl r3
    3864:	00303b05 	eorseq	r3, r0, r5, lsl #22
    3868:	0c100000 	ldceq	0, cr0, [r0], {-0}
    386c:	00000301 	andeq	r0, r0, r1, lsl #6
    3870:	00303c05 	eorseq	r3, r0, r5, lsl #24
    3874:	0c140000 	ldceq	0, cr0, [r4], {-0}
    3878:	000004da 	ldrdeq	r0, [r0], -sl
    387c:	00303d05 	eorseq	r3, r0, r5, lsl #26
    3880:	0c180000 	ldceq	0, cr0, [r8], {-0}
    3884:	000003c3 	andeq	r0, r0, r3, asr #7
    3888:	00303e05 	eorseq	r3, r0, r5, lsl #28
    388c:	0c1c0000 	ldceq	0, cr0, [ip], {-0}
    3890:	0000050f 	andeq	r0, r0, pc, lsl #10
    3894:	00303f05 	eorseq	r3, r0, r5, lsl #30
    3898:	00200000 	eoreq	r0, r0, r0
    389c:	0000b910 	andeq	fp, r0, r0, lsl r9
    38a0:	05010800 	streq	r0, [r1, #-2048]	; 0x800
    38a4:	00024a48 	andeq	r4, r2, r8, asr #20
    38a8:	01250c00 	teqeq	r5, r0, lsl #24
    38ac:	49050000 	stmdbmi	r5, {}	; <UNPREDICTABLE>
    38b0:	0000024a 	andeq	r0, r0, sl, asr #4
    38b4:	00000c00 	andeq	r0, r0, r0, lsl #24
    38b8:	4a050000 	bmi	1438c0 <_stack+0xc38c0>
    38bc:	0000024a 	andeq	r0, r0, sl, asr #4
    38c0:	04931180 	ldreq	r1, [r3], #384	; 0x180
    38c4:	4c050000 	stcmi	0, cr0, [r5], {-0}
    38c8:	0000011d 	andeq	r0, r0, sp, lsl r1
    38cc:	de110100 	mufles	f0, f1, f0
    38d0:	05000000 	streq	r0, [r0, #-0]
    38d4:	00011d4f 	andeq	r1, r1, pc, asr #26
    38d8:	00010400 	andeq	r0, r1, r0, lsl #8
    38dc:	00004909 	andeq	r4, r0, r9, lsl #18
    38e0:	00025a00 	andeq	r5, r2, r0, lsl #20
    38e4:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    38e8:	001f0000 	andseq	r0, pc, r0
    38ec:	00032410 	andeq	r2, r3, r0, lsl r4
    38f0:	05019000 	streq	r9, [r1, #-0]
    38f4:	0002985b 	andeq	r9, r2, fp, asr r8
    38f8:	04020c00 	streq	r0, [r2], #-3072	; 0xc00
    38fc:	5c050000 	stcpl	0, cr0, [r5], {-0}
    3900:	00000298 	muleq	r0, r8, r2
    3904:	041a0c00 	ldreq	r0, [sl], #-3072	; 0xc00
    3908:	5d050000 	stcpl	0, cr0, [r5, #-0]
    390c:	00000030 	andeq	r0, r0, r0, lsr r0
    3910:	012d0c04 	teqeq	sp, r4, lsl #24
    3914:	5f050000 	svcpl	0x00050000
    3918:	0000029e 	muleq	r0, lr, r2
    391c:	00b90c08 	adcseq	r0, r9, r8, lsl #24
    3920:	60050000 	andvs	r0, r5, r0
    3924:	0000020a 	andeq	r0, r0, sl, lsl #4
    3928:	040f0088 	streq	r0, [pc], #-136	; 3930 <CPSR_IRQ_INHIBIT+0x38b0>
    392c:	0000025a 	andeq	r0, r0, sl, asr r2
    3930:	0002ae09 	andeq	sl, r2, r9, lsl #28
    3934:	0002ae00 	andeq	sl, r2, r0, lsl #28
    3938:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    393c:	001f0000 	andseq	r0, pc, r0
    3940:	02b4040f 	adcseq	r0, r4, #251658240	; 0xf000000
    3944:	0d120000 	ldceq	0, cr0, [r2, #-0]
    3948:	000003cd 	andeq	r0, r0, sp, asr #7
    394c:	da730508 	ble	1cc4d74 <_stack+0x1c44d74>
    3950:	0c000002 	stceq	0, cr0, [r0], {2}
    3954:	00000761 	andeq	r0, r0, r1, ror #14
    3958:	02da7405 	sbcseq	r7, sl, #83886080	; 0x5000000
    395c:	0c000000 	stceq	0, cr0, [r0], {-0}
    3960:	00000618 	andeq	r0, r0, r8, lsl r6
    3964:	00307505 	eorseq	r7, r0, r5, lsl #10
    3968:	00040000 	andeq	r0, r4, r0
    396c:	0052040f 	subseq	r0, r2, pc, lsl #8
    3970:	ec0d0000 	stc	0, cr0, [sp], {-0}
    3974:	68000003 	stmdavs	r0, {r0, r1}
    3978:	040ab305 	streq	fp, [sl], #-773	; 0x305
    397c:	5f0e0000 	svcpl	0x000e0000
    3980:	b4050070 	strlt	r0, [r5], #-112	; 0x70
    3984:	000002da 	ldrdeq	r0, [r0], -sl
    3988:	725f0e00 	subsvc	r0, pc, #0, 28
    398c:	30b50500 	adcscc	r0, r5, r0, lsl #10
    3990:	04000000 	streq	r0, [r0], #-0
    3994:	00775f0e 	rsbseq	r5, r7, lr, lsl #30
    3998:	0030b605 	eorseq	fp, r0, r5, lsl #12
    399c:	0c080000 	stceq	0, cr0, [r8], {-0}
    39a0:	000000d7 	ldrdeq	r0, [r0], -r7
    39a4:	0059b705 	subseq	fp, r9, r5, lsl #14
    39a8:	0c0c0000 	stceq	0, cr0, [ip], {-0}
    39ac:	00000246 	andeq	r0, r0, r6, asr #4
    39b0:	0059b805 	subseq	fp, r9, r5, lsl #16
    39b4:	0e0e0000 	cdpeq	0, 0, cr0, cr14, cr0, {0}
    39b8:	0066625f 	rsbeq	r6, r6, pc, asr r2
    39bc:	02b5b905 	adcseq	fp, r5, #81920	; 0x14000
    39c0:	0c100000 	ldceq	0, cr0, [r0], {-0}
    39c4:	00000062 	andeq	r0, r0, r2, rrx
    39c8:	0030ba05 	eorseq	fp, r0, r5, lsl #20
    39cc:	0c180000 	ldceq	0, cr0, [r8], {-0}
    39d0:	000000c7 	andeq	r0, r0, r7, asr #1
    39d4:	0049c105 	subeq	ip, r9, r5, lsl #2
    39d8:	0c1c0000 	ldceq	0, cr0, [ip], {-0}
    39dc:	0000021a 	andeq	r0, r0, sl, lsl r2
    39e0:	056dc305 	strbeq	ip, [sp, #-773]!	; 0x305
    39e4:	0c200000 	stceq	0, cr0, [r0], #-0
    39e8:	000002fa 	strdeq	r0, [r0], -sl
    39ec:	059cc505 	ldreq	ip, [ip, #1285]	; 0x505
    39f0:	0c240000 	stceq	0, cr0, [r4], #-0
    39f4:	00000461 	andeq	r0, r0, r1, ror #8
    39f8:	05c0c805 	strbeq	ip, [r0, #2053]	; 0x805
    39fc:	0c280000 	stceq	0, cr0, [r8], #-0
    3a00:	00000529 	andeq	r0, r0, r9, lsr #10
    3a04:	05dac905 	ldrbeq	ip, [sl, #2309]	; 0x905
    3a08:	0e2c0000 	cdpeq	0, 2, cr0, cr12, cr0, {0}
    3a0c:	0062755f 	rsbeq	r7, r2, pc, asr r5
    3a10:	02b5cc05 	adcseq	ip, r5, #1280	; 0x500
    3a14:	0e300000 	cdpeq	0, 3, cr0, cr0, cr0, {0}
    3a18:	0070755f 	rsbseq	r7, r0, pc, asr r5
    3a1c:	02dacd05 	sbcseq	ip, sl, #320	; 0x140
    3a20:	0e380000 	cdpeq	0, 3, cr0, cr8, cr0, {0}
    3a24:	0072755f 	rsbseq	r7, r2, pc, asr r5
    3a28:	0030ce05 	eorseq	ip, r0, r5, lsl #28
    3a2c:	0c3c0000 	ldceq	0, cr0, [ip], #-0
    3a30:	000000a4 	andeq	r0, r0, r4, lsr #1
    3a34:	05e0d105 	strbeq	sp, [r0, #261]!	; 0x105
    3a38:	0c400000 	mareq	acc0, r0, r0
    3a3c:	00000501 	andeq	r0, r0, r1, lsl #10
    3a40:	05f0d205 	ldrbeq	sp, [r0, #517]!	; 0x205
    3a44:	0e430000 	cdpeq	0, 4, cr0, cr3, cr0, {0}
    3a48:	00626c5f 	rsbeq	r6, r2, pc, asr ip
    3a4c:	02b5d505 	adcseq	sp, r5, #20971520	; 0x1400000
    3a50:	0c440000 	mareq	acc0, r0, r4
    3a54:	000000ed 	andeq	r0, r0, sp, ror #1
    3a58:	0030d805 	eorseq	sp, r0, r5, lsl #16
    3a5c:	0c4c0000 	mareq	acc0, r0, ip
    3a60:	000000fe 	strdeq	r0, [r0], -lr
    3a64:	008ed905 	addeq	sp, lr, r5, lsl #18
    3a68:	0c500000 	mraeq	r0, r0, acc0
    3a6c:	00000a9a 	muleq	r0, sl, sl
    3a70:	0428dc05 	strteq	sp, [r8], #-3077	; 0xc05
    3a74:	0c540000 	mraeq	r0, r4, acc0
    3a78:	000005fb 	strdeq	r0, [r0], -fp
    3a7c:	0112e005 	tsteq	r2, r5
    3a80:	0c580000 	mraeq	r0, r8, acc0
    3a84:	000003f4 	strdeq	r0, [r0], -r4
    3a88:	0107e205 	tsteq	r7, r5, lsl #4
    3a8c:	0c5c0000 	mraeq	r0, ip, acc0
    3a90:	000002f2 	strdeq	r0, [r0], -r2
    3a94:	0030e305 	eorseq	lr, r0, r5, lsl #6
    3a98:	00640000 	rsbeq	r0, r4, r0
    3a9c:	00003013 	andeq	r3, r0, r3, lsl r0
    3aa0:	00042800 	andeq	r2, r4, r0, lsl #16
    3aa4:	04281400 	strteq	r1, [r8], #-1024	; 0x400
    3aa8:	49140000 	ldmdbmi	r4, {}	; <UNPREDICTABLE>
    3aac:	14000000 	strne	r0, [r0], #-0
    3ab0:	00000560 	andeq	r0, r0, r0, ror #10
    3ab4:	00003014 	andeq	r3, r0, r4, lsl r0
    3ab8:	040f0000 	streq	r0, [pc], #-0	; 3ac0 <CPSR_IRQ_INHIBIT+0x3a40>
    3abc:	0000042e 	andeq	r0, r0, lr, lsr #8
    3ac0:	0009d915 	andeq	sp, r9, r5, lsl r9
    3ac4:	05042800 	streq	r2, [r4, #-2048]	; 0x800
    3ac8:	05600239 	strbeq	r0, [r0, #-569]!	; 0x239
    3acc:	b2160000 	andslt	r0, r6, #0
    3ad0:	05000003 	streq	r0, [r0, #-3]
    3ad4:	0030023b 	eorseq	r0, r0, fp, lsr r2
    3ad8:	16000000 	strne	r0, [r0], -r0
    3adc:	000000e6 	andeq	r0, r0, r6, ror #1
    3ae0:	47024005 	strmi	r4, [r2, -r5]
    3ae4:	04000006 	streq	r0, [r0], #-6
    3ae8:	00023616 	andeq	r3, r2, r6, lsl r6
    3aec:	02400500 	subeq	r0, r0, #0, 10
    3af0:	00000647 	andeq	r0, r0, r7, asr #12
    3af4:	047e1608 	ldrbteq	r1, [lr], #-1544	; 0x608
    3af8:	40050000 	andmi	r0, r5, r0
    3afc:	00064702 	andeq	r4, r6, r2, lsl #14
    3b00:	15160c00 	ldrne	r0, [r6, #-3072]	; 0xc00
    3b04:	05000004 	streq	r0, [r0, #-4]
    3b08:	00300242 	eorseq	r0, r0, r2, asr #4
    3b0c:	16100000 	ldrne	r0, [r0], -r0
    3b10:	00000020 	andeq	r0, r0, r0, lsr #32
    3b14:	29024305 	stmdbcs	r2, {r0, r2, r8, r9, lr}
    3b18:	14000008 	strne	r0, [r0], #-8
    3b1c:	0004b616 	andeq	fp, r4, r6, lsl r6
    3b20:	02450500 	subeq	r0, r5, #0, 10
    3b24:	00000030 	andeq	r0, r0, r0, lsr r0
    3b28:	041f1630 	ldreq	r1, [pc], #-1584	; 3b30 <CPSR_IRQ_INHIBIT+0x3ab0>
    3b2c:	46050000 	strmi	r0, [r5], -r0
    3b30:	00059102 	andeq	r9, r5, r2, lsl #2
    3b34:	2c163400 	cfldrscs	mvf3, [r6], {-0}
    3b38:	05000003 	streq	r0, [r0, #-3]
    3b3c:	00300248 	eorseq	r0, r0, r8, asr #4
    3b40:	16380000 	ldrtne	r0, [r8], -r0
    3b44:	00000439 	andeq	r0, r0, r9, lsr r4
    3b48:	44024a05 	strmi	r4, [r2], #-2565	; 0xa05
    3b4c:	3c000008 	stccc	0, cr0, [r0], {8}
    3b50:	0002dd16 	andeq	sp, r2, r6, lsl sp
    3b54:	024d0500 	subeq	r0, sp, #0, 10
    3b58:	0000017b 	andeq	r0, r0, fp, ror r1
    3b5c:	02201640 	eoreq	r1, r0, #64, 12	; 0x4000000
    3b60:	4e050000 	cdpmi	0, 0, cr0, cr5, cr0, {0}
    3b64:	00003002 	andeq	r3, r0, r2
    3b68:	43164400 	tstmi	r6, #0, 8
    3b6c:	05000005 	streq	r0, [r0, #-5]
    3b70:	017b024f 	cmneq	fp, pc, asr #4
    3b74:	16480000 	strbne	r0, [r8], -r0
    3b78:	0000033e 	andeq	r0, r0, lr, lsr r3
    3b7c:	4a025005 	bmi	97b98 <_stack+0x17b98>
    3b80:	4c000008 	stcmi	0, cr0, [r0], {8}
    3b84:	00023e16 	andeq	r3, r2, r6, lsl lr
    3b88:	02530500 	subseq	r0, r3, #0, 10
    3b8c:	00000030 	andeq	r0, r0, r0, lsr r0
    3b90:	00f61650 	rscseq	r1, r6, r0, asr r6
    3b94:	54050000 	strpl	r0, [r5], #-0
    3b98:	00056002 	andeq	r6, r5, r2
    3b9c:	ab165400 	blge	598ba4 <_stack+0x518ba4>
    3ba0:	05000003 	streq	r0, [r0, #-3]
    3ba4:	08070277 	stmdaeq	r7, {r0, r1, r2, r4, r5, r6, r9}
    3ba8:	17580000 	ldrbne	r0, [r8, -r0]
    3bac:	00000324 	andeq	r0, r0, r4, lsr #6
    3bb0:	98027b05 	stmdals	r2, {r0, r2, r8, r9, fp, ip, sp, lr}
    3bb4:	48000002 	stmdami	r0, {r1}
    3bb8:	02bb1701 	adcseq	r1, fp, #262144	; 0x40000
    3bbc:	7c050000 	stcvc	0, cr0, [r5], {-0}
    3bc0:	00025a02 	andeq	r5, r2, r2, lsl #20
    3bc4:	17014c00 	strne	r4, [r1, -r0, lsl #24]
    3bc8:	000004f7 	strdeq	r0, [r0], -r7
    3bcc:	5b028005 	blpl	a3be8 <_stack+0x23be8>
    3bd0:	dc000008 	stcle	0, cr0, [r0], {8}
    3bd4:	00cf1702 	sbceq	r1, pc, r2, lsl #14
    3bd8:	85050000 	strhi	r0, [r5, #-0]
    3bdc:	00060c02 	andeq	r0, r6, r2, lsl #24
    3be0:	1702e000 	strne	lr, [r2, -r0]
    3be4:	000000b4 	strheq	r0, [r0], -r4
    3be8:	67028605 	strvs	r8, [r2, -r5, lsl #12]
    3bec:	ec000008 	stc	0, cr0, [r0], {8}
    3bf0:	040f0002 	streq	r0, [pc], #-2	; 3bf8 <CPSR_IRQ_INHIBIT+0x3b78>
    3bf4:	00000566 	andeq	r0, r0, r6, ror #10
    3bf8:	a6080104 	strge	r0, [r8], -r4, lsl #2
    3bfc:	0f000003 	svceq	0x00000003
    3c00:	00040a04 	andeq	r0, r4, r4, lsl #20
    3c04:	00301300 	eorseq	r1, r0, r0, lsl #6
    3c08:	05910000 	ldreq	r0, [r1]
    3c0c:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
    3c10:	14000004 	strne	r0, [r0], #-4
    3c14:	00000049 	andeq	r0, r0, r9, asr #32
    3c18:	00059114 	andeq	r9, r5, r4, lsl r1
    3c1c:	00301400 	eorseq	r1, r0, r0, lsl #8
    3c20:	0f000000 	svceq	0x00000000
    3c24:	00059704 	andeq	r9, r5, r4, lsl #14
    3c28:	05661800 	strbeq	r1, [r6, #-2048]!	; 0x800
    3c2c:	040f0000 	streq	r0, [pc], #-0	; 3c34 <CPSR_IRQ_INHIBIT+0x3bb4>
    3c30:	00000573 	andeq	r0, r0, r3, ror r5
    3c34:	00009913 	andeq	r9, r0, r3, lsl r9
    3c38:	0005c000 	andeq	ip, r5, r0
    3c3c:	04281400 	strteq	r1, [r8], #-1024	; 0x400
    3c40:	49140000 	ldmdbmi	r4, {}	; <UNPREDICTABLE>
    3c44:	14000000 	strne	r0, [r0], #-0
    3c48:	00000099 	muleq	r0, r9, r0
    3c4c:	00003014 	andeq	r3, r0, r4, lsl r0
    3c50:	040f0000 	streq	r0, [pc], #-0	; 3c58 <CPSR_IRQ_INHIBIT+0x3bd8>
    3c54:	000005a2 	andeq	r0, r0, r2, lsr #11
    3c58:	00003013 	andeq	r3, r0, r3, lsl r0
    3c5c:	0005da00 	andeq	sp, r5, r0, lsl #20
    3c60:	04281400 	strteq	r1, [r8], #-1024	; 0x400
    3c64:	49140000 	ldmdbmi	r4, {}	; <UNPREDICTABLE>
    3c68:	00000000 	andeq	r0, r0, r0
    3c6c:	05c6040f 	strbeq	r0, [r6, #1039]	; 0x40f
    3c70:	52090000 	andpl	r0, r9, #0
    3c74:	f0000000 			; <UNDEFINED> instruction: 0xf0000000
    3c78:	0a000005 	beq	3c94 <CPSR_IRQ_INHIBIT+0x3c14>
    3c7c:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    3c80:	52090002 	andpl	r0, r9, #2
    3c84:	00000000 	andeq	r0, r0, r0
    3c88:	0a000006 	beq	3ca8 <CPSR_IRQ_INHIBIT+0x3c28>
    3c8c:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    3c90:	da060000 	ble	183c98 <_stack+0x103c98>
    3c94:	05000003 	streq	r0, [r0, #-3]
    3c98:	02e0011d 	rsceq	r0, r0, #1073741831	; 0x40000007
    3c9c:	3d190000 	ldccc	0, cr0, [r9, #-0]
    3ca0:	0c000009 	stceq	0, cr0, [r0], {9}
    3ca4:	41012105 	tstmi	r1, r5, lsl #2
    3ca8:	16000006 	strne	r0, [r0], -r6
    3cac:	00000402 	andeq	r0, r0, r2, lsl #8
    3cb0:	41012305 	tstmi	r1, r5, lsl #6
    3cb4:	00000006 	andeq	r0, r0, r6
    3cb8:	0002a116 	andeq	sl, r2, r6, lsl r1
    3cbc:	01240500 	teqeq	r4, r0, lsl #10
    3cc0:	00000030 	andeq	r0, r0, r0, lsr r0
    3cc4:	03d41604 	bicseq	r1, r4, #4, 12	; 0x400000
    3cc8:	25050000 	strcs	r0, [r5, #-0]
    3ccc:	00064701 	andeq	r4, r6, r1, lsl #14
    3cd0:	0f000800 	svceq	0x00000800
    3cd4:	00060c04 	andeq	r0, r6, r4, lsl #24
    3cd8:	00040f00 	andeq	r0, r4, r0, lsl #30
    3cdc:	19000006 	stmdbne	r0, {r1, r2}
    3ce0:	00000013 	andeq	r0, r0, r3, lsl r0
    3ce4:	013d050e 	teqeq	sp, lr, lsl #10
    3ce8:	00000682 	andeq	r0, r0, r2, lsl #13
    3cec:	00044b16 	andeq	r4, r4, r6, lsl fp
    3cf0:	013e0500 	teqeq	lr, r0, lsl #10
    3cf4:	00000682 	andeq	r0, r0, r2, lsl #13
    3cf8:	04781600 	ldrbteq	r1, [r8], #-1536	; 0x600
    3cfc:	3f050000 	svccc	0x00050000
    3d00:	00068201 	andeq	r8, r6, r1, lsl #4
    3d04:	9c160600 	ldcls	6, cr0, [r6], {-0}
    3d08:	05000004 	streq	r0, [r0, #-4]
    3d0c:	00600140 	rsbeq	r0, r0, r0, asr #2
    3d10:	000c0000 	andeq	r0, ip, r0
    3d14:	00006009 	andeq	r6, r0, r9
    3d18:	00069200 	andeq	r9, r6, r0, lsl #4
    3d1c:	00df0a00 	sbcseq	r0, pc, r0, lsl #20
    3d20:	00020000 	andeq	r0, r2, r0
    3d24:	5805d01a 	stmdapl	r5, {r1, r3, r4, ip, lr, pc}
    3d28:	00079302 	andeq	r9, r7, r2, lsl #6
    3d2c:	04c81600 	strbeq	r1, [r8], #1536	; 0x600
    3d30:	5a050000 	bpl	143d38 <_stack+0xc3d38>
    3d34:	00004202 	andeq	r4, r0, r2, lsl #4
    3d38:	86160000 	ldrhi	r0, [r6], -r0
    3d3c:	05000004 	streq	r0, [r0, #-4]
    3d40:	0560025b 	strbeq	r0, [r0, #-603]!	; 0x25b
    3d44:	16040000 	strne	r0, [r4], -r0
    3d48:	000002d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    3d4c:	93025c05 	movwls	r5, #11269	; 0x2c05
    3d50:	08000007 	stmdaeq	r0, {r0, r1, r2}
    3d54:	00051a16 	andeq	r1, r5, r6, lsl sl
    3d58:	025d0500 	subseq	r0, sp, #0, 10
    3d5c:	00000191 	muleq	r0, r1, r1
    3d60:	020b1624 	andeq	r1, fp, #36, 12	; 0x2400000
    3d64:	5e050000 	cdppl	0, 0, cr0, cr5, cr0, {0}
    3d68:	00003002 	andeq	r3, r0, r2
    3d6c:	fd164800 	ldc2	8, cr4, [r6, #-0]
    3d70:	05000003 	streq	r0, [r0, #-3]
    3d74:	007c025f 	rsbseq	r0, ip, pc, asr r2
    3d78:	16500000 	ldrbne	r0, [r0], -r0
    3d7c:	00000530 	andeq	r0, r0, r0, lsr r5
    3d80:	4d026005 	stcmi	0, cr6, [r2, #-20]	; 0xffffffec
    3d84:	58000006 	stmdapl	r0, {r1, r2}
    3d88:	00040816 	andeq	r0, r4, r6, lsl r8
    3d8c:	02610500 	rsbeq	r0, r1, #0, 10
    3d90:	00000107 	andeq	r0, r0, r7, lsl #2
    3d94:	05351668 	ldreq	r1, [r5, #-1640]!	; 0x668
    3d98:	62050000 	andvs	r0, r5, #0
    3d9c:	00010702 	andeq	r0, r1, r2, lsl #14
    3da0:	7f167000 	svcvc	0x00167000
    3da4:	05000000 	streq	r0, [r0, #-0]
    3da8:	01070263 	tsteq	r7, r3, ror #4
    3dac:	16780000 	ldrbtne	r0, [r8], -r0
    3db0:	000004ed 	andeq	r0, r0, sp, ror #9
    3db4:	a3026405 	movwge	r6, #9221	; 0x2405
    3db8:	80000007 	andhi	r0, r0, r7
    3dbc:	0002c416 	andeq	ip, r2, r6, lsl r4
    3dc0:	02650500 	rsbeq	r0, r5, #0, 10
    3dc4:	000007b3 			; <UNDEFINED> instruction: 0x000007b3
    3dc8:	04a91688 	strteq	r1, [r9], #1672	; 0x688
    3dcc:	66050000 	strvs	r0, [r5], -r0
    3dd0:	00003002 	andeq	r3, r0, r2
    3dd4:	1716a000 	ldrne	sl, [r6, -r0]
    3dd8:	05000001 	streq	r0, [r0, #-1]
    3ddc:	01070267 	tsteq	r7, r7, ror #4
    3de0:	16a40000 	strtne	r0, [r4], r0
    3de4:	0000006b 	andeq	r0, r0, fp, rrx
    3de8:	07026805 	streq	r6, [r2, -r5, lsl #16]
    3dec:	ac000001 	stcge	0, cr0, [r0], {1}
    3df0:	00010616 	andeq	r0, r1, r6, lsl r6
    3df4:	02690500 	rsbeq	r0, r9, #0, 10
    3df8:	00000107 	andeq	r0, r0, r7, lsl #2
    3dfc:	002b16b4 	strhteq	r1, [fp], -r4
    3e00:	6a050000 	bvs	143e08 <_stack+0xc3e08>
    3e04:	00010702 	andeq	r0, r1, r2, lsl #14
    3e08:	3a16bc00 	bcc	5b2e10 <_stack+0x532e10>
    3e0c:	05000000 	streq	r0, [r0, #-0]
    3e10:	0107026b 	tsteq	r7, fp, ror #4
    3e14:	16c40000 	strbne	r0, [r4], r0
    3e18:	000003b0 			; <UNDEFINED> instruction: 0x000003b0
    3e1c:	30026c05 	andcc	r6, r2, r5, lsl #24
    3e20:	cc000000 	stcgt	0, cr0, [r0], {-0}
    3e24:	05660900 	strbeq	r0, [r6, #-2304]!	; 0x900
    3e28:	07a30000 	streq	r0, [r3, r0]!
    3e2c:	df0a0000 	svcle	0x000a0000
    3e30:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    3e34:	05660900 	strbeq	r0, [r6, #-2304]!	; 0x900
    3e38:	07b30000 	ldreq	r0, [r3, r0]!
    3e3c:	df0a0000 	svcle	0x000a0000
    3e40:	07000000 	streq	r0, [r0, -r0]
    3e44:	05660900 	strbeq	r0, [r6, #-2304]!	; 0x900
    3e48:	07c30000 	strbeq	r0, [r3, r0]
    3e4c:	df0a0000 	svcle	0x000a0000
    3e50:	17000000 	strne	r0, [r0, -r0]
    3e54:	05f01a00 	ldrbeq	r1, [r0, #2560]!	; 0xa00
    3e58:	07e70271 			; <UNDEFINED> instruction: 0x07e70271
    3e5c:	14160000 	ldrne	r0, [r6], #-0
    3e60:	05000003 	streq	r0, [r0, #-3]
    3e64:	07e70274 			; <UNDEFINED> instruction: 0x07e70274
    3e68:	16000000 	strne	r0, [r0], -r0
    3e6c:	000004e4 	andeq	r0, r0, r4, ror #9
    3e70:	f7027505 			; <UNDEFINED> instruction: 0xf7027505
    3e74:	78000007 	stmdavc	r0, {r0, r1, r2}
    3e78:	02da0900 	sbcseq	r0, sl, #0, 18
    3e7c:	07f70000 	ldrbeq	r0, [r7, r0]!
    3e80:	df0a0000 	svcle	0x000a0000
    3e84:	1d000000 	stcne	0, cr0, [r0, #-0]
    3e88:	00420900 	subeq	r0, r2, r0, lsl #18
    3e8c:	08070000 	stmdaeq	r7, {}	; <UNPREDICTABLE>
    3e90:	df0a0000 	svcle	0x000a0000
    3e94:	1d000000 	stcne	0, cr0, [r0, #-0]
    3e98:	05f01b00 	ldrbeq	r1, [r0, #2816]!	; 0xb00
    3e9c:	08290256 	stmdaeq	r9!, {r1, r2, r4, r6, r9}
    3ea0:	d91c0000 	ldmdble	ip, {}	; <UNPREDICTABLE>
    3ea4:	05000009 	streq	r0, [r0, #-9]
    3ea8:	0692026d 	ldreq	r0, [r2], sp, ror #4
    3eac:	071c0000 	ldreq	r0, [ip, -r0]
    3eb0:	05000005 	streq	r0, [r0, #-5]
    3eb4:	07c30276 			; <UNDEFINED> instruction: 0x07c30276
    3eb8:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    3ebc:	00000566 	andeq	r0, r0, r6, ror #10
    3ec0:	00000839 	andeq	r0, r0, r9, lsr r8
    3ec4:	0000df0a 	andeq	sp, r0, sl, lsl #30
    3ec8:	1d001800 	stcne	8, cr1, [r0, #-0]
    3ecc:	00000844 	andeq	r0, r0, r4, asr #16
    3ed0:	00042814 	andeq	r2, r4, r4, lsl r8
    3ed4:	040f0000 	streq	r0, [pc], #-0	; 3edc <CPSR_IRQ_INHIBIT+0x3e5c>
    3ed8:	00000839 	andeq	r0, r0, r9, lsr r8
    3edc:	017b040f 	cmneq	fp, pc, lsl #8
    3ee0:	5b1d0000 	blpl	743ee8 <_stack+0x6c3ee8>
    3ee4:	14000008 	strne	r0, [r0], #-8
    3ee8:	00000030 	andeq	r0, r0, r0, lsr r0
    3eec:	61040f00 	tstvs	r4, r0, lsl #30
    3ef0:	0f000008 	svceq	0x00000008
    3ef4:	00085004 	andeq	r5, r8, r4
    3ef8:	06000900 	streq	r0, [r0], -r0, lsl #18
    3efc:	08770000 	ldmdaeq	r7!, {}^	; <UNPREDICTABLE>
    3f00:	df0a0000 	svcle	0x000a0000
    3f04:	02000000 	andeq	r0, r0, #0
    3f08:	069b1900 	ldreq	r1, [fp], r0, lsl #18
    3f0c:	01280000 	teqeq	r8, r0
    3f10:	090702d8 	stmdbeq	r7, {r3, r4, r6, r7, r9}
    3f14:	7a160000 	bvc	583f1c <_stack+0x503f1c>
    3f18:	01000005 	tsteq	r0, r5
    3f1c:	003002d9 	ldrsbteq	r0, [r0], -r9
    3f20:	16000000 	strne	r0, [r0], -r0
    3f24:	000005dc 	ldrdeq	r0, [r0], -ip
    3f28:	3002da01 	andcc	sp, r2, r1, lsl #20
    3f2c:	04000000 	streq	r0, [r0], #-0
    3f30:	00064f16 	andeq	r4, r6, r6, lsl pc
    3f34:	02db0100 	sbcseq	r0, fp, #0, 2
    3f38:	00000030 	andeq	r0, r0, r0, lsr r0
    3f3c:	056d1608 	strbeq	r1, [sp, #-1544]!	; 0x608
    3f40:	dc010000 	stcle	0, cr0, [r1], {-0}
    3f44:	00003002 	andeq	r3, r0, r2
    3f48:	72160c00 	andsvc	r0, r6, #0, 24
    3f4c:	01000007 	tsteq	r0, r7
    3f50:	003002dd 	ldrsbteq	r0, [r0], -sp
    3f54:	16100000 	ldrne	r0, [r0], -r0
    3f58:	0000067b 	andeq	r0, r0, fp, ror r6
    3f5c:	3002de01 	andcc	sp, r2, r1, lsl #28
    3f60:	14000000 	strne	r0, [r0], #-0
    3f64:	00064e16 	andeq	r4, r6, r6, lsl lr
    3f68:	02df0100 	sbcseq	r0, pc, #0, 2
    3f6c:	00000030 	andeq	r0, r0, r0, lsr r0
    3f70:	060b1618 			; <UNDEFINED> instruction: 0x060b1618
    3f74:	e0010000 	and	r0, r1, r0
    3f78:	00003002 	andeq	r3, r0, r2
    3f7c:	db161c00 	blle	58af84 <_stack+0x50af84>
    3f80:	01000005 	tsteq	r0, r5
    3f84:	003002e1 	eorseq	r0, r0, r1, ror #5
    3f88:	16200000 	strtne	r0, [r0], -r0
    3f8c:	0000074b 	andeq	r0, r0, fp, asr #14
    3f90:	3002e201 	andcc	lr, r2, r1, lsl #4
    3f94:	24000000 	strcs	r0, [r0], #-0
    3f98:	06561900 	ldrbeq	r1, [r6], -r0, lsl #18
    3f9c:	01100000 	tsteq	r0, r0
    3fa0:	094704e9 	stmdbeq	r7, {r0, r3, r5, r6, r7, sl}^
    3fa4:	52160000 	andspl	r0, r6, #0
    3fa8:	01000005 	tsteq	r0, r5
    3fac:	003704eb 	eorseq	r0, r7, fp, ror #9
    3fb0:	16000000 	strne	r0, [r0], -r0
    3fb4:	00000619 	andeq	r0, r0, r9, lsl r6
    3fb8:	3704ec01 	strcc	lr, [r4, -r1, lsl #24]
    3fbc:	04000000 	streq	r0, [r0], #-0
    3fc0:	0064661e 	rsbeq	r6, r4, lr, lsl r6
    3fc4:	4704ed01 	strmi	lr, [r4, -r1, lsl #26]
    3fc8:	08000009 	stmdaeq	r0, {r0, r3}
    3fcc:	006b621e 	rsbeq	r6, fp, lr, lsl r2
    3fd0:	4704ee01 	strmi	lr, [r4, -r1, lsl #28]
    3fd4:	0c000009 	stceq	0, cr0, [r0], {9}
    3fd8:	07040f00 	streq	r0, [r4, -r0, lsl #30]
    3fdc:	06000009 	streq	r0, [r0], -r9
    3fe0:	00000734 	andeq	r0, r0, r4, lsr r7
    3fe4:	4704f101 	strmi	pc, [r4, -r1, lsl #2]
    3fe8:	06000009 	streq	r0, [r0], -r9
    3fec:	000005ad 	andeq	r0, r0, sp, lsr #11
    3ff0:	47061d01 	strmi	r1, [r6, -r1, lsl #26]
    3ff4:	1f000009 	svcne	0x00000009
    3ff8:	00000a85 	andeq	r0, r0, r5, lsl #21
    3ffc:	300ce901 	andcc	lr, ip, r1, lsl #18
    4000:	10000000 	andne	r0, r0, r0
    4004:	a20000a5 	andge	r0, r0, #165	; 0xa5
    4008:	01000000 	mrseq	r0, (UNDEF: 0)
    400c:	000a739c 	muleq	sl, ip, r3
    4010:	06c32000 	strbeq	r2, [r3], r0
    4014:	e9010000 	stmdb	r1, {}	; <UNPREDICTABLE>
    4018:	0004280c 	andeq	r2, r4, ip, lsl #16
    401c:	0013b500 	andseq	fp, r3, r0, lsl #10
    4020:	61702100 	cmnvs	r0, r0, lsl #2
    4024:	e9010064 	stmdb	r1, {r2, r5, r6}
    4028:	0000370c 	andeq	r3, r0, ip, lsl #14
    402c:	0013d300 	andseq	sp, r3, r0, lsl #6
    4030:	07422200 	strbeq	r2, [r2, -r0, lsl #4]
    4034:	ee010000 	cdp	0, 0, cr0, cr1, cr0, {0}
    4038:	0000670c 	andeq	r6, r0, ip, lsl #14
    403c:	0013ff00 	andseq	pc, r3, r0, lsl #30
    4040:	0a602200 	beq	180c848 <_stack+0x178c848>
    4044:	ef010000 	svc	0x00010000
    4048:	0000670c 	andeq	r6, r0, ip, lsl #14
    404c:	00144300 	andseq	r4, r4, r0, lsl #6
    4050:	0a6b2200 	beq	1acc858 <_stack+0x1a4c858>
    4054:	f0010000 			; <UNDEFINED> instruction: 0xf0010000
    4058:	0005600c 	andeq	r6, r5, ip
    405c:	00146100 	andseq	r6, r4, r0, lsl #2
    4060:	05b52200 	ldreq	r2, [r5, #512]!	; 0x200
    4064:	f1010000 	setend	le
    4068:	0005600c 	andeq	r6, r5, ip
    406c:	00148a00 	andseq	r8, r4, r0, lsl #20
    4070:	06832300 	streq	r2, [r3], r0, lsl #6
    4074:	f3010000 	vhadd.u8	d0, d1, d0
    4078:	00006e0c 	andeq	r6, r0, ip, lsl #28
    407c:	24100000 	ldrcs	r0, [r0], #-0
    4080:	0000a522 	andeq	sl, r0, r2, lsr #10
    4084:	00000be1 	andeq	r0, r0, r1, ror #23
    4088:	00000a01 	andeq	r0, r0, r1, lsl #20
    408c:	02500125 	subseq	r0, r0, #1073741833	; 0x40000009
    4090:	24000075 	strcs	r0, [r0], #-117	; 0x75
    4094:	0000a544 	andeq	sl, r0, r4, asr #10
    4098:	00000bf3 	strdeq	r0, [r0], -r3
    409c:	00000a1a 	andeq	r0, r0, sl, lsl sl
    40a0:	01510125 	cmpeq	r1, r5, lsr #2
    40a4:	50012530 	andpl	r2, r1, r0, lsr r5
    40a8:	00007502 	andeq	r7, r0, r2, lsl #10
    40ac:	00a55224 	adceq	r5, r5, r4, lsr #4
    40b0:	000c0d00 	andeq	r0, ip, r0, lsl #26
    40b4:	000a2e00 	andeq	r2, sl, r0, lsl #28
    40b8:	50012500 	andpl	r2, r1, r0, lsl #10
    40bc:	00007502 	andeq	r7, r0, r2, lsl #10
    40c0:	00a55e24 	adceq	r5, r5, r4, lsr #28
    40c4:	000bf300 	andeq	pc, fp, r0, lsl #6
    40c8:	000a4900 	andeq	r4, sl, r0, lsl #18
    40cc:	51012500 	tstpl	r1, r0, lsl #10
    40d0:	1f007703 	svcne	0x00007703
    40d4:	02500125 	subseq	r0, r0, #1073741833	; 0x40000009
    40d8:	24000075 	strcs	r0, [r0], #-117	; 0x75
    40dc:	0000a580 	andeq	sl, r0, r0, lsl #11
    40e0:	00000c0d 	andeq	r0, r0, sp, lsl #24
    40e4:	00000a5d 	andeq	r0, r0, sp, asr sl
    40e8:	02500125 	subseq	r0, r0, #1073741833	; 0x40000009
    40ec:	26000075 			; <UNDEFINED> instruction: 0x26000075
    40f0:	0000a58c 	andeq	sl, r0, ip, lsl #11
    40f4:	00000bf3 	strdeq	r0, [r0], -r3
    40f8:	01510125 	cmpeq	r1, r5, lsr #2
    40fc:	50012530 	andpl	r2, r1, r0, lsr r5
    4100:	00007502 	andeq	r7, r0, r2, lsl #10
    4104:	03952700 	orrseq	r2, r5, #0, 14
    4108:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
    410c:	00a5b40a 	adceq	fp, r5, sl, lsl #8
    4110:	00019800 	andeq	r9, r1, r0, lsl #16
    4114:	949c0100 	ldrls	r0, [ip], #256	; 0x100
    4118:	2000000b 	andcs	r0, r0, fp
    411c:	000006c3 	andeq	r0, r0, r3, asr #13
    4120:	280a3e01 	stmdacs	sl, {r0, r9, sl, fp, ip, sp}
    4124:	b7000004 	strlt	r0, [r0, -r4]
    4128:	21000014 	tstcs	r0, r4, lsl r0
    412c:	006d656d 	rsbeq	r6, sp, sp, ror #10
    4130:	490a3e01 	stmdbmi	sl, {r0, r9, sl, fp, ip, sp}
    4134:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
    4138:	28000015 	stmdacs	r0, {r0, r2, r4}
    413c:	49010070 	stmdbmi	r1, {r4, r5, r6}
    4140:	00094d0a 	andeq	r4, r9, sl, lsl #26
    4144:	00159300 	andseq	r9, r5, r0, lsl #6
    4148:	64682800 	strbtvs	r2, [r8], #-2048	; 0x800
    414c:	0a4a0100 	beq	1284554 <_stack+0x1204554>
    4150:	00000037 	andeq	r0, r0, r7, lsr r0
    4154:	000015c8 	andeq	r1, r0, r8, asr #11
    4158:	007a7328 	rsbseq	r7, sl, r8, lsr #6
    415c:	370a4b01 	strcc	r4, [sl, -r1, lsl #22]
    4160:	f2000000 	vhadd.s8	d0, d0, d0
    4164:	28000015 	stmdacs	r0, {r0, r2, r4}
    4168:	00786469 	rsbseq	r6, r8, r9, ror #8
    416c:	300a4c01 	andcc	r4, sl, r1, lsl #24
    4170:	3c000000 	stccc	0, cr0, [r0], {-0}
    4174:	22000016 	andcs	r0, r0, #22
    4178:	00000403 	andeq	r0, r0, r3, lsl #8
    417c:	4d0a4d01 	stcmi	13, cr4, [sl, #-4]
    4180:	65000009 	strvs	r0, [r0, #-9]
    4184:	22000016 	andcs	r0, r0, #22
    4188:	00000a77 	andeq	r0, r0, r7, ror sl
    418c:	370a4e01 	strcc	r4, [sl, -r1, lsl #28]
    4190:	a3000000 	movwge	r0, #0
    4194:	22000016 	andcs	r0, r0, #22
    4198:	00000a7e 	andeq	r0, r0, lr, ror sl
    419c:	370a4f01 	strcc	r4, [sl, -r1, lsl #30]
    41a0:	03000000 	movweq	r0, #0
    41a4:	28000017 	stmdacs	r0, {r0, r1, r2, r4}
    41a8:	006b6362 	rsbeq	r6, fp, r2, ror #6
    41ac:	4d0a5001 	stcmi	0, cr5, [sl, #-4]
    41b0:	3c000009 	stccc	0, cr0, [r0], {9}
    41b4:	28000017 	stmdacs	r0, {r0, r1, r2, r4}
    41b8:	00647766 	rsbeq	r7, r4, r6, ror #14
    41bc:	4d0a5101 	stfmis	f5, [sl, #-4]
    41c0:	91000009 	tstls	r0, r9
    41c4:	22000017 	andcs	r0, r0, #23
    41c8:	00000a66 	andeq	r0, r0, r6, ror #20
    41cc:	300a5201 	andcc	r5, sl, r1, lsl #4
    41d0:	db000000 	blle	41d8 <CPSR_IRQ_INHIBIT+0x4158>
    41d4:	24000017 	strcs	r0, [r0], #-23
    41d8:	0000a5c4 	andeq	sl, r0, r4, asr #11
    41dc:	00000be1 	andeq	r0, r0, r1, ror #23
    41e0:	00000b59 	andeq	r0, r0, r9, asr fp
    41e4:	02500125 	subseq	r0, r0, #1073741833	; 0x40000009
    41e8:	29000078 	stmdbcs	r0, {r3, r4, r5, r6}
    41ec:	0000a67e 	andeq	sl, r0, lr, ror r6
    41f0:	00000c0d 	andeq	r0, r0, sp, lsl #24
    41f4:	00000b6e 	andeq	r0, r0, lr, ror #22
    41f8:	03500125 	cmpeq	r0, #1073741833	; 0x40000009
    41fc:	005001f3 	ldrsheq	r0, [r0], #-19	; 0xffffffed
    4200:	00a6aa29 	adceq	sl, r6, r9, lsr #20
    4204:	000c0d00 	andeq	r0, ip, r0, lsl #26
    4208:	000b8300 	andeq	r8, fp, r0, lsl #6
    420c:	50012500 	andpl	r2, r1, r0, lsl #10
    4210:	5001f303 	andpl	pc, r1, r3, lsl #6
    4214:	a6e62600 	strbtge	r2, [r6], r0, lsl #12
    4218:	09650000 	stmdbeq	r5!, {}^	; <UNPREDICTABLE>
    421c:	01250000 	teqeq	r5, r0
    4220:	00780250 	rsbseq	r0, r8, r0, asr r2
    4224:	59090000 	stmdbpl	r9, {}	; <UNPREDICTABLE>
    4228:	a5000009 	strge	r0, [r0, #-9]
    422c:	2a00000b 	bcs	4260 <CPSR_IRQ_INHIBIT+0x41e0>
    4230:	000000df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    4234:	2b000101 	blcs	4640 <CPSR_IRQ_INHIBIT+0x45c0>
    4238:	000006b6 			; <UNDEFINED> instruction: 0x000006b6
    423c:	94065101 	strls	r5, [r6], #-257	; 0x101
    4240:	2b00000b 	blcs	4274 <CPSR_IRQ_INHIBIT+0x41f4>
    4244:	00000663 	andeq	r0, r0, r3, ror #12
    4248:	6e06c801 	cdpvs	8, 0, cr12, cr6, cr1, {0}
    424c:	2b000000 	blcs	4254 <CPSR_IRQ_INHIBIT+0x41d4>
    4250:	0000055c 	andeq	r0, r0, ip, asr r5
    4254:	6e06c901 	cdpvs	9, 0, cr12, cr6, cr1, {0}
    4258:	2b000000 	blcs	4260 <CPSR_IRQ_INHIBIT+0x41e0>
    425c:	00000754 	andeq	r0, r0, r4, asr r7
    4260:	6006ce01 	andvs	ip, r6, r1, lsl #28
    4264:	2b000005 	blcs	4280 <CPSR_IRQ_INHIBIT+0x4200>
    4268:	0000068a 	andeq	r0, r0, sl, lsl #13
    426c:	7706d101 	strvc	sp, [r6, -r1, lsl #2]
    4270:	2c000008 	stccs	0, cr0, [r0], {8}
    4274:	000005f3 	strdeq	r0, [r0], -r3
    4278:	f3014801 	vsub.i8	d4, d1, d1
    427c:	1400000b 	strne	r0, [r0], #-11
    4280:	00000428 	andeq	r0, r0, r8, lsr #8
    4284:	071a2d00 	ldreq	r2, [sl, -r0, lsl #26]
    4288:	9a060000 	bls	184290 <_stack+0x104290>
    428c:	00000049 	andeq	r0, r0, r9, asr #32
    4290:	00000c0d 	andeq	r0, r0, sp, lsl #24
    4294:	00042814 	andeq	r2, r4, r4, lsl r8
    4298:	00251400 	eoreq	r1, r5, r0, lsl #8
    429c:	2e000000 	cdpcs	0, 0, cr0, cr0, cr0, {0}
    42a0:	0000059d 	muleq	r0, sp, r5
    42a4:	14014901 	strne	r4, [r1], #-2305	; 0x901
    42a8:	00000428 	andeq	r0, r0, r8, lsr #8
    42ac:	08900000 	ldmeq	r0, {}	; <UNPREDICTABLE>
    42b0:	00040000 	andeq	r0, r4, r0
    42b4:	00000ee8 	andeq	r0, r0, r8, ror #29
    42b8:	01410104 	cmpeq	r1, r4, lsl #2
    42bc:	a0010000 	andge	r0, r1, r0
    42c0:	7500000a 	strvc	r0, [r0, #-10]
    42c4:	49000009 	stmdbmi	r0, {r0, r3}
    42c8:	0200000e 	andeq	r0, r0, #14
    42cc:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    42d0:	04030074 	streq	r0, [r3], #-116	; 0x74
    42d4:	00005507 	andeq	r5, r0, r7, lsl #10
    42d8:	06010300 	streq	r0, [r1], -r0, lsl #6
    42dc:	0000039f 	muleq	r0, pc, r3	; <UNPREDICTABLE>
    42e0:	9d080103 	stflss	f0, [r8, #-12]
    42e4:	03000003 	movweq	r0, #3
    42e8:	03b90502 			; <UNDEFINED> instruction: 0x03b90502
    42ec:	02030000 	andeq	r0, r3, #0
    42f0:	0002a807 	andeq	sl, r2, r7, lsl #16
    42f4:	05040300 	streq	r0, [r4, #-768]	; 0x300
    42f8:	0000009b 	muleq	r0, fp, r0
    42fc:	50070403 	andpl	r0, r7, r3, lsl #8
    4300:	03000000 	movweq	r0, #0
    4304:	00960508 	addseq	r0, r6, r8, lsl #10
    4308:	08030000 	stmdaeq	r3, {}	; <UNPREDICTABLE>
    430c:	00004b07 	andeq	r4, r0, r7, lsl #22
    4310:	034f0400 	movteq	r0, #62464	; 0xf400
    4314:	07010000 	streq	r0, [r1, -r0]
    4318:	0000001d 	andeq	r0, r0, sp, lsl r0
    431c:	00033704 	andeq	r3, r3, r4, lsl #14
    4320:	47100200 	ldrmi	r0, [r0, -r0, lsl #4]
    4324:	04000000 	streq	r0, [r0], #-0
    4328:	00000467 	andeq	r0, r0, r7, ror #8
    432c:	00472702 	subeq	r2, r7, r2, lsl #14
    4330:	eb050000 	bl	144338 <_stack+0xc4338>
    4334:	03000002 	movweq	r0, #2
    4338:	00240161 	eoreq	r0, r4, r1, ror #2
    433c:	04060000 	streq	r0, [r6], #-0
    4340:	00af4a02 	adceq	r4, pc, r2, lsl #20
    4344:	e5070000 	str	r0, [r7, #-0]
    4348:	02000002 	andeq	r0, r0, #2
    434c:	0000844c 	andeq	r8, r0, ip, asr #8
    4350:	022f0700 	eoreq	r0, pc, #0, 14
    4354:	4d020000 	stcmi	0, cr0, [r2, #-0]
    4358:	000000af 	andeq	r0, r0, pc, lsr #1
    435c:	00320800 	eorseq	r0, r2, r0, lsl #16
    4360:	00bf0000 	adcseq	r0, pc, r0
    4364:	bf090000 	svclt	0x00090000
    4368:	03000000 	movweq	r0, #0
    436c:	07040300 	streq	r0, [r4, -r0, lsl #6]
    4370:	0000030b 	andeq	r0, r0, fp, lsl #6
    4374:	4702080a 	strmi	r0, [r2, -sl, lsl #16]
    4378:	000000e7 	andeq	r0, r0, r7, ror #1
    437c:	0004510b 	andeq	r5, r4, fp, lsl #2
    4380:	1d490200 	sfmne	f0, 2, [r9, #-0]
    4384:	00000000 	andeq	r0, r0, r0
    4388:	0004590b 	andeq	r5, r4, fp, lsl #18
    438c:	904e0200 	subls	r0, lr, r0, lsl #4
    4390:	04000000 	streq	r0, [r0], #-0
    4394:	03e10400 	mvneq	r0, #0, 8
    4398:	4f020000 	svcmi	0x00020000
    439c:	000000c6 	andeq	r0, r0, r6, asr #1
    43a0:	00013804 	andeq	r3, r1, r4, lsl #16
    43a4:	63530200 	cmpvs	r3, #0, 4
    43a8:	0c000000 	stceq	0, cr0, [r0], {-0}
    43ac:	04a10404 	strteq	r0, [r1], #1028	; 0x404
    43b0:	16040000 	strne	r0, [r4], -r0
    43b4:	0000004e 	andeq	r0, r0, lr, asr #32
    43b8:	0002030d 	andeq	r0, r2, sp, lsl #6
    43bc:	2d041800 	stccs	8, cr1, [r4, #-0]
    43c0:	0000015d 	andeq	r0, r0, sp, asr r1
    43c4:	0004020b 	andeq	r0, r4, fp, lsl #4
    43c8:	5d2f0400 	cfstrspl	mvf0, [pc, #-0]	; 43d0 <CPSR_IRQ_INHIBIT+0x4350>
    43cc:	00000001 	andeq	r0, r0, r1
    43d0:	006b5f0e 	rsbeq	r5, fp, lr, lsl #30
    43d4:	001d3004 	andseq	r3, sp, r4
    43d8:	0b040000 	bleq	1043e0 <_stack+0x843e0>
    43dc:	00000443 	andeq	r0, r0, r3, asr #8
    43e0:	001d3004 	andseq	r3, sp, r4
    43e4:	0b080000 	bleq	2043ec <_stack+0x1843ec>
    43e8:	00000132 	andeq	r0, r0, r2, lsr r1
    43ec:	001d3004 	andseq	r3, sp, r4
    43f0:	0b0c0000 	bleq	3043f8 <_stack+0x2843f8>
    43f4:	000004d5 	ldrdeq	r0, [r0], -r5
    43f8:	001d3004 	andseq	r3, sp, r4
    43fc:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
    4400:	0400785f 	streq	r7, [r0], #-2143	; 0x85f
    4404:	00016331 	andeq	r6, r1, r1, lsr r3
    4408:	0f001400 	svceq	0x00001400
    440c:	00010a04 	andeq	r0, r1, r4, lsl #20
    4410:	00ff0800 	rscseq	r0, pc, r0, lsl #16
    4414:	01730000 	cmneq	r3, r0
    4418:	bf090000 	svclt	0x00090000
    441c:	00000000 	andeq	r0, r0, r0
    4420:	022a0d00 	eoreq	r0, sl, #0, 26
    4424:	04240000 	strteq	r0, [r4], #-0
    4428:	0001ec35 	andeq	lr, r1, r5, lsr ip
    442c:	008d0b00 	addeq	r0, sp, r0, lsl #22
    4430:	37040000 	strcc	r0, [r4, -r0]
    4434:	0000001d 	andeq	r0, r0, sp, lsl r0
    4438:	046f0b00 	strbteq	r0, [pc], #-2816	; 4440 <CPSR_IRQ_INHIBIT+0x43c0>
    443c:	38040000 	stmdacc	r4, {}	; <UNPREDICTABLE>
    4440:	0000001d 	andeq	r0, r0, sp, lsl r0
    4444:	00aa0b04 	adceq	r0, sl, r4, lsl #22
    4448:	39040000 	stmdbcc	r4, {}	; <UNPREDICTABLE>
    444c:	0000001d 	andeq	r0, r0, sp, lsl r0
    4450:	05480b08 	strbeq	r0, [r8, #-2824]	; 0xb08
    4454:	3a040000 	bcc	10445c <_stack+0x8445c>
    4458:	0000001d 	andeq	r0, r0, sp, lsl r0
    445c:	031b0b0c 	tsteq	fp, #12, 22	; 0x3000
    4460:	3b040000 	blcc	104468 <_stack+0x84468>
    4464:	0000001d 	andeq	r0, r0, sp, lsl r0
    4468:	03010b10 	movweq	r0, #6928	; 0x1b10
    446c:	3c040000 	stccc	0, cr0, [r4], {-0}
    4470:	0000001d 	andeq	r0, r0, sp, lsl r0
    4474:	04da0b14 	ldrbeq	r0, [sl], #2836	; 0xb14
    4478:	3d040000 	stccc	0, cr0, [r4, #-0]
    447c:	0000001d 	andeq	r0, r0, sp, lsl r0
    4480:	03c30b18 	biceq	r0, r3, #24, 22	; 0x6000
    4484:	3e040000 	cdpcc	0, 0, cr0, cr4, cr0, {0}
    4488:	0000001d 	andeq	r0, r0, sp, lsl r0
    448c:	050f0b1c 	streq	r0, [pc, #-2844]	; 3978 <CPSR_IRQ_INHIBIT+0x38f8>
    4490:	3f040000 	svccc	0x00040000
    4494:	0000001d 	andeq	r0, r0, sp, lsl r0
    4498:	b9100020 	ldmdblt	r0, {r5}
    449c:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    44a0:	2c480401 	cfstrdcs	mvd0, [r8], {1}
    44a4:	0b000002 	bleq	44b4 <CPSR_IRQ_INHIBIT+0x4434>
    44a8:	00000125 	andeq	r0, r0, r5, lsr #2
    44ac:	022c4904 	eoreq	r4, ip, #4, 18	; 0x10000
    44b0:	0b000000 	bleq	44b8 <CPSR_IRQ_INHIBIT+0x4438>
    44b4:	00000000 	andeq	r0, r0, r0
    44b8:	022c4a04 	eoreq	r4, ip, #4, 20	; 0x4000
    44bc:	11800000 	orrne	r0, r0, r0
    44c0:	00000493 	muleq	r0, r3, r4
    44c4:	00ff4c04 	rscseq	r4, pc, r4, lsl #24
    44c8:	01000000 	mrseq	r0, (UNDEF: 0)
    44cc:	0000de11 	andeq	sp, r0, r1, lsl lr
    44d0:	ff4f0400 			; <UNDEFINED> instruction: 0xff4f0400
    44d4:	04000000 	streq	r0, [r0], #-0
    44d8:	fd080001 	stc2	0, cr0, [r8, #-4]
    44dc:	3c000000 	stccc	0, cr0, [r0], {-0}
    44e0:	09000002 	stmdbeq	r0, {r1}
    44e4:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    44e8:	2410001f 	ldrcs	r0, [r0], #-31
    44ec:	90000003 	andls	r0, r0, r3
    44f0:	7a5b0401 	bvc	16c54fc <_stack+0x16454fc>
    44f4:	0b000002 	bleq	4504 <CPSR_IRQ_INHIBIT+0x4484>
    44f8:	00000402 	andeq	r0, r0, r2, lsl #8
    44fc:	027a5c04 	rsbseq	r5, sl, #4, 24	; 0x400
    4500:	0b000000 	bleq	4508 <CPSR_IRQ_INHIBIT+0x4488>
    4504:	0000041a 	andeq	r0, r0, sl, lsl r4
    4508:	001d5d04 	andseq	r5, sp, r4, lsl #26
    450c:	0b040000 	bleq	104514 <_stack+0x84514>
    4510:	0000012d 	andeq	r0, r0, sp, lsr #2
    4514:	02805f04 	addeq	r5, r0, #4, 30
    4518:	0b080000 	bleq	204520 <_stack+0x184520>
    451c:	000000b9 	strheq	r0, [r0], -r9
    4520:	01ec6004 	mvneq	r6, r4
    4524:	00880000 	addeq	r0, r8, r0
    4528:	023c040f 	eorseq	r0, ip, #251658240	; 0xf000000
    452c:	90080000 	andls	r0, r8, r0
    4530:	90000002 	andls	r0, r0, r2
    4534:	09000002 	stmdbeq	r0, {r1}
    4538:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    453c:	040f001f 	streq	r0, [pc], #-31	; 4544 <CPSR_IRQ_INHIBIT+0x44c4>
    4540:	00000296 	muleq	r0, r6, r2
    4544:	03cd0d12 	biceq	r0, sp, #1152	; 0x480
    4548:	04080000 	streq	r0, [r8], #-0
    454c:	0002bc73 	andeq	fp, r2, r3, ror ip
    4550:	07610b00 	strbeq	r0, [r1, -r0, lsl #22]!
    4554:	74040000 	strvc	r0, [r4], #-0
    4558:	000002bc 			; <UNDEFINED> instruction: 0x000002bc
    455c:	06180b00 	ldreq	r0, [r8], -r0, lsl #22
    4560:	75040000 	strvc	r0, [r4, #-0]
    4564:	0000001d 	andeq	r0, r0, sp, lsl r0
    4568:	040f0004 	streq	r0, [pc], #-4	; 4570 <CPSR_IRQ_INHIBIT+0x44f0>
    456c:	00000032 	andeq	r0, r0, r2, lsr r0
    4570:	0003ec0d 	andeq	lr, r3, sp, lsl #24
    4574:	b3046800 	movwlt	r6, #18432	; 0x4800
    4578:	000003ec 	andeq	r0, r0, ip, ror #7
    457c:	00705f0e 	rsbseq	r5, r0, lr, lsl #30
    4580:	02bcb404 	adcseq	fp, ip, #4, 8	; 0x4000000
    4584:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    4588:	0400725f 	streq	r7, [r0], #-607	; 0x25f
    458c:	00001db5 			; <UNDEFINED> instruction: 0x00001db5
    4590:	5f0e0400 	svcpl	0x000e0400
    4594:	b6040077 			; <UNDEFINED> instruction: 0xb6040077
    4598:	0000001d 	andeq	r0, r0, sp, lsl r0
    459c:	00d70b08 	sbcseq	r0, r7, r8, lsl #22
    45a0:	b7040000 	strlt	r0, [r4, -r0]
    45a4:	00000039 	andeq	r0, r0, r9, lsr r0
    45a8:	02460b0c 	subeq	r0, r6, #12, 22	; 0x3000
    45ac:	b8040000 	stmdalt	r4, {}	; <UNPREDICTABLE>
    45b0:	00000039 	andeq	r0, r0, r9, lsr r0
    45b4:	625f0e0e 	subsvs	r0, pc, #14, 28	; 0xe0
    45b8:	b9040066 	stmdblt	r4, {r1, r2, r5, r6}
    45bc:	00000297 	muleq	r0, r7, r2
    45c0:	00620b10 	rsbeq	r0, r2, r0, lsl fp
    45c4:	ba040000 	blt	1045cc <_stack+0x845cc>
    45c8:	0000001d 	andeq	r0, r0, sp, lsl r0
    45cc:	00c70b18 	sbceq	r0, r7, r8, lsl fp
    45d0:	c1040000 	mrsgt	r0, (UNDEF: 4)
    45d4:	000000fd 	strdeq	r0, [r0], -sp
    45d8:	021a0b1c 	andseq	r0, sl, #28, 22	; 0x7000
    45dc:	c3040000 	movwgt	r0, #16384	; 0x4000
    45e0:	0000054f 	andeq	r0, r0, pc, asr #10
    45e4:	02fa0b20 	rscseq	r0, sl, #32, 22	; 0x8000
    45e8:	c5040000 	strgt	r0, [r4, #-0]
    45ec:	0000057e 	andeq	r0, r0, lr, ror r5
    45f0:	04610b24 	strbteq	r0, [r1], #-2852	; 0xb24
    45f4:	c8040000 	stmdagt	r4, {}	; <UNPREDICTABLE>
    45f8:	000005a2 	andeq	r0, r0, r2, lsr #11
    45fc:	05290b28 	streq	r0, [r9, #-2856]!	; 0xb28
    4600:	c9040000 	stmdbgt	r4, {}	; <UNPREDICTABLE>
    4604:	000005bc 			; <UNDEFINED> instruction: 0x000005bc
    4608:	755f0e2c 	ldrbvc	r0, [pc, #-3628]	; 37e4 <CPSR_IRQ_INHIBIT+0x3764>
    460c:	cc040062 	stcgt	0, cr0, [r4], {98}	; 0x62
    4610:	00000297 	muleq	r0, r7, r2
    4614:	755f0e30 	ldrbvc	r0, [pc, #-3632]	; 37ec <CPSR_IRQ_INHIBIT+0x376c>
    4618:	cd040070 	stcgt	0, cr0, [r4, #-448]	; 0xfffffe40
    461c:	000002bc 			; <UNDEFINED> instruction: 0x000002bc
    4620:	755f0e38 	ldrbvc	r0, [pc, #-3640]	; 37f0 <CPSR_IRQ_INHIBIT+0x3770>
    4624:	ce040072 	mcrgt	0, 0, r0, cr4, cr2, {3}
    4628:	0000001d 	andeq	r0, r0, sp, lsl r0
    462c:	00a40b3c 	adceq	r0, r4, ip, lsr fp
    4630:	d1040000 	mrsle	r0, (UNDEF: 4)
    4634:	000005c2 	andeq	r0, r0, r2, asr #11
    4638:	05010b40 	streq	r0, [r1, #-2880]	; 0xb40
    463c:	d2040000 	andle	r0, r4, #0
    4640:	000005d2 	ldrdeq	r0, [r0], -r2
    4644:	6c5f0e43 	mrrcvs	14, 4, r0, pc, cr3	; <UNPREDICTABLE>
    4648:	d5040062 	strle	r0, [r4, #-98]	; 0x62
    464c:	00000297 	muleq	r0, r7, r2
    4650:	00ed0b44 	rsceq	r0, sp, r4, asr #22
    4654:	d8040000 	stmdale	r4, {}	; <UNPREDICTABLE>
    4658:	0000001d 	andeq	r0, r0, sp, lsl r0
    465c:	00fe0b4c 	rscseq	r0, lr, ip, asr #22
    4660:	d9040000 	stmdble	r4, {}	; <UNPREDICTABLE>
    4664:	0000006e 	andeq	r0, r0, lr, rrx
    4668:	0a9a0b50 	beq	fe6873b0 <STACK_SVR+0xfa6873b0>
    466c:	dc040000 	stcle	0, cr0, [r4], {-0}
    4670:	0000040a 	andeq	r0, r0, sl, lsl #8
    4674:	05fb0b54 	ldrbeq	r0, [fp, #2900]!	; 0xb54
    4678:	e0040000 	and	r0, r4, r0
    467c:	000000f2 	strdeq	r0, [r0], -r2
    4680:	03f40b58 	mvnseq	r0, #88, 22	; 0x16000
    4684:	e2040000 	and	r0, r4, #0
    4688:	000000e7 	andeq	r0, r0, r7, ror #1
    468c:	02f20b5c 	rscseq	r0, r2, #92, 22	; 0x17000
    4690:	e3040000 	movw	r0, #16384	; 0x4000
    4694:	0000001d 	andeq	r0, r0, sp, lsl r0
    4698:	1d130064 	ldcne	0, cr0, [r3, #-400]	; 0xfffffe70
    469c:	0a000000 	beq	46a4 <CPSR_IRQ_INHIBIT+0x4624>
    46a0:	14000004 	strne	r0, [r0], #-4
    46a4:	0000040a 	andeq	r0, r0, sl, lsl #8
    46a8:	0000fd14 	andeq	pc, r0, r4, lsl sp	; <UNPREDICTABLE>
    46ac:	05421400 	strbeq	r1, [r2, #-1024]	; 0x400
    46b0:	1d140000 	ldcne	0, cr0, [r4, #-0]
    46b4:	00000000 	andeq	r0, r0, r0
    46b8:	0410040f 	ldreq	r0, [r0], #-1039	; 0x40f
    46bc:	d9150000 	ldmdble	r5, {}	; <UNPREDICTABLE>
    46c0:	28000009 	stmdacs	r0, {r0, r3}
    46c4:	02390404 	eorseq	r0, r9, #4, 8	; 0x4000000
    46c8:	00000542 	andeq	r0, r0, r2, asr #10
    46cc:	0003b216 	andeq	fp, r3, r6, lsl r2
    46d0:	023b0400 	eorseq	r0, fp, #0, 8
    46d4:	0000001d 	andeq	r0, r0, sp, lsl r0
    46d8:	00e61600 	rsceq	r1, r6, r0, lsl #12
    46dc:	40040000 	andmi	r0, r4, r0
    46e0:	00062902 	andeq	r2, r6, r2, lsl #18
    46e4:	36160400 	ldrcc	r0, [r6], -r0, lsl #8
    46e8:	04000002 	streq	r0, [r0], #-2
    46ec:	06290240 	strteq	r0, [r9], -r0, asr #4
    46f0:	16080000 	strne	r0, [r8], -r0
    46f4:	0000047e 	andeq	r0, r0, lr, ror r4
    46f8:	29024004 	stmdbcs	r2, {r2, lr}
    46fc:	0c000006 	stceq	0, cr0, [r0], {6}
    4700:	00041516 	andeq	r1, r4, r6, lsl r5
    4704:	02420400 	subeq	r0, r2, #0, 8
    4708:	0000001d 	andeq	r0, r0, sp, lsl r0
    470c:	00201610 	eoreq	r1, r0, r0, lsl r6
    4710:	43040000 	movwmi	r0, #16384	; 0x4000
    4714:	00080b02 	andeq	r0, r8, r2, lsl #22
    4718:	b6161400 	ldrlt	r1, [r6], -r0, lsl #8
    471c:	04000004 	streq	r0, [r0], #-4
    4720:	001d0245 	andseq	r0, sp, r5, asr #4
    4724:	16300000 	ldrtne	r0, [r0], -r0
    4728:	0000041f 	andeq	r0, r0, pc, lsl r4
    472c:	73024604 	movwvc	r4, #9732	; 0x2604
    4730:	34000005 	strcc	r0, [r0], #-5
    4734:	00032c16 	andeq	r2, r3, r6, lsl ip
    4738:	02480400 	subeq	r0, r8, #0, 8
    473c:	0000001d 	andeq	r0, r0, sp, lsl r0
    4740:	04391638 	ldrteq	r1, [r9], #-1592	; 0x638
    4744:	4a040000 	bmi	10474c <_stack+0x8474c>
    4748:	00082602 	andeq	r2, r8, r2, lsl #12
    474c:	dd163c00 	ldcle	12, cr3, [r6, #-0]
    4750:	04000002 	streq	r0, [r0], #-2
    4754:	015d024d 	cmpeq	sp, sp, asr #4
    4758:	16400000 	strbne	r0, [r0], -r0
    475c:	00000220 	andeq	r0, r0, r0, lsr #4
    4760:	1d024e04 	stcne	14, cr4, [r2, #-16]
    4764:	44000000 	strmi	r0, [r0], #-0
    4768:	00054316 	andeq	r4, r5, r6, lsl r3
    476c:	024f0400 	subeq	r0, pc, #0, 8
    4770:	0000015d 	andeq	r0, r0, sp, asr r1
    4774:	033e1648 	teqeq	lr, #72, 12	; 0x4800000
    4778:	50040000 	andpl	r0, r4, r0
    477c:	00082c02 	andeq	r2, r8, r2, lsl #24
    4780:	3e164c00 	cdpcc	12, 1, cr4, cr6, cr0, {0}
    4784:	04000002 	streq	r0, [r0], #-2
    4788:	001d0253 	andseq	r0, sp, r3, asr r2
    478c:	16500000 	ldrbne	r0, [r0], -r0
    4790:	000000f6 	strdeq	r0, [r0], -r6
    4794:	42025404 	andmi	r5, r2, #4, 8	; 0x4000000
    4798:	54000005 	strpl	r0, [r0], #-5
    479c:	0003ab16 	andeq	sl, r3, r6, lsl fp
    47a0:	02770400 	rsbseq	r0, r7, #0, 8
    47a4:	000007e9 	andeq	r0, r0, r9, ror #15
    47a8:	03241758 	teqeq	r4, #88, 14	; 0x1600000
    47ac:	7b040000 	blvc	1047b4 <_stack+0x847b4>
    47b0:	00027a02 	andeq	r7, r2, r2, lsl #20
    47b4:	17014800 	strne	r4, [r1, -r0, lsl #16]
    47b8:	000002bb 			; <UNDEFINED> instruction: 0x000002bb
    47bc:	3c027c04 	stccc	12, cr7, [r2], {4}
    47c0:	4c000002 	stcmi	0, cr0, [r0], {2}
    47c4:	04f71701 	ldrbteq	r1, [r7], #1793	; 0x701
    47c8:	80040000 	andhi	r0, r4, r0
    47cc:	00083d02 	andeq	r3, r8, r2, lsl #26
    47d0:	1702dc00 	strne	sp, [r2, -r0, lsl #24]
    47d4:	000000cf 	andeq	r0, r0, pc, asr #1
    47d8:	ee028504 	cfsh32	mvfx8, mvfx2, #4
    47dc:	e0000005 	and	r0, r0, r5
    47e0:	00b41702 	adcseq	r1, r4, r2, lsl #14
    47e4:	86040000 	strhi	r0, [r4], -r0
    47e8:	00084902 	andeq	r4, r8, r2, lsl #18
    47ec:	0002ec00 	andeq	lr, r2, r0, lsl #24
    47f0:	0548040f 	strbeq	r0, [r8, #-1039]	; 0x40f
    47f4:	01030000 	mrseq	r0, (UNDEF: 3)
    47f8:	0003a608 	andeq	sl, r3, r8, lsl #12
    47fc:	ec040f00 	stc	15, cr0, [r4], {-0}
    4800:	13000003 	movwne	r0, #3
    4804:	0000001d 	andeq	r0, r0, sp, lsl r0
    4808:	00000573 	andeq	r0, r0, r3, ror r5
    480c:	00040a14 	andeq	r0, r4, r4, lsl sl
    4810:	00fd1400 	rscseq	r1, sp, r0, lsl #8
    4814:	73140000 	tstvc	r4, #0
    4818:	14000005 	strne	r0, [r0], #-5
    481c:	0000001d 	andeq	r0, r0, sp, lsl r0
    4820:	79040f00 	stmdbvc	r4, {r8, r9, sl, fp}
    4824:	18000005 	stmdane	r0, {r0, r2}
    4828:	00000548 	andeq	r0, r0, r8, asr #10
    482c:	0555040f 	ldrbeq	r0, [r5, #-1039]	; 0x40f
    4830:	79130000 	ldmdbvc	r3, {}	; <UNPREDICTABLE>
    4834:	a2000000 	andge	r0, r0, #0
    4838:	14000005 	strne	r0, [r0], #-5
    483c:	0000040a 	andeq	r0, r0, sl, lsl #8
    4840:	0000fd14 	andeq	pc, r0, r4, lsl sp	; <UNPREDICTABLE>
    4844:	00791400 	rsbseq	r1, r9, r0, lsl #8
    4848:	1d140000 	ldcne	0, cr0, [r4, #-0]
    484c:	00000000 	andeq	r0, r0, r0
    4850:	0584040f 	streq	r0, [r4, #1039]	; 0x40f
    4854:	1d130000 	ldcne	0, cr0, [r3, #-0]
    4858:	bc000000 	stclt	0, cr0, [r0], {-0}
    485c:	14000005 	strne	r0, [r0], #-5
    4860:	0000040a 	andeq	r0, r0, sl, lsl #8
    4864:	0000fd14 	andeq	pc, r0, r4, lsl sp	; <UNPREDICTABLE>
    4868:	040f0000 	streq	r0, [pc], #-0	; 4870 <CPSR_IRQ_INHIBIT+0x47f0>
    486c:	000005a8 	andeq	r0, r0, r8, lsr #11
    4870:	00003208 	andeq	r3, r0, r8, lsl #4
    4874:	0005d200 	andeq	sp, r5, r0, lsl #4
    4878:	00bf0900 	adcseq	r0, pc, r0, lsl #18
    487c:	00020000 	andeq	r0, r2, r0
    4880:	00003208 	andeq	r3, r0, r8, lsl #4
    4884:	0005e200 	andeq	lr, r5, r0, lsl #4
    4888:	00bf0900 	adcseq	r0, pc, r0, lsl #18
    488c:	00000000 	andeq	r0, r0, r0
    4890:	0003da05 	andeq	sp, r3, r5, lsl #20
    4894:	011d0400 	tsteq	sp, r0, lsl #8
    4898:	000002c2 	andeq	r0, r0, r2, asr #5
    489c:	00093d19 	andeq	r3, r9, r9, lsl sp
    48a0:	21040c00 	tstcs	r4, r0, lsl #24
    48a4:	00062301 	andeq	r2, r6, r1, lsl #6
    48a8:	04021600 	streq	r1, [r2], #-1536	; 0x600
    48ac:	23040000 	movwcs	r0, #16384	; 0x4000
    48b0:	00062301 	andeq	r2, r6, r1, lsl #6
    48b4:	a1160000 	tstge	r6, r0
    48b8:	04000002 	streq	r0, [r0], #-2
    48bc:	001d0124 	andseq	r0, sp, r4, lsr #2
    48c0:	16040000 	strne	r0, [r4], -r0
    48c4:	000003d4 	ldrdeq	r0, [r0], -r4
    48c8:	29012504 	stmdbcs	r1, {r2, r8, sl, sp}
    48cc:	08000006 	stmdaeq	r0, {r1, r2}
    48d0:	ee040f00 	cdp	15, 0, cr0, cr4, cr0, {0}
    48d4:	0f000005 	svceq	0x00000005
    48d8:	0005e204 	andeq	lr, r5, r4, lsl #4
    48dc:	00131900 	andseq	r1, r3, r0, lsl #18
    48e0:	040e0000 	streq	r0, [lr], #-0
    48e4:	0664013d 			; <UNDEFINED> instruction: 0x0664013d
    48e8:	4b160000 	blmi	5848f0 <_stack+0x5048f0>
    48ec:	04000004 	streq	r0, [r0], #-4
    48f0:	0664013e 			; <UNDEFINED> instruction: 0x0664013e
    48f4:	16000000 	strne	r0, [r0], -r0
    48f8:	00000478 	andeq	r0, r0, r8, ror r4
    48fc:	64013f04 	strvs	r3, [r1], #-3844	; 0xf04
    4900:	06000006 	streq	r0, [r0], -r6
    4904:	00049c16 	andeq	r9, r4, r6, lsl ip
    4908:	01400400 	cmpeq	r0, r0, lsl #8
    490c:	00000040 	andeq	r0, r0, r0, asr #32
    4910:	4008000c 	andmi	r0, r8, ip
    4914:	74000000 	strvc	r0, [r0], #-0
    4918:	09000006 	stmdbeq	r0, {r1, r2}
    491c:	000000bf 	strheq	r0, [r0], -pc	; <UNPREDICTABLE>
    4920:	d01a0002 	andsle	r0, sl, r2
    4924:	75025804 	strvc	r5, [r2, #-2052]	; 0x804
    4928:	16000007 	strne	r0, [r0], -r7
    492c:	000004c8 	andeq	r0, r0, r8, asr #9
    4930:	24025a04 	strcs	r5, [r2], #-2564	; 0xa04
    4934:	00000000 	andeq	r0, r0, r0
    4938:	00048616 	andeq	r8, r4, r6, lsl r6
    493c:	025b0400 	subseq	r0, fp, #0, 8
    4940:	00000542 	andeq	r0, r0, r2, asr #10
    4944:	02d01604 	sbcseq	r1, r0, #4, 12	; 0x400000
    4948:	5c040000 	stcpl	0, cr0, [r4], {-0}
    494c:	00077502 	andeq	r7, r7, r2, lsl #10
    4950:	1a160800 	bne	586958 <_stack+0x506958>
    4954:	04000005 	streq	r0, [r0], #-5
    4958:	0173025d 	cmneq	r3, sp, asr r2
    495c:	16240000 	strtne	r0, [r4], -r0
    4960:	0000020b 	andeq	r0, r0, fp, lsl #4
    4964:	1d025e04 	stcne	14, cr5, [r2, #-16]
    4968:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
    496c:	0003fd16 	andeq	pc, r3, r6, lsl sp	; <UNPREDICTABLE>
    4970:	025f0400 	subseq	r0, pc, #0, 8
    4974:	0000005c 	andeq	r0, r0, ip, asr r0
    4978:	05301650 	ldreq	r1, [r0, #-1616]!	; 0x650
    497c:	60040000 	andvs	r0, r4, r0
    4980:	00062f02 	andeq	r2, r6, r2, lsl #30
    4984:	08165800 	ldmdaeq	r6, {fp, ip, lr}
    4988:	04000004 	streq	r0, [r0], #-4
    498c:	00e70261 	rsceq	r0, r7, r1, ror #4
    4990:	16680000 	strbtne	r0, [r8], -r0
    4994:	00000535 	andeq	r0, r0, r5, lsr r5
    4998:	e7026204 	str	r6, [r2, -r4, lsl #4]
    499c:	70000000 	andvc	r0, r0, r0
    49a0:	00007f16 	andeq	r7, r0, r6, lsl pc
    49a4:	02630400 	rsbeq	r0, r3, #0, 8
    49a8:	000000e7 	andeq	r0, r0, r7, ror #1
    49ac:	04ed1678 	strbteq	r1, [sp], #1656	; 0x678
    49b0:	64040000 	strvs	r0, [r4], #-0
    49b4:	00078502 	andeq	r8, r7, r2, lsl #10
    49b8:	c4168000 	ldrgt	r8, [r6], #-0
    49bc:	04000002 	streq	r0, [r0], #-2
    49c0:	07950265 	ldreq	r0, [r5, r5, ror #4]
    49c4:	16880000 	strne	r0, [r8], r0
    49c8:	000004a9 	andeq	r0, r0, r9, lsr #9
    49cc:	1d026604 	stcne	6, cr6, [r2, #-16]
    49d0:	a0000000 	andge	r0, r0, r0
    49d4:	00011716 	andeq	r1, r1, r6, lsl r7
    49d8:	02670400 	rsbeq	r0, r7, #0, 8
    49dc:	000000e7 	andeq	r0, r0, r7, ror #1
    49e0:	006b16a4 	rsbeq	r1, fp, r4, lsr #13
    49e4:	68040000 	stmdavs	r4, {}	; <UNPREDICTABLE>
    49e8:	0000e702 	andeq	lr, r0, r2, lsl #14
    49ec:	0616ac00 	ldreq	sl, [r6], -r0, lsl #24
    49f0:	04000001 	streq	r0, [r0], #-1
    49f4:	00e70269 	rsceq	r0, r7, r9, ror #4
    49f8:	16b40000 	ldrtne	r0, [r4], r0
    49fc:	0000002b 	andeq	r0, r0, fp, lsr #32
    4a00:	e7026a04 	str	r6, [r2, -r4, lsl #20]
    4a04:	bc000000 	stclt	0, cr0, [r0], {-0}
    4a08:	00003a16 	andeq	r3, r0, r6, lsl sl
    4a0c:	026b0400 	rsbeq	r0, fp, #0, 8
    4a10:	000000e7 	andeq	r0, r0, r7, ror #1
    4a14:	03b016c4 	movseq	r1, #196, 12	; 0xc400000
    4a18:	6c040000 	stcvs	0, cr0, [r4], {-0}
    4a1c:	00001d02 	andeq	r1, r0, r2, lsl #26
    4a20:	0800cc00 	stmdaeq	r0, {sl, fp, lr, pc}
    4a24:	00000548 	andeq	r0, r0, r8, asr #10
    4a28:	00000785 	andeq	r0, r0, r5, lsl #15
    4a2c:	0000bf09 	andeq	fp, r0, r9, lsl #30
    4a30:	08001900 	stmdaeq	r0, {r8, fp, ip}
    4a34:	00000548 	andeq	r0, r0, r8, asr #10
    4a38:	00000795 	muleq	r0, r5, r7
    4a3c:	0000bf09 	andeq	fp, r0, r9, lsl #30
    4a40:	08000700 	stmdaeq	r0, {r8, r9, sl}
    4a44:	00000548 	andeq	r0, r0, r8, asr #10
    4a48:	000007a5 	andeq	r0, r0, r5, lsr #15
    4a4c:	0000bf09 	andeq	fp, r0, r9, lsl #30
    4a50:	1a001700 	bne	a658 <_free_r+0xa4>
    4a54:	027104f0 	rsbseq	r0, r1, #240, 8	; 0xf0000000
    4a58:	000007c9 	andeq	r0, r0, r9, asr #15
    4a5c:	00031416 	andeq	r1, r3, r6, lsl r4
    4a60:	02740400 	rsbseq	r0, r4, #0, 8
    4a64:	000007c9 	andeq	r0, r0, r9, asr #15
    4a68:	04e41600 	strbteq	r1, [r4], #1536	; 0x600
    4a6c:	75040000 	strvc	r0, [r4, #-0]
    4a70:	0007d902 	andeq	sp, r7, r2, lsl #18
    4a74:	08007800 	stmdaeq	r0, {fp, ip, sp, lr}
    4a78:	000002bc 			; <UNDEFINED> instruction: 0x000002bc
    4a7c:	000007d9 	ldrdeq	r0, [r0], -r9
    4a80:	0000bf09 	andeq	fp, r0, r9, lsl #30
    4a84:	08001d00 	stmdaeq	r0, {r8, sl, fp, ip}
    4a88:	00000024 	andeq	r0, r0, r4, lsr #32
    4a8c:	000007e9 	andeq	r0, r0, r9, ror #15
    4a90:	0000bf09 	andeq	fp, r0, r9, lsl #30
    4a94:	1b001d00 	blne	be9c <__bss_start+0x980>
    4a98:	025604f0 	subseq	r0, r6, #240, 8	; 0xf0000000
    4a9c:	0000080b 	andeq	r0, r0, fp, lsl #16
    4aa0:	0009d91c 	andeq	sp, r9, ip, lsl r9
    4aa4:	026d0400 	rsbeq	r0, sp, #0, 8
    4aa8:	00000674 	andeq	r0, r0, r4, ror r6
    4aac:	0005071c 	andeq	r0, r5, ip, lsl r7
    4ab0:	02760400 	rsbseq	r0, r6, #0, 8
    4ab4:	000007a5 	andeq	r0, r0, r5, lsr #15
    4ab8:	05480800 	strbeq	r0, [r8, #-2048]	; 0x800
    4abc:	081b0000 	ldmdaeq	fp, {}	; <UNPREDICTABLE>
    4ac0:	bf090000 	svclt	0x00090000
    4ac4:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    4ac8:	08261d00 	stmdaeq	r6!, {r8, sl, fp, ip}
    4acc:	0a140000 	beq	504ad4 <_stack+0x484ad4>
    4ad0:	00000004 	andeq	r0, r0, r4
    4ad4:	081b040f 	ldmdaeq	fp, {r0, r1, r2, r3, sl}
    4ad8:	040f0000 	streq	r0, [pc], #-0	; 4ae0 <CPSR_IRQ_INHIBIT+0x4a60>
    4adc:	0000015d 	andeq	r0, r0, sp, asr r1
    4ae0:	00083d1d 	andeq	r3, r8, sp, lsl sp
    4ae4:	001d1400 	andseq	r1, sp, r0, lsl #8
    4ae8:	0f000000 	svceq	0x00000000
    4aec:	00084304 	andeq	r4, r8, r4, lsl #6
    4af0:	32040f00 	andcc	r0, r4, #0, 30
    4af4:	08000008 	stmdaeq	r0, {r3}
    4af8:	000005e2 	andeq	r0, r0, r2, ror #11
    4afc:	00000859 	andeq	r0, r0, r9, asr r8
    4b00:	0000bf09 	andeq	fp, r0, r9, lsl #30
    4b04:	1e000200 	cdpne	2, 0, cr0, cr0, cr0, {0}
    4b08:	00000a94 	muleq	r0, r4, sl
    4b0c:	04101705 	ldreq	r1, [r0], #-1797	; 0x705
    4b10:	03050000 	movweq	r0, #20480	; 0x5000
    4b14:	0000b0f0 	strdeq	fp, [r0], -r0
    4b18:	000ada1f 	andeq	sp, sl, pc, lsl sl
    4b1c:	02fa0400 	rscseq	r0, sl, #0, 8
    4b20:	0000040a 	andeq	r0, r0, sl, lsl #8
    4b24:	b5180305 	ldrlt	r0, [r8, #-773]	; 0x305
    4b28:	d31f0000 	tstle	pc, #0
    4b2c:	0400000a 	streq	r0, [r0], #-10
    4b30:	088e02fb 	stmeq	lr, {r0, r1, r3, r4, r5, r6, r7, r9}
    4b34:	03050000 	movweq	r0, #20480	; 0x5000
    4b38:	0000acd0 	ldrdeq	sl, [r0], -r0
    4b3c:	00040a18 	andeq	r0, r4, r8, lsl sl
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
       0:	10001101 	andne	r1, r0, r1, lsl #2
       4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
       8:	1b080301 	blne	200c14 <_stack+0x180c14>
       c:	13082508 	movwne	r2, #34056	; 0x8508
      10:	00000005 	andeq	r0, r0, r5
      14:	10001101 	andne	r1, r0, r1, lsl #2
      18:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
      1c:	1b080301 	blne	200c28 <_stack+0x180c28>
      20:	13082508 	movwne	r2, #34056	; 0x8508
      24:	00000005 	andeq	r0, r0, r5
      28:	25011101 	strcs	r1, [r1, #-257]	; 0x101
      2c:	030b130e 	movweq	r1, #45838	; 0xb30e
      30:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
      34:	10011117 	andne	r1, r1, r7, lsl r1
      38:	02000017 	andeq	r0, r0, #23
      3c:	0b0b0024 	bleq	2c00d4 <_stack+0x2400d4>
      40:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
      44:	16030000 	strne	r0, [r3], -r0
      48:	3a0e0300 	bcc	380c50 <_stack+0x300c50>
      4c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
      50:	04000013 	streq	r0, [r0], #-19
      54:	0b0b0024 	bleq	2c00ec <_stack+0x2400ec>
      58:	0e030b3e 	vmoveq.16	d3[0], r0
      5c:	16050000 	strne	r0, [r5], -r0
      60:	3a0e0300 	bcc	380c68 <_stack+0x300c68>
      64:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
      68:	06000013 			; <UNDEFINED> instruction: 0x06000013
      6c:	0b0b0117 	bleq	2c04d0 <_stack+0x2404d0>
      70:	0b3b0b3a 	bleq	ec2d60 <_stack+0xe42d60>
      74:	00001301 	andeq	r1, r0, r1, lsl #6
      78:	03000d07 	movweq	r0, #3335	; 0xd07
      7c:	3b0b3a0e 	blcc	2ce8bc <_stack+0x24e8bc>
      80:	0013490b 	andseq	r4, r3, fp, lsl #18
      84:	01010800 	tsteq	r1, r0, lsl #16
      88:	13011349 	movwne	r1, #4937	; 0x1349
      8c:	21090000 	mrscs	r0, (UNDEF: 9)
      90:	2f134900 	svccs	0x00134900
      94:	0a00000b 	beq	c8 <CPSR_IRQ_INHIBIT+0x48>
      98:	0b0b0113 	bleq	2c04ec <_stack+0x2404ec>
      9c:	0b3b0b3a 	bleq	ec2d8c <_stack+0xe42d8c>
      a0:	00001301 	andeq	r1, r0, r1, lsl #6
      a4:	03000d0b 	movweq	r0, #3339	; 0xd0b
      a8:	3b0b3a0e 	blcc	2ce8e8 <_stack+0x24e8e8>
      ac:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
      b0:	0c00000b 	stceq	0, cr0, [r0], {11}
      b4:	0b0b000f 	bleq	2c00f8 <_stack+0x2400f8>
      b8:	130d0000 	movwne	r0, #53248	; 0xd000
      bc:	0b0e0301 	bleq	380cc8 <_stack+0x300cc8>
      c0:	3b0b3a0b 	blcc	2ce8f4 <_stack+0x24e8f4>
      c4:	0013010b 	andseq	r0, r3, fp, lsl #2
      c8:	000d0e00 	andeq	r0, sp, r0, lsl #28
      cc:	0b3a0803 	bleq	e820e0 <_stack+0xe020e0>
      d0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
      d4:	00000b38 	andeq	r0, r0, r8, lsr fp
      d8:	0b000f0f 	bleq	3d1c <CPSR_IRQ_INHIBIT+0x3c9c>
      dc:	0013490b 	andseq	r4, r3, fp, lsl #18
      e0:	01131000 	tsteq	r3, r0
      e4:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
      e8:	0b3b0b3a 	bleq	ec2dd8 <_stack+0xe42dd8>
      ec:	00001301 	andeq	r1, r0, r1, lsl #6
      f0:	03000d11 	movweq	r0, #3345	; 0xd11
      f4:	3b0b3a0e 	blcc	2ce934 <_stack+0x24e934>
      f8:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
      fc:	12000005 	andne	r0, r0, #5
     100:	19270015 	stmdbne	r7!, {r0, r2, r4}
     104:	15130000 	ldrne	r0, [r3, #-0]
     108:	49192701 	ldmdbmi	r9, {r0, r8, r9, sl, sp}
     10c:	00130113 	andseq	r0, r3, r3, lsl r1
     110:	00051400 	andeq	r1, r5, r0, lsl #8
     114:	00001349 	andeq	r1, r0, r9, asr #6
     118:	03011315 	movweq	r1, #4885	; 0x1315
     11c:	3a050b0e 	bcc	142d5c <_stack+0xc2d5c>
     120:	01053b0b 	tsteq	r5, fp, lsl #22
     124:	16000013 			; <UNDEFINED> instruction: 0x16000013
     128:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     12c:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     130:	0b381349 	bleq	e04e5c <_stack+0xd84e5c>
     134:	0d170000 	ldceq	0, cr0, [r7, #-0]
     138:	3a0e0300 	bcc	380d40 <_stack+0x300d40>
     13c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     140:	00053813 	andeq	r3, r5, r3, lsl r8
     144:	00261800 	eoreq	r1, r6, r0, lsl #16
     148:	00001349 	andeq	r1, r0, r9, asr #6
     14c:	03011319 	movweq	r1, #4889	; 0x1319
     150:	3a0b0b0e 	bcc	2c2d90 <_stack+0x242d90>
     154:	01053b0b 	tsteq	r5, fp, lsl #22
     158:	1a000013 	bne	1ac <CPSR_IRQ_INHIBIT+0x12c>
     15c:	0b0b0113 	bleq	2c05b0 <_stack+0x2405b0>
     160:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     164:	00001301 	andeq	r1, r0, r1, lsl #6
     168:	0b01171b 	bleq	45ddc <__bss_end__+0x31d94>
     16c:	3b0b3a0b 	blcc	2ce9a0 <_stack+0x24e9a0>
     170:	00130105 	andseq	r0, r3, r5, lsl #2
     174:	000d1c00 	andeq	r1, sp, r0, lsl #24
     178:	0b3a0e03 	bleq	e8398c <_stack+0xe0398c>
     17c:	1349053b 	movtne	r0, #38203	; 0x953b
     180:	151d0000 	ldrne	r0, [sp, #-0]
     184:	01192701 	tsteq	r9, r1, lsl #14
     188:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
     18c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     190:	0b3a0e03 	bleq	e839a4 <_stack+0xe039a4>
     194:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
     198:	01111349 	tsteq	r1, r9, asr #6
     19c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     1a0:	01194297 			; <UNDEFINED> instruction: 0x01194297
     1a4:	1f000013 	svcne	0x00000013
     1a8:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
     1ac:	0b3b0b3a 	bleq	ec2e9c <_stack+0xe42e9c>
     1b0:	17021349 	strne	r1, [r2, -r9, asr #6]
     1b4:	89200000 	stmdbhi	r0!, {}	; <UNPREDICTABLE>
     1b8:	11010182 	smlabbne	r1, r2, r1, r0
     1bc:	19429501 	stmdbne	r2, {r0, r8, sl, ip, pc}^
     1c0:	00001331 	andeq	r1, r0, r1, lsr r3
     1c4:	01828a21 	orreq	r8, r2, r1, lsr #20
     1c8:	91180200 	tstls	r8, r0, lsl #4
     1cc:	00001842 	andeq	r1, r0, r2, asr #16
     1d0:	3f012e22 	svccc	0x00012e22
     1d4:	3a0e0319 	bcc	380e40 <_stack+0x300e40>
     1d8:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
     1dc:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
     1e0:	97184006 	ldrls	r4, [r8, -r6]
     1e4:	13011942 	movwne	r1, #6466	; 0x1942
     1e8:	34230000 	strtcc	r0, [r3], #-0
     1ec:	3a0e0300 	bcc	380df4 <_stack+0x300df4>
     1f0:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     1f4:	3c193f13 	ldccc	15, cr3, [r9], {19}
     1f8:	24000019 	strcs	r0, [r0], #-25
     1fc:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     200:	0b3a0e03 	bleq	e83a14 <_stack+0xe03a14>
     204:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
     208:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
     20c:	00001301 	andeq	r1, r0, r1, lsl #6
     210:	3f012e25 	svccc	0x00012e25
     214:	3a0e0319 	bcc	380e80 <_stack+0x300e80>
     218:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
     21c:	00193c19 	andseq	r3, r9, r9, lsl ip
     220:	11010000 	mrsne	r0, (UNDEF: 1)
     224:	130e2501 	movwne	r2, #58625	; 0xe501
     228:	1b0e030b 	blne	380e5c <_stack+0x300e5c>
     22c:	1117550e 	tstne	r7, lr, lsl #10
     230:	00171001 	andseq	r1, r7, r1
     234:	00160200 	andseq	r0, r6, r0, lsl #4
     238:	0b3a0e03 	bleq	e83a4c <_stack+0xe03a4c>
     23c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     240:	24030000 	strcs	r0, [r3], #-0
     244:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     248:	0008030b 	andeq	r0, r8, fp, lsl #6
     24c:	00240400 	eoreq	r0, r4, r0, lsl #8
     250:	0b3e0b0b 	bleq	f82e84 <_stack+0xf02e84>
     254:	00000e03 	andeq	r0, r0, r3, lsl #28
     258:	0b000f05 	bleq	3e74 <CPSR_IRQ_INHIBIT+0x3df4>
     25c:	0600000b 	streq	r0, [r0], -fp
     260:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     264:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     268:	00001349 	andeq	r1, r0, r9, asr #6
     26c:	0b011707 	bleq	45e90 <__bss_end__+0x31e48>
     270:	3b0b3a0b 	blcc	2ceaa4 <_stack+0x24eaa4>
     274:	0013010b 	andseq	r0, r3, fp, lsl #2
     278:	000d0800 	andeq	r0, sp, r0, lsl #16
     27c:	0b3a0e03 	bleq	e83a90 <_stack+0xe03a90>
     280:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     284:	01090000 	mrseq	r0, (UNDEF: 9)
     288:	01134901 	tsteq	r3, r1, lsl #18
     28c:	0a000013 	beq	2e0 <CPSR_IRQ_INHIBIT+0x260>
     290:	13490021 	movtne	r0, #36897	; 0x9021
     294:	00000b2f 	andeq	r0, r0, pc, lsr #22
     298:	0b01130b 	bleq	44ecc <__bss_end__+0x30e84>
     29c:	3b0b3a0b 	blcc	2cead0 <_stack+0x24ead0>
     2a0:	0013010b 	andseq	r0, r3, fp, lsl #2
     2a4:	000d0c00 	andeq	r0, sp, r0, lsl #24
     2a8:	0b3a0e03 	bleq	e83abc <_stack+0xe03abc>
     2ac:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     2b0:	00000b38 	andeq	r0, r0, r8, lsr fp
     2b4:	0301130d 	movweq	r1, #4877	; 0x130d
     2b8:	3a0b0b0e 	bcc	2c2ef8 <_stack+0x242ef8>
     2bc:	010b3b0b 	tsteq	fp, fp, lsl #22
     2c0:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
     2c4:	0803000d 	stmdaeq	r3, {r0, r2, r3}
     2c8:	0b3b0b3a 	bleq	ec2fb8 <_stack+0xe42fb8>
     2cc:	0b381349 	bleq	e04ff8 <_stack+0xd84ff8>
     2d0:	0f0f0000 	svceq	0x000f0000
     2d4:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
     2d8:	10000013 	andne	r0, r0, r3, lsl r0
     2dc:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
     2e0:	0b3a050b 	bleq	e81714 <_stack+0xe01714>
     2e4:	13010b3b 	movwne	r0, #6971	; 0x1b3b
     2e8:	0d110000 	ldceq	0, cr0, [r1, #-0]
     2ec:	3a0e0300 	bcc	380ef4 <_stack+0x300ef4>
     2f0:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     2f4:	00053813 	andeq	r3, r5, r3, lsl r8
     2f8:	00151200 	andseq	r1, r5, r0, lsl #4
     2fc:	00001927 	andeq	r1, r0, r7, lsr #18
     300:	27011513 	smladcs	r1, r3, r5, r1
     304:	01134919 	tsteq	r3, r9, lsl r9
     308:	14000013 	strne	r0, [r0], #-19
     30c:	13490005 	movtne	r0, #36869	; 0x9005
     310:	13150000 	tstne	r5, #0
     314:	0b0e0301 	bleq	380f20 <_stack+0x300f20>
     318:	3b0b3a05 	blcc	2ceb34 <_stack+0x24eb34>
     31c:	00130105 	andseq	r0, r3, r5, lsl #2
     320:	000d1600 	andeq	r1, sp, r0, lsl #12
     324:	0b3a0e03 	bleq	e83b38 <_stack+0xe03b38>
     328:	1349053b 	movtne	r0, #38203	; 0x953b
     32c:	00000b38 	andeq	r0, r0, r8, lsr fp
     330:	03000d17 	movweq	r0, #3351	; 0xd17
     334:	3b0b3a0e 	blcc	2ceb74 <_stack+0x24eb74>
     338:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
     33c:	18000005 	stmdane	r0, {r0, r2}
     340:	13490026 	movtne	r0, #36902	; 0x9026
     344:	13190000 	tstne	r9, #0
     348:	0b0e0301 	bleq	380f54 <_stack+0x300f54>
     34c:	3b0b3a0b 	blcc	2ceb80 <_stack+0x24eb80>
     350:	00130105 	andseq	r0, r3, r5, lsl #2
     354:	01131a00 	tsteq	r3, r0, lsl #20
     358:	0b3a0b0b 	bleq	e82f8c <_stack+0xe02f8c>
     35c:	1301053b 	movwne	r0, #5435	; 0x153b
     360:	171b0000 	ldrne	r0, [fp, -r0]
     364:	3a0b0b01 	bcc	2c2f70 <_stack+0x242f70>
     368:	01053b0b 	tsteq	r5, fp, lsl #22
     36c:	1c000013 	stcne	0, cr0, [r0], {19}
     370:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     374:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     378:	00001349 	andeq	r1, r0, r9, asr #6
     37c:	2701151d 	smladcs	r1, sp, r5, r1
     380:	00130119 	andseq	r0, r3, r9, lsl r1
     384:	000d1e00 	andeq	r1, sp, r0, lsl #28
     388:	0b3a0803 	bleq	e8239c <_stack+0xe0239c>
     38c:	1349053b 	movtne	r0, #38203	; 0x953b
     390:	00000b38 	andeq	r0, r0, r8, lsr fp
     394:	03012e1f 	movweq	r2, #7711	; 0x1e1f
     398:	3b0b3a0e 	blcc	2cebd8 <_stack+0x24ebd8>
     39c:	20192705 	andscs	r2, r9, r5, lsl #14
     3a0:	0013010b 	andseq	r0, r3, fp, lsl #2
     3a4:	00052000 	andeq	r2, r5, r0
     3a8:	0b3a0e03 	bleq	e83bbc <_stack+0xe03bbc>
     3ac:	1349053b 	movtne	r0, #38203	; 0x953b
     3b0:	05210000 	streq	r0, [r1, #-0]!
     3b4:	3a080300 	bcc	200fbc <_stack+0x180fbc>
     3b8:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     3bc:	22000013 	andcs	r0, r0, #19
     3c0:	08030034 	stmdaeq	r3, {r2, r4, r5}
     3c4:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     3c8:	00001349 	andeq	r1, r0, r9, asr #6
     3cc:	03003423 	movweq	r3, #1059	; 0x423
     3d0:	3b0b3a0e 	blcc	2cec10 <_stack+0x24ec10>
     3d4:	00134905 	andseq	r4, r3, r5, lsl #18
     3d8:	012e2400 	teqeq	lr, r0, lsl #8
     3dc:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
     3e0:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     3e4:	13491927 	movtne	r1, #39207	; 0x9927
     3e8:	06120111 			; <UNDEFINED> instruction: 0x06120111
     3ec:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
     3f0:	00130119 	andseq	r0, r3, r9, lsl r1
     3f4:	00052500 	andeq	r2, r5, r0, lsl #10
     3f8:	0b3a0e03 	bleq	e83c0c <_stack+0xe03c0c>
     3fc:	1349053b 	movtne	r0, #38203	; 0x953b
     400:	00001702 	andeq	r1, r0, r2, lsl #14
     404:	03003426 	movweq	r3, #1062	; 0x426
     408:	3b0b3a0e 	blcc	2cec48 <_stack+0x24ec48>
     40c:	02134905 	andseq	r4, r3, #81920	; 0x14000
     410:	27000017 	smladcs	r0, r7, r0, r0
     414:	08030034 	stmdaeq	r3, {r2, r4, r5}
     418:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     41c:	17021349 	strne	r1, [r2, -r9, asr #6]
     420:	1d280000 	stcne	0, cr0, [r8, #-0]
     424:	52133101 	andspl	r3, r3, #1073741824	; 0x40000000
     428:	58175501 	ldmdapl	r7, {r0, r8, sl, ip, lr}
     42c:	0105590b 	tsteq	r5, fp, lsl #18
     430:	29000013 	stmdbcs	r0, {r0, r1, r4}
     434:	13310005 	teqne	r1, #5
     438:	00001702 	andeq	r1, r0, r2, lsl #14
     43c:	55010b2a 	strpl	r0, [r1, #-2858]	; 0xb2a
     440:	2b000017 	blcs	4a4 <CPSR_IRQ_INHIBIT+0x424>
     444:	13310034 	teqne	r1, #52	; 0x34
     448:	00001702 	andeq	r1, r0, r2, lsl #14
     44c:	0182892c 	orreq	r8, r2, ip, lsr #18
     450:	31011101 	tstcc	r1, r1, lsl #2
     454:	00130113 	andseq	r0, r3, r3, lsl r1
     458:	828a2d00 	addhi	r2, sl, #0, 26
     45c:	18020001 	stmdane	r2, {r0}
     460:	00184291 	mulseq	r8, r1, r2
     464:	82892e00 	addhi	r2, r9, #0, 28
     468:	01110101 	tsteq	r1, r1, lsl #2
     46c:	00001331 	andeq	r1, r0, r1, lsr r3
     470:	4900212f 	stmdbmi	r0, {r0, r1, r2, r3, r5, r8, sp}
     474:	00052f13 	andeq	r2, r5, r3, lsl pc
     478:	00343000 	eorseq	r3, r4, r0
     47c:	0b3a0e03 	bleq	e83c90 <_stack+0xe03c90>
     480:	1349053b 	movtne	r0, #38203	; 0x953b
     484:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
     488:	2e310000 	cdpcs	0, 3, cr0, cr1, cr0, {0}
     48c:	03193f01 	tsteq	r9, #1, 30
     490:	3b0b3a0e 	blcc	2cecd0 <_stack+0x24ecd0>
     494:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
     498:	01193c13 	tsteq	r9, r3, lsl ip
     49c:	32000013 	andcc	r0, r0, #19
     4a0:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     4a4:	0b3a0e03 	bleq	e83cb8 <_stack+0xe03cb8>
     4a8:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
     4ac:	1301193c 	movwne	r1, #6460	; 0x193c
     4b0:	2e330000 	cdpcs	0, 3, cr0, cr3, cr0, {0}
     4b4:	03193f01 	tsteq	r9, #1, 30
     4b8:	3b0b3a0e 	blcc	2cecf8 <_stack+0x24ecf8>
     4bc:	3c192705 	ldccc	7, cr2, [r9], {5}
     4c0:	00000019 	andeq	r0, r0, r9, lsl r0
     4c4:	25011101 	strcs	r1, [r1, #-257]	; 0x101
     4c8:	030b130e 	movweq	r1, #45838	; 0xb30e
     4cc:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
     4d0:	10011117 	andne	r1, r1, r7, lsl r1
     4d4:	02000017 	andeq	r0, r0, #23
     4d8:	0b0b0024 	bleq	2c0570 <_stack+0x240570>
     4dc:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
     4e0:	16030000 	strne	r0, [r3], -r0
     4e4:	3a0e0300 	bcc	3810ec <_stack+0x3010ec>
     4e8:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     4ec:	04000013 	streq	r0, [r0], #-19
     4f0:	0b0b0024 	bleq	2c0588 <_stack+0x240588>
     4f4:	0e030b3e 	vmoveq.16	d3[0], r0
     4f8:	0f050000 	svceq	0x00050000
     4fc:	000b0b00 	andeq	r0, fp, r0, lsl #22
     500:	000f0600 	andeq	r0, pc, r0, lsl #12
     504:	13490b0b 	movtne	r0, #39691	; 0x9b0b
     508:	26070000 	strcs	r0, [r7], -r0
     50c:	00134900 	andseq	r4, r3, r0, lsl #18
     510:	012e0800 	teqeq	lr, r0, lsl #16
     514:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
     518:	0b3b0b3a 	bleq	ec3208 <_stack+0xe43208>
     51c:	13491927 	movtne	r1, #39207	; 0x9927
     520:	06120111 			; <UNDEFINED> instruction: 0x06120111
     524:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
     528:	00130119 	andseq	r0, r3, r9, lsl r1
     52c:	00050900 	andeq	r0, r5, r0, lsl #18
     530:	0b3a0e03 	bleq	e83d44 <_stack+0xe03d44>
     534:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     538:	00001802 	andeq	r1, r0, r2, lsl #16
     53c:	0300050a 	movweq	r0, #1290	; 0x50a
     540:	3b0b3a0e 	blcc	2ced80 <_stack+0x24ed80>
     544:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
     548:	0b000017 	bleq	5ac <CPSR_IRQ_INHIBIT+0x52c>
     54c:	08030034 	stmdaeq	r3, {r2, r4, r5}
     550:	0b3b0b3a 	bleq	ec3240 <_stack+0xe43240>
     554:	17021349 	strne	r1, [r2, -r9, asr #6]
     558:	340c0000 	strcc	r0, [ip], #-0
     55c:	3a0e0300 	bcc	381164 <_stack+0x301164>
     560:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     564:	00170213 	andseq	r0, r7, r3, lsl r2
     568:	00260d00 	eoreq	r0, r6, r0, lsl #26
     56c:	01000000 	mrseq	r0, (UNDEF: 0)
     570:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
     574:	0e030b13 	vmoveq.32	d3[0], r0
     578:	17550e1b 	smmlane	r5, fp, lr, r0
     57c:	17100111 			; <UNDEFINED> instruction: 0x17100111
     580:	24020000 	strcs	r0, [r2], #-0
     584:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     588:	0008030b 	andeq	r0, r8, fp, lsl #6
     58c:	00160300 	andseq	r0, r6, r0, lsl #6
     590:	0b3a0e03 	bleq	e83da4 <_stack+0xe03da4>
     594:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     598:	24040000 	strcs	r0, [r4], #-0
     59c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     5a0:	000e030b 	andeq	r0, lr, fp, lsl #6
     5a4:	000f0500 	andeq	r0, pc, r0, lsl #10
     5a8:	00000b0b 	andeq	r0, r0, fp, lsl #22
     5ac:	0b000f06 	bleq	41cc <CPSR_IRQ_INHIBIT+0x414c>
     5b0:	0013490b 	andseq	r4, r3, fp, lsl #18
     5b4:	012e0700 	teqeq	lr, r0, lsl #14
     5b8:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
     5bc:	0b3b0b3a 	bleq	ec32ac <_stack+0xe432ac>
     5c0:	13491927 	movtne	r1, #39207	; 0x9927
     5c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
     5c8:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
     5cc:	00130119 	andseq	r0, r3, r9, lsl r1
     5d0:	00050800 	andeq	r0, r5, r0, lsl #16
     5d4:	0b3a0803 	bleq	e825e8 <_stack+0xe025e8>
     5d8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     5dc:	00001802 	andeq	r1, r0, r2, lsl #16
     5e0:	03000509 	movweq	r0, #1289	; 0x509
     5e4:	3b0b3a08 	blcc	2cee0c <_stack+0x24ee0c>
     5e8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
     5ec:	0a000017 	beq	650 <CPSR_IRQ_INHIBIT+0x5d0>
     5f0:	08030034 	stmdaeq	r3, {r2, r4, r5}
     5f4:	0b3b0b3a 	bleq	ec32e4 <_stack+0xe432e4>
     5f8:	17021349 	strne	r1, [r2, -r9, asr #6]
     5fc:	340b0000 	strcc	r0, [fp], #-0
     600:	3a0e0300 	bcc	381208 <_stack+0x301208>
     604:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     608:	00170213 	andseq	r0, r7, r3, lsl r2
     60c:	11010000 	mrsne	r0, (UNDEF: 1)
     610:	130e2501 	movwne	r2, #58625	; 0xe501
     614:	1b0e030b 	blne	381248 <_stack+0x301248>
     618:	1117550e 	tstne	r7, lr, lsl #10
     61c:	00171001 	andseq	r1, r7, r1
     620:	00240200 	eoreq	r0, r4, r0, lsl #4
     624:	0b3e0b0b 	bleq	f83258 <_stack+0xf03258>
     628:	00000803 	andeq	r0, r0, r3, lsl #16
     62c:	0b002403 	bleq	9640 <ipc_msg_enqueue+0x4>
     630:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
     634:	0400000e 	streq	r0, [r0], #-14
     638:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     63c:	0b3b0b3a 	bleq	ec332c <_stack+0xe4332c>
     640:	00001349 	andeq	r1, r0, r9, asr #6
     644:	03001605 	movweq	r1, #1541	; 0x605
     648:	3b0b3a0e 	blcc	2cee88 <_stack+0x24ee88>
     64c:	00134905 	andseq	r4, r3, r5, lsl #18
     650:	01170600 	tsteq	r7, r0, lsl #12
     654:	0b3a0b0b 	bleq	e83288 <_stack+0xe03288>
     658:	13010b3b 	movwne	r0, #6971	; 0x1b3b
     65c:	0d070000 	stceq	0, cr0, [r7, #-0]
     660:	3a0e0300 	bcc	381268 <_stack+0x301268>
     664:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     668:	08000013 	stmdaeq	r0, {r0, r1, r4}
     66c:	13490101 	movtne	r0, #37121	; 0x9101
     670:	00001301 	andeq	r1, r0, r1, lsl #6
     674:	49002109 	stmdbmi	r0, {r0, r3, r8, sp}
     678:	000b2f13 	andeq	r2, fp, r3, lsl pc
     67c:	01130a00 	tsteq	r3, r0, lsl #20
     680:	0b3a0b0b 	bleq	e832b4 <_stack+0xe032b4>
     684:	13010b3b 	movwne	r0, #6971	; 0x1b3b
     688:	0d0b0000 	stceq	0, cr0, [fp, #-0]
     68c:	3a0e0300 	bcc	381294 <_stack+0x301294>
     690:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     694:	000b3813 	andeq	r3, fp, r3, lsl r8
     698:	000f0c00 	andeq	r0, pc, r0, lsl #24
     69c:	00000b0b 	andeq	r0, r0, fp, lsl #22
     6a0:	0301130d 	movweq	r1, #4877	; 0x130d
     6a4:	3a0b0b0e 	bcc	2c32e4 <_stack+0x2432e4>
     6a8:	010b3b0b 	tsteq	fp, fp, lsl #22
     6ac:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
     6b0:	0803000d 	stmdaeq	r3, {r0, r2, r3}
     6b4:	0b3b0b3a 	bleq	ec33a4 <_stack+0xe433a4>
     6b8:	0b381349 	bleq	e053e4 <_stack+0xd853e4>
     6bc:	0f0f0000 	svceq	0x000f0000
     6c0:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
     6c4:	10000013 	andne	r0, r0, r3, lsl r0
     6c8:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
     6cc:	0b3a050b 	bleq	e81b00 <_stack+0xe01b00>
     6d0:	13010b3b 	movwne	r0, #6971	; 0x1b3b
     6d4:	0d110000 	ldceq	0, cr0, [r1, #-0]
     6d8:	3a0e0300 	bcc	3812e0 <_stack+0x3012e0>
     6dc:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     6e0:	00053813 	andeq	r3, r5, r3, lsl r8
     6e4:	00151200 	andseq	r1, r5, r0, lsl #4
     6e8:	00001927 	andeq	r1, r0, r7, lsr #18
     6ec:	27011513 	smladcs	r1, r3, r5, r1
     6f0:	01134919 	tsteq	r3, r9, lsl r9
     6f4:	14000013 	strne	r0, [r0], #-19
     6f8:	13490005 	movtne	r0, #36869	; 0x9005
     6fc:	13150000 	tstne	r5, #0
     700:	0b0e0301 	bleq	38130c <_stack+0x30130c>
     704:	3b0b3a05 	blcc	2cef20 <_stack+0x24ef20>
     708:	00130105 	andseq	r0, r3, r5, lsl #2
     70c:	000d1600 	andeq	r1, sp, r0, lsl #12
     710:	0b3a0e03 	bleq	e83f24 <_stack+0xe03f24>
     714:	1349053b 	movtne	r0, #38203	; 0x953b
     718:	00000b38 	andeq	r0, r0, r8, lsr fp
     71c:	03000d17 	movweq	r0, #3351	; 0xd17
     720:	3b0b3a0e 	blcc	2cef60 <_stack+0x24ef60>
     724:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
     728:	18000005 	stmdane	r0, {r0, r2}
     72c:	13490026 	movtne	r0, #36902	; 0x9026
     730:	13190000 	tstne	r9, #0
     734:	0b0e0301 	bleq	381340 <_stack+0x301340>
     738:	3b0b3a0b 	blcc	2cef6c <_stack+0x24ef6c>
     73c:	00130105 	andseq	r0, r3, r5, lsl #2
     740:	01131a00 	tsteq	r3, r0, lsl #20
     744:	0b3a0b0b 	bleq	e83378 <_stack+0xe03378>
     748:	1301053b 	movwne	r0, #5435	; 0x153b
     74c:	171b0000 	ldrne	r0, [fp, -r0]
     750:	3a0b0b01 	bcc	2c335c <_stack+0x24335c>
     754:	01053b0b 	tsteq	r5, fp, lsl #22
     758:	1c000013 	stcne	0, cr0, [r0], {19}
     75c:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     760:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     764:	00001349 	andeq	r1, r0, r9, asr #6
     768:	2701151d 	smladcs	r1, sp, r5, r1
     76c:	00130119 	andseq	r0, r3, r9, lsl r1
     770:	012e1e00 	teqeq	lr, r0, lsl #28
     774:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
     778:	0b3b0b3a 	bleq	ec3468 <_stack+0xe43468>
     77c:	06120111 			; <UNDEFINED> instruction: 0x06120111
     780:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
     784:	00130119 	andseq	r0, r3, r9, lsl r1
     788:	00051f00 	andeq	r1, r5, r0, lsl #30
     78c:	0b3a0803 	bleq	e827a0 <_stack+0xe027a0>
     790:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     794:	00001802 	andeq	r1, r0, r2, lsl #16
     798:	03003420 	movweq	r3, #1056	; 0x420
     79c:	3b0b3a0e 	blcc	2cefdc <_stack+0x24efdc>
     7a0:	1c13490b 	ldcne	9, cr4, [r3], {11}
     7a4:	0000000b 	andeq	r0, r0, fp
     7a8:	25011101 	strcs	r1, [r1, #-257]	; 0x101
     7ac:	030b130e 	movweq	r1, #45838	; 0xb30e
     7b0:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
     7b4:	10011117 	andne	r1, r1, r7, lsl r1
     7b8:	02000017 	andeq	r0, r0, #23
     7bc:	0b0b0024 	bleq	2c0854 <_stack+0x240854>
     7c0:	0e030b3e 	vmoveq.16	d3[0], r0
     7c4:	24030000 	strcs	r0, [r3], #-0
     7c8:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     7cc:	0008030b 	andeq	r0, r8, fp, lsl #6
     7d0:	00160400 	andseq	r0, r6, r0, lsl #8
     7d4:	0b3a0e03 	bleq	e83fe8 <_stack+0xe03fe8>
     7d8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     7dc:	16050000 	strne	r0, [r5], -r0
     7e0:	3a0e0300 	bcc	3813e8 <_stack+0x3013e8>
     7e4:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     7e8:	06000013 			; <UNDEFINED> instruction: 0x06000013
     7ec:	0b0b0117 	bleq	2c0c50 <_stack+0x240c50>
     7f0:	0b3b0b3a 	bleq	ec34e0 <_stack+0xe434e0>
     7f4:	00001301 	andeq	r1, r0, r1, lsl #6
     7f8:	03000d07 	movweq	r0, #3335	; 0xd07
     7fc:	3b0b3a0e 	blcc	2cf03c <_stack+0x24f03c>
     800:	0013490b 	andseq	r4, r3, fp, lsl #18
     804:	01010800 	tsteq	r1, r0, lsl #16
     808:	13011349 	movwne	r1, #4937	; 0x1349
     80c:	21090000 	mrscs	r0, (UNDEF: 9)
     810:	2f134900 	svccs	0x00134900
     814:	0a00000b 	beq	848 <CPSR_IRQ_INHIBIT+0x7c8>
     818:	0b0b0113 	bleq	2c0c6c <_stack+0x240c6c>
     81c:	0b3b0b3a 	bleq	ec350c <_stack+0xe4350c>
     820:	00001301 	andeq	r1, r0, r1, lsl #6
     824:	03000d0b 	movweq	r0, #3339	; 0xd0b
     828:	3b0b3a0e 	blcc	2cf068 <_stack+0x24f068>
     82c:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     830:	0c00000b 	stceq	0, cr0, [r0], {11}
     834:	0b0b000f 	bleq	2c0878 <_stack+0x240878>
     838:	130d0000 	movwne	r0, #53248	; 0xd000
     83c:	0b0e0301 	bleq	381448 <_stack+0x301448>
     840:	3b0b3a0b 	blcc	2cf074 <_stack+0x24f074>
     844:	0013010b 	andseq	r0, r3, fp, lsl #2
     848:	000d0e00 	andeq	r0, sp, r0, lsl #28
     84c:	0b3a0803 	bleq	e82860 <_stack+0xe02860>
     850:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     854:	00000b38 	andeq	r0, r0, r8, lsr fp
     858:	0b000f0f 	bleq	449c <CPSR_IRQ_INHIBIT+0x441c>
     85c:	0013490b 	andseq	r4, r3, fp, lsl #18
     860:	01131000 	tsteq	r3, r0
     864:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
     868:	0b3b0b3a 	bleq	ec3558 <_stack+0xe43558>
     86c:	00001301 	andeq	r1, r0, r1, lsl #6
     870:	03000d11 	movweq	r0, #3345	; 0xd11
     874:	3b0b3a0e 	blcc	2cf0b4 <_stack+0x24f0b4>
     878:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     87c:	12000005 	andne	r0, r0, #5
     880:	19270015 	stmdbne	r7!, {r0, r2, r4}
     884:	15130000 	ldrne	r0, [r3, #-0]
     888:	49192701 	ldmdbmi	r9, {r0, r8, r9, sl, sp}
     88c:	00130113 	andseq	r0, r3, r3, lsl r1
     890:	00051400 	andeq	r1, r5, r0, lsl #8
     894:	00001349 	andeq	r1, r0, r9, asr #6
     898:	03011315 	movweq	r1, #4885	; 0x1315
     89c:	3a050b0e 	bcc	1434dc <_stack+0xc34dc>
     8a0:	01053b0b 	tsteq	r5, fp, lsl #22
     8a4:	16000013 			; <UNDEFINED> instruction: 0x16000013
     8a8:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     8ac:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     8b0:	0b381349 	bleq	e055dc <_stack+0xd855dc>
     8b4:	0d170000 	ldceq	0, cr0, [r7, #-0]
     8b8:	3a0e0300 	bcc	3814c0 <_stack+0x3014c0>
     8bc:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     8c0:	00053813 	andeq	r3, r5, r3, lsl r8
     8c4:	00261800 	eoreq	r1, r6, r0, lsl #16
     8c8:	00001349 	andeq	r1, r0, r9, asr #6
     8cc:	03011319 	movweq	r1, #4889	; 0x1319
     8d0:	3a0b0b0e 	bcc	2c3510 <_stack+0x243510>
     8d4:	01053b0b 	tsteq	r5, fp, lsl #22
     8d8:	1a000013 	bne	92c <CPSR_IRQ_INHIBIT+0x8ac>
     8dc:	0b0b0113 	bleq	2c0d30 <_stack+0x240d30>
     8e0:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     8e4:	00001301 	andeq	r1, r0, r1, lsl #6
     8e8:	0b01171b 	bleq	4655c <__bss_end__+0x32514>
     8ec:	3b0b3a0b 	blcc	2cf120 <_stack+0x24f120>
     8f0:	00130105 	andseq	r0, r3, r5, lsl #2
     8f4:	000d1c00 	andeq	r1, sp, r0, lsl #24
     8f8:	0b3a0e03 	bleq	e8410c <_stack+0xe0410c>
     8fc:	1349053b 	movtne	r0, #38203	; 0x953b
     900:	151d0000 	ldrne	r0, [sp, #-0]
     904:	01192701 	tsteq	r9, r1, lsl #14
     908:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
     90c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     910:	0b3a0e03 	bleq	e84124 <_stack+0xe04124>
     914:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
     918:	06120111 			; <UNDEFINED> instruction: 0x06120111
     91c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
     920:	00130119 	andseq	r0, r3, r9, lsl r1
     924:	00051f00 	andeq	r1, r5, r0, lsl #30
     928:	0b3a0803 	bleq	e8293c <_stack+0xe0293c>
     92c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     930:	00001702 	andeq	r1, r0, r2, lsl #14
     934:	03000520 	movweq	r0, #1312	; 0x520
     938:	3b0b3a0e 	blcc	2cf178 <_stack+0x24f178>
     93c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
     940:	21000017 	tstcs	r0, r7, lsl r0
     944:	01018289 	smlabbeq	r1, r9, r2, r8
     948:	13310111 	teqne	r1, #1073741828	; 0x40000004
     94c:	00001301 	andeq	r1, r0, r1, lsl #6
     950:	01828a22 	orreq	r8, r2, r2, lsr #20
     954:	91180200 	tstls	r8, r0, lsl #4
     958:	00001842 	andeq	r1, r0, r2, asr #16
     95c:	01828923 	orreq	r8, r2, r3, lsr #18
     960:	95011101 	strls	r1, [r1, #-257]	; 0x101
     964:	13311942 	teqne	r1, #1081344	; 0x108000
     968:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
     96c:	03193f01 	tsteq	r9, #1, 30
     970:	3b0b3a0e 	blcc	2cf1b0 <_stack+0x24f1b0>
     974:	11192705 	tstne	r9, r5, lsl #14
     978:	40061201 	andmi	r1, r6, r1, lsl #4
     97c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
     980:	00001301 	andeq	r1, r0, r1, lsl #6
     984:	55010b25 	strpl	r0, [r1, #-2853]	; 0xb25
     988:	00130117 	andseq	r0, r3, r7, lsl r1
     98c:	00342600 	eorseq	r2, r4, r0, lsl #12
     990:	0b3a0803 	bleq	e829a4 <_stack+0xe029a4>
     994:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     998:	00001702 	andeq	r1, r0, r2, lsl #14
     99c:	11010b27 	tstne	r1, r7, lsr #22
     9a0:	01061201 	tsteq	r6, r1, lsl #4
     9a4:	28000013 	stmdacs	r0, {r0, r1, r4}
     9a8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
     9ac:	0b3b0b3a 	bleq	ec369c <_stack+0xe4369c>
     9b0:	17021349 	strne	r1, [r2, -r9, asr #6]
     9b4:	89290000 	stmdbhi	r9!, {}	; <UNPREDICTABLE>
     9b8:	11010182 	smlabbne	r1, r2, r1, r0
     9bc:	00133101 	andseq	r3, r3, r1, lsl #2
     9c0:	82892a00 	addhi	r2, r9, #0, 20
     9c4:	01110101 	tsteq	r1, r1, lsl #2
     9c8:	00001301 	andeq	r1, r0, r1, lsl #6
     9cc:	0300342b 	movweq	r3, #1067	; 0x42b
     9d0:	3b0b3a0e 	blcc	2cf210 <_stack+0x24f210>
     9d4:	3f134905 	svccc	0x00134905
     9d8:	00193c19 	andseq	r3, r9, r9, lsl ip
     9dc:	00342c00 	eorseq	r2, r4, r0, lsl #24
     9e0:	0b3a0e03 	bleq	e841f4 <_stack+0xe041f4>
     9e4:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     9e8:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
     9ec:	2e2d0000 	cdpcs	0, 2, cr0, cr13, cr0, {0}
     9f0:	03193f01 	tsteq	r9, #1, 30
     9f4:	3b0b3a0e 	blcc	2cf234 <_stack+0x24f234>
     9f8:	3c19270b 	ldccc	7, cr2, [r9], {11}
     9fc:	00000019 	andeq	r0, r0, r9, lsl r0
     a00:	25011101 	strcs	r1, [r1, #-257]	; 0x101
     a04:	030b130e 	movweq	r1, #45838	; 0xb30e
     a08:	550e1b0e 	strpl	r1, [lr, #-2830]	; 0xb0e
     a0c:	10011117 	andne	r1, r1, r7, lsl r1
     a10:	02000017 	andeq	r0, r0, #23
     a14:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     a18:	0b3b0b3a 	bleq	ec3708 <_stack+0xe43708>
     a1c:	00001349 	andeq	r1, r0, r9, asr #6
     a20:	0b002403 	bleq	9a34 <time_increments_get+0x8>
     a24:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
     a28:	04000008 	streq	r0, [r0], #-8
     a2c:	0b0b0024 	bleq	2c0ac4 <_stack+0x240ac4>
     a30:	0e030b3e 	vmoveq.16	d3[0], r0
     a34:	16050000 	strne	r0, [r5], -r0
     a38:	3a0e0300 	bcc	381640 <_stack+0x301640>
     a3c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     a40:	06000013 			; <UNDEFINED> instruction: 0x06000013
     a44:	0b0b0117 	bleq	2c0ea8 <_stack+0x240ea8>
     a48:	0b3b0b3a 	bleq	ec3738 <_stack+0xe43738>
     a4c:	00001301 	andeq	r1, r0, r1, lsl #6
     a50:	03000d07 	movweq	r0, #3335	; 0xd07
     a54:	3b0b3a0e 	blcc	2cf294 <_stack+0x24f294>
     a58:	0013490b 	andseq	r4, r3, fp, lsl #18
     a5c:	01010800 	tsteq	r1, r0, lsl #16
     a60:	13011349 	movwne	r1, #4937	; 0x1349
     a64:	21090000 	mrscs	r0, (UNDEF: 9)
     a68:	2f134900 	svccs	0x00134900
     a6c:	0a00000b 	beq	aa0 <CPSR_IRQ_INHIBIT+0xa20>
     a70:	0b0b0113 	bleq	2c0ec4 <_stack+0x240ec4>
     a74:	0b3b0b3a 	bleq	ec3764 <_stack+0xe43764>
     a78:	00001301 	andeq	r1, r0, r1, lsl #6
     a7c:	03000d0b 	movweq	r0, #3339	; 0xd0b
     a80:	3b0b3a0e 	blcc	2cf2c0 <_stack+0x24f2c0>
     a84:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     a88:	0c00000b 	stceq	0, cr0, [r0], {11}
     a8c:	0b0b000f 	bleq	2c0ad0 <_stack+0x240ad0>
     a90:	130d0000 	movwne	r0, #53248	; 0xd000
     a94:	0b0e0301 	bleq	3816a0 <_stack+0x3016a0>
     a98:	3b0b3a0b 	blcc	2cf2cc <_stack+0x24f2cc>
     a9c:	0013010b 	andseq	r0, r3, fp, lsl #2
     aa0:	000d0e00 	andeq	r0, sp, r0, lsl #28
     aa4:	0b3a0803 	bleq	e82ab8 <_stack+0xe02ab8>
     aa8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     aac:	00000b38 	andeq	r0, r0, r8, lsr fp
     ab0:	0b000f0f 	bleq	46f4 <CPSR_IRQ_INHIBIT+0x4674>
     ab4:	0013490b 	andseq	r4, r3, fp, lsl #18
     ab8:	01131000 	tsteq	r3, r0
     abc:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
     ac0:	0b3b0b3a 	bleq	ec37b0 <_stack+0xe437b0>
     ac4:	00001301 	andeq	r1, r0, r1, lsl #6
     ac8:	03000d11 	movweq	r0, #3345	; 0xd11
     acc:	3b0b3a0e 	blcc	2cf30c <_stack+0x24f30c>
     ad0:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     ad4:	12000005 	andne	r0, r0, #5
     ad8:	19270015 	stmdbne	r7!, {r0, r2, r4}
     adc:	15130000 	ldrne	r0, [r3, #-0]
     ae0:	49192701 	ldmdbmi	r9, {r0, r8, r9, sl, sp}
     ae4:	00130113 	andseq	r0, r3, r3, lsl r1
     ae8:	00051400 	andeq	r1, r5, r0, lsl #8
     aec:	00001349 	andeq	r1, r0, r9, asr #6
     af0:	03011315 	movweq	r1, #4885	; 0x1315
     af4:	3a050b0e 	bcc	143734 <_stack+0xc3734>
     af8:	01053b0b 	tsteq	r5, fp, lsl #22
     afc:	16000013 			; <UNDEFINED> instruction: 0x16000013
     b00:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     b04:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     b08:	0b381349 	bleq	e05834 <_stack+0xd85834>
     b0c:	0d170000 	ldceq	0, cr0, [r7, #-0]
     b10:	3a0e0300 	bcc	381718 <_stack+0x301718>
     b14:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     b18:	00053813 	andeq	r3, r5, r3, lsl r8
     b1c:	00261800 	eoreq	r1, r6, r0, lsl #16
     b20:	00001349 	andeq	r1, r0, r9, asr #6
     b24:	03011319 	movweq	r1, #4889	; 0x1319
     b28:	3a0b0b0e 	bcc	2c3768 <_stack+0x243768>
     b2c:	01053b0b 	tsteq	r5, fp, lsl #22
     b30:	1a000013 	bne	b84 <CPSR_IRQ_INHIBIT+0xb04>
     b34:	0b0b0113 	bleq	2c0f88 <_stack+0x240f88>
     b38:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     b3c:	00001301 	andeq	r1, r0, r1, lsl #6
     b40:	0b01171b 	bleq	467b4 <__bss_end__+0x3276c>
     b44:	3b0b3a0b 	blcc	2cf378 <_stack+0x24f378>
     b48:	00130105 	andseq	r0, r3, r5, lsl #2
     b4c:	000d1c00 	andeq	r1, sp, r0, lsl #24
     b50:	0b3a0e03 	bleq	e84364 <_stack+0xe04364>
     b54:	1349053b 	movtne	r0, #38203	; 0x953b
     b58:	151d0000 	ldrne	r0, [sp, #-0]
     b5c:	01192701 	tsteq	r9, r1, lsl #14
     b60:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
     b64:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     b68:	0b3a0e03 	bleq	e8437c <_stack+0xe0437c>
     b6c:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
     b70:	01111349 	tsteq	r1, r9, asr #6
     b74:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     b78:	01194297 			; <UNDEFINED> instruction: 0x01194297
     b7c:	1f000013 	svcne	0x00000013
     b80:	08030005 	stmdaeq	r3, {r0, r2}
     b84:	0b3b0b3a 	bleq	ec3874 <_stack+0xe43874>
     b88:	17021349 	strne	r1, [r2, -r9, asr #6]
     b8c:	05200000 	streq	r0, [r0, #-0]!
     b90:	3a0e0300 	bcc	381798 <_stack+0x301798>
     b94:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     b98:	00170213 	andseq	r0, r7, r3, lsl r2
     b9c:	00342100 	eorseq	r2, r4, r0, lsl #2
     ba0:	0b3a0803 	bleq	e82bb4 <_stack+0xe02bb4>
     ba4:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     ba8:	00001802 	andeq	r1, r0, r2, lsl #16
     bac:	3f012e22 	svccc	0x00012e22
     bb0:	3a0e0319 	bcc	38181c <_stack+0x30181c>
     bb4:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
     bb8:	3c134919 	ldccc	9, cr4, [r3], {25}
     bbc:	00130119 	andseq	r0, r3, r9, lsl r1
     bc0:	82892300 	addhi	r2, r9, #0, 6
     bc4:	01110101 	tsteq	r1, r1, lsl #2
     bc8:	00001331 	andeq	r1, r0, r1, lsr r3
     bcc:	01828a24 	orreq	r8, r2, r4, lsr #20
     bd0:	91180200 	tstls	r8, r0, lsl #4
     bd4:	00001842 	andeq	r1, r0, r2, asr #16
     bd8:	03003425 	movweq	r3, #1061	; 0x425
     bdc:	3b0b3a0e 	blcc	2cf41c <_stack+0x24f41c>
     be0:	3f13490b 	svccc	0x0013490b
     be4:	00193c19 	andseq	r3, r9, r9, lsl ip
     be8:	012e2600 	teqeq	lr, r0, lsl #12
     bec:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
     bf0:	0b3b0b3a 	bleq	ec38e0 <_stack+0xe438e0>
     bf4:	13491927 	movtne	r1, #39207	; 0x9927
     bf8:	0000193c 	andeq	r1, r0, ip, lsr r9
     bfc:	01110100 	tsteq	r1, r0, lsl #2
     c00:	0b130e25 	bleq	4c449c <_stack+0x44449c>
     c04:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
     c08:	01111755 	tsteq	r1, r5, asr r7
     c0c:	00001710 	andeq	r1, r0, r0, lsl r7
     c10:	0b002402 	bleq	9c20 <.divsi3_skip_div0_test+0x1ca>
     c14:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
     c18:	03000008 	movweq	r0, #8
     c1c:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     c20:	0b3b0b3a 	bleq	ec3910 <_stack+0xe43910>
     c24:	00001349 	andeq	r1, r0, r9, asr #6
     c28:	0b002404 	bleq	9c40 <.divsi3_skip_div0_test+0x1ea>
     c2c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
     c30:	0500000e 	streq	r0, [r0, #-14]
     c34:	0b0b000f 	bleq	2c0c78 <_stack+0x240c78>
     c38:	00001349 	andeq	r1, r0, r9, asr #6
     c3c:	49002606 	stmdbmi	r0, {r1, r2, r9, sl, sp}
     c40:	07000013 	smladeq	r0, r3, r0, r0
     c44:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     c48:	0b3a0e03 	bleq	e8445c <_stack+0xe0445c>
     c4c:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
     c50:	01111349 	tsteq	r1, r9, asr #6
     c54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     c58:	00194297 	mulseq	r9, r7, r2
     c5c:	00050800 	andeq	r0, r5, r0, lsl #16
     c60:	0b3a0803 	bleq	e82c74 <_stack+0xe02c74>
     c64:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     c68:	00001702 	andeq	r1, r0, r2, lsl #14
     c6c:	01110100 	tsteq	r1, r0, lsl #2
     c70:	0b130e25 	bleq	4c450c <_stack+0x44450c>
     c74:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
     c78:	01111755 	tsteq	r1, r5, asr r7
     c7c:	00001710 	andeq	r1, r0, r0, lsl r7
     c80:	03001602 	movweq	r1, #1538	; 0x602
     c84:	3b0b3a0e 	blcc	2cf4c4 <_stack+0x24f4c4>
     c88:	0013490b 	andseq	r4, r3, fp, lsl #18
     c8c:	00240300 	eoreq	r0, r4, r0, lsl #6
     c90:	0b3e0b0b 	bleq	f838c4 <_stack+0xf038c4>
     c94:	00000803 	andeq	r0, r0, r3, lsl #16
     c98:	0b002404 	bleq	9cb0 <.divsi3_skip_div0_test+0x25a>
     c9c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
     ca0:	0500000e 	streq	r0, [r0, #-14]
     ca4:	0b0b000f 	bleq	2c0ce8 <_stack+0x240ce8>
     ca8:	16060000 	strne	r0, [r6], -r0
     cac:	3a0e0300 	bcc	3818b4 <_stack+0x3018b4>
     cb0:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     cb4:	07000013 	smladeq	r0, r3, r0, r0
     cb8:	0b0b0117 	bleq	2c111c <_stack+0x24111c>
     cbc:	0b3b0b3a 	bleq	ec39ac <_stack+0xe439ac>
     cc0:	00001301 	andeq	r1, r0, r1, lsl #6
     cc4:	03000d08 	movweq	r0, #3336	; 0xd08
     cc8:	3b0b3a0e 	blcc	2cf508 <_stack+0x24f508>
     ccc:	0013490b 	andseq	r4, r3, fp, lsl #18
     cd0:	01010900 	tsteq	r1, r0, lsl #18
     cd4:	13011349 	movwne	r1, #4937	; 0x1349
     cd8:	210a0000 	mrscs	r0, (UNDEF: 10)
     cdc:	2f134900 	svccs	0x00134900
     ce0:	0b00000b 	bleq	d14 <CPSR_IRQ_INHIBIT+0xc94>
     ce4:	0b0b0113 	bleq	2c1138 <_stack+0x241138>
     ce8:	0b3b0b3a 	bleq	ec39d8 <_stack+0xe439d8>
     cec:	00001301 	andeq	r1, r0, r1, lsl #6
     cf0:	03000d0c 	movweq	r0, #3340	; 0xd0c
     cf4:	3b0b3a0e 	blcc	2cf534 <_stack+0x24f534>
     cf8:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     cfc:	0d00000b 	stceq	0, cr0, [r0, #-44]	; 0xffffffd4
     d00:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
     d04:	0b3a0b0b 	bleq	e83938 <_stack+0xe03938>
     d08:	13010b3b 	movwne	r0, #6971	; 0x1b3b
     d0c:	0d0e0000 	stceq	0, cr0, [lr, #-0]
     d10:	3a080300 	bcc	201918 <_stack+0x181918>
     d14:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     d18:	000b3813 	andeq	r3, fp, r3, lsl r8
     d1c:	000f0f00 	andeq	r0, pc, r0, lsl #30
     d20:	13490b0b 	movtne	r0, #39691	; 0x9b0b
     d24:	13100000 	tstne	r0, #0
     d28:	0b0e0301 	bleq	381934 <_stack+0x301934>
     d2c:	3b0b3a05 	blcc	2cf548 <_stack+0x24f548>
     d30:	0013010b 	andseq	r0, r3, fp, lsl #2
     d34:	000d1100 	andeq	r1, sp, r0, lsl #2
     d38:	0b3a0e03 	bleq	e8454c <_stack+0xe0454c>
     d3c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     d40:	00000538 	andeq	r0, r0, r8, lsr r5
     d44:	27001512 	smladcs	r0, r2, r5, r1
     d48:	13000019 	movwne	r0, #25
     d4c:	19270115 	stmdbne	r7!, {r0, r2, r4, r8}
     d50:	13011349 	movwne	r1, #4937	; 0x1349
     d54:	05140000 	ldreq	r0, [r4, #-0]
     d58:	00134900 	andseq	r4, r3, r0, lsl #18
     d5c:	01131500 	tsteq	r3, r0, lsl #10
     d60:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
     d64:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     d68:	00001301 	andeq	r1, r0, r1, lsl #6
     d6c:	03000d16 	movweq	r0, #3350	; 0xd16
     d70:	3b0b3a0e 	blcc	2cf5b0 <_stack+0x24f5b0>
     d74:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
     d78:	1700000b 	strne	r0, [r0, -fp]
     d7c:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     d80:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     d84:	05381349 	ldreq	r1, [r8, #-841]!	; 0x349
     d88:	26180000 	ldrcs	r0, [r8], -r0
     d8c:	00134900 	andseq	r4, r3, r0, lsl #18
     d90:	01131900 	tsteq	r3, r0, lsl #18
     d94:	0b0b0e03 	bleq	2c45a8 <_stack+0x2445a8>
     d98:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     d9c:	00001301 	andeq	r1, r0, r1, lsl #6
     da0:	0b01131a 	bleq	45a10 <__bss_end__+0x319c8>
     da4:	3b0b3a0b 	blcc	2cf5d8 <_stack+0x24f5d8>
     da8:	00130105 	andseq	r0, r3, r5, lsl #2
     dac:	01171b00 	tsteq	r7, r0, lsl #22
     db0:	0b3a0b0b 	bleq	e839e4 <_stack+0xe039e4>
     db4:	1301053b 	movwne	r0, #5435	; 0x153b
     db8:	0d1c0000 	ldceq	0, cr0, [ip, #-0]
     dbc:	3a0e0300 	bcc	3819c4 <_stack+0x3019c4>
     dc0:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     dc4:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
     dc8:	19270115 	stmdbne	r7!, {r0, r2, r4, r8}
     dcc:	00001301 	andeq	r1, r0, r1, lsl #6
     dd0:	03000d1e 	movweq	r0, #3358	; 0xd1e
     dd4:	3b0b3a08 	blcc	2cf5fc <_stack+0x24f5fc>
     dd8:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
     ddc:	1f00000b 	svcne	0x0000000b
     de0:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     de4:	0b3a0e03 	bleq	e845f8 <_stack+0xe045f8>
     de8:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
     dec:	01111349 	tsteq	r1, r9, asr #6
     df0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     df4:	01194297 			; <UNDEFINED> instruction: 0x01194297
     df8:	20000013 	andcs	r0, r0, r3, lsl r0
     dfc:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
     e00:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     e04:	17021349 	strne	r1, [r2, -r9, asr #6]
     e08:	05210000 	streq	r0, [r1, #-0]!
     e0c:	3a080300 	bcc	201a14 <_stack+0x181a14>
     e10:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     e14:	00170213 	andseq	r0, r7, r3, lsl r2
     e18:	00342200 	eorseq	r2, r4, r0, lsl #4
     e1c:	0b3a0e03 	bleq	e84630 <_stack+0xe04630>
     e20:	1349053b 	movtne	r0, #38203	; 0x953b
     e24:	00001702 	andeq	r1, r0, r2, lsl #14
     e28:	03003423 	movweq	r3, #1059	; 0x423
     e2c:	3b0b3a0e 	blcc	2cf66c <_stack+0x24f66c>
     e30:	1c134905 	ldcne	9, cr4, [r3], {5}
     e34:	24000005 	strcs	r0, [r0], #-5
     e38:	01018289 	smlabbeq	r1, r9, r2, r8
     e3c:	13310111 	teqne	r1, #1073741828	; 0x40000004
     e40:	00001301 	andeq	r1, r0, r1, lsl #6
     e44:	01828a25 	orreq	r8, r2, r5, lsr #20
     e48:	91180200 	tstls	r8, r0, lsl #4
     e4c:	00001842 	andeq	r1, r0, r2, asr #16
     e50:	01828926 	orreq	r8, r2, r6, lsr #18
     e54:	31011101 	tstcc	r1, r1, lsl #2
     e58:	27000013 	smladcs	r0, r3, r0, r0
     e5c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
     e60:	0b3a0e03 	bleq	e84674 <_stack+0xe04674>
     e64:	1927053b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, sl}
     e68:	06120111 			; <UNDEFINED> instruction: 0x06120111
     e6c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
     e70:	00130119 	andseq	r0, r3, r9, lsl r1
     e74:	00342800 	eorseq	r2, r4, r0, lsl #16
     e78:	0b3a0803 	bleq	e82e8c <_stack+0xe02e8c>
     e7c:	1349053b 	movtne	r0, #38203	; 0x953b
     e80:	00001702 	andeq	r1, r0, r2, lsl #14
     e84:	01828929 	orreq	r8, r2, r9, lsr #18
     e88:	95011101 	strls	r1, [r1, #-257]	; 0x101
     e8c:	13311942 	teqne	r1, #1081344	; 0x108000
     e90:	00001301 	andeq	r1, r0, r1, lsl #6
     e94:	4900212a 	stmdbmi	r0, {r1, r3, r5, r8, sp}
     e98:	00052f13 	andeq	r2, r5, r3, lsl pc
     e9c:	00342b00 	eorseq	r2, r4, r0, lsl #22
     ea0:	0b3a0e03 	bleq	e846b4 <_stack+0xe046b4>
     ea4:	1349053b 	movtne	r0, #38203	; 0x953b
     ea8:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
     eac:	2e2c0000 	cdpcs	0, 2, cr0, cr12, cr0, {0}
     eb0:	03193f01 	tsteq	r9, #1, 30
     eb4:	3b0b3a0e 	blcc	2cf6f4 <_stack+0x24f6f4>
     eb8:	3c192705 	ldccc	7, cr2, [r9], {5}
     ebc:	00130119 	andseq	r0, r3, r9, lsl r1
     ec0:	012e2d00 	teqeq	lr, r0, lsl #26
     ec4:	0e03193f 	mcreq	9, 0, r1, cr3, cr15, {1}
     ec8:	0b3b0b3a 	bleq	ec3bb8 <_stack+0xe43bb8>
     ecc:	13491927 	movtne	r1, #39207	; 0x9927
     ed0:	1301193c 	movwne	r1, #6460	; 0x193c
     ed4:	2e2e0000 	cdpcs	0, 2, cr0, cr14, cr0, {0}
     ed8:	03193f01 	tsteq	r9, #1, 30
     edc:	3b0b3a0e 	blcc	2cf71c <_stack+0x24f71c>
     ee0:	3c192705 	ldccc	7, cr2, [r9], {5}
     ee4:	00000019 	andeq	r0, r0, r9, lsl r0
     ee8:	25011101 	strcs	r1, [r1, #-257]	; 0x101
     eec:	030b130e 	movweq	r1, #45838	; 0xb30e
     ef0:	100e1b0e 	andne	r1, lr, lr, lsl #22
     ef4:	02000017 	andeq	r0, r0, #23
     ef8:	0b0b0024 	bleq	2c0f90 <_stack+0x240f90>
     efc:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
     f00:	24030000 	strcs	r0, [r3], #-0
     f04:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     f08:	000e030b 	andeq	r0, lr, fp, lsl #6
     f0c:	00160400 	andseq	r0, r6, r0, lsl #8
     f10:	0b3a0e03 	bleq	e84724 <_stack+0xe04724>
     f14:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     f18:	16050000 	strne	r0, [r5], -r0
     f1c:	3a0e0300 	bcc	381b24 <_stack+0x301b24>
     f20:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     f24:	06000013 			; <UNDEFINED> instruction: 0x06000013
     f28:	0b0b0117 	bleq	2c138c <_stack+0x24138c>
     f2c:	0b3b0b3a 	bleq	ec3c1c <_stack+0xe43c1c>
     f30:	00001301 	andeq	r1, r0, r1, lsl #6
     f34:	03000d07 	movweq	r0, #3335	; 0xd07
     f38:	3b0b3a0e 	blcc	2cf778 <_stack+0x24f778>
     f3c:	0013490b 	andseq	r4, r3, fp, lsl #18
     f40:	01010800 	tsteq	r1, r0, lsl #16
     f44:	13011349 	movwne	r1, #4937	; 0x1349
     f48:	21090000 	mrscs	r0, (UNDEF: 9)
     f4c:	2f134900 	svccs	0x00134900
     f50:	0a00000b 	beq	f84 <CPSR_IRQ_INHIBIT+0xf04>
     f54:	0b0b0113 	bleq	2c13a8 <_stack+0x2413a8>
     f58:	0b3b0b3a 	bleq	ec3c48 <_stack+0xe43c48>
     f5c:	00001301 	andeq	r1, r0, r1, lsl #6
     f60:	03000d0b 	movweq	r0, #3339	; 0xd0b
     f64:	3b0b3a0e 	blcc	2cf7a4 <_stack+0x24f7a4>
     f68:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     f6c:	0c00000b 	stceq	0, cr0, [r0], {11}
     f70:	0b0b000f 	bleq	2c0fb4 <_stack+0x240fb4>
     f74:	130d0000 	movwne	r0, #53248	; 0xd000
     f78:	0b0e0301 	bleq	381b84 <_stack+0x301b84>
     f7c:	3b0b3a0b 	blcc	2cf7b0 <_stack+0x24f7b0>
     f80:	0013010b 	andseq	r0, r3, fp, lsl #2
     f84:	000d0e00 	andeq	r0, sp, r0, lsl #28
     f88:	0b3a0803 	bleq	e82f9c <_stack+0xe02f9c>
     f8c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
     f90:	00000b38 	andeq	r0, r0, r8, lsr fp
     f94:	0b000f0f 	bleq	4bd8 <CPSR_IRQ_INHIBIT+0x4b58>
     f98:	0013490b 	andseq	r4, r3, fp, lsl #18
     f9c:	01131000 	tsteq	r3, r0
     fa0:	050b0e03 	streq	r0, [fp, #-3587]	; 0xe03
     fa4:	0b3b0b3a 	bleq	ec3c94 <_stack+0xe43c94>
     fa8:	00001301 	andeq	r1, r0, r1, lsl #6
     fac:	03000d11 	movweq	r0, #3345	; 0xd11
     fb0:	3b0b3a0e 	blcc	2cf7f0 <_stack+0x24f7f0>
     fb4:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
     fb8:	12000005 	andne	r0, r0, #5
     fbc:	19270015 	stmdbne	r7!, {r0, r2, r4}
     fc0:	15130000 	ldrne	r0, [r3, #-0]
     fc4:	49192701 	ldmdbmi	r9, {r0, r8, r9, sl, sp}
     fc8:	00130113 	andseq	r0, r3, r3, lsl r1
     fcc:	00051400 	andeq	r1, r5, r0, lsl #8
     fd0:	00001349 	andeq	r1, r0, r9, asr #6
     fd4:	03011315 	movweq	r1, #4885	; 0x1315
     fd8:	3a050b0e 	bcc	143c18 <_stack+0xc3c18>
     fdc:	01053b0b 	tsteq	r5, fp, lsl #22
     fe0:	16000013 			; <UNDEFINED> instruction: 0x16000013
     fe4:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
     fe8:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
     fec:	0b381349 	bleq	e05d18 <_stack+0xd85d18>
     ff0:	0d170000 	ldceq	0, cr0, [r7, #-0]
     ff4:	3a0e0300 	bcc	381bfc <_stack+0x301bfc>
     ff8:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
     ffc:	00053813 	andeq	r3, r5, r3, lsl r8
    1000:	00261800 	eoreq	r1, r6, r0, lsl #16
    1004:	00001349 	andeq	r1, r0, r9, asr #6
    1008:	03011319 	movweq	r1, #4889	; 0x1319
    100c:	3a0b0b0e 	bcc	2c3c4c <_stack+0x243c4c>
    1010:	01053b0b 	tsteq	r5, fp, lsl #22
    1014:	1a000013 	bne	1068 <CPSR_IRQ_INHIBIT+0xfe8>
    1018:	0b0b0113 	bleq	2c146c <_stack+0x24146c>
    101c:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
    1020:	00001301 	andeq	r1, r0, r1, lsl #6
    1024:	0b01171b 	bleq	46c98 <__bss_end__+0x32c50>
    1028:	3b0b3a0b 	blcc	2cf85c <_stack+0x24f85c>
    102c:	00130105 	andseq	r0, r3, r5, lsl #2
    1030:	000d1c00 	andeq	r1, sp, r0, lsl #24
    1034:	0b3a0e03 	bleq	e84848 <_stack+0xe04848>
    1038:	1349053b 	movtne	r0, #38203	; 0x953b
    103c:	151d0000 	ldrne	r0, [sp, #-0]
    1040:	01192701 	tsteq	r9, r1, lsl #14
    1044:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
    1048:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
    104c:	0b3b0b3a 	bleq	ec3d3c <_stack+0xe43d3c>
    1050:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
    1054:	341f0000 	ldrcc	r0, [pc], #-0	; 105c <CPSR_IRQ_INHIBIT+0xfdc>
    1058:	3a0e0300 	bcc	381c60 <_stack+0x301c60>
    105c:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
    1060:	02193f13 	andseq	r3, r9, #19, 30	; 0x4c
    1064:	00000018 	andeq	r0, r0, r8, lsl r0

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000009a 	muleq	r0, sl, r0
   4:	00500002 	subseq	r0, r0, r2
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
  1c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  20:	2f2e2e2f 	svccs	0x002e2e2f
  24:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
  28:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  2c:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
  30:	382e342d 	stmdacc	lr!, {r0, r2, r3, r5, sl, ip, sp}
  34:	6c2f322e 	sfmvs	f3, 4, [pc], #-184	; ffffff84 <STACK_SVR+0xfbffff84>
  38:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
  3c:	6f632f63 	svcvs	0x00632f63
  40:	6769666e 	strbvs	r6, [r9, -lr, ror #12]!
  44:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
  48:	696c0000 	stmdbvs	ip!, {}^	; <UNPREDICTABLE>
  4c:	75663162 	strbvc	r3, [r6, #-354]!	; 0x162
  50:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
  54:	00010053 	andeq	r0, r1, r3, asr r0
  58:	05000000 	streq	r0, [r0, #-0]
  5c:	009a5002 	addseq	r5, sl, r2
  60:	08f60300 	ldmeq	r6!, {r8, r9}^
  64:	2f302101 	svccs	0x00302101
  68:	2f212121 	svccs	0x00212121
  6c:	21212121 	teqcs	r1, r1, lsr #2
  70:	0230212f 	eorseq	r2, r0, #-1073741813	; 0xc000000b
  74:	2f140291 	svccs	0x00140291
  78:	2f222121 	svccs	0x00222121
  7c:	21222121 	teqcs	r2, r1, lsr #2
  80:	2f2f2121 	svccs	0x002f2121
  84:	2f2f4c22 	svccs	0x002f4c22
  88:	b1032121 	tstlt	r3, r1, lsr #2
  8c:	e9032079 	stmdb	r3, {r0, r3, r4, r5, r6, sp}
  90:	21219006 	teqcs	r1, r6
  94:	2f2f2f2f 	svccs	0x002f2f2f
  98:	0001022f 	andeq	r0, r1, pc, lsr #4
  9c:	00660101 	rsbeq	r0, r6, r1, lsl #2
  a0:	00020000 	andeq	r0, r2, r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
  ac:	0101000d 	tsteq	r1, sp
  b0:	00000101 	andeq	r0, r0, r1, lsl #2
  b4:	00000100 	andeq	r0, r0, r0, lsl #2
  b8:	2f2e2e01 	svccs	0x002e2e01
  bc:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
  c0:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  c4:	2f2e2e2f 	svccs	0x002e2e2f
  c8:	672f2e2e 	strvs	r2, [pc, -lr, lsr #28]!
  cc:	342d6363 	strtcc	r6, [sp], #-867	; 0x363
  d0:	322e382e 	eorcc	r3, lr, #3014656	; 0x2e0000
  d4:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
  d8:	2f636367 	svccs	0x00636367
  dc:	666e6f63 	strbtvs	r6, [lr], -r3, ror #30
  e0:	612f6769 	teqvs	pc, r9, ror #14
  e4:	00006d72 	andeq	r6, r0, r2, ror sp
  e8:	3162696c 	cmncc	r2, ip, ror #18
  ec:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
  f0:	00532e73 	subseq	r2, r3, r3, ror lr
  f4:	00000001 	andeq	r0, r0, r1
  f8:	00020500 	andeq	r0, r2, r0, lsl #10
  fc:	0300009d 	movweq	r0, #157	; 0x9d
 100:	02010a96 	andeq	r0, r1, #614400	; 0x96000
 104:	01010001 	tsteq	r1, r1
 108:	0000013a 	andeq	r0, r0, sl, lsr r1
 10c:	010e0002 	tsteq	lr, r2
 110:	01020000 	mrseq	r0, (UNDEF: 2)
 114:	000d0efb 	strdeq	r0, [sp], -fp
 118:	01010101 	tsteq	r1, r1, lsl #2
 11c:	01000000 	mrseq	r0, (UNDEF: 0)
 120:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
 124:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 128:	2f2e2e2f 	svccs	0x002e2e2f
 12c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 130:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 134:	2f2e2e2f 	svccs	0x002e2e2f
 138:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 13c:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 140:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 144:	732f6362 	teqvc	pc, #-2013265919	; 0x88000001
 148:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 14c:	752f0062 	strvc	r0, [pc, #-98]!	; f2 <CPSR_IRQ_INHIBIT+0x72>
 150:	6c2f7273 	sfmvs	f7, 4, [pc], #-460	; ffffff8c <STACK_SVR+0xfbffff8c>
 154:	672f6269 	strvs	r6, [pc, -r9, ror #4]!
 158:	612f6363 	teqvs	pc, r3, ror #6
 15c:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 160:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 164:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 168:	382e342f 	stmdacc	lr!, {r0, r1, r2, r3, r5, sl, ip, sp}
 16c:	692f322e 	stmdbvs	pc!, {r1, r2, r3, r5, r9, ip, sp}	; <UNPREDICTABLE>
 170:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 174:	2f006564 	svccs	0x00006564
 178:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 17c:	75622f64 	strbvc	r2, [r2, #-3940]!	; 0xf64
 180:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xc69
 184:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 188:	2d62696c 	stclcs	9, cr6, [r2, #-432]!	; 0xfffffe50
 18c:	2e312e32 	mrccs	14, 1, r2, cr1, cr2, {1}
 190:	656e2f30 	strbvs	r2, [lr, #-3888]!	; 0xf30
 194:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 198:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 19c:	6e692f63 	cdpvs	15, 6, cr2, cr9, cr3, {3}
 1a0:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 1a4:	79732f65 	ldmdbvc	r3!, {r0, r2, r5, r6, r8, r9, sl, fp, sp}^
 1a8:	622f0073 	eorvs	r0, pc, #115	; 0x73
 1ac:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 1b0:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 1b4:	2f64646c 	svccs	0x0064646c
 1b8:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 1bc:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 1c0:	302e312e 	eorcc	r3, lr, lr, lsr #2
 1c4:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 1c8:	2f62696c 	svccs	0x0062696c
 1cc:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 1d0:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 1d4:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 1d8:	616d0000 	cmnvs	sp, r0
 1dc:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 1e0:	0100632e 	tsteq	r0, lr, lsr #6
 1e4:	74730000 	ldrbtvc	r0, [r3], #-0
 1e8:	66656464 	strbtvs	r6, [r5], -r4, ror #8
 1ec:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 1f0:	6f6c0000 	svcvs	0x006c0000
 1f4:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 1f8:	00000300 	andeq	r0, r0, r0, lsl #6
 1fc:	7079745f 	rsbsvc	r7, r9, pc, asr r4
 200:	682e7365 	stmdavs	lr!, {r0, r2, r5, r6, r8, r9, ip, sp, lr}
 204:	00000300 	andeq	r0, r0, r0, lsl #6
 208:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 20c:	00682e74 	rsbeq	r2, r8, r4, ror lr
 210:	6d000003 	stcvs	0, cr0, [r0, #-12]
 214:	6f6c6c61 	svcvs	0x006c6c61
 218:	00682e63 	rsbeq	r2, r8, r3, ror #28
 21c:	00000004 	andeq	r0, r0, r4
 220:	04020500 	streq	r0, [r2], #-1280	; 0x500
 224:	0300009d 	movweq	r0, #157	; 0x9d
 228:	130101d5 	movwne	r0, #4565	; 0x11d5
 22c:	03022149 	movweq	r2, #8521	; 0x2149
 230:	00010100 	andeq	r0, r1, r0, lsl #2
 234:	9d140205 	lfmls	f0, 4, [r4, #-20]	; 0xffffffec
 238:	dc030000 	stcle	0, cr0, [r3], {-0}
 23c:	49130101 	ldmdbmi	r3, {r0, r8}
 240:	00030221 	andeq	r0, r3, r1, lsr #4
 244:	03380101 	teqeq	r8, #1073741824	; 0x40000000
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
 360:	009d2402 	addseq	r2, sp, r2, lsl #8
 364:	12970300 	addsne	r0, r7, #0, 6
 368:	2e140301 	cdpcs	3, 1, cr0, cr4, cr1, {0}
 36c:	033c6c03 	teqeq	ip, #768	; 0x300
 370:	6c032014 	stcvs	0, cr2, [r3], {20}
 374:	3c14033c 	ldccc	3, cr0, [r4], {60}	; 0x3c
 378:	3e328831 	mrccc	8, 1, r8, cr2, cr1, {1}
 37c:	44246732 	strtmi	r6, [r4], #-1842	; 0x732
 380:	1c232a25 	stcne	10, cr2, [r3], #-148	; 0xffffff6c
 384:	212d212f 	teqcs	sp, pc, lsr #2
 388:	0322212d 	teqeq	r2, #1073741835	; 0x4000000b
 38c:	032e01d1 	teqeq	lr, #1073741876	; 0x40000034
 390:	004a7eb8 	strheq	r7, [sl], #-232	; 0xffffff18
 394:	83120402 	tsthi	r2, #33554432	; 0x2000000
 398:	12040200 	andne	r0, r4, #0, 4
 39c:	4a0b0368 	bmi	2c1144 <_stack+0x241144>
 3a0:	3e3c7503 	cdpcc	5, 3, cr7, cr12, cr3, {0}
 3a4:	0330223d 	teqeq	r0, #-805306365	; 0xd0000003
 3a8:	ae342e0e 	cdpge	14, 3, cr2, cr4, cr14, {0}
 3ac:	0e03223d 	mcreq	2, 0, r2, cr3, cr13, {1}
 3b0:	034c1e3c 	movteq	r1, #52796	; 0xce3c
 3b4:	0200200a 	andeq	r2, r0, #10
 3b8:	4a060104 	bmi	1807d0 <_stack+0x1007d0>
 3bc:	6b1a0806 	blvs	6823dc <_stack+0x6023dc>
 3c0:	301f2f31 	andscc	r2, pc, r1, lsr pc	; <UNPREDICTABLE>
 3c4:	512e0b03 	teqpl	lr, r3, lsl #22
 3c8:	034a1203 	movteq	r1, #41475	; 0xa203
 3cc:	3d4c3c6e 	stclcc	12, cr3, [ip, #-440]	; 0xfffffe48
 3d0:	27563222 	ldrbcs	r3, [r6, -r2, lsr #4]
 3d4:	31207a03 	teqcc	r0, r3, lsl #20
 3d8:	674b212b 	strbvs	r2, [fp, -fp, lsr #2]
 3dc:	032f2221 	teqeq	pc, #268435458	; 0x10000002
 3e0:	1f207eeb 	svcne	0x00207eeb
 3e4:	2e01f003 	cdpcs	0, 0, cr15, cr1, cr3, {0}
 3e8:	02040200 	andeq	r0, r4, #0, 4
 3ec:	4a7eb803 	bmi	1fae400 <_stack+0x1f2e400>
 3f0:	03040200 	movweq	r0, #16896	; 0x4200
 3f4:	03064a06 	movweq	r4, #27142	; 0x6a06
 3f8:	2d237433 	cfstrscs	mvf7, [r3, #-204]!	; 0xffffff34
 3fc:	93034c1e 	movwls	r4, #15390	; 0x3c1e
 400:	5f032e01 	svcpl	0x00032e01
 404:	02004b4a 	andeq	r4, r0, #75776	; 0x12800
 408:	002d0104 	eoreq	r0, sp, r4, lsl #2
 40c:	2f010402 	svccs	0x00010402
 410:	3c7cea03 	ldclcc	10, cr14, [ip], #-12
 414:	2e790335 	mrccs	3, 3, r0, cr9, cr5, {1}
 418:	72033135 	andvc	r3, r3, #1073741837	; 0x4000000d
 41c:	03273220 	teqeq	r7, #32, 4
 420:	21272e79 	teqcs	r7, r9, ror lr
 424:	363c7803 	ldrtcc	r7, [ip], -r3, lsl #16
 428:	23475b68 	movtcs	r5, #31592	; 0x7b68
 42c:	5a1e4c5c 	bpl	7935a4 <_stack+0x7135a4>
 430:	032e0903 	teqeq	lr, #49152	; 0xc000
 434:	70037413 	andvc	r7, r3, r3, lsl r4
 438:	40303a20 	eorsmi	r3, r0, r0, lsr #20
 43c:	03425930 	movteq	r5, #10544	; 0x2930
 440:	09032e77 	stmdbeq	r3, {r0, r1, r2, r4, r5, r6, r9, sl, fp, sp}
 444:	30444d3c 	subcc	r4, r4, ip, lsr sp
 448:	2e79032c 	cdpcs	3, 7, cr0, cr9, cr12, {1}
 44c:	66790327 	ldrbtvs	r0, [r9], -r7, lsr #6
 450:	3c0b033e 	stccc	3, cr0, [fp], {62}	; 0x3e
 454:	24207a03 	strtcs	r7, [r0], #-2563	; 0xa03
 458:	5127342a 	teqpl	r7, sl, lsr #8
 45c:	4f301f2f 	svcmi	0x00301f2f
 460:	59207a03 	stmdbpl	r0!, {r0, r1, r9, fp, ip, sp, lr}
 464:	75333130 	ldrvc	r3, [r3, #-304]!	; 0x130
 468:	c8036733 	stmdagt	r3, {r0, r1, r4, r5, r8, r9, sl, sp, lr}
 46c:	2f1f5802 	svccs	0x001f5802
 470:	01040200 	mrseq	r0, R12_usr
 474:	30062006 	andcc	r2, r6, r6
 478:	262f1f21 	strtcs	r1, [pc], -r1, lsr #30
 47c:	411c3021 	tstmi	ip, r1, lsr #32
 480:	3222211c 	eorcc	r2, r2, #28, 2
 484:	4a7ec903 	bmi	1fb2898 <_stack+0x1f32898>
 488:	231e311f 	tstcs	lr, #-1073741817	; 0xc0000007
 48c:	212d212a 	teqcs	sp, sl, lsr #2
 490:	01b50322 			; <UNDEFINED> instruction: 0x01b50322
 494:	0402002e 	streq	r0, [r2], #-46	; 0x2e
 498:	7eb80304 	cdpvc	3, 11, cr0, cr8, cr4, {0}
 49c:	0402004a 	streq	r0, [r2], #-74	; 0x4a
 4a0:	00900606 	addseq	r0, r0, r6, lsl #12
 4a4:	4a070402 	bmi	1c14b4 <_stack+0x1414b4>
 4a8:	02040200 	andeq	r0, r4, #0, 4
 4ac:	743b0306 	ldrtvc	r0, [fp], #-774	; 0x306
 4b0:	04040200 	streq	r0, [r4], #-512	; 0x200
 4b4:	02003c06 	andeq	r3, r0, #1536	; 0x600
 4b8:	00660604 	rsbeq	r0, r6, r4, lsl #12
 4bc:	3c070402 	cfstrscc	mvf0, [r7], {2}
 4c0:	12040200 	andne	r0, r4, #0, 4
 4c4:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 4c8:	02009002 	andeq	r9, r0, #2
 4cc:	00580104 	subseq	r0, r8, r4, lsl #2
 4d0:	3c030402 	cfstrscc	mvf0, [r3], {2}
 4d4:	01040200 	mrseq	r0, R12_usr
 4d8:	6a03062e 	bvs	c1d98 <_stack+0x41d98>
 4dc:	301b2658 	andscc	r2, fp, r8, asr r6
 4e0:	6729262c 	strvs	r2, [r9, -ip, lsr #12]!
 4e4:	032f2221 	teqeq	pc, #268435458	; 0x10000002
 4e8:	032000d9 	teqeq	r0, #217	; 0xd9
 4ec:	09032e77 	stmdbeq	r3, {r0, r1, r2, r4, r5, r6, r9, sl, fp, sp}
 4f0:	7ee80320 	cdpvc	3, 14, cr0, cr8, cr0, {1}
 4f4:	03232f58 	teqeq	r3, #88, 30	; 0x160
 4f8:	7603200a 	strvc	r2, [r3], -sl
 4fc:	0182033c 	orreq	r0, r2, ip, lsr r3
 500:	1e3e213c 	mrcne	1, 1, r2, cr14, cr12, {1}
 504:	2f304b1f 	svccs	0x00304b1f
 508:	03040200 	movweq	r0, #16896	; 0x4200
 50c:	03204403 	teqeq	r0, #50331648	; 0x3000000
 510:	034a7de5 	movteq	r7, #44517	; 0xade5
 514:	038202f2 	orreq	r0, r2, #536870927	; 0x2000000f
 518:	2d344a79 	vldmdbcs	r4!, {s8-s128}
 51c:	09032229 	stmdbeq	r3, {r0, r3, r5, r9, sp}
 520:	0402004a 	streq	r0, [r2], #-74	; 0x4a
 524:	004a0601 	subeq	r0, sl, r1, lsl #12
 528:	06010402 	streq	r0, [r1], -r2, lsl #8
 52c:	0402003e 	streq	r0, [r2], #-62	; 0x3e
 530:	206d0301 	rsbcs	r0, sp, r1, lsl #6
 534:	01040200 	mrseq	r0, R12_usr
 538:	31201303 	teqcc	r0, r3, lsl #6
 53c:	02002c1f 	andeq	r2, r0, #7936	; 0x1f00
 540:	e8030804 	stmda	r3, {r2, fp}
 544:	02003c7e 	andeq	r3, r0, #32256	; 0x7e00
 548:	3c060904 	stccc	9, cr0, [r6], {4}
 54c:	7ed80306 	cdpvc	3, 13, cr0, cr8, cr6, {0}
 550:	04020074 	streq	r0, [r2], #-116	; 0x74
 554:	01e30301 	mvneq	r0, r1, lsl #6
 558:	04020066 	streq	r0, [r2], #-102	; 0x66
 55c:	9e45030a 	cdpls	3, 4, cr0, cr5, cr10, {0}
 560:	e47ea703 	ldrbt	sl, [lr], #-1795	; 0x703
 564:	032f1f5b 	teqeq	pc, #364	; 0x16c
 568:	02004a3b 	andeq	r4, r0, #241664	; 0x3b000
 56c:	d6030804 	strle	r0, [r3], -r4, lsl #16
 570:	02009001 	andeq	r9, r0, #1
 574:	3c060904 	stccc	9, cr0, [r6], {4}
 578:	0a040200 	beq	100d80 <_stack+0x80d80>
 57c:	000d024a 	andeq	r0, sp, sl, asr #4
 580:	011f0101 	tsteq	pc, r1, lsl #2
 584:	00020000 	andeq	r0, r2, r0
 588:	000000cf 	andeq	r0, r0, pc, asr #1
 58c:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 590:	0101000d 	tsteq	r1, sp
 594:	00000101 	andeq	r0, r0, r1, lsl #2
 598:	00000100 	andeq	r0, r0, r0, lsl #2
 59c:	2f2e2e01 	svccs	0x002e2e01
 5a0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 5a4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 5a8:	2f2e2e2f 	svccs	0x002e2e2f
 5ac:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 5b0:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 5b4:	2f2e2e2f 	svccs	0x002e2e2f
 5b8:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 5bc:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 420 <CPSR_IRQ_INHIBIT+0x3a0>
 5c0:	2f636269 	svccs	0x00636269
 5c4:	6863616d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, sp, lr}^
 5c8:	2f656e69 	svccs	0x00656e69
 5cc:	2f6d7261 	svccs	0x006d7261
 5d0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 5d4:	74732f2e 	ldrbtvc	r2, [r3], #-3886	; 0xf2e
 5d8:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 5dc:	73752f00 	cmnvc	r5, #0, 30
 5e0:	696c2f72 	stmdbvs	ip!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 5e4:	63672f62 	cmnvs	r7, #392	; 0x188
 5e8:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 5ec:	6f6e2d6d 	svcvs	0x006e2d6d
 5f0:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
 5f4:	2f696261 	svccs	0x00696261
 5f8:	2e382e34 	mrccs	14, 1, r2, cr8, cr4, {1}
 5fc:	6e692f32 	mcrvs	15, 3, r2, cr9, cr2, {1}
 600:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 604:	622f0065 	eorvs	r0, pc, #101	; 0x65
 608:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 60c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 610:	2f64646c 	svccs	0x0064646c
 614:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 618:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 61c:	302e312e 	eorcc	r3, lr, lr, lsr #2
 620:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 624:	2f62696c 	svccs	0x0062696c
 628:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 62c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 630:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 634:	656d0000 	strbvs	r0, [sp, #-0]!
 638:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
 63c:	0100632e 	tsteq	r0, lr, lsr #6
 640:	74730000 	ldrbtvc	r0, [r3], #-0
 644:	66656464 	strbtvs	r6, [r5], -r4, ror #8
 648:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 64c:	74730000 	ldrbtvc	r0, [r3], #-0
 650:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 654:	0300682e 	movweq	r6, #2094	; 0x82e
 658:	00000000 	andeq	r0, r0, r0
 65c:	a28c0205 	addge	r0, ip, #1342177280	; 0x50000000
 660:	39030000 	stmdbcc	r3, {}	; <UNPREDICTABLE>
 664:	01150301 	tsteq	r5, r1, lsl #6
 668:	03206b03 	teqeq	r0, #3072	; 0xc00
 66c:	02002015 	andeq	r2, r0, #21
 670:	20060104 	andcs	r0, r6, r4, lsl #2
 674:	596e0666 	stmdbpl	lr!, {r1, r2, r5, r6, r9, sl}^
 678:	00454b4b 	subeq	r4, r5, fp, asr #22
 67c:	03010402 	movweq	r0, #5122	; 0x1402
 680:	336f580a 	cmncc	pc, #655360	; 0xa0000
 684:	221d2f22 	andscs	r2, sp, #34, 30	; 0x88
 688:	9e0b032c 	cdpls	3, 0, cr0, cr11, cr12, {1}
 68c:	2d212d2f 	stccs	13, cr2, [r1, #-188]!	; 0xffffff44
 690:	2e590325 	cdpcs	3, 5, cr0, cr9, cr5, {1}
 694:	03202203 	teqeq	r0, #805306368	; 0x30000000
 698:	17033c5e 	smlsdne	r3, lr, ip, r3
 69c:	200b032e 	andcs	r0, fp, lr, lsr #6
 6a0:	01000302 	tsteq	r0, r2, lsl #6
 6a4:	00010a01 	andeq	r0, r1, r1, lsl #20
 6a8:	ba000200 	blt	eb0 <CPSR_IRQ_INHIBIT+0xe30>
 6ac:	02000000 	andeq	r0, r0, #0
 6b0:	0d0efb01 	vstreq	d15, [lr, #-4]
 6b4:	01010100 	mrseq	r0, (UNDEF: 17)
 6b8:	00000001 	andeq	r0, r0, r1
 6bc:	01000001 	tsteq	r0, r1
 6c0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 6c4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 6c8:	2f2e2e2f 	svccs	0x002e2e2f
 6cc:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 6d0:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 6d4:	2f2e2e2f 	svccs	0x002e2e2f
 6d8:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 6dc:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 540 <CPSR_IRQ_INHIBIT+0x4c0>
 6e0:	2f636269 	svccs	0x00636269
 6e4:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 6e8:	2f00676e 	svccs	0x0000676e
 6ec:	2f727375 	svccs	0x00727375
 6f0:	2f62696c 	svccs	0x0062696c
 6f4:	2f636367 	svccs	0x00636367
 6f8:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 6fc:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
 700:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 704:	2e342f69 	cdpcs	15, 3, cr2, cr4, cr9, {3}
 708:	2f322e38 	svccs	0x00322e38
 70c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 710:	00656475 	rsbeq	r6, r5, r5, ror r4
 714:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 718:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 71c:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 720:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 724:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 728:	312e322d 	teqcc	lr, sp, lsr #4
 72c:	6e2f302e 	cdpvs	0, 2, cr3, cr15, cr14, {1}
 730:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 734:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 738:	692f6362 	stmdbvs	pc!, {r1, r5, r6, r8, r9, sp, lr}	; <UNPREDICTABLE>
 73c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 740:	00006564 	andeq	r6, r0, r4, ror #10
 744:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
 748:	632e7465 	teqvs	lr, #1694498816	; 0x65000000
 74c:	00000100 	andeq	r0, r0, r0, lsl #2
 750:	64647473 	strbtvs	r7, [r4], #-1139	; 0x473
 754:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 758:	00000200 	andeq	r0, r0, r0, lsl #4
 75c:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 760:	682e676e 	stmdavs	lr!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
 764:	00000300 	andeq	r0, r0, r0, lsl #6
 768:	02050000 	andeq	r0, r5, #0
 76c:	0000a334 	andeq	sl, r0, r4, lsr r3
 770:	03013003 	movweq	r3, #4099	; 0x1003
 774:	7603010a 	strvc	r0, [r3], -sl, lsl #2
 778:	200a0320 	andcs	r0, sl, r0, lsr #6
 77c:	302b9122 	eorcc	r9, fp, r2, lsr #2
 780:	7503282c 	strvc	r2, [r3, #-2092]	; 0x82c
 784:	2018032e 	andscs	r0, r8, lr, lsr #6
 788:	2f207a03 	svccs	0x00207a03
 78c:	2f2f9233 	svccs	0x002f9233
 790:	0200292f 	andeq	r2, r0, #770048	; 0xbc000
 794:	09030104 	stmdbeq	r3, {r2, r8}
 798:	4a620358 	bmi	1881500 <_stack+0x1801500>
 79c:	1f2e2103 	svcne	0x002e2103
 7a0:	0402002c 	streq	r0, [r2], #-44	; 0x2c
 7a4:	900b0301 	andls	r0, fp, r1, lsl #6
 7a8:	03322d3d 	teqeq	r2, #3904	; 0xf40
 7ac:	03022e53 	movweq	r2, #11859	; 0x2e53
 7b0:	f6010100 			; <UNDEFINED> instruction: 0xf6010100
 7b4:	02000000 	andeq	r0, r0, #0
 7b8:	0000d200 	andeq	sp, r0, r0, lsl #4
 7bc:	fb010200 	blx	40fc6 <__bss_end__+0x2cf7e>
 7c0:	01000d0e 	tsteq	r0, lr, lsl #26
 7c4:	00010101 	andeq	r0, r1, r1, lsl #2
 7c8:	00010000 	andeq	r0, r1, r0
 7cc:	2e2e0100 	sufcse	f0, f6, f0
 7d0:	2f2e2e2f 	svccs	0x002e2e2f
 7d4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7d8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 7dc:	2f2e2e2f 	svccs	0x002e2e2f
 7e0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7e4:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xf2e
 7e8:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 7ec:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 7f0:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xf63
 7f4:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 7f8:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
 7fc:	2f646c69 	svccs	0x00646c69
 800:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 804:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
 808:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 80c:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
 810:	2f302e31 	svccs	0x00302e31
 814:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 818:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 67c <CPSR_IRQ_INHIBIT+0x5fc>
 81c:	2f636269 	svccs	0x00636269
 820:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 824:	2f656475 	svccs	0x00656475
 828:	00737973 	rsbseq	r7, r3, r3, ror r9
 82c:	7273752f 	rsbsvc	r7, r3, #197132288	; 0xbc00000
 830:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 834:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 838:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 83c:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 840:	61652d65 	cmnvs	r5, r5, ror #26
 844:	342f6962 	strtcc	r6, [pc], #-2402	; 84c <CPSR_IRQ_INHIBIT+0x7cc>
 848:	322e382e 	eorcc	r3, lr, #3014656	; 0x2e0000
 84c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 850:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 854:	6c6d0000 	stclvs	0, cr0, [sp], #-0
 858:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 85c:	00010063 	andeq	r0, r1, r3, rrx
 860:	636f6c00 	cmnvs	pc, #0, 24
 864:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 868:	5f000002 	svcpl	0x00000002
 86c:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0x974
 870:	00682e73 	rsbeq	r2, r8, r3, ror lr
 874:	73000002 	movwvc	r0, #2
 878:	65646474 	strbvs	r6, [r4, #-1140]!	; 0x474
 87c:	00682e66 	rsbeq	r2, r8, r6, ror #28
 880:	72000003 	andvc	r0, r0, #3
 884:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 888:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 88c:	00000000 	andeq	r0, r0, r0
 890:	a3d40205 	bicsge	r0, r4, #1342177280	; 0x50000000
 894:	30030000 	andcc	r0, r3, r0
 898:	00010201 	andeq	r0, r1, r1, lsl #4
 89c:	05000101 	streq	r0, [r0, #-257]	; 0x101
 8a0:	00a3d802 	adceq	sp, r3, r2, lsl #16
 8a4:	01390300 	teqeq	r9, r0, lsl #6
 8a8:	01000102 	tsteq	r0, r2, lsl #2
 8ac:	00016501 	andeq	r6, r1, r1, lsl #10
 8b0:	0c000200 	sfmeq	f0, 4, [r0], {-0}
 8b4:	02000001 	andeq	r0, r0, #1
 8b8:	0d0efb01 	vstreq	d15, [lr, #-4]
 8bc:	01010100 	mrseq	r0, (UNDEF: 17)
 8c0:	00000001 	andeq	r0, r0, r1
 8c4:	01000001 	tsteq	r0, r1
 8c8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 8cc:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 8d0:	2f2e2e2f 	svccs	0x002e2e2f
 8d4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 8d8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 8dc:	2f2e2e2f 	svccs	0x002e2e2f
 8e0:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 8e4:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 748 <CPSR_IRQ_INHIBIT+0x6c8>
 8e8:	2f636269 	svccs	0x00636269
 8ec:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 8f0:	622f0074 	eorvs	r0, pc, #116	; 0x74
 8f4:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 8f8:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 8fc:	2f64646c 	svccs	0x0064646c
 900:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 904:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 908:	302e312e 	eorcc	r3, lr, lr, lsr #2
 90c:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 910:	2f62696c 	svccs	0x0062696c
 914:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 918:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 91c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 920:	7379732f 	cmnvc	r9, #-1140850688	; 0xbc000000
 924:	73752f00 	cmnvc	r5, #0, 30
 928:	696c2f72 	stmdbvs	ip!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 92c:	63672f62 	cmnvs	r7, #392	; 0x188
 930:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 934:	6f6e2d6d 	svcvs	0x006e2d6d
 938:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
 93c:	2f696261 	svccs	0x00696261
 940:	2e382e34 	mrccs	14, 1, r2, cr8, cr4, {1}
 944:	6e692f32 	mcrvs	15, 3, r2, cr9, cr2, {1}
 948:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 94c:	622f0065 	eorvs	r0, pc, #101	; 0x65
 950:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 954:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 958:	2f64646c 	svccs	0x0064646c
 95c:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 960:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 964:	302e312e 	eorcc	r3, lr, lr, lsr #2
 968:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 96c:	2f62696c 	svccs	0x0062696c
 970:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 974:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 978:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 97c:	65720000 	ldrbvs	r0, [r2, #-0]!
 980:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
 984:	00010063 	andeq	r0, r1, r3, rrx
 988:	636f6c00 	cmnvs	pc, #0, 24
 98c:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 990:	5f000002 	svcpl	0x00000002
 994:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0x974
 998:	00682e73 	rsbeq	r2, r8, r3, ror lr
 99c:	73000002 	movwvc	r0, #2
 9a0:	65646474 	strbvs	r6, [r4, #-1140]!	; 0x474
 9a4:	00682e66 	rsbeq	r2, r8, r6, ror #28
 9a8:	72000003 	andvc	r0, r0, #3
 9ac:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 9b0:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 9b4:	74730000 	ldrbtvc	r0, [r3], #-0
 9b8:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 9bc:	0400682e 	streq	r6, [r0], #-2094	; 0x82e
 9c0:	00000000 	andeq	r0, r0, r0
 9c4:	a3dc0205 	bicsge	r0, ip, #1342177280	; 0x50000000
 9c8:	23030000 	movwcs	r0, #12288	; 0x3000
 9cc:	1e222001 	cdpne	0, 2, cr2, cr2, cr1, {0}
 9d0:	2f302122 	svccs	0x00302122
 9d4:	0002022d 	andeq	r0, r2, sp, lsr #4
 9d8:	05000101 	streq	r0, [r0, #-257]	; 0x101
 9dc:	00a3f802 	adceq	pc, r3, r2, lsl #16
 9e0:	012e0300 	teqeq	lr, r0, lsl #6
 9e4:	21204913 	teqcs	r0, r3, lsl r9
 9e8:	271d3143 	ldrcs	r3, [sp, -r3, asr #2]
 9ec:	382f312f 	stmdacc	pc!, {r0, r1, r2, r3, r5, r8, ip, sp}	; <UNPREDICTABLE>
 9f0:	4a0d0337 	bmi	3416d4 <_stack+0x2c16d4>
 9f4:	1c032f4c 	stcne	15, cr2, [r3], {76}	; 0x4c
 9f8:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 9fc:	063c0601 	ldrteq	r0, [ip], -r1, lsl #12
 a00:	23382150 	teqcs	r8, #80, 2
 a04:	200a031d 	andcs	r0, sl, sp, lsl r3
 a08:	3e40432f 	cdpcc	3, 4, cr4, cr0, cr15, {1}
 a0c:	7a03264b 	bvc	ca340 <_stack+0x4a340>
 a10:	0002022e 	andeq	r0, r2, lr, lsr #4
 a14:	012d0101 	teqeq	sp, r1, lsl #2
 a18:	00020000 	andeq	r0, r2, r0
 a1c:	0000010b 	andeq	r0, r0, fp, lsl #2
 a20:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 a24:	0101000d 	tsteq	r1, sp
 a28:	00000101 	andeq	r0, r0, r1, lsl #2
 a2c:	00000100 	andeq	r0, r0, r0, lsl #2
 a30:	2f2e2e01 	svccs	0x002e2e01
 a34:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a38:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a3c:	2f2e2e2f 	svccs	0x002e2e2f
 a40:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a44:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a48:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 a4c:	2f62696c 	svccs	0x0062696c
 a50:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 a54:	6565722f 	strbvs	r7, [r5, #-559]!	; 0x22f
 a58:	2f00746e 	svccs	0x0000746e
 a5c:	2f727375 	svccs	0x00727375
 a60:	2f62696c 	svccs	0x0062696c
 a64:	2f636367 	svccs	0x00636367
 a68:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 a6c:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
 a70:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 a74:	2e342f69 	cdpcs	15, 3, cr2, cr4, cr9, {3}
 a78:	2f322e38 	svccs	0x00322e38
 a7c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 a80:	00656475 	rsbeq	r6, r5, r5, ror r4
 a84:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 a88:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 a8c:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 a90:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 a94:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 a98:	312e322d 	teqcc	lr, sp, lsr #4
 a9c:	6e2f302e 	cdpvs	0, 2, cr3, cr15, cr14, {1}
 aa0:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 aa4:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 aa8:	692f6362 	stmdbvs	pc!, {r1, r5, r6, r8, r9, sp, lr}	; <UNPREDICTABLE>
 aac:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 ab0:	732f6564 	teqvc	pc, #100, 10	; 0x19000000
 ab4:	2f007379 	svccs	0x00007379
 ab8:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 abc:	75622f64 	strbvc	r2, [r2, #-3940]!	; 0xf64
 ac0:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xc69
 ac4:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 ac8:	2d62696c 	stclcs	9, cr6, [r2, #-432]!	; 0xfffffe50
 acc:	2e312e32 	mrccs	14, 1, r2, cr1, cr2, {1}
 ad0:	656e2f30 	strbvs	r2, [lr, #-3888]!	; 0xf30
 ad4:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 ad8:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 adc:	6e692f63 	cdpvs	15, 6, cr2, cr9, cr3, {3}
 ae0:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 ae4:	73000065 	movwvc	r0, #101	; 0x65
 ae8:	726b7262 	rsbvc	r7, fp, #536870918	; 0x20000006
 aec:	0100632e 	tsteq	r0, lr, lsr #6
 af0:	74730000 	ldrbtvc	r0, [r3], #-0
 af4:	66656464 	strbtvs	r6, [r5], -r4, ror #8
 af8:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 afc:	6f6c0000 	svcvs	0x006c0000
 b00:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 b04:	00000300 	andeq	r0, r0, r0, lsl #6
 b08:	7079745f 	rsbsvc	r7, r9, pc, asr r4
 b0c:	682e7365 	stmdavs	lr!, {r0, r2, r5, r6, r8, r9, ip, sp, lr}
 b10:	00000300 	andeq	r0, r0, r0, lsl #6
 b14:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 b18:	00682e74 	rsbeq	r2, r8, r4, ror lr
 b1c:	72000003 	andvc	r0, r0, #3
 b20:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 b24:	0400682e 	streq	r6, [r0], #-2094	; 0x82e
 b28:	00000000 	andeq	r0, r0, r0
 b2c:	a4880205 	strge	r0, [r8], #517	; 0x205
 b30:	34030000 	strcc	r0, [r3], #-0
 b34:	25462401 	strbcs	r2, [r6, #-1025]	; 0x401
 b38:	004d2f1f 	subeq	r2, sp, pc, lsl pc
 b3c:	1d010402 	cfstrsne	mvf0, [r1, #-8]
 b40:	0102223d 	tsteq	r2, sp, lsr r2
 b44:	d9010100 	stmdble	r1, {r8}
 b48:	02000000 	andeq	r0, r0, #0
 b4c:	0000c200 	andeq	ip, r0, r0, lsl #4
 b50:	fb010200 	blx	4135a <__bss_end__+0x2d312>
 b54:	01000d0e 	tsteq	r0, lr, lsl #26
 b58:	00010101 	andeq	r0, r1, r1, lsl #2
 b5c:	00010000 	andeq	r0, r1, r0
 b60:	2e2e0100 	sufcse	f0, f6, f0
 b64:	2f2e2e2f 	svccs	0x002e2e2f
 b68:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 b6c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 b70:	2f2e2e2f 	svccs	0x002e2e2f
 b74:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 b78:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 b7c:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 b80:	2f62696c 	svccs	0x0062696c
 b84:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 b88:	63616d2f 	cmnvs	r1, #3008	; 0xbc0
 b8c:	656e6968 	strbvs	r6, [lr, #-2408]!	; 0x968
 b90:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 b94:	73752f00 	cmnvc	r5, #0, 30
 b98:	696c2f72 	stmdbvs	ip!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 b9c:	63672f62 	cmnvs	r7, #392	; 0x188
 ba0:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 ba4:	6f6e2d6d 	svcvs	0x006e2d6d
 ba8:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
 bac:	2f696261 	svccs	0x00696261
 bb0:	2e382e34 	mrccs	14, 1, r2, cr8, cr4, {1}
 bb4:	6e692f32 	mcrvs	15, 3, r2, cr9, cr2, {1}
 bb8:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 bbc:	622f0065 	eorvs	r0, pc, #101	; 0x65
 bc0:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 bc4:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 bc8:	2f64646c 	svccs	0x0064646c
 bcc:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 bd0:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 bd4:	302e312e 	eorcc	r3, lr, lr, lsr #2
 bd8:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 bdc:	2f62696c 	svccs	0x0062696c
 be0:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 be4:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 be8:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 bec:	74730000 	ldrbtvc	r0, [r3], #-0
 bf0:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
 bf4:	0100632e 	tsteq	r0, lr, lsr #6
 bf8:	74730000 	ldrbtvc	r0, [r3], #-0
 bfc:	66656464 	strbtvs	r6, [r5], -r4, ror #8
 c00:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 c04:	74730000 	ldrbtvc	r0, [r3], #-0
 c08:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 c0c:	0300682e 	movweq	r6, #2094	; 0x82e
 c10:	00000000 	andeq	r0, r0, r0
 c14:	a4b00205 	ldrtge	r0, [r0], #517	; 0x205
 c18:	c2030000 	andgt	r0, r3, #0
 c1c:	02130100 	andseq	r0, r3, #0, 2
 c20:	0101002f 	tsteq	r1, pc, lsr #32
 c24:	00000221 	andeq	r0, r0, r1, lsr #4
 c28:	010e0002 	tsteq	lr, r2
 c2c:	01020000 	mrseq	r0, (UNDEF: 2)
 c30:	000d0efb 	strdeq	r0, [sp], -fp
 c34:	01010101 	tsteq	r1, r1, lsl #2
 c38:	01000000 	mrseq	r0, (UNDEF: 0)
 c3c:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
 c40:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 c44:	2f2e2e2f 	svccs	0x002e2e2f
 c48:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 c4c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 c50:	2f2e2e2f 	svccs	0x002e2e2f
 c54:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 c58:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 c5c:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 c60:	732f6362 	teqvc	pc, #-2013265919	; 0x88000001
 c64:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 c68:	752f0062 	strvc	r0, [pc, #-98]!	; c0e <CPSR_IRQ_INHIBIT+0xb8e>
 c6c:	6c2f7273 	sfmvs	f7, 4, [pc], #-460	; aa8 <CPSR_IRQ_INHIBIT+0xa28>
 c70:	672f6269 	strvs	r6, [pc, -r9, ror #4]!
 c74:	612f6363 	teqvs	pc, r3, ror #6
 c78:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 c7c:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 c80:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 c84:	382e342f 	stmdacc	lr!, {r0, r1, r2, r3, r5, sl, ip, sp}
 c88:	692f322e 	stmdbvs	pc!, {r1, r2, r3, r5, r9, ip, sp}	; <UNPREDICTABLE>
 c8c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 c90:	2f006564 	svccs	0x00006564
 c94:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 c98:	75622f64 	strbvc	r2, [r2, #-3940]!	; 0xf64
 c9c:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xc69
 ca0:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 ca4:	2d62696c 	stclcs	9, cr6, [r2, #-432]!	; 0xfffffe50
 ca8:	2e312e32 	mrccs	14, 1, r2, cr1, cr2, {1}
 cac:	656e2f30 	strbvs	r2, [lr, #-3888]!	; 0xf30
 cb0:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 cb4:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 cb8:	6e692f63 	cdpvs	15, 6, cr2, cr9, cr3, {3}
 cbc:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
 cc0:	79732f65 	ldmdbvc	r3!, {r0, r2, r5, r6, r8, r9, sl, fp, sp}^
 cc4:	622f0073 	eorvs	r0, pc, #115	; 0x73
 cc8:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 ccc:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 cd0:	2f64646c 	svccs	0x0064646c
 cd4:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 cd8:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 cdc:	302e312e 	eorcc	r3, lr, lr, lsr #2
 ce0:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 ce4:	2f62696c 	svccs	0x0062696c
 ce8:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 cec:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 cf0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0x56c
 cf4:	616d0000 	cmnvs	sp, r0
 cf8:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 cfc:	00632e72 	rsbeq	r2, r3, r2, ror lr
 d00:	73000001 	movwvc	r0, #1
 d04:	65646474 	strbvs	r6, [r4, #-1140]!	; 0x474
 d08:	00682e66 	rsbeq	r2, r8, r6, ror #28
 d0c:	6c000002 	stcvs	0, cr0, [r0], {2}
 d10:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 d14:	00030068 	andeq	r0, r3, r8, rrx
 d18:	79745f00 	ldmdbvc	r4!, {r8, r9, sl, fp, ip, lr}^
 d1c:	2e736570 	mrccs	5, 3, r6, cr3, cr0, {3}
 d20:	00030068 	andeq	r0, r3, r8, rrx
 d24:	65657200 	strbvs	r7, [r5, #-512]!	; 0x200
 d28:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 d2c:	00000300 	andeq	r0, r0, r0, lsl #6
 d30:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 d34:	00682e74 	rsbeq	r2, r8, r4, ror lr
 d38:	00000004 	andeq	r0, r0, r4
 d3c:	10020500 	andne	r0, r2, r0, lsl #10
 d40:	030000a5 	movweq	r0, #165	; 0xa5
 d44:	030119ec 	movweq	r1, #6636	; 0x19ec
 d48:	7603200a 	strvc	r2, [r3], -sl
 d4c:	4b30364a 	blmi	c0e67c <_stack+0xb8e67c>
 d50:	3c090368 	stccc	3, cr0, [r9], {104}	; 0x68
 d54:	4a78034b 	bmi	1e01a88 <_stack+0x1d81a88>
 d58:	2e0f033d 	mcrcs	3, 0, r0, cr15, cr13, {1}
 d5c:	2e12034c 	cdpcs	3, 1, cr0, cr2, cr12, {2}
 d60:	1d234921 	stcne	9, cr4, [r3, #-132]!	; 0xffffff7c
 d64:	30211f2f 	eorcc	r1, r1, pc, lsr #30
 d68:	6903242f 	stmdbvs	r3, {r0, r1, r2, r3, r5, sl, sp}
 d6c:	302f4b20 	eorcc	r4, pc, r0, lsr #22
 d70:	03023b91 	movweq	r3, #11153	; 0x2b91
 d74:	00010100 	andeq	r0, r1, r0, lsl #2
 d78:	a5b40205 	ldrge	r0, [r4, #517]!	; 0x205
 d7c:	c1030000 	mrsgt	r0, (UNDEF: 3)
 d80:	12030114 	andne	r0, r3, #20, 2
 d84:	206e032e 	rsbcs	r0, lr, lr, lsr #6
 d88:	31201203 	teqcc	r0, r3, lsl #4
 d8c:	2e110331 	mrccs	3, 0, r0, cr1, cr1, {1}
 d90:	034a6e03 	movteq	r6, #44547	; 0xae03
 d94:	232f2e0e 	teqcs	pc, #14, 28	; 0xe0
 d98:	301e221e 	andscc	r2, lr, lr, lsl r2
 d9c:	2a201803 	bcs	806db0 <_stack+0x786db0>
 da0:	32223022 	eorcc	r3, r2, #34	; 0x22
 da4:	3122212b 	teqcc	r2, fp, lsr #2
 da8:	4c4d223a 	sfmmi	f2, 2, [sp], {58}	; 0x3a
 dac:	04020022 	streq	r0, [r2], #-34	; 0x22
 db0:	062e0601 	strteq	r0, [lr], -r1, lsl #12
 db4:	213d4042 	teqcs	sp, r2, asr #32
 db8:	04020021 	streq	r0, [r2], #-33	; 0x21
 dbc:	003c0602 	eorseq	r0, ip, r2, lsl #12
 dc0:	3c030402 	cfstrscc	mvf0, [r3], {2}
 dc4:	12040200 	andne	r0, r4, #0, 4
 dc8:	0402003c 	streq	r0, [r2], #-60	; 0x3c
 dcc:	02009002 	andeq	r9, r0, #2
 dd0:	00580104 	subseq	r0, r8, r4, lsl #2
 dd4:	3c030402 	cfstrscc	mvf0, [r3], {2}
 dd8:	01040200 	mrseq	r0, R12_usr
 ddc:	5b030620 	blpl	c2664 <_stack+0x42664>
 de0:	202a034a 	eorcs	r0, sl, sl, asr #6
 de4:	002e5603 	eoreq	r5, lr, r3, lsl #12
 de8:	03010402 	movweq	r0, #5122	; 0x1402
 dec:	02004a25 	andeq	r4, r0, #151552	; 0x25000
 df0:	5b030104 	blpl	c1208 <_stack+0x41208>
 df4:	040200ba 	streq	r0, [r2], #-186	; 0xba
 df8:	20250301 	eorcs	r0, r5, r1, lsl #6
 dfc:	01040200 	mrseq	r0, R12_usr
 e00:	04020041 	streq	r0, [r2], #-65	; 0x41
 e04:	2e560301 	cdpcs	3, 5, cr0, cr6, cr1, {0}
 e08:	1e2e7403 	cdpne	4, 2, cr7, cr14, cr3, {0}
 e0c:	212f2222 	teqcs	pc, r2, lsr #4
 e10:	3e484f21 	cdpcc	15, 4, cr4, cr8, cr1, {1}
 e14:	032f211f 	teqeq	pc, #-1073741817	; 0xc0000007
 e18:	0327901c 	teqeq	r7, #28
 e1c:	21432e79 	hvccs	13033	; 0x32e9
 e20:	04040200 	streq	r0, [r4], #-512	; 0x200
 e24:	04020030 	streq	r0, [r2], #-48	; 0x30
 e28:	00660606 	rsbeq	r0, r6, r6, lsl #12
 e2c:	2e070402 	cdpcs	4, 0, cr0, cr7, cr2, {0}
 e30:	01040200 	mrseq	r0, R12_usr
 e34:	0402004a 	streq	r0, [r2], #-74	; 0x4a
 e38:	02009008 	andeq	r9, r0, #8
 e3c:	003c0904 	eorseq	r0, ip, r4, lsl #18
 e40:	4a0a0402 	bmi	281e50 <_stack+0x201e50>
 e44:	01000d02 	tsteq	r0, r2, lsl #26
 e48:	0000d801 	andeq	sp, r0, r1, lsl #16
 e4c:	d2000200 	andle	r0, r0, #0, 4
 e50:	02000000 	andeq	r0, r0, #0
 e54:	0d0efb01 	vstreq	d15, [lr, #-4]
 e58:	01010100 	mrseq	r0, (UNDEF: 17)
 e5c:	00000001 	andeq	r0, r0, r1
 e60:	01000001 	tsteq	r0, r1
 e64:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 e68:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 e6c:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 e70:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 e74:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 e78:	312e322d 	teqcc	lr, sp, lsr #4
 e7c:	6e2f302e 	cdpvs	0, 2, cr3, cr15, cr14, {1}
 e80:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 e84:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 e88:	692f6362 	stmdbvs	pc!, {r1, r5, r6, r8, r9, sp, lr}	; <UNPREDICTABLE>
 e8c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0x36e
 e90:	732f6564 	teqvc	pc, #100, 10	; 0x19000000
 e94:	2f007379 	svccs	0x00007379
 e98:	2f727375 	svccs	0x00727375
 e9c:	2f62696c 	svccs	0x0062696c
 ea0:	2f636367 	svccs	0x00636367
 ea4:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 ea8:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xf6e
 eac:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 eb0:	2e342f69 	cdpcs	15, 3, cr2, cr4, cr9, {3}
 eb4:	2f322e38 	svccs	0x00322e38
 eb8:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 ebc:	00656475 	rsbeq	r6, r5, r5, ror r4
 ec0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 ec4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 ec8:	2f2e2e2f 	svccs	0x002e2e2f
 ecc:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 ed0:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 ed4:	2f2e2e2f 	svccs	0x002e2e2f
 ed8:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 edc:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; d40 <CPSR_IRQ_INHIBIT+0xcc0>
 ee0:	2f636269 	svccs	0x00636269
 ee4:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 ee8:	6c000074 	stcvs	0, cr0, [r0], {116}	; 0x74
 eec:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 ef0:	00010068 	andeq	r0, r1, r8, rrx
 ef4:	79745f00 	ldmdbvc	r4!, {r8, r9, sl, fp, ip, lr}^
 ef8:	2e736570 	mrccs	5, 3, r6, cr3, cr0, {3}
 efc:	00010068 	andeq	r0, r1, r8, rrx
 f00:	64747300 	ldrbtvs	r7, [r4], #-768	; 0x300
 f04:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 f08:	00020068 	andeq	r0, r2, r8, rrx
 f0c:	65657200 	strbvs	r7, [r5, #-512]!	; 0x200
 f10:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 f14:	00000100 	andeq	r0, r0, r0, lsl #2
 f18:	75706d69 	ldrbvc	r6, [r0, #-3433]!	; 0xd69
 f1c:	632e6572 	teqvs	lr, #478150656	; 0x1c800000
 f20:	00000300 	andeq	r0, r0, r0, lsl #6
	...

Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c010001 	stcvc	0, cr0, [r1], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	0000000c 	andeq	r0, r0, ip
  14:	00000000 	andeq	r0, r0, r0
  18:	00009a51 	andeq	r9, r0, r1, asr sl
  1c:	00000294 	muleq	r0, r4, r2
  20:	0000000c 	andeq	r0, r0, ip
  24:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  28:	7c020001 	stcvc	0, cr0, [r2], {1}
  2c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  30:	0000000c 	andeq	r0, r0, ip
  34:	00000020 	andeq	r0, r0, r0, lsr #32
  38:	00009d04 	andeq	r9, r0, r4, lsl #26
  3c:	00000010 	andeq	r0, r0, r0, lsl r0
  40:	0000000c 	andeq	r0, r0, ip
  44:	00000020 	andeq	r0, r0, r0, lsr #32
  48:	00009d14 	andeq	r9, r0, r4, lsl sp
  4c:	00000010 	andeq	r0, r0, r0, lsl r0
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	00000024 	andeq	r0, r0, r4, lsr #32
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	00009d24 	andeq	r9, r0, r4, lsr #26
  6c:	00000566 	andeq	r0, r0, r6, ror #10
  70:	84240e42 	strthi	r0, [r4], #-3650	; 0xe42
  74:	86088509 	strhi	r8, [r8], -r9, lsl #10
  78:	88068707 	stmdahi	r6, {r0, r1, r2, r8, r9, sl, pc}
  7c:	8a048905 	bhi	122498 <_stack+0xa2498>
  80:	8e028b03 	vmlahi.f64	d8, d2, d3
  84:	300e4401 	andcc	r4, lr, r1, lsl #8
  88:	0000000c 	andeq	r0, r0, ip
  8c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  90:	7c020001 	stcvc	0, cr0, [r2], {1}
  94:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  98:	00000018 	andeq	r0, r0, r8, lsl r0
  9c:	00000088 	andeq	r0, r0, r8, lsl #1
  a0:	0000a28c 	andeq	sl, r0, ip, lsl #5
  a4:	000000a6 	andeq	r0, r0, r6, lsr #1
  a8:	84100e42 	ldrhi	r0, [r0], #-3650	; 0xe42
  ac:	86038504 	strhi	r8, [r3], -r4, lsl #10
  b0:	00018702 	andeq	r8, r1, r2, lsl #14
  b4:	0000000c 	andeq	r0, r0, ip
  b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  bc:	7c020001 	stcvc	0, cr0, [r2], {1}
  c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  c4:	00000018 	andeq	r0, r0, r8, lsl r0
  c8:	000000b4 	strheq	r0, [r0], -r4
  cc:	0000a334 	andeq	sl, r0, r4, lsr r3
  d0:	0000009e 	muleq	r0, lr, r0
  d4:	84100e42 	ldrhi	r0, [r0], #-3650	; 0xe42
  d8:	86038504 	strhi	r8, [r3], -r4, lsl #10
  dc:	00018702 	andeq	r8, r1, r2, lsl #14
  e0:	0000000c 	andeq	r0, r0, ip
  e4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  e8:	7c020001 	stcvc	0, cr0, [r2], {1}
  ec:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  f0:	0000000c 	andeq	r0, r0, ip
  f4:	000000e0 	andeq	r0, r0, r0, ror #1
  f8:	0000a3d4 	ldrdeq	sl, [r0], -r4
  fc:	00000002 	andeq	r0, r0, r2
 100:	0000000c 	andeq	r0, r0, ip
 104:	000000e0 	andeq	r0, r0, r0, ror #1
 108:	0000a3d8 	ldrdeq	sl, [r0], -r8
 10c:	00000002 	andeq	r0, r0, r2
 110:	0000000c 	andeq	r0, r0, ip
 114:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 118:	7c020001 	stcvc	0, cr0, [r2], {1}
 11c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 120:	00000018 	andeq	r0, r0, r8, lsl r0
 124:	00000110 	andeq	r0, r0, r0, lsl r1
 128:	0000a3dc 	ldrdeq	sl, [r0], -ip
 12c:	0000001a 	andeq	r0, r0, sl, lsl r0
 130:	83100e41 	tsthi	r0, #1040	; 0x410
 134:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
 138:	00018e02 	andeq	r8, r1, r2, lsl #28
 13c:	00000018 	andeq	r0, r0, r8, lsl r0
 140:	00000110 	andeq	r0, r0, r0, lsl r1
 144:	0000a3f8 	strdeq	sl, [r0], -r8
 148:	00000090 	muleq	r0, r0, r0
 14c:	84100e45 	ldrhi	r0, [r0], #-3653	; 0xe45
 150:	86038504 	strhi	r8, [r3], -r4, lsl #10
 154:	00018e02 	andeq	r8, r1, r2, lsl #28
 158:	0000000c 	andeq	r0, r0, ip
 15c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 160:	7c020001 	stcvc	0, cr0, [r2], {1}
 164:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 168:	00000018 	andeq	r0, r0, r8, lsl r0
 16c:	00000158 	andeq	r0, r0, r8, asr r1
 170:	0000a488 	andeq	sl, r0, r8, lsl #9
 174:	00000026 	andeq	r0, r0, r6, lsr #32
 178:	83100e41 	tsthi	r0, #1040	; 0x410
 17c:	85038404 	strhi	r8, [r3, #-1028]	; 0x404
 180:	00018e02 	andeq	r8, r1, r2, lsl #28
 184:	0000000c 	andeq	r0, r0, ip
 188:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 18c:	7c020001 	stcvc	0, cr0, [r2], {1}
 190:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 194:	0000000c 	andeq	r0, r0, ip
 198:	00000184 	andeq	r0, r0, r4, lsl #3
 19c:	0000a4b0 			; <UNDEFINED> instruction: 0x0000a4b0
 1a0:	0000005e 	andeq	r0, r0, lr, asr r0
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 1b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1bc:	0000a510 	andeq	sl, r0, r0, lsl r5
 1c0:	000000a2 	andeq	r0, r0, r2, lsr #1
 1c4:	83180e41 	tsthi	r8, #1040	; 0x410
 1c8:	85058406 	strhi	r8, [r5, #-1030]	; 0x406
 1cc:	87038604 	strhi	r8, [r3, -r4, lsl #12]
 1d0:	00018e02 	andeq	r8, r1, r2, lsl #28
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1dc:	0000a5b4 			; <UNDEFINED> instruction: 0x0000a5b4
 1e0:	00000198 	muleq	r0, r8, r1
 1e4:	84180e42 	ldrhi	r0, [r8], #-3650	; 0xe42
 1e8:	86058506 	strhi	r8, [r5], -r6, lsl #10
 1ec:	88038704 	stmdahi	r3, {r2, r8, r9, sl, pc}
 1f0:	00018e02 	andeq	r8, r1, r2, lsl #28

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	6f73645f 	svcvs	0x0073645f
   4:	6e61685f 	mcrvs	8, 3, r6, cr1, cr15, {2}
   8:	00656c64 	rsbeq	r6, r5, r4, ror #24
   c:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0x973
  10:	5f00745f 	svcpl	0x0000745f
  14:	646e6172 	strbtvs	r6, [lr], #-370	; 0x172
  18:	61003834 	tstvs	r0, r4, lsr r8
  1c:	00727470 	rsbseq	r7, r2, r0, ror r4
  20:	656d655f 	strbvs	r6, [sp, #-1375]!	; 0x55f
  24:	6e656772 	mcrvs	7, 3, r6, cr5, cr2, {3}
  28:	5f007963 	svcpl	0x00007963
  2c:	74726377 	ldrbtvc	r6, [r2], #-887	; 0x377
  30:	5f626d6f 	svcpl	0x00626d6f
  34:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
  38:	775f0065 	ldrbvc	r0, [pc, -r5, rrx]
  3c:	74727363 	ldrbtvc	r7, [r2], #-867	; 0x363
  40:	73626d6f 	cmnvc	r2, #7104	; 0x1bc0
  44:	6174735f 	cmnvs	r4, pc, asr r3
  48:	6c006574 	cfstr32vs	mvfx6, [r0], {116}	; 0x74
  4c:	20676e6f 	rsbcs	r6, r7, pc, ror #28
  50:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
  54:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
  58:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0x769
  5c:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
  60:	6c5f0074 	mrrcvs	0, 7, r0, pc, cr4	; <UNPREDICTABLE>
  64:	69736662 	ldmdbvs	r3!, {r1, r5, r6, r9, sl, sp, lr}^
  68:	5f00657a 	svcpl	0x0000657a
  6c:	7472626d 	ldrbtvc	r6, [r2], #-621	; 0x26d
  70:	5f63776f 	svcpl	0x0063776f
  74:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
  78:	72660065 	rsbvc	r0, r6, #101	; 0x65
  7c:	5f006565 	svcpl	0x00006565
  80:	6f746377 	svcvs	0x00746377
  84:	735f626d 	cmpvc	pc, #-805306362	; 0xd0000006
  88:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
  8c:	745f5f00 	ldrbvc	r5, [pc], #-3840	; 94 <CPSR_IRQ_INHIBIT+0x14>
  90:	65735f6d 	ldrbvs	r5, [r3, #-3949]!	; 0xf6d
  94:	6f6c0063 	svcvs	0x006c0063
  98:	6c20676e 	stcvs	7, cr6, [r0], #-440	; 0xfffffe48
  9c:	20676e6f 	rsbcs	r6, r7, pc, ror #28
  a0:	00746e69 	rsbseq	r6, r4, r9, ror #28
  a4:	7562755f 	strbvc	r7, [r2, #-1375]!	; 0x55f
  a8:	5f5f0066 	svcpl	0x005f0066
  ac:	685f6d74 	ldmdavs	pc, {r2, r4, r5, r6, r8, sl, fp, sp, lr}^	; <UNPREDICTABLE>
  b0:	0072756f 	rsbseq	r7, r2, pc, ror #10
  b4:	66735f5f 	uhsaxvs	r5, r3, pc	; <UNPREDICTABLE>
  b8:	6e6f5f00 	cdpvs	15, 6, cr5, cr15, cr0, {0}
  bc:	6978655f 	ldmdbvs	r8!, {r0, r1, r2, r3, r4, r6, r8, sl, sp, lr}^
  c0:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
  c4:	5f007367 	svcpl	0x00007367
  c8:	6b6f6f63 	blvs	1bdbe5c <_stack+0x1b5be5c>
  cc:	5f006569 	svcpl	0x00006569
  d0:	6c67735f 	stclvs	3, cr7, [r7], #-380	; 0xfffffe84
  d4:	5f006575 	svcpl	0x00006575
  d8:	67616c66 	strbvs	r6, [r1, -r6, ror #24]!
  dc:	695f0073 	ldmdbvs	pc, {r0, r1, r4, r5, r6}^	; <UNPREDICTABLE>
  e0:	78635f73 	stmdavc	r3!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
  e4:	735f0061 	cmpvc	pc, #97	; 0x61
  e8:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
  ec:	6c625f00 	stclvs	15, cr5, [r2], #-0
  f0:	7a69736b 	bvc	1a5cea4 <_stack+0x19dcea4>
  f4:	635f0065 	cmpvs	pc, #101	; 0x65
  f8:	75627476 	strbvc	r7, [r2, #-1142]!	; 0x476
  fc:	6f5f0066 	svcvs	0x005f0066
 100:	65736666 	ldrbvs	r6, [r3, #-1638]!	; 0x666
 104:	6d5f0074 	ldclvs	0, cr0, [pc, #-464]	; ffffff3c <STACK_SVR+0xfbffff3c>
 108:	74727362 	ldrbtvc	r7, [r2], #-866	; 0x362
 10c:	7363776f 	cmnvc	r3, #29097984	; 0x1bc0000
 110:	6174735f 	cmnvs	r4, pc, asr r3
 114:	5f006574 	svcpl	0x00006574
 118:	6c72626d 	lfmvs	f6, 2, [r2], #-436	; 0xfffffe4c
 11c:	735f6e65 	cmpvc	pc, #1616	; 0x650
 120:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 124:	6e665f00 	cdpvs	15, 6, cr5, cr6, cr0, {0}
 128:	73677261 	cmnvc	r7, #268435462	; 0x10000006
 12c:	6e665f00 	cdpvs	15, 6, cr5, cr6, cr0, {0}
 130:	735f0073 	cmpvc	pc, #115	; 0x73
 134:	006e6769 	rsbeq	r6, lr, r9, ror #14
 138:	6f6c665f 	svcvs	0x006c665f
 13c:	745f6b63 	ldrbvc	r6, [pc], #-2915	; 144 <CPSR_IRQ_INHIBIT+0xc4>
 140:	554e4700 	strbpl	r4, [lr, #-1792]	; 0x700
 144:	34204320 	strtcc	r4, [r0], #-800	; 0x320
 148:	322e382e 	eorcc	r3, lr, #3014656	; 0x2e0000
 14c:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xd20
 150:	626d7568 	rsbvs	r7, sp, #104, 10	; 0x1a000000
 154:	616d2d20 	cmnvs	sp, r0, lsr #26
 158:	3d686372 	stclcc	3, cr6, [r8, #-456]!	; 0xfffffe38
 15c:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
 160:	6d2d2037 	stcvs	0, cr2, [sp, #-220]!	; 0xffffff24
 164:	616f6c66 	cmnvs	pc, r6, ror #24
 168:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
 16c:	61683d69 	cmnvs	r8, r9, ror #26
 170:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
 174:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0x66d
 178:	7066763d 	rsbvc	r7, r6, sp, lsr r6
 17c:	642d3376 	strtvs	r3, [sp], #-886	; 0x376
 180:	2d203631 	stccs	6, cr3, [r0, #-196]!	; 0xffffff3c
 184:	7568746d 	strbvc	r7, [r8, #-1133]!	; 0x46d
 188:	2d20626d 	sfmcs	f6, 4, [r0, #-436]!	; 0xfffffe4c
 18c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
 190:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
 194:	2037766d 	eorscs	r7, r7, sp, ror #12
 198:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
 19c:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
 1a0:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
 1a4:	64726168 	ldrbtvs	r6, [r2], #-360	; 0x168
 1a8:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
 1ac:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
 1b0:	33767066 	cmncc	r6, #102	; 0x66
 1b4:	3631642d 	ldrtcc	r6, [r1], -sp, lsr #8
 1b8:	20672d20 	rsbcs	r2, r7, r0, lsr #26
 1bc:	20324f2d 	eorscs	r4, r2, sp, lsr #30
 1c0:	6f6e662d 	svcvs	0x006e662d
 1c4:	6975622d 	ldmdbvs	r5!, {r0, r2, r3, r5, r9, sp, lr}^
 1c8:	6e69746c 	cdpvs	4, 6, cr7, cr9, cr12, {3}
 1cc:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
 1d0:	6e752d6f 	cdpvs	13, 7, cr2, cr5, cr15, {3}
 1d4:	6c6c6f72 	stclvs	15, cr6, [ip], #-456	; 0xfffffe38
 1d8:	6f6f6c2d 	svcvs	0x006f6c2d
 1dc:	2d207370 	stccs	3, cr7, [r0, #-448]!	; 0xfffffe40
 1e0:	6e756666 	cdpvs	6, 7, cr6, cr5, cr6, {3}
 1e4:	6f697463 	svcvs	0x00697463
 1e8:	65732d6e 	ldrbvs	r2, [r3, #-3438]!	; 0xd6e
 1ec:	6f697463 	svcvs	0x00697463
 1f0:	2d20736e 	stccs	3, cr7, [r0, #-440]!	; 0xfffffe48
 1f4:	74616466 	strbtvc	r6, [r1], #-1126	; 0x466
 1f8:	65732d61 	ldrbvs	r2, [r3, #-3425]!	; 0xd61
 1fc:	6f697463 	svcvs	0x00697463
 200:	5f00736e 	svcpl	0x0000736e
 204:	69676942 	stmdbvs	r7!, {r1, r6, r8, fp, sp, lr}^
 208:	5f00746e 	svcpl	0x0000746e
 20c:	6d6d6167 	stfvse	f6, [sp, #-412]!	; 0xfffffe64
 210:	69735f61 	ldmdbvs	r3!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 214:	61676e67 	cmnvs	r7, r7, ror #28
 218:	725f006d 	subsvc	r0, pc, #109	; 0x6d
 21c:	00646165 	rsbeq	r6, r4, r5, ror #2
 220:	7365725f 	cmnvc	r5, #-268435451	; 0xf0000005
 224:	5f746c75 	svcpl	0x00746c75
 228:	5f5f006b 	svcpl	0x005f006b
 22c:	5f006d74 	svcpl	0x00006d74
 230:	6863775f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, ip, sp, lr}^
 234:	735f0062 	cmpvc	pc, #98	; 0x62
 238:	756f6474 	strbvc	r6, [pc, #-1140]!	; fffffdcc <STACK_SVR+0xfbfffdcc>
 23c:	635f0074 	cmpvs	pc, #116	; 0x74
 240:	656c7476 	strbvs	r7, [ip, #-1142]!	; 0x476
 244:	665f006e 	ldrbvs	r0, [pc], -lr, rrx
 248:	00656c69 	rsbeq	r6, r5, r9, ror #24
 24c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 250:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 254:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 258:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 25c:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 260:	312e322d 	teqcc	lr, sp, lsr #4
 264:	622f302e 	eorvs	r3, pc, #46	; 0x2e
 268:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 26c:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 270:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 274:	61652d65 	cmnvs	r5, r5, ror #26
 278:	612f6962 	teqvs	pc, r2, ror #18
 27c:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
 280:	2f72612d 	svccs	0x0072612d
 284:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
 288:	70662f62 	rsbvc	r2, r6, r2, ror #30
 28c:	656e2f75 	strbvs	r2, [lr, #-3957]!	; 0xf75
 290:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 294:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 298:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xf63
 29c:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 2a0:	696e5f00 	stmdbvs	lr!, {r8, r9, sl, fp, ip, lr}^
 2a4:	0073626f 	rsbseq	r6, r3, pc, ror #4
 2a8:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
 2ac:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
 2b0:	6e676973 	mcrvs	9, 3, r6, cr7, cr3, {3}
 2b4:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
 2b8:	5f00746e 	svcpl	0x0000746e
 2bc:	78657461 	stmdavc	r5!, {r0, r5, r6, sl, ip, sp, lr}^
 2c0:	00307469 	eorseq	r7, r0, r9, ror #8
 2c4:	6769735f 			; <UNDEFINED> instruction: 0x6769735f
 2c8:	5f6c616e 	svcpl	0x006c616e
 2cc:	00667562 	rsbeq	r7, r6, r2, ror #10
 2d0:	6373615f 	cmnvs	r3, #-1073741801	; 0xc0000017
 2d4:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 2d8:	6675625f 			; <UNDEFINED> instruction: 0x6675625f
 2dc:	65725f00 	ldrbvs	r5, [r2, #-3840]!	; 0xf00
 2e0:	746c7573 	strbtvc	r7, [ip], #-1395	; 0x573
 2e4:	775f5f00 	ldrbvc	r5, [pc, -r0, lsl #30]
 2e8:	77006863 	strvc	r6, [r0, -r3, ror #16]
 2ec:	5f746e69 	svcpl	0x00746e69
 2f0:	665f0074 			; <UNDEFINED> instruction: 0x665f0074
 2f4:	7367616c 	cmnvc	r7, #108, 2
 2f8:	775f0032 	smmlarvc	pc, r2, r0, r0	; <UNPREDICTABLE>
 2fc:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0x972
 300:	745f5f00 	ldrbvc	r5, [pc], #-3840	; 308 <CPSR_IRQ_INHIBIT+0x288>
 304:	65795f6d 	ldrbvs	r5, [r9, #-3949]!	; 0xf6d
 308:	73007261 	movwvc	r7, #609	; 0x261
 30c:	74657a69 	strbtvc	r7, [r5], #-2665	; 0xa69
 310:	00657079 	rsbeq	r7, r5, r9, ror r0
 314:	78656e5f 	stmdavc	r5!, {r0, r1, r2, r3, r4, r6, r9, sl, fp, sp, lr}^
 318:	5f006674 	svcpl	0x00006674
 31c:	5f6d745f 	svcpl	0x006d745f
 320:	006e6f6d 	rsbeq	r6, lr, sp, ror #30
 324:	6574615f 	ldrbvs	r6, [r4, #-351]!	; 0x15f
 328:	00746978 	rsbseq	r6, r4, r8, ror r9
 32c:	64735f5f 	ldrbtvs	r5, [r3], #-3935	; 0xf5f
 330:	6e696469 	cdpvs	4, 6, cr6, cr9, cr9, {3}
 334:	5f007469 	svcpl	0x00007469
 338:	5f66666f 	svcpl	0x0066666f
 33c:	665f0074 			; <UNDEFINED> instruction: 0x665f0074
 340:	6c656572 	cfstr64vs	mvdx6, [r5], #-456	; 0xfffffe38
 344:	00747369 	rsbseq	r7, r4, r9, ror #6
 348:	7479626e 	ldrbtvc	r6, [r9], #-622	; 0x26e
 34c:	5f007365 	svcpl	0x00007365
 350:	4b434f4c 	blmi	10d4088 <_stack+0x1054088>
 354:	4345525f 	movtmi	r5, #21087	; 0x525f
 358:	49535255 	ldmdbmi	r3, {r0, r2, r4, r6, r9, ip, lr}^
 35c:	545f4556 	ldrbpl	r4, [pc], #-1366	; 364 <CPSR_IRQ_INHIBIT+0x2e4>
 360:	2f2e2e00 	svccs	0x002e2e00
 364:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 368:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 36c:	2f2e2e2f 	svccs	0x002e2e2f
 370:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 374:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 378:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 37c:	2f62696c 	svccs	0x0062696c
 380:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 384:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0x32f
 388:	2f62696c 	svccs	0x0062696c
 38c:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 390:	632e636f 	teqvs	lr, #-1140850687	; 0xbc000001
 394:	72665f00 	rsbvc	r5, r6, #0, 30
 398:	725f6565 	subsvc	r6, pc, #423624704	; 0x19400000
 39c:	736e7500 	cmnvc	lr, #0, 10
 3a0:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0x769
 3a4:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
 3a8:	5f007261 	svcpl	0x00007261
 3ac:	0077656e 	rsbseq	r6, r7, lr, ror #10
 3b0:	655f685f 	ldrbvs	r6, [pc, #-2143]	; fffffb59 <STACK_SVR+0xfbfffb59>
 3b4:	6f6e7272 	svcvs	0x006e7272
 3b8:	6f687300 	svcvs	0x00687300
 3bc:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
 3c0:	5f00746e 	svcpl	0x0000746e
 3c4:	5f6d745f 	svcpl	0x006d745f
 3c8:	79616479 	stmdbvc	r1!, {r0, r3, r4, r5, r6, sl, sp, lr}^
 3cc:	735f5f00 	cmpvc	pc, #0, 30
 3d0:	00667562 	rsbeq	r7, r6, r2, ror #10
 3d4:	626f695f 	rsbvs	r6, pc, #1556480	; 0x17c000
 3d8:	5f5f0073 	svcpl	0x005f0073
 3dc:	454c4946 	strbmi	r4, [ip, #-2374]	; 0x946
 3e0:	626d5f00 	rsbvs	r5, sp, #0, 30
 3e4:	74617473 	strbtvc	r7, [r1], #-1139	; 0x473
 3e8:	00745f65 	rsbseq	r5, r4, r5, ror #30
 3ec:	46735f5f 	uhsaxmi	r5, r3, pc	; <UNPREDICTABLE>
 3f0:	00454c49 	subeq	r4, r5, r9, asr #24
 3f4:	73626d5f 	cmnvc	r2, #6080	; 0x17c0
 3f8:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 3fc:	61725f00 	cmnvs	r2, r0, lsl #30
 400:	6e5f646e 	cdpvs	4, 5, cr6, cr15, cr14, {3}
 404:	00747865 	rsbseq	r7, r4, r5, ror #16
 408:	6c626d5f 	stclvs	13, cr6, [r2], #-380	; 0xfffffe84
 40c:	735f6e65 	cmpvc	pc, #1616	; 0x650
 410:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0x174
 414:	6e695f00 	cdpvs	15, 6, cr5, cr9, cr0, {0}
 418:	695f0063 	ldmdbvs	pc, {r0, r1, r5, r6}^	; <UNPREDICTABLE>
 41c:	5f00646e 	svcpl	0x0000646e
 420:	72727563 	rsbsvc	r7, r2, #415236096	; 0x18c00000
 424:	5f746e65 	svcpl	0x00746e65
 428:	61636f6c 	cmnvs	r3, ip, ror #30
 42c:	5f00656c 	svcpl	0x0000656c
 430:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 434:	725f636f 	subsvc	r6, pc, #-1140850687	; 0xbc000001
 438:	635f5f00 	cmpvs	pc, #0, 30
 43c:	6e61656c 	cdpvs	5, 6, cr6, cr1, cr12, {3}
 440:	5f007075 	svcpl	0x00007075
 444:	7778616d 	ldrbvc	r6, [r8, -sp, ror #2]!
 448:	5f007364 	svcpl	0x00007364
 44c:	64656573 	strbtvs	r6, [r5], #-1395	; 0x573
 450:	635f5f00 	cmpvs	pc, #0, 30
 454:	746e756f 	strbtvc	r7, [lr], #-1391	; 0x56f
 458:	765f5f00 	ldrbvc	r5, [pc], -r0, lsl #30
 45c:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xc61
 460:	65735f00 	ldrbvs	r5, [r3, #-3840]!	; 0xf00
 464:	5f006b65 	svcpl	0x00006b65
 468:	736f7066 	cmnvc	pc, #102	; 0x66
 46c:	5f00745f 	svcpl	0x0000745f
 470:	5f6d745f 	svcpl	0x006d745f
 474:	006e696d 	rsbeq	r6, lr, sp, ror #18
 478:	6c756d5f 	ldclvs	13, cr6, [r5], #-380	; 0xfffffe84
 47c:	735f0074 	cmpvc	pc, #116	; 0x74
 480:	72656474 	rsbvc	r6, r5, #116, 8	; 0x74000000
 484:	735f0072 	cmpvc	pc, #114	; 0x72
 488:	6f747274 	svcvs	0x00747274
 48c:	616c5f6b 	cmnvs	ip, fp, ror #30
 490:	5f007473 	svcpl	0x00007473
 494:	79746e66 	ldmdbvc	r4!, {r1, r2, r5, r6, r9, sl, fp, sp, lr}^
 498:	00736570 	rsbseq	r6, r3, r0, ror r5
 49c:	6464615f 	strbtvs	r6, [r4], #-351	; 0x15f
 4a0:	555f5f00 	ldrbpl	r5, [pc, #-3840]	; fffff5a8 <STACK_SVR+0xfbfff5a8>
 4a4:	676e6f4c 	strbvs	r6, [lr, -ip, asr #30]!
 4a8:	65675f00 	strbvs	r5, [r7, #-3840]!	; 0xf00
 4ac:	74616474 	strbtvc	r6, [r1], #-1140	; 0x474
 4b0:	72655f65 	rsbvc	r5, r5, #404	; 0x194
 4b4:	635f0072 	cmpvs	pc, #114	; 0x72
 4b8:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0x275
 4bc:	635f746e 	cmpvs	pc, #1845493760	; 0x6e000000
 4c0:	67657461 	strbvs	r7, [r5, -r1, ror #8]!
 4c4:	0079726f 	rsbseq	r7, r9, pc, ror #4
 4c8:	756e755f 	strbvc	r7, [lr, #-1375]!	; 0x55f
 4cc:	5f646573 	svcpl	0x00646573
 4d0:	646e6172 	strbtvs	r6, [lr], #-370	; 0x172
 4d4:	64775f00 	ldrbtvs	r5, [r7], #-3840	; 0xf00
 4d8:	5f5f0073 	svcpl	0x005f0073
 4dc:	775f6d74 			; <UNDEFINED> instruction: 0x775f6d74
 4e0:	00796164 	rsbseq	r6, r9, r4, ror #2
 4e4:	616d6e5f 	cmnvs	sp, pc, asr lr
 4e8:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 4ec:	366c5f00 	strbtcc	r5, [ip], -r0, lsl #30
 4f0:	625f6134 	subsvs	r6, pc, #52, 2
 4f4:	5f006675 	svcpl	0x00006675
 4f8:	5f676973 	svcpl	0x00676973
 4fc:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
 500:	626e5f00 	rsbvs	r5, lr, #0, 30
 504:	5f006675 	svcpl	0x00006675
 508:	73756e75 	cmnvc	r5, #1872	; 0x750
 50c:	5f006465 	svcpl	0x00006465
 510:	5f6d745f 	svcpl	0x006d745f
 514:	73647369 	cmnvc	r4, #-1543503871	; 0xa4000001
 518:	6c5f0074 	mrrcvs	0, 7, r0, pc, cr4	; <UNPREDICTABLE>
 51c:	6c61636f 	stclvs	3, cr6, [r1], #-444	; 0xfffffe44
 520:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0x974
 524:	6675625f 			; <UNDEFINED> instruction: 0x6675625f
 528:	6c635f00 	stclvs	15, cr5, [r3], #-0
 52c:	0065736f 	rsbeq	r7, r5, pc, ror #6
 530:	3834725f 	ldmdacc	r4!, {r0, r1, r2, r3, r4, r6, r9, ip, sp, lr}
 534:	626d5f00 	rsbvs	r5, sp, #0, 30
 538:	63776f74 	cmnvs	r7, #116, 30	; 0x1d0
 53c:	6174735f 	cmnvs	r4, pc, asr r3
 540:	5f006574 	svcpl	0x00006574
 544:	00733570 	rsbseq	r3, r3, r0, ror r5
 548:	6d745f5f 	ldclvs	15, cr5, [r4, #-380]!	; 0xfffffe84
 54c:	61646d5f 	cmnvs	r4, pc, asr sp
 550:	72700079 	rsbsvc	r0, r0, #121	; 0x79
 554:	735f7665 	cmpvc	pc, #105906176	; 0x6500000
 558:	00657a69 	rsbeq	r7, r5, r9, ror #20
 55c:	616d5f5f 	cmnvs	sp, pc, asr pc
 560:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 564:	706f745f 	rsbvc	r7, pc, pc, asr r4	; <UNPREDICTABLE>
 568:	6461705f 	strbtvs	r7, [r1], #-95	; 0x5f
 56c:	6c626800 	stclvs	8, cr6, [r2], #-0
 570:	7600736b 	strvc	r7, [r0], -fp, ror #6
 574:	69746369 	ldmdbvs	r4!, {r0, r3, r5, r6, r8, r9, sp, lr}^
 578:	7261006d 	rsbvc	r0, r1, #109	; 0x6d
 57c:	00616e65 	rsbeq	r6, r1, r5, ror #28
 580:	616d6572 	smcvs	54866	; 0xd652
 584:	65646e69 	strbvs	r6, [r4, #-3689]!	; 0xe69
 588:	69735f72 	ldmdbvs	r3!, {r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 58c:	6f00657a 	svcvs	0x0000657a
 590:	655f646c 	ldrbvs	r6, [pc, #-1132]	; 12c <CPSR_IRQ_INHIBIT+0xac>
 594:	6200646e 	andvs	r6, r0, #1845493760	; 0x6e000000
 598:	6b636f6c 	blvs	18dc350 <_stack+0x185c350>
 59c:	6d5f5f00 	ldclvs	15, cr5, [pc, #-0]	; 5a4 <CPSR_IRQ_INHIBIT+0x524>
 5a0:	6f6c6c61 	svcvs	0x006c6c61
 5a4:	6e755f63 	cdpvs	15, 7, cr5, cr5, cr3, {3}
 5a8:	6b636f6c 	blvs	18dc360 <_stack+0x185c360>
 5ac:	69626d00 	stmdbvs	r2!, {r8, sl, fp, sp, lr}^
 5b0:	7274706e 	rsbsvc	r7, r4, #110	; 0x6e
 5b4:	77656e00 	strbvc	r6, [r5, -r0, lsl #28]!
 5b8:	6b72625f 	blvs	1c98f3c <_stack+0x1c18f3c>
 5bc:	63697600 	cmnvs	r9, #0, 12
 5c0:	5f6d6974 	svcpl	0x006d6974
 5c4:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0x973
 5c8:	6c616d00 	stclvs	13, cr6, [r1], #-0
 5cc:	5f636f6c 	svcpl	0x00636f6c
 5d0:	65747865 	ldrbvs	r7, [r4, #-2149]!	; 0x865
 5d4:	745f646e 	ldrbvc	r6, [pc], #-1134	; 5dc <CPSR_IRQ_INHIBIT+0x55c>
 5d8:	6600706f 	strvs	r7, [r0], -pc, rrx
 5dc:	6264726f 	rsbvs	r7, r4, #-268435450	; 0xf0000006
 5e0:	00736b6c 	rsbseq	r6, r3, ip, ror #22
 5e4:	6e6f7266 	cdpvs	2, 6, cr7, cr15, cr6, {3}
 5e8:	696d5f74 	stmdbvs	sp!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 5ec:	696c6173 	stmdbvs	ip!, {r0, r1, r4, r5, r6, r8, sp, lr}^
 5f0:	5f006e67 	svcpl	0x00006e67
 5f4:	6c616d5f 	stclvs	13, cr6, [r1], #-380	; 0xfffffe84
 5f8:	5f636f6c 	svcpl	0x00636f6c
 5fc:	6b636f6c 	blvs	18dc3b4 <_stack+0x185c3b4>
 600:	72747000 	rsbsvc	r7, r4, #0
 604:	66666964 	strbtvs	r6, [r6], -r4, ror #18
 608:	7500745f 	strvc	r7, [r0, #-1119]	; 0x45f
 60c:	6264726f 	rsbvs	r7, r4, #-268435450	; 0xf0000006
 610:	00736b6c 	rsbseq	r6, r3, ip, ror #22
 614:	6b726273 	blvs	1c98fe8 <_stack+0x1c18fe8>
 618:	7a69735f 	bvc	1a5d39c <_stack+0x19dd39c>
 61c:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0x65
 620:	6e69616d 	powvsez	f6, f1, #5.0
 624:	5f726564 	svcpl	0x00726564
 628:	65646e69 	strbvs	r6, [r4, #-3689]!	; 0xe69
 62c:	5f5f0078 	svcpl	0x005f0078
 630:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 634:	6d5f636f 	ldclvs	3, cr6, [pc, #-444]	; 480 <CPSR_IRQ_INHIBIT+0x400>
 638:	745f7861 	ldrbvc	r7, [pc], #-2145	; 640 <CPSR_IRQ_INHIBIT+0x5c0>
 63c:	6c61746f 	cfstrdvs	mvd7, [r1], #-444	; 0xfffffe44
 640:	6d656d5f 	stclvs	13, cr6, [r5, #-380]!	; 0xfffffe84
 644:	61747300 	cmnvs	r4, r0, lsl #6
 648:	64697472 	strbtvs	r7, [r9], #-1138	; 0x472
 64c:	73660078 	cmnvc	r6, #120	; 0x78
 650:	6b6c626d 	blvs	1b1900c <_stack+0x1a9900c>
 654:	616d0073 	smcvs	53251	; 0xd003
 658:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 65c:	7568635f 	strbvc	r6, [r8, #-863]!	; 0x35f
 660:	5f006b6e 	svcpl	0x00006b6e
 664:	6c616d5f 	stclvs	13, cr6, [r1], #-380	; 0xfffffe84
 668:	5f636f6c 	svcpl	0x00636f6c
 66c:	6d697274 	sfmvs	f7, 2, [r9, #-464]!	; 0xfffffe30
 670:	7268745f 	rsbvc	r7, r8, #1593835520	; 0x5f000000
 674:	6f687365 	svcvs	0x00687365
 678:	7500646c 	strvc	r6, [r0, #-1132]	; 0x46c
 67c:	6c626d73 	stclvs	13, cr6, [r2], #-460	; 0xfffffe34
 680:	7000736b 	andvc	r7, r0, fp, ror #6
 684:	73656761 	cmnvc	r5, #25427968	; 0x1840000
 688:	5f5f007a 	svcpl	0x005f007a
 68c:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 690:	635f636f 	cmpvs	pc, #-1140850687	; 0xbc000001
 694:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0x275
 698:	6d5f746e 	cfldrdvs	mvd7, [pc, #-440]	; 4e8 <CPSR_IRQ_INHIBIT+0x468>
 69c:	696c6c61 	stmdbvs	ip!, {r0, r5, r6, sl, fp, sp, lr}^
 6a0:	006f666e 	rsbeq	r6, pc, lr, ror #12
 6a4:	616d6572 	smcvs	54866	; 0xd652
 6a8:	65646e69 	strbvs	r6, [r4, #-3689]!	; 0xe69
 6ac:	6c6f0072 	stclvs	0, cr0, [pc], #-456	; 4ec <CPSR_IRQ_INHIBIT+0x46c>
 6b0:	6f745f64 	svcvs	0x00745f64
 6b4:	5f5f0070 	svcpl	0x005f0070
 6b8:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 6bc:	615f636f 	cmpvs	pc, pc, ror #6
 6c0:	72005f76 	andvc	r5, r0, #472	; 0x1d8
 6c4:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 6c8:	7274705f 	rsbsvc	r7, r4, #95	; 0x5f
 6cc:	6d5f5f00 	ldclvs	15, cr5, [pc, #-0]	; 6d4 <CPSR_IRQ_INHIBIT+0x654>
 6d0:	6f6c6c61 	svcvs	0x006c6c61
 6d4:	616d5f63 	cmnvs	sp, r3, ror #30
 6d8:	62735f78 	rsbsvs	r5, r3, #120, 30	; 0x1e0
 6dc:	64656b72 	strbtvs	r6, [r5], #-2930	; 0xb72
 6e0:	6d656d5f 	stclvs	13, cr6, [r5, #-380]!	; 0xfffffe84
 6e4:	2f2e2e00 	svccs	0x002e2e00
 6e8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 6ec:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 6f0:	2f2e2e2f 	svccs	0x002e2e2f
 6f4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 6f8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 6fc:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 700:	2f62696c 	svccs	0x0062696c
 704:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 708:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0x32f
 70c:	2f62696c 	svccs	0x0062696c
 710:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 714:	2e72636f 	cdpcs	3, 7, cr6, cr2, cr15, {3}
 718:	735f0063 	cmpvc	pc, #99	; 0x63
 71c:	5f6b7262 	svcpl	0x006b7262
 720:	6f630072 	svcvs	0x00630072
 724:	63657272 	cmnvs	r5, #536870919	; 0x20000007
 728:	6e6f6974 	mcrvs	9, 3, r6, cr15, cr4, {3}
 72c:	6961665f 	stmdbvs	r1!, {r0, r1, r2, r3, r4, r6, r9, sl, sp, lr}^
 730:	0064656c 	rsbeq	r6, r4, ip, ror #10
 734:	7568636d 	strbvc	r6, [r8, #-877]!	; 0x36d
 738:	74706b6e 	ldrbtvc	r6, [r0], #-2926	; 0xb6e
 73c:	6c6f0072 	stclvs	0, cr0, [pc], #-456	; 57c <CPSR_IRQ_INHIBIT+0x4fc>
 740:	6f745f64 	svcvs	0x00745f64
 744:	69735f70 	ldmdbvs	r3!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 748:	6b00657a 	blvs	19d38 <__bss_end__+0x5cf0>
 74c:	63706565 	cmnvs	r0, #423624704	; 0x19400000
 750:	0074736f 	rsbseq	r7, r4, pc, ror #6
 754:	616d5f5f 	cmnvs	sp, pc, asr pc
 758:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 75c:	7262735f 	rsbvc	r7, r2, #2080374785	; 0x7c000001
 760:	61625f6b 	cmnvs	r2, fp, ror #30
 764:	63006573 	movwvs	r6, #1395	; 0x573
 768:	6572726f 	ldrbvs	r7, [r2, #-623]!	; 0x26f
 76c:	6f697463 	svcvs	0x00697463
 770:	6268006e 	rsbvs	r0, r8, #110	; 0x6e
 774:	64686b6c 	strbtvs	r6, [r8], #-2924	; 0xb6c
 778:	696c6100 	stmdbvs	ip!, {r8, sp, lr}^
 77c:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xe67
 780:	7473645f 	ldrbtvc	r6, [r3], #-1119	; 0x45f
 784:	63727300 	cmnvs	r2, #0, 6
 788:	73640030 	cmnvc	r4, #48	; 0x30
 78c:	2e003074 	mcrcs	0, 0, r3, cr0, cr4, {3}
 790:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 794:	2f2e2e2f 	svccs	0x002e2e2f
 798:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 79c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 7a0:	2f2e2e2f 	svccs	0x002e2e2f
 7a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7a8:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xf2e
 7ac:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 7b0:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 7b4:	616d2f63 	cmnvs	sp, r3, ror #30
 7b8:	6e696863 	cdpvs	8, 6, cr6, cr9, cr3, {3}
 7bc:	72612f65 	rsbvc	r2, r1, #404	; 0x194
 7c0:	656d2f6d 	strbvs	r2, [sp, #-3949]!	; 0xf6d
 7c4:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
 7c8:	7574732d 	ldrbvc	r7, [r4, #-813]!	; 0x32d
 7cc:	00632e62 	rsbeq	r2, r3, r2, ror #28
 7d0:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 7d4:	622f646c 	eorvs	r6, pc, #108, 8	; 0x6c000000
 7d8:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 7dc:	656e2f64 	strbvs	r2, [lr, #-3940]!	; 0xf64
 7e0:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 7e4:	312e322d 	teqcc	lr, sp, lsr #4
 7e8:	622f302e 	eorvs	r3, pc, #46	; 0x2e
 7ec:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 7f0:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 7f4:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 7f8:	61652d65 	cmnvs	r5, r5, ror #26
 7fc:	612f6962 	teqvs	pc, r2, ror #18
 800:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
 804:	2f72612d 	svccs	0x0072612d
 808:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
 80c:	70662f62 	rsbvc	r2, r6, r2, ror #30
 810:	656e2f75 	strbvs	r2, [lr, #-3957]!	; 0xf75
 814:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 818:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 81c:	616d2f63 	cmnvs	sp, r3, ror #30
 820:	6e696863 	cdpvs	8, 6, cr6, cr9, cr3, {3}
 824:	72612f65 	rsbvc	r2, r1, #404	; 0x194
 828:	6c61006d 	stclvs	0, cr0, [r1], #-436	; 0xfffffe4c
 82c:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0x769
 830:	72735f64 	rsbsvc	r5, r3, #100, 30	; 0x190
 834:	656d0063 	strbvs	r0, [sp, #-99]!	; 0x63
 838:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
 83c:	6e656c00 	cdpvs	12, 6, cr6, cr5, cr0, {0}
 840:	622f0030 	eorvs	r0, pc, #48	; 0x30
 844:	646c6975 	strbtvs	r6, [ip], #-2421	; 0x975
 848:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 84c:	2f64646c 	svccs	0x0064646c
 850:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 854:	322d6269 	eorcc	r6, sp, #-1879048186	; 0x90000006
 858:	302e312e 	eorcc	r3, lr, lr, lsr #2
 85c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 860:	612f646c 	teqvs	pc, ip, ror #8
 864:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 868:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 86c:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 870:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 874:	612d3776 	teqvs	sp, r6, ror r7
 878:	68742f72 	ldmdavs	r4!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 87c:	2f626d75 	svccs	0x00626d75
 880:	2f757066 	svccs	0x00757066
 884:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 888:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 6ec <CPSR_IRQ_INHIBIT+0x66c>
 88c:	2f636269 	svccs	0x00636269
 890:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 894:	6100676e 	tstvs	r0, lr, ror #14
 898:	6e67696c 	cdpvs	9, 6, cr6, cr7, cr12, {3}
 89c:	615f6465 	cmpvs	pc, r5, ror #8
 8a0:	00726464 	rsbseq	r6, r2, r4, ror #8
 8a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 8a8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 8ac:	2f2e2e2f 	svccs	0x002e2e2f
 8b0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 8b4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 8b8:	2f2e2e2f 	svccs	0x002e2e2f
 8bc:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 8c0:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 724 <CPSR_IRQ_INHIBIT+0x6a4>
 8c4:	2f636269 	svccs	0x00636269
 8c8:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 8cc:	6d2f676e 	stcvs	7, cr6, [pc, #-440]!	; 71c <CPSR_IRQ_INHIBIT+0x69c>
 8d0:	65736d65 	ldrbvs	r6, [r3, #-3429]!	; 0xd65
 8d4:	00632e74 	rsbeq	r2, r3, r4, ror lr
 8d8:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
 8dc:	62007465 	andvs	r7, r0, #1694498816	; 0x65000000
 8e0:	65666675 	strbvs	r6, [r6, #-1653]!	; 0x675
 8e4:	5f5f0072 	svcpl	0x005f0072
 8e8:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
 8ec:	6c5f636f 	mrrcvs	3, 6, r6, pc, cr15	; <UNPREDICTABLE>
 8f0:	5f6b636f 	svcpl	0x006b636f
 8f4:	656a626f 	strbvs	r6, [sl, #-623]!	; 0x26f
 8f8:	2e007463 	cdpcs	4, 0, cr7, cr0, cr3, {3}
 8fc:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 900:	2f2e2e2f 	svccs	0x002e2e2f
 904:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 908:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 90c:	2f2e2e2f 	svccs	0x002e2e2f
 910:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 914:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 918:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 91c:	732f6362 	teqvc	pc, #-2013265919	; 0x88000001
 920:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 924:	6c6d2f62 	stclvs	15, cr2, [sp], #-392	; 0xfffffe78
 928:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 92c:	656e0063 	strbvs	r0, [lr, #-99]!	; 0x63
 930:	6e6f7478 	mcrvs	4, 3, r7, cr15, cr8, {3}
 934:	6c630065 	stclvs	0, cr0, [r3], #-404	; 0xfffffe6c
 938:	756e6165 	strbvc	r6, [lr, #-357]!	; 0x165
 93c:	6c675f70 	stclvs	15, cr5, [r7], #-448	; 0xfffffe40
 940:	2e006575 	cfrshl64cs	mvdx0, mvdx5, r6
 944:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 948:	2f2e2e2f 	svccs	0x002e2e2f
 94c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 950:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 954:	2f2e2e2f 	svccs	0x002e2e2f
 958:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 95c:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 960:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 964:	722f6362 	eorvc	r6, pc, #-2013265919	; 0x88000001
 968:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 96c:	6565722f 	strbvs	r7, [r5, #-559]!	; 0x22f
 970:	632e746e 	teqvs	lr, #1845493760	; 0x6e000000
 974:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xf00
 978:	2f646c69 	svccs	0x00646c69
 97c:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 980:	6e2f6464 	cdpvs	4, 2, cr6, cr15, cr4, {3}
 984:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 988:	2e322d62 	cdpcs	13, 3, cr2, cr2, cr2, {3}
 98c:	2f302e31 	svccs	0x00302e31
 990:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 994:	72612f64 	rsbvc	r2, r1, #100, 30	; 0x190
 998:	6f6e2d6d 	svcvs	0x006e2d6d
 99c:	652d656e 	strvs	r6, [sp, #-1390]!	; 0x56e
 9a0:	2f696261 	svccs	0x00696261
 9a4:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
 9a8:	72612d37 	rsbvc	r2, r1, #3520	; 0xdc0
 9ac:	7568742f 	strbvc	r7, [r8, #-1071]!	; 0x42f
 9b0:	662f626d 	strtvs	r6, [pc], -sp, ror #4
 9b4:	6e2f7570 	mcrvs	5, 1, r7, cr15, cr0, {3}
 9b8:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 9bc:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 9c0:	722f6362 	eorvc	r6, pc, #-2013265919	; 0x88000001
 9c4:	746e6565 	strbtvc	r6, [lr], #-1381	; 0x565
 9c8:	69687400 	stmdbvs	r8!, {sl, ip, sp, lr}^
 9cc:	656e6f73 	strbvs	r6, [lr, #-3955]!	; 0xf73
 9d0:	65725f00 	ldrbvs	r5, [r2, #-3840]!	; 0xf00
 9d4:	69616c63 	stmdbvs	r1!, {r0, r1, r5, r6, sl, fp, sp, lr}^
 9d8:	65725f6d 	ldrbvs	r5, [r2, #-3949]!	; 0xf6d
 9dc:	00746e65 	rsbseq	r6, r4, r5, ror #28
 9e0:	72636e69 	rsbvc	r6, r3, #1680	; 0x690
 9e4:	2f2e2e00 	svccs	0x002e2e00
 9e8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 9ec:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 9f0:	2f2e2e2f 	svccs	0x002e2e2f
 9f4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 9f8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 9fc:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 a00:	2f62696c 	svccs	0x0062696c
 a04:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
 a08:	6565722f 	strbvs	r7, [r5, #-559]!	; 0x22f
 a0c:	732f746e 	teqvc	pc, #1845493760	; 0x6e000000
 a10:	726b7262 	rsbvc	r7, fp, #536870918	; 0x20000006
 a14:	5f00632e 	svcpl	0x0000632e
 a18:	6b726273 	blvs	1c993ec <_stack+0x1c193ec>
 a1c:	72747300 	rsbsvc	r7, r4, #0, 6
 a20:	006e656c 	rsbeq	r6, lr, ip, ror #10
 a24:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a28:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a2c:	2f2e2e2f 	svccs	0x002e2e2f
 a30:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a34:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a38:	2f2e2e2f 	svccs	0x002e2e2f
 a3c:	6e2f2e2e 	cdpvs	14, 2, cr2, cr15, cr14, {1}
 a40:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
 a44:	696c2f62 	stmdbvs	ip!, {r1, r5, r6, r8, r9, sl, fp, sp}^
 a48:	6d2f6362 	stcvs	3, cr6, [pc, #-392]!	; 8c8 <CPSR_IRQ_INHIBIT+0x848>
 a4c:	69686361 	stmdbvs	r8!, {r0, r5, r6, r8, r9, sp, lr}^
 a50:	612f656e 	teqvs	pc, lr, ror #10
 a54:	732f6d72 	teqvc	pc, #7296	; 0x1c80
 a58:	656c7274 	strbvs	r7, [ip, #-628]!	; 0x274
 a5c:	00632e6e 	rsbeq	r2, r3, lr, ror #28
 a60:	72747865 	rsbsvc	r7, r4, #6619136	; 0x650000
 a64:	73690061 	cmnvc	r9, #97	; 0x61
 a68:	6300726c 	movwvs	r7, #620	; 0x26c
 a6c:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0x275
 a70:	625f746e 	subsvs	r7, pc, #1845493760	; 0x6e000000
 a74:	6e006b72 	vmovvs.16	d0[1], r6
 a78:	73747865 	cmnvc	r4, #6619136	; 0x650000
 a7c:	7270007a 	rsbsvc	r0, r0, #122	; 0x7a
 a80:	7a737665 	bvc	1cde41c <_stack+0x1c5e41c>
 a84:	616d5f00 	cmnvs	sp, r0, lsl #30
 a88:	636f6c6c 	cmnvs	pc, #108, 24	; 0x6c00
 a8c:	6972745f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, sl, ip, sp, lr}^
 a90:	00725f6d 	rsbseq	r5, r2, sp, ror #30
 a94:	75706d69 	ldrbvc	r6, [r0, #-3433]!	; 0xd69
 a98:	645f6572 	ldrbvs	r6, [pc], #-1394	; aa0 <CPSR_IRQ_INHIBIT+0xa20>
 a9c:	00617461 	rsbeq	r7, r1, r1, ror #8
 aa0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 aa4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 aa8:	2f2e2e2f 	svccs	0x002e2e2f
 aac:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 ab0:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 ab4:	2f2e2e2f 	svccs	0x002e2e2f
 ab8:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 abc:	6c2f6269 	sfmvs	f6, 4, [pc], #-420	; 920 <CPSR_IRQ_INHIBIT+0x8a0>
 ac0:	2f636269 	svccs	0x00636269
 ac4:	6e656572 	mcrvs	5, 3, r6, cr5, cr2, {3}
 ac8:	6d692f74 	stclvs	15, cr2, [r9, #-464]!	; 0xfffffe30
 acc:	65727570 	ldrbvs	r7, [r2, #-1392]!	; 0x570
 ad0:	5f00632e 	svcpl	0x0000632e
 ad4:	626f6c67 	rsbvs	r6, pc, #26368	; 0x6700
 ad8:	695f6c61 	ldmdbvs	pc, {r0, r5, r6, sl, fp, sp, lr}^	; <UNPREDICTABLE>
 adc:	7275706d 	rsbsvc	r7, r5, #109	; 0x6d
 ae0:	74705f65 	ldrbtvc	r5, [r0], #-3941	; 0xf65
 ae4:	Address 0x0000000000000ae4 is out of bounds.


Disassembly of section .debug_loc:

00000000 <.debug_loc>:
       0:	00009d04 	andeq	r9, r0, r4, lsl #26
       4:	00009d10 	andeq	r9, r0, r0, lsl sp
       8:	10500001 	subsne	r0, r0, r1
       c:	1300009d 	movwne	r0, #157	; 0x9d
      10:	0100009d 	swpeq	r0, sp, [r0]	; <UNPREDICTABLE>
      14:	9d135100 	ldflss	f5, [r3, #-0]
      18:	9d140000 	ldcls	0, cr0, [r4, #-0]
      1c:	00040000 	andeq	r0, r4, r0
      20:	9f5001f3 	svcls	0x005001f3
	...
      2c:	00009d14 	andeq	r9, r0, r4, lsl sp
      30:	00009d20 	andeq	r9, r0, r0, lsr #26
      34:	20500001 	subscs	r0, r0, r1
      38:	2300009d 	movwcs	r0, #157	; 0x9d
      3c:	0100009d 	swpeq	r0, sp, [r0]	; <UNPREDICTABLE>
      40:	9d235100 	stflss	f5, [r3, #-0]
      44:	9d240000 	stcls	0, cr0, [r4, #-0]
      48:	00040000 	andeq	r0, r4, r0
      4c:	9f5001f3 	svcls	0x005001f3
	...
      58:	00009d24 	andeq	r9, r0, r4, lsr #26
      5c:	00009d53 	andeq	r9, r0, r3, asr sp
      60:	53500001 	cmppl	r0, #1
      64:	9400009d 	strls	r0, [r0], #-157	; 0x9d
      68:	0100009d 	swpeq	r0, sp, [r0]	; <UNPREDICTABLE>
      6c:	9d945700 	ldcls	7, cr5, [r4]
      70:	9d9c0000 	ldcls	0, cr0, [ip]
      74:	00040000 	andeq	r0, r4, r0
      78:	9f5001f3 	svcls	0x005001f3
      7c:	00009d9c 	muleq	r0, ip, sp
      80:	00009e98 	muleq	r0, r8, lr
      84:	98570001 	ldmdals	r7, {r0}^
      88:	b500009e 	strlt	r0, [r0, #-158]	; 0x9e
      8c:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
      90:	9eb55000 	cdpls	0, 11, cr5, cr5, cr0, {0}
      94:	9eb80000 	cdpls	0, 11, cr0, cr8, cr0, {0}
      98:	00040000 	andeq	r0, r4, r0
      9c:	9f5001f3 	svcls	0x005001f3
      a0:	00009eb8 			; <UNDEFINED> instruction: 0x00009eb8
      a4:	00009ec0 	andeq	r9, r0, r0, asr #29
      a8:	c0500001 	subsgt	r0, r0, r1
      ac:	3000009e 	mulcc	r0, lr, r0
      b0:	010000a1 	smlatbeq	r0, r1, r0, r0
      b4:	a1305700 	teqge	r0, r0, lsl #14
      b8:	a1490000 	mrsge	r0, (UNDEF: 73)
      bc:	00010000 	andeq	r0, r1, r0
      c0:	00a14950 	adceq	r4, r1, r0, asr r9
      c4:	00a14c00 	adceq	r4, r1, r0, lsl #24
      c8:	f3000400 	vshl.u8	d0, d0, d0
      cc:	4c9f5001 	ldcmi	0, cr5, [pc], {1}
      d0:	8a0000a1 	bhi	35c <CPSR_IRQ_INHIBIT+0x2dc>
      d4:	010000a2 	smlatbeq	r0, r2, r0, r0
      d8:	00005700 	andeq	r5, r0, r0, lsl #14
      dc:	00000000 	andeq	r0, r0, r0
      e0:	9d240000 	stcls	0, cr0, [r4, #-0]
      e4:	9d4a0000 	stclls	0, cr0, [sl, #-0]
      e8:	00010000 	andeq	r0, r1, r0
      ec:	009d4a51 	addseq	r4, sp, r1, asr sl
      f0:	00a28a00 	adceq	r8, r2, r0, lsl #20
      f4:	f3000400 	vshl.u8	d0, d0, d0
      f8:	009f5101 	addseq	r5, pc, r1, lsl #2
      fc:	00000000 	andeq	r0, r0, r0
     100:	6c000000 	stcvs	0, cr0, [r0], {-0}
     104:	8400009d 	strhi	r0, [r0], #-157	; 0x9d
     108:	0100009d 	swpeq	r0, sp, [r0]	; <UNPREDICTABLE>
     10c:	9d845300 	stcls	3, cr5, [r4]
     110:	9d940000 	ldcls	0, cr0, [r4]
     114:	00030000 	andeq	r0, r3, r0
     118:	ba9f7875 	blt	fe7de2f4 <STACK_SVR+0xfa7de2f4>
     11c:	3e00009d 	mcrcc	0, 0, r0, cr0, cr13, {4}
     120:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     124:	9e625300 	cdpls	3, 6, cr5, cr2, cr0, {0}
     128:	9eb50000 	cdpls	0, 11, cr0, cr5, cr0, {0}
     12c:	00010000 	andeq	r0, r1, r0
     130:	009eb552 	addseq	fp, lr, r2, asr r5
     134:	009eb800 	addseq	fp, lr, r0, lsl #16
     138:	75000300 	strvc	r0, [r0, #-768]	; 0x300
     13c:	9edc9f78 	mrcls	15, 6, r9, cr12, cr8, {3}
     140:	9ee60000 	cdpls	0, 14, cr0, cr6, cr0, {0}
     144:	00010000 	andeq	r0, r1, r0
     148:	009ee653 	addseq	lr, lr, r3, asr r6
     14c:	009eef00 	addseq	lr, lr, r0, lsl #30
     150:	03000500 	movweq	r0, #1280	; 0x500
     154:	0000acf0 	strdeq	sl, [r0], -r0
     158:	00009eef 	andeq	r9, r0, pc, ror #29
     15c:	00009ef8 	strdeq	r9, [r0], -r8
     160:	78750003 	ldmdavc	r5!, {r0, r1}^
     164:	00a06a9f 	umlaleq	r6, r0, pc, sl	; <UNPREDICTABLE>
     168:	00a07a00 	adceq	r7, r0, r0, lsl #20
     16c:	55000100 	strpl	r0, [r0, #-256]	; 0x100
     170:	0000a07a 	andeq	sl, r0, sl, ror r0
     174:	0000a08a 	andeq	sl, r0, sl, lsl #1
     178:	78750003 	ldmdavc	r5!, {r0, r1}^
     17c:	00a08a9f 	umlaleq	r8, r0, pc, sl	; <UNPREDICTABLE>
     180:	00a0a500 	adceq	sl, r0, r0, lsl #10
     184:	53000100 	movwpl	r0, #256	; 0x100
     188:	0000a0a5 	andeq	sl, r0, r5, lsr #1
     18c:	0000a0ae 	andeq	sl, r0, lr, lsr #1
     190:	78750003 	ldmdavc	r5!, {r0, r1}^
     194:	00a0d69f 	umlaleq	sp, r0, pc, r6	; <UNPREDICTABLE>
     198:	00a14900 	adceq	r4, r1, r0, lsl #18
     19c:	53000100 	movwpl	r0, #256	; 0x100
     1a0:	0000a149 	andeq	sl, r0, r9, asr #2
     1a4:	0000a14c 	andeq	sl, r0, ip, asr #2
     1a8:	78750003 	ldmdavc	r5!, {r0, r1}^
     1ac:	00a14c9f 	umlaleq	r4, r1, pc, ip	; <UNPREDICTABLE>
     1b0:	00a15c00 	adceq	r5, r1, r0, lsl #24
     1b4:	52000100 	andpl	r0, r0, #0, 2
     1b8:	0000a15c 	andeq	sl, r0, ip, asr r1
     1bc:	0000a170 	andeq	sl, r0, r0, ror r1
     1c0:	70530001 	subsvc	r0, r3, r1
     1c4:	7c0000a1 	stcvc	0, cr0, [r0], {161}	; 0xa1
     1c8:	010000a1 	smlatbeq	r0, r1, r0, r0
     1cc:	a17c5200 	cmnge	ip, r0, lsl #4
     1d0:	a18e0000 	orrge	r0, lr, r0
     1d4:	00030000 	andeq	r0, r3, r0
     1d8:	8e9f7875 	mrchi	8, 4, r7, cr15, cr5, {3}
     1dc:	960000a1 	strls	r0, [r0], -r1, lsr #1
     1e0:	010000a1 	smlatbeq	r0, r1, r0, r0
     1e4:	a1a65300 			; <UNDEFINED> instruction: 0xa1a65300
     1e8:	a1e60000 	mvnge	r0, r0
     1ec:	00010000 	andeq	r0, r1, r0
     1f0:	00a20652 	adceq	r0, r2, r2, asr r6
     1f4:	00a21a00 	adceq	r1, r2, r0, lsl #20
     1f8:	53000100 	movwpl	r0, #256	; 0x100
     1fc:	0000a262 	andeq	sl, r0, r2, ror #4
     200:	0000a286 	andeq	sl, r0, r6, lsl #5
     204:	86530001 	ldrbhi	r0, [r3], -r1
     208:	8a0000a2 	bhi	498 <CPSR_IRQ_INHIBIT+0x418>
     20c:	010000a2 	smlatbeq	r0, r2, r0, r0
     210:	00005200 	andeq	r5, r0, r0, lsl #4
     214:	00000000 	andeq	r0, r0, r0
     218:	9d800000 	stcls	0, cr0, [r0]
     21c:	9d860000 	stcls	0, cr0, [r6]
     220:	00010000 	andeq	r0, r1, r0
     224:	009d8654 	addseq	r8, sp, r4, asr r6
     228:	009d9000 	addseq	r9, sp, r0
     22c:	75000700 	strvc	r0, [r0, #-1792]	; 0x700
     230:	fc09067c 	stc2	6, cr0, [r9], {124}	; 0x7c
     234:	9dc09f1a 	stclls	15, cr9, [r0, #104]	; 0x68
     238:	9dcc0000 	stclls	0, cr0, [ip]
     23c:	00010000 	andeq	r0, r1, r0
     240:	009dd251 	addseq	sp, sp, r1, asr r2
     244:	009ddc00 	addseq	sp, sp, r0, lsl #24
     248:	51000100 	mrspl	r0, (UNDEF: 16)
     24c:	00009dfc 	strdeq	r9, [r0], -ip
     250:	00009e1a 	andeq	r9, r0, sl, lsl lr
     254:	1a500001 	bne	1400260 <_stack+0x1380260>
     258:	3400009e 	strcc	r0, [r0], #-158	; 0x9e
     25c:	0700009e 			; <UNDEFINED> instruction: 0x0700009e
     260:	06047300 	streq	r7, [r4], -r0, lsl #6
     264:	9f1afc09 	svcls	0x001afc09
     268:	00009e68 	andeq	r9, r0, r8, ror #28
     26c:	00009e76 	andeq	r9, r0, r6, ror lr
     270:	7c530001 	mrrcvc	0, 0, r0, r3, cr1
     274:	8e00009e 	mcrhi	0, 0, r0, cr0, cr14, {4}
     278:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     27c:	9e8e5300 	cdpls	3, 8, cr5, cr14, cr0, {0}
     280:	9e9a0000 	cdpls	0, 9, cr0, cr10, cr0, {0}
     284:	00070000 	andeq	r0, r7, r0
     288:	09060472 	stmdbeq	r6, {r1, r4, r5, r6, sl}
     28c:	dc9f1afc 	vldmiale	pc, {s2-s253}
     290:	e400009e 	str	r0, [r0], #-158	; 0x9e
     294:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     298:	9ee45000 	cdpls	0, 14, cr5, cr4, cr0, {0}
     29c:	9ee60000 	cdpls	0, 14, cr0, cr6, cr0, {0}
     2a0:	00070000 	andeq	r0, r7, r0
     2a4:	09060473 	stmdbeq	r6, {r0, r1, r4, r5, r6, sl}
     2a8:	e69f1afc 			; <UNDEFINED> instruction: 0xe69f1afc
     2ac:	ec00009e 	stc	0, cr0, [r0], {158}	; 0x9e
     2b0:	0d00009e 	stceq	0, cr0, [r0, #-632]	; 0xfffffd88
     2b4:	acf00300 	ldclge	3, cr0, [r0]
     2b8:	23060000 	movwcs	r0, #24576	; 0x6000
     2bc:	fc090604 	stc2	6, cr0, [r9], {4}
     2c0:	a08a9f1a 	addge	r9, sl, sl, lsl pc
     2c4:	a08c0000 	addge	r0, ip, r0
     2c8:	00010000 	andeq	r0, r1, r0
     2cc:	00a08c51 	adceq	r8, r0, r1, asr ip
     2d0:	00a0a200 	adceq	sl, r0, r0, lsl #4
     2d4:	73000700 	movwvc	r0, #1792	; 0x700
     2d8:	fc090604 	stc2	6, cr0, [r9], {4}
     2dc:	a0d69f1a 	sbcsge	r9, r6, sl, lsl pc
     2e0:	a1180000 	tstge	r8, r0
     2e4:	00010000 	andeq	r0, r1, r0
     2e8:	00a11850 	adceq	r1, r1, r0, asr r8
     2ec:	00a11a00 	adceq	r1, r1, r0, lsl #20
     2f0:	73000700 	movwvc	r0, #1792	; 0x700
     2f4:	fc090604 	stc2	6, cr0, [r9], {4}
     2f8:	a1249f1a 	teqge	r4, sl, lsl pc
     2fc:	a1280000 	teqge	r8, r0
     300:	00010000 	andeq	r0, r1, r0
     304:	00a12850 	adceq	r2, r1, r0, asr r8
     308:	00a13200 	adceq	r3, r1, r0, lsl #4
     30c:	73000700 	movwvc	r0, #1792	; 0x700
     310:	fc090604 	stc2	6, cr0, [r9], {4}
     314:	a1709f1a 	cmnge	r0, sl, lsl pc
     318:	a1720000 	cmnge	r2, r0
     31c:	00010000 	andeq	r0, r1, r0
     320:	00a17253 	adceq	r7, r1, r3, asr r2
     324:	00a17c00 	adceq	r7, r1, r0, lsl #24
     328:	72000700 	andvc	r0, r0, #0, 14
     32c:	fc090604 	stc2	6, cr0, [r9], {4}
     330:	a17c9f1a 	cmnge	ip, sl, lsl pc
     334:	a1840000 	orrge	r0, r4, r0
     338:	00070000 	andeq	r0, r7, r0
     33c:	09067c75 	stmdbeq	r6, {r0, r2, r4, r5, r6, sl, fp, ip, sp, lr}
     340:	8e9f1afc 	mrchi	10, 4, r1, cr15, cr12, {7}
     344:	960000a1 	strls	r0, [r0], -r1, lsr #1
     348:	010000a1 	smlatbeq	r0, r1, r0, r0
     34c:	a2065000 	andge	r5, r6, #0
     350:	a2080000 	andge	r0, r8, #0
     354:	00010000 	andeq	r0, r1, r0
     358:	00a20850 	adceq	r0, r2, r0, asr r8
     35c:	00a21800 	adceq	r1, r2, r0, lsl #16
     360:	73000700 	movwvc	r0, #1792	; 0x700
     364:	fc090604 	stc2	6, cr0, [r9], {4}
     368:	a2629f1a 	rsbge	r9, r2, #26, 30	; 0x68
     36c:	a2860000 	addge	r0, r6, #0
     370:	00010000 	andeq	r0, r1, r0
     374:	00000050 	andeq	r0, r0, r0, asr r0
     378:	00000000 	andeq	r0, r0, r0
     37c:	009d5e00 	addseq	r5, sp, r0, lsl #28
     380:	009d7200 	addseq	r7, sp, r0, lsl #4
     384:	5c000100 	stfpls	f0, [r0], {-0}
     388:	00009d72 	andeq	r9, r0, r2, ror sp
     38c:	00009d80 	andeq	r9, r0, r0, lsl #27
     390:	00740005 	rsbseq	r0, r4, r5
     394:	809f2533 	addshi	r2, pc, r3, lsr r5	; <UNPREDICTABLE>
     398:	9400009d 	strls	r0, [r0], #-157	; 0x9d
     39c:	3900009d 	stmdbcc	r0, {r0, r2, r3, r4, r7}
     3a0:	01f34000 	mvnseq	r4, r0
     3a4:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     3a8:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     3ac:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     3b0:	0b235101 	bleq	8d47bc <_stack+0x8547bc>
     3b4:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     3b8:	0000160c 	andeq	r1, r0, ip, lsl #12
     3bc:	01282b80 	smlawbeq	r8, r0, fp, r2
     3c0:	f3131600 	vmax.u16	d1, d3, d0
     3c4:	0b235101 	bleq	8d47d0 <_stack+0x8547d0>
     3c8:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     3cc:	0000160c 	andeq	r1, r0, ip, lsl #12
     3d0:	01282c80 	smlawbeq	r8, r0, ip, r2
     3d4:	33131600 	tstcc	r3, #0, 12
     3d8:	9dac9f25 	stcls	15, cr9, [ip, #148]!	; 0x94
     3dc:	9e4e0000 	cdpls	0, 4, cr0, cr14, cr0, {0}
     3e0:	00010000 	andeq	r0, r1, r0
     3e4:	009e545c 	addseq	r5, lr, ip, asr r4
     3e8:	009e6000 	addseq	r6, lr, r0
     3ec:	5c000100 	stfpls	f0, [r0], {-0}
     3f0:	00009e60 	andeq	r9, r0, r0, ror #28
     3f4:	00009eb8 			; <UNDEFINED> instruction: 0x00009eb8
     3f8:	dc590001 	mrrcle	0, 0, r0, r9, cr1
     3fc:	ef00009e 	svc	0x0000009e
     400:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     404:	a08a5c00 	addge	r5, sl, r0, lsl #24
     408:	a0a50000 	adcge	r0, r5, r0
     40c:	00010000 	andeq	r0, r1, r0
     410:	00a0d65c 	adceq	sp, r0, ip, asr r6
     414:	00a14900 	adceq	r4, r1, r0, lsl #18
     418:	5c000100 	stfpls	f0, [r0], {-0}
     41c:	0000a14c 	andeq	sl, r0, ip, asr #2
     420:	0000a150 	andeq	sl, r0, r0, asr r1
     424:	50590001 	subspl	r0, r9, r1
     428:	520000a1 	andpl	r0, r0, #161	; 0xa1
     42c:	030000a1 	movweq	r0, #161	; 0xa1
     430:	9f7f7900 	svcls	0x007f7900
     434:	0000a152 	andeq	sl, r0, r2, asr r1
     438:	0000a15c 	andeq	sl, r0, ip, asr r1
     43c:	5c590001 	mrrcpl	0, 0, r0, r9, cr1
     440:	6a0000a1 	bvs	6cc <CPSR_IRQ_INHIBIT+0x64c>
     444:	010000a1 	smlatbeq	r0, r1, r0, r0
     448:	a16a5c00 	cmnge	sl, r0, lsl #24
     44c:	a1700000 	cmnge	r0, r0
     450:	00050000 	andeq	r0, r5, r0
     454:	25330074 	ldrcs	r0, [r3, #-116]!	; 0x74
     458:	00a1709f 	umlaleq	r7, r1, pc, r0	; <UNPREDICTABLE>
     45c:	00a18e00 	adceq	r8, r1, r0, lsl #28
     460:	59000100 	stmdbpl	r0, {r8}
     464:	0000a18e 	andeq	sl, r0, lr, lsl #3
     468:	0000a196 	muleq	r0, r6, r1
     46c:	a65c0001 	ldrbge	r0, [ip], -r1
     470:	da0000a1 	ble	6fc <CPSR_IRQ_INHIBIT+0x67c>
     474:	010000a1 	smlatbeq	r0, r1, r0, r0
     478:	a1da5900 	bicsge	r5, sl, r0, lsl #18
     47c:	a1e60000 	mvnge	r0, r0
     480:	00010000 	andeq	r0, r1, r0
     484:	00a2065c 	adceq	r0, r2, ip, asr r6
     488:	00a21a00 	adceq	r1, r2, r0, lsl #20
     48c:	5c000100 	stfpls	f0, [r0], {-0}
     490:	0000a262 	andeq	sl, r0, r2, ror #4
     494:	0000a286 	andeq	sl, r0, r6, lsl #5
     498:	865c0001 	ldrbhi	r0, [ip], -r1
     49c:	8a0000a2 	bhi	72c <CPSR_IRQ_INHIBIT+0x6ac>
     4a0:	010000a2 	smlatbeq	r0, r2, r0, r0
     4a4:	00005900 	andeq	r5, r0, r0, lsl #18
     4a8:	00000000 	andeq	r0, r0, r0
     4ac:	9db80000 	ldcls	0, cr0, [r8]
     4b0:	9de00000 	stclls	0, cr0, [r0]
     4b4:	00010000 	andeq	r0, r1, r0
     4b8:	009e5c55 	addseq	r5, lr, r5, asr ip
     4bc:	009e6000 	addseq	r6, lr, r0
     4c0:	58000100 	stmdapl	r0, {r8}
     4c4:	00009e60 	andeq	r9, r0, r0, ror #28
     4c8:	00009e84 	andeq	r9, r0, r4, lsl #29
     4cc:	8a550001 	bhi	15404d8 <_stack+0x14c04d8>
     4d0:	980000a0 	stmdals	r0, {r5, r7}
     4d4:	010000a0 	smlatbeq	r0, r0, r0, r0
     4d8:	a14c5500 	cmpge	ip, r0, lsl #10
     4dc:	a15c0000 	cmpge	ip, r0
     4e0:	00010000 	andeq	r0, r1, r0
     4e4:	00a17055 	adceq	r7, r1, r5, asr r0
     4e8:	00a17400 	adceq	r7, r1, r0, lsl #8
     4ec:	55000100 	strpl	r0, [r0, #-256]	; 0x100
     4f0:	0000a1a6 	andeq	sl, r0, r6, lsr #3
     4f4:	0000a1e6 	andeq	sl, r0, r6, ror #3
     4f8:	86550001 	ldrbhi	r0, [r5], -r1
     4fc:	8a0000a2 	bhi	78c <CPSR_IRQ_INHIBIT+0x70c>
     500:	010000a2 	smlatbeq	r0, r2, r0, r0
     504:	00005500 	andeq	r5, r0, r0, lsl #10
     508:	00000000 	andeq	r0, r0, r0
     50c:	9e8e0000 	cdpls	0, 8, cr0, cr14, cr0, {0}
     510:	9eb50000 	cdpls	0, 11, cr0, cr5, cr0, {0}
     514:	00010000 	andeq	r0, r1, r0
     518:	009eb553 	addseq	fp, lr, r3, asr r5
     51c:	009eb800 	addseq	fp, lr, r0, lsl #16
     520:	40003c00 	andmi	r3, r0, r0, lsl #24
     524:	235101f3 	cmpcs	r1, #-1073741764	; 0xc000003c
     528:	1af8090b 	bne	ffe0295c <STACK_SVR+0xfbe0295c>
     52c:	235101f3 	cmpcs	r1, #-1073741764	; 0xc000003c
     530:	5101f30b 	tstpl	r1, fp, lsl #6
     534:	4b400b23 	blmi	10031c8 <_stack+0xf831c8>
     538:	160c2224 	strne	r2, [ip], -r4, lsr #4
     53c:	2b800000 	blcs	fe000544 <STACK_SVR+0xfa000544>
     540:	16000128 	strne	r0, [r0], -r8, lsr #2
     544:	5101f313 	tstpl	r1, r3, lsl r3
     548:	4b400b23 	blmi	10031dc <_stack+0xf831dc>
     54c:	160c2224 	strne	r2, [ip], -r4, lsr #4
     550:	2c800000 	stccs	0, cr0, [r0], {0}
     554:	16000128 	strne	r0, [r0], -r8, lsr #2
     558:	22007513 	andcs	r7, r0, #79691776	; 0x4c00000
     55c:	269f1c38 			; <UNDEFINED> instruction: 0x269f1c38
     560:	4c0000a1 	stcmi	0, cr0, [r0], {161}	; 0xa1
     564:	010000a1 	smlatbeq	r0, r1, r0, r0
     568:	00005600 	andeq	r5, r0, r0, lsl #12
     56c:	00000000 	andeq	r0, r0, r0
     570:	9dc00000 	stclls	0, cr0, [r0]
     574:	9dc60000 	stclls	0, cr0, [r6]
     578:	00010000 	andeq	r0, r1, r0
     57c:	009dd452 	addseq	sp, sp, r2, asr r4
     580:	009ddc00 	addseq	sp, sp, r0, lsl #24
     584:	52000100 	andpl	r0, r0, #0, 2
     588:	00009dfe 	strdeq	r9, [r0], -lr
     58c:	00009e20 	andeq	r9, r0, r0, lsr #28
     590:	20510001 	subscs	r0, r1, r1
     594:	3400009e 	strcc	r0, [r0], #-158	; 0x9e
     598:	0a00009e 	beq	818 <CPSR_IRQ_INHIBIT+0x798>
     59c:	06047300 	streq	r7, [r4], -r0, lsl #6
     5a0:	741afc09 	ldrvc	pc, [sl], #-3081	; 0xc09
     5a4:	689f1c00 	ldmvs	pc, {sl, fp, ip}	; <UNPREDICTABLE>
     5a8:	7600009e 			; <UNDEFINED> instruction: 0x7600009e
     5ac:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     5b0:	9e7e5100 	rpwlse	f5, f6, f0
     5b4:	9eb50000 	cdpls	0, 11, cr0, cr5, cr0, {0}
     5b8:	00010000 	andeq	r0, r1, r0
     5bc:	009edc51 	addseq	sp, lr, r1, asr ip
     5c0:	009eef00 	addseq	lr, lr, r0, lsl #30
     5c4:	51000100 	mrspl	r0, (UNDEF: 16)
     5c8:	00009f00 	andeq	r9, r0, r0, lsl #30
     5cc:	00009f08 	andeq	r9, r0, r8, lsl #30
     5d0:	00790006 	rsbseq	r0, r9, r6
     5d4:	9f1c0074 	svcls	0x001c0074
     5d8:	00009f08 	andeq	r9, r0, r8, lsl #30
     5dc:	00009f0e 	andeq	r9, r0, lr, lsl #30
     5e0:	0e530001 	cdpeq	0, 5, cr0, cr3, cr1, {0}
     5e4:	5a00009f 	bpl	868 <CPSR_IRQ_INHIBIT+0x7e8>
     5e8:	060000a0 	streq	r0, [r0], -r0, lsr #1
     5ec:	74007900 	strvc	r7, [r0], #-2304	; 0x900
     5f0:	5a9f1c00 	bpl	fe7c75f8 <STACK_SVR+0xfa7c75f8>
     5f4:	670000a0 	strvs	r0, [r0, -r0, lsr #1]
     5f8:	010000a0 	smlatbeq	r0, r0, r0, r0
     5fc:	a06a5300 	rsbge	r5, sl, r0, lsl #6
     600:	a0700000 	rsbsge	r0, r0, r0
     604:	00010000 	andeq	r0, r1, r0
     608:	00a08a53 	adceq	r8, r0, r3, asr sl
     60c:	00a08e00 	adceq	r8, r0, r0, lsl #28
     610:	52000100 	andpl	r0, r0, #0, 2
     614:	0000a08e 	andeq	sl, r0, lr, lsl #1
     618:	0000a090 	muleq	r0, r0, r0
     61c:	0473000a 	ldrbteq	r0, [r3], #-10
     620:	1afc0906 	bne	fff02a40 <STACK_SVR+0xfbf02a40>
     624:	9f1c0074 	svcls	0x001c0074
     628:	0000a090 	muleq	r0, r0, r0
     62c:	0000a0a2 	andeq	sl, r0, r2, lsr #1
     630:	0473003e 	ldrbteq	r0, [r3], #-62	; 0x3e
     634:	1afc0906 	bne	fff02a54 <STACK_SVR+0xfbf02a54>
     638:	5101f340 	tstpl	r1, r0, asr #6
     63c:	f8090b23 			; <UNDEFINED> instruction: 0xf8090b23
     640:	5101f31a 	tstpl	r1, sl, lsl r3
     644:	01f30b23 	mvnseq	r0, r3, lsr #22
     648:	400b2351 	andmi	r2, fp, r1, asr r3
     64c:	0c22244b 	cfstrseq	mvf2, [r2], #-300	; 0xfffffed4
     650:	80000016 	andhi	r0, r0, r6, lsl r0
     654:	0001282b 	andeq	r2, r1, fp, lsr #16
     658:	01f31316 	mvnseq	r1, r6, lsl r3
     65c:	400b2351 	andmi	r2, fp, r1, asr r3
     660:	0c22244b 	cfstrseq	mvf2, [r2], #-300	; 0xfffffed4
     664:	80000016 	andhi	r0, r0, r6, lsl r0
     668:	0001282c 	andeq	r2, r1, ip, lsr #16
     66c:	9f1c1316 	svcls	0x001c1316
     670:	0000a0d6 	ldrdeq	sl, [r0], -r6
     674:	0000a0e4 	andeq	sl, r0, r4, ror #1
     678:	e4510001 	ldrb	r0, [r1], #-1
     67c:	180000a0 	stmdane	r0, {r5, r7}
     680:	060000a1 	streq	r0, [r0], -r1, lsr #1
     684:	74007000 	strvc	r7, [r0], #-0
     688:	189f1c00 	ldmne	pc, {sl, fp, ip}	; <UNPREDICTABLE>
     68c:	1a0000a1 	bne	918 <CPSR_IRQ_INHIBIT+0x898>
     690:	0a0000a1 	beq	91c <CPSR_IRQ_INHIBIT+0x89c>
     694:	06047300 	streq	r7, [r4], -r0, lsl #6
     698:	741afc09 	ldrvc	pc, [sl], #-3081	; 0xc09
     69c:	249f1c00 	ldrcs	r1, [pc], #3072	; 6a4 <CPSR_IRQ_INHIBIT+0x624>
     6a0:	490000a1 	stmdbmi	r0, {r0, r5, r7}
     6a4:	010000a1 	smlatbeq	r0, r1, r0, r0
     6a8:	a1705100 	cmnge	r0, r0, lsl #2
     6ac:	a1780000 	cmnge	r8, r0
     6b0:	00010000 	andeq	r0, r1, r0
     6b4:	00a17851 	adceq	r7, r1, r1, asr r8
     6b8:	00a17c00 	adceq	r7, r1, r0, lsl #24
     6bc:	72000a00 	andvc	r0, r0, #0, 20
     6c0:	fc090604 	stc2	6, cr0, [r9], {4}
     6c4:	1c00741a 	cfstrsne	mvf7, [r0], {26}
     6c8:	00a17c9f 	umlaleq	r7, r1, pc, ip	; <UNPREDICTABLE>
     6cc:	00a17e00 	adceq	r7, r1, r0, lsl #28
     6d0:	75000a00 	strvc	r0, [r0, #-2560]	; 0xa00
     6d4:	fc09067c 	stc2	6, cr0, [r9], {124}	; 0x7c
     6d8:	1c00741a 	cfstrsne	mvf7, [r0], {26}
     6dc:	00a17e9f 	umlaleq	r7, r1, pc, lr	; <UNPREDICTABLE>
     6e0:	00a18400 	adceq	r8, r1, r0, lsl #8
     6e4:	75003e00 	strvc	r3, [r0, #-3584]	; 0xe00
     6e8:	fc09067c 	stc2	6, cr0, [r9], {124}	; 0x7c
     6ec:	01f3401a 	mvnseq	r4, sl, lsl r0
     6f0:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     6f4:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     6f8:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     6fc:	0b235101 	bleq	8d4b08 <_stack+0x854b08>
     700:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     704:	0000160c 	andeq	r1, r0, ip, lsl #12
     708:	01282b80 	smlawbeq	r8, r0, fp, r2
     70c:	f3131600 	vmax.u16	d1, d3, d0
     710:	0b235101 	bleq	8d4b1c <_stack+0x854b1c>
     714:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     718:	0000160c 	andeq	r1, r0, ip, lsl #12
     71c:	01282c80 	smlawbeq	r8, r0, ip, r2
     720:	1c131600 	ldcne	6, cr1, [r3], {-0}
     724:	00a18e9f 	umlaleq	r8, r1, pc, lr	; <UNPREDICTABLE>
     728:	00a19000 	adceq	r9, r1, r0
     72c:	51000100 	mrspl	r0, (UNDEF: 16)
     730:	0000a190 	muleq	r0, r0, r1
     734:	0000a196 	muleq	r0, r6, r1
     738:	00700006 	rsbseq	r0, r0, r6
     73c:	9f1c0074 	svcls	0x001c0074
     740:	0000a196 	muleq	r0, r6, r1
     744:	0000a1a6 	andeq	sl, r0, r6, lsr #3
     748:	00790006 	rsbseq	r0, r9, r6
     74c:	9f1c0074 	svcls	0x001c0074
     750:	0000a1fa 	strdeq	sl, [r0], -sl	; <UNPREDICTABLE>
     754:	0000a206 	andeq	sl, r0, r6, lsl #4
     758:	00790006 	rsbseq	r0, r9, r6
     75c:	9f1c0074 	svcls	0x001c0074
     760:	0000a206 	andeq	sl, r0, r6, lsl #4
     764:	0000a208 	andeq	sl, r0, r8, lsl #4
     768:	00700006 	rsbseq	r0, r0, r6
     76c:	9f1c0074 	svcls	0x001c0074
     770:	0000a208 	andeq	sl, r0, r8, lsl #4
     774:	0000a218 	andeq	sl, r0, r8, lsl r2
     778:	0473000a 	ldrbteq	r0, [r3], #-10
     77c:	1afc0906 	bne	fff02b9c <STACK_SVR+0xfbf02b9c>
     780:	9f1c0074 	svcls	0x001c0074
     784:	0000a238 	andeq	sl, r0, r8, lsr r2
     788:	0000a262 	andeq	sl, r0, r2, ror #4
     78c:	00790006 	rsbseq	r0, r9, r6
     790:	9f1c0074 	svcls	0x001c0074
     794:	0000a262 	andeq	sl, r0, r2, ror #4
     798:	0000a286 	andeq	sl, r0, r6, lsl #5
     79c:	00700006 	rsbseq	r0, r0, r6
     7a0:	9f1c0074 	svcls	0x001c0074
	...
     7ac:	00009e1a 	andeq	r9, r0, sl, lsl lr
     7b0:	00009e26 	andeq	r9, r0, r6, lsr #28
     7b4:	26500001 	ldrbcs	r0, [r0], -r1
     7b8:	3400009e 	strcc	r0, [r0], #-158	; 0x9e
     7bc:	0900009e 	stmdbeq	r0, {r1, r2, r3, r4, r7}
     7c0:	06047300 	streq	r7, [r4], -r0, lsl #6
     7c4:	331afc09 	tstcc	sl, #2304	; 0x900
     7c8:	a0f49f25 	rscsge	r9, r4, r5, lsr #30
     7cc:	a1060000 	mrsge	r0, (UNDEF: 6)
     7d0:	00010000 	andeq	r0, r1, r0
     7d4:	00a20651 	adceq	r0, r2, r1, asr r6
     7d8:	00a20e00 	adceq	r0, r2, r0, lsl #28
     7dc:	51000100 	mrspl	r0, (UNDEF: 16)
	...
     7e8:	00009e42 	andeq	r9, r0, r2, asr #28
     7ec:	00009e50 	andeq	r9, r0, r0, asr lr
     7f0:	54500001 	ldrbpl	r0, [r0], #-1
     7f4:	9000009e 	mulls	r0, lr, r0
     7f8:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     7fc:	9ef85000 	cdpls	0, 15, cr5, cr8, cr0, {0}
     800:	9f200000 	svcls	0x00200000
     804:	00010000 	andeq	r0, r1, r0
     808:	00a14c50 	adceq	r4, r1, r0, asr ip
     80c:	00a15c00 	adceq	r5, r1, r0, lsl #24
     810:	50000100 	andpl	r0, r0, r0, lsl #2
     814:	0000a170 	andeq	sl, r0, r0, ror r1
     818:	0000a17a 	andeq	sl, r0, sl, ror r1
     81c:	a6500001 	ldrbge	r0, [r0], -r1
     820:	dc0000a1 	stcle	0, cr0, [r0], {161}	; 0xa1
     824:	010000a1 	smlatbeq	r0, r1, r0, r0
     828:	a1e05000 	mvnge	r5, r0
     82c:	a1e60000 	mvnge	r0, r0
     830:	00010000 	andeq	r0, r1, r0
     834:	00a28650 	adceq	r8, r2, r0, asr r6
     838:	00a28a00 	adceq	r8, r2, r0, lsl #20
     83c:	50000100 	andpl	r0, r0, r0, lsl #2
	...
     848:	00009e58 	andeq	r9, r0, r8, asr lr
     84c:	00009e88 	andeq	r9, r0, r8, lsl #29
     850:	4c5c0001 	mrrcmi	0, 0, r0, ip, cr1
     854:	5c0000a1 	stcpl	0, cr0, [r0], {161}	; 0xa1
     858:	010000a1 	smlatbeq	r0, r1, r0, r0
     85c:	a1705c00 	cmnge	r0, r0, lsl #24
     860:	a18b0000 	orrge	r0, fp, r0
     864:	00010000 	andeq	r0, r1, r0
     868:	00a1a65c 	adceq	sl, r1, ip, asr r6
     86c:	00a1d600 	adceq	sp, r1, r0, lsl #12
     870:	5c000100 	stfpls	f0, [r0], {-0}
     874:	0000a286 	andeq	sl, r0, r6, lsl #5
     878:	0000a28a 	andeq	sl, r0, sl, lsl #5
     87c:	005c0001 	subseq	r0, ip, r1
     880:	00000000 	andeq	r0, r0, r0
     884:	82000000 	andhi	r0, r0, #0
     888:	9300009d 	movwls	r0, #157	; 0x9d
     88c:	0100009d 	swpeq	r0, sp, [r0]	; <UNPREDICTABLE>
     890:	9e2c5100 	suflse	f5, f4, f0
     894:	9e3a0000 	cdpls	0, 3, cr0, cr10, cr0, {0}
     898:	00010000 	andeq	r0, r1, r0
     89c:	009e8e50 	addseq	r8, lr, r0, asr lr
     8a0:	009eb800 	addseq	fp, lr, r0, lsl #16
     8a4:	58000100 	stmdapl	r0, {r8}
     8a8:	0000a090 	muleq	r0, r0, r0
     8ac:	0000a0ae 	andeq	sl, r0, lr, lsr #1
     8b0:	02540001 	subseq	r0, r4, #1
     8b4:	240000a1 	strcs	r0, [r0], #-161	; 0xa1
     8b8:	010000a1 	smlatbeq	r0, r1, r0, r0
     8bc:	a17c5200 	cmnge	ip, r0, lsl #4
     8c0:	a18b0000 	orrge	r0, fp, r0
     8c4:	00010000 	andeq	r0, r1, r0
     8c8:	00a20651 	adceq	r0, r2, r1, asr r6
     8cc:	00a21a00 	adceq	r1, r2, r0, lsl #20
     8d0:	52000100 	andpl	r0, r0, #0, 2
	...
     8dc:	00009d80 	andeq	r9, r0, r0, lsl #27
     8e0:	00009d93 	muleq	r0, r3, sp
     8e4:	24520001 	ldrbcs	r0, [r2], #-1
     8e8:	3a00009e 	bcc	b68 <CPSR_IRQ_INHIBIT+0xae8>
     8ec:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     8f0:	9e8e5500 	cdpls	5, 8, cr5, cr14, cr0, {0}
     8f4:	9eb50000 	cdpls	0, 11, cr0, cr5, cr0, {0}
     8f8:	00010000 	andeq	r0, r1, r0
     8fc:	00a08e5c 	adceq	r8, r0, ip, asr lr
     900:	00a0a500 	adceq	sl, r0, r0, lsl #10
     904:	52000100 	andpl	r0, r0, #0, 2
     908:	0000a0f8 	strdeq	sl, [r0], -r8
     90c:	0000a118 	andeq	sl, r0, r8, lsl r1
     910:	18550001 	ldmdane	r5, {r0}^
     914:	240000a1 	strcs	r0, [r0], #-161	; 0xa1
     918:	010000a1 	smlatbeq	r0, r1, r0, r0
     91c:	a17c5000 	cmnge	ip, r0
     920:	a18b0000 	orrge	r0, fp, r0
     924:	00010000 	andeq	r0, r1, r0
     928:	00a20652 	adceq	r0, r2, r2, asr r6
     92c:	00a20a00 	adceq	r0, r2, r0, lsl #20
     930:	55000100 	strpl	r0, [r0, #-256]	; 0x100
	...
     93c:	00009d6a 	andeq	r9, r0, sl, ror #26
     940:	00009d72 	andeq	r9, r0, r2, ror sp
     944:	5c520001 	mrrcpl	0, 0, r0, r2, cr1
     948:	8c00009e 	stchi	0, cr0, [r0], {158}	; 0x9e
     94c:	0100009e 	swpeq	r0, lr, [r0]	; <UNPREDICTABLE>
     950:	a14c5800 	cmpge	ip, r0, lsl #16
     954:	a15c0000 	cmpge	ip, r0
     958:	00010000 	andeq	r0, r1, r0
     95c:	00a15c58 	adceq	r5, r1, r8, asr ip
     960:	00a17000 	adceq	r7, r1, r0
     964:	52000100 	andpl	r0, r0, #0, 2
     968:	0000a170 	andeq	sl, r0, r0, ror r1
     96c:	0000a18e 	andeq	sl, r0, lr, lsl #3
     970:	a6580001 	ldrbge	r0, [r8], -r1
     974:	ae0000a1 	cdpge	0, 0, cr0, cr0, cr1, {5}
     978:	010000a1 	smlatbeq	r0, r1, r0, r0
     97c:	a1ae5300 			; <UNDEFINED> instruction: 0xa1ae5300
     980:	a1ba0000 			; <UNDEFINED> instruction: 0xa1ba0000
     984:	00010000 	andeq	r0, r1, r0
     988:	00a1ba58 	adceq	fp, r1, r8, asr sl
     98c:	00a1be00 	adceq	fp, r1, r0, lsl #28
     990:	53000100 	movwpl	r0, #256	; 0x100
     994:	0000a1be 			; <UNDEFINED> instruction: 0x0000a1be
     998:	0000a1c4 	andeq	sl, r0, r4, asr #3
     99c:	78780003 	ldmdavc	r8!, {r0, r1}^
     9a0:	00a2869f 	umlaleq	r8, r2, pc, r6	; <UNPREDICTABLE>
     9a4:	00a28800 	adceq	r8, r2, r0, lsl #16
     9a8:	53000100 	movwpl	r0, #256	; 0x100
	...
     9b4:	00009d3e 	andeq	r9, r0, lr, lsr sp
     9b8:	00009d80 	andeq	r9, r0, r0, lsl #27
     9bc:	80540001 	subshi	r0, r4, r1
     9c0:	9c00009d 	stcls	0, cr0, [r0], {157}	; 0x9d
     9c4:	3700009d 			; <UNDEFINED> instruction: 0x3700009d
     9c8:	01f34000 	mvnseq	r4, r0
     9cc:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     9d0:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     9d4:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     9d8:	0b235101 	bleq	8d4de4 <_stack+0x854de4>
     9dc:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     9e0:	0000160c 	andeq	r1, r0, ip, lsl #12
     9e4:	01282b80 	smlawbeq	r8, r0, fp, r2
     9e8:	f3131600 	vmax.u16	d1, d3, d0
     9ec:	0b235101 	bleq	8d4df8 <_stack+0x854df8>
     9f0:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     9f4:	0000160c 	andeq	r1, r0, ip, lsl #12
     9f8:	01282c80 	smlawbeq	r8, r0, ip, r2
     9fc:	9f131600 	svcls	0x00131600
     a00:	00009d9c 	muleq	r0, ip, sp
     a04:	00009e94 	muleq	r0, r4, lr
     a08:	94540001 	ldrbls	r0, [r4], #-1
     a0c:	b800009e 	stmdalt	r0, {r1, r2, r3, r4, r7}
     a10:	3700009e 			; <UNDEFINED> instruction: 0x3700009e
     a14:	01f34000 	mvnseq	r4, r0
     a18:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     a1c:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     a20:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     a24:	0b235101 	bleq	8d4e30 <_stack+0x854e30>
     a28:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     a2c:	0000160c 	andeq	r1, r0, ip, lsl #12
     a30:	01282b80 	smlawbeq	r8, r0, fp, r2
     a34:	f3131600 	vmax.u16	d1, d3, d0
     a38:	0b235101 	bleq	8d4e44 <_stack+0x854e44>
     a3c:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     a40:	0000160c 	andeq	r1, r0, ip, lsl #12
     a44:	01282c80 	smlawbeq	r8, r0, ip, r2
     a48:	9f131600 	svcls	0x00131600
     a4c:	00009eb8 			; <UNDEFINED> instruction: 0x00009eb8
     a50:	0000a076 	andeq	sl, r0, r6, ror r0
     a54:	76540001 	ldrbvc	r0, [r4], -r1
     a58:	8a0000a0 	bhi	ce0 <CPSR_IRQ_INHIBIT+0xc60>
     a5c:	370000a0 	strcc	r0, [r0, -r0, lsr #1]
     a60:	01f34000 	mvnseq	r4, r0
     a64:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     a68:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     a6c:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     a70:	0b235101 	bleq	8d4e7c <_stack+0x854e7c>
     a74:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     a78:	0000160c 	andeq	r1, r0, ip, lsl #12
     a7c:	01282b80 	smlawbeq	r8, r0, fp, r2
     a80:	f3131600 	vmax.u16	d1, d3, d0
     a84:	0b235101 	bleq	8d4e90 <_stack+0x854e90>
     a88:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     a8c:	0000160c 	andeq	r1, r0, ip, lsl #12
     a90:	01282c80 	smlawbeq	r8, r0, ip, r2
     a94:	9f131600 	svcls	0x00131600
     a98:	0000a08a 	andeq	sl, r0, sl, lsl #1
     a9c:	0000a090 	muleq	r0, r0, r0
     aa0:	90540001 	subsls	r0, r4, r1
     aa4:	ae0000a0 	cdpge	0, 0, cr0, cr0, cr0, {5}
     aa8:	370000a0 	strcc	r0, [r0, -r0, lsr #1]
     aac:	01f34000 	mvnseq	r4, r0
     ab0:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     ab4:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     ab8:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     abc:	0b235101 	bleq	8d4ec8 <_stack+0x854ec8>
     ac0:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     ac4:	0000160c 	andeq	r1, r0, ip, lsl #12
     ac8:	01282b80 	smlawbeq	r8, r0, fp, r2
     acc:	f3131600 	vmax.u16	d1, d3, d0
     ad0:	0b235101 	bleq	8d4edc <_stack+0x854edc>
     ad4:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     ad8:	0000160c 	andeq	r1, r0, ip, lsl #12
     adc:	01282c80 	smlawbeq	r8, r0, ip, r2
     ae0:	9f131600 	svcls	0x00131600
     ae4:	0000a0ae 	andeq	sl, r0, lr, lsr #1
     ae8:	0000a12c 	andeq	sl, r0, ip, lsr #2
     aec:	2c540001 	mrrccs	0, 0, r0, r4, cr1
     af0:	4c0000a1 	stcmi	0, cr0, [r0], {161}	; 0xa1
     af4:	370000a1 	strcc	r0, [r0, -r1, lsr #1]
     af8:	01f34000 	mvnseq	r4, r0
     afc:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     b00:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     b04:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     b08:	0b235101 	bleq	8d4f14 <_stack+0x854f14>
     b0c:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     b10:	0000160c 	andeq	r1, r0, ip, lsl #12
     b14:	01282b80 	smlawbeq	r8, r0, fp, r2
     b18:	f3131600 	vmax.u16	d1, d3, d0
     b1c:	0b235101 	bleq	8d4f28 <_stack+0x854f28>
     b20:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     b24:	0000160c 	andeq	r1, r0, ip, lsl #12
     b28:	01282c80 	smlawbeq	r8, r0, ip, r2
     b2c:	9f131600 	svcls	0x00131600
     b30:	0000a14c 	andeq	sl, r0, ip, asr #2
     b34:	0000a17e 	andeq	sl, r0, lr, ror r1
     b38:	7e540001 	cdpvc	0, 5, cr0, cr4, cr1, {0}
     b3c:	8e0000a1 	cdphi	0, 0, cr0, cr0, cr1, {5}
     b40:	370000a1 	strcc	r0, [r0, -r1, lsr #1]
     b44:	01f34000 	mvnseq	r4, r0
     b48:	090b2351 	stmdbeq	fp, {r0, r4, r6, r8, r9, sp}
     b4c:	01f31af8 	ldrsheq	r1, [r3, #168]!	; 0xa8
     b50:	f30b2351 	vcge.u8	q1, <illegal reg q5.5>, <illegal reg q0.5>
     b54:	0b235101 	bleq	8d4f60 <_stack+0x854f60>
     b58:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     b5c:	0000160c 	andeq	r1, r0, ip, lsl #12
     b60:	01282b80 	smlawbeq	r8, r0, fp, r2
     b64:	f3131600 	vmax.u16	d1, d3, d0
     b68:	0b235101 	bleq	8d4f74 <_stack+0x854f74>
     b6c:	22244b40 	eorcs	r4, r4, #64, 22	; 0x10000
     b70:	0000160c 	andeq	r1, r0, ip, lsl #12
     b74:	01282c80 	smlawbeq	r8, r0, ip, r2
     b78:	9f131600 	svcls	0x00131600
     b7c:	0000a18e 	andeq	sl, r0, lr, lsl #3
     b80:	0000a28a 	andeq	sl, r0, sl, lsl #5
     b84:	00540001 	subseq	r0, r4, r1
     b88:	00000000 	andeq	r0, r0, r0
     b8c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     b90:	6a00009f 	bvs	e14 <CPSR_IRQ_INHIBIT+0xd94>
     b94:	010000a0 	smlatbeq	r0, r0, r0, r0
     b98:	a1965400 	orrsge	r5, r6, r0, lsl #8
     b9c:	a1a60000 			; <UNDEFINED> instruction: 0xa1a60000
     ba0:	00010000 	andeq	r0, r1, r0
     ba4:	00a1fa54 	adceq	pc, r1, r4, asr sl	; <UNPREDICTABLE>
     ba8:	00a20600 	adceq	r0, r2, r0, lsl #12
     bac:	54000100 	strpl	r0, [r0], #-256	; 0x100
     bb0:	0000a238 	andeq	sl, r0, r8, lsr r2
     bb4:	0000a262 	andeq	sl, r0, r2, ror #4
     bb8:	00540001 	subseq	r0, r4, r1
     bbc:	00000000 	andeq	r0, r0, r0
     bc0:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     bc4:	6a00009f 	bvs	e48 <CPSR_IRQ_INHIBIT+0xdc8>
     bc8:	010000a0 	smlatbeq	r0, r0, r0, r0
     bcc:	a1965700 	orrsge	r5, r6, r0, lsl #14
     bd0:	a1a60000 			; <UNDEFINED> instruction: 0xa1a60000
     bd4:	00010000 	andeq	r0, r1, r0
     bd8:	00a1fa57 	adceq	pc, r1, r7, asr sl	; <UNPREDICTABLE>
     bdc:	00a20600 	adceq	r0, r2, r0, lsl #12
     be0:	57000100 	strpl	r0, [r0, -r0, lsl #2]
     be4:	0000a238 	andeq	sl, r0, r8, lsr r2
     be8:	0000a262 	andeq	sl, r0, r2, ror #4
     bec:	00570001 	subseq	r0, r7, r1
     bf0:	00000000 	andeq	r0, r0, r0
     bf4:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
     bf8:	7e00009f 	mcrvc	0, 0, r0, cr0, cr15, {4}
     bfc:	0100009f 	swpeq	r0, pc, [r0]	; <UNPREDICTABLE>
     c00:	9f7e5000 	svcls	0x007e5000
     c04:	a06a0000 	rsbge	r0, sl, r0
     c08:	00010000 	andeq	r0, r1, r0
     c0c:	00a19658 	adceq	r9, r1, r8, asr r6
     c10:	00a1a600 	adceq	sl, r1, r0, lsl #12
     c14:	50000100 	andpl	r0, r0, r0, lsl #2
     c18:	0000a1fa 	strdeq	sl, [r0], -sl	; <UNPREDICTABLE>
     c1c:	0000a206 	andeq	sl, r0, r6, lsl #4
     c20:	38580001 	ldmdacc	r8, {r0}^
     c24:	500000a2 	andpl	r0, r0, r2, lsr #1
     c28:	010000a2 	smlatbeq	r0, r2, r0, r0
     c2c:	a2505000 	subsge	r5, r0, #0
     c30:	a2620000 	rsbge	r0, r2, #0
     c34:	00010000 	andeq	r0, r1, r0
     c38:	00000058 	andeq	r0, r0, r8, asr r0
     c3c:	00000000 	andeq	r0, r0, r0
     c40:	009f7a00 	addseq	r7, pc, r0, lsl #20
     c44:	009f7e00 	addseq	r7, pc, r0, lsl #28
     c48:	70000500 	andvc	r0, r0, r0, lsl #10
     c4c:	9f1a3700 	svcls	0x001a3700
     c50:	00009f7e 	andeq	r9, r0, lr, ror pc
     c54:	00009f9e 	muleq	r0, lr, pc	; <UNPREDICTABLE>
     c58:	00780005 	rsbseq	r0, r8, r5
     c5c:	9e9f1a37 	mrcls	10, 4, r1, cr15, cr7, {1}
     c60:	a800009f 	stmdage	r0, {r0, r1, r2, r3, r4, r7}
     c64:	0100009f 	swpeq	r0, pc, [r0]	; <UNPREDICTABLE>
     c68:	9fa85300 	svcls	0x00a85300
     c6c:	9faa0000 	svcls	0x00aa0000
     c70:	00050000 	andeq	r0, r5, r0
     c74:	1a370078 	bne	dc0e5c <_stack+0xd40e5c>
     c78:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     c7c:	00000000 	andeq	r0, r0, r0
     c80:	009f9e00 	addseq	r9, pc, r0, lsl #28
     c84:	009fa800 	addseq	sl, pc, r0, lsl #16
     c88:	38000500 	stmdacc	r0, {r8, sl}
     c8c:	9f1c0073 	svcls	0x001c0073
     c90:	00009fa8 	andeq	r9, r0, r8, lsr #31
     c94:	00009faa 	andeq	r9, r0, sl, lsr #31
     c98:	78380007 	ldmdavc	r8!, {r0, r1, r2}
     c9c:	1c1a3700 	ldcne	7, cr3, [sl], {-0}
     ca0:	009fc09f 	umullseq	ip, pc, pc, r0	; <UNPREDICTABLE>
     ca4:	00a02c00 	adceq	r2, r0, r0, lsl #24
     ca8:	5a000100 	bpl	10b0 <CPSR_IRQ_INHIBIT+0x1030>
     cac:	0000a1fa 	strdeq	sl, [r0], -sl	; <UNPREDICTABLE>
     cb0:	0000a206 	andeq	sl, r0, r6, lsl #4
     cb4:	505a0001 	subspl	r0, sl, r1
     cb8:	620000a2 	andvs	r0, r0, #162	; 0xa2
     cbc:	010000a2 	smlatbeq	r0, r2, r0, r0
     cc0:	00005a00 	andeq	r5, r0, r0, lsl #20
     cc4:	00000000 	andeq	r0, r0, r0
     cc8:	9f0e0000 	svcls	0x000e0000
     ccc:	a06a0000 	rsbge	r0, sl, r0
     cd0:	00020000 	andeq	r0, r2, r0
     cd4:	a1969f30 	orrsge	r9, r6, r0, lsr pc
     cd8:	a1a60000 			; <UNDEFINED> instruction: 0xa1a60000
     cdc:	00020000 	andeq	r0, r2, r0
     ce0:	a1fa9f30 	mvnsge	r9, r0, lsr pc
     ce4:	a2060000 	andge	r0, r6, #0
     ce8:	00020000 	andeq	r0, r2, r0
     cec:	a2389f30 	eorsge	r9, r8, #48, 30	; 0xc0
     cf0:	a2620000 	rsbge	r0, r2, #0
     cf4:	00020000 	andeq	r0, r2, r0
     cf8:	00009f30 	andeq	r9, r0, r0, lsr pc
     cfc:	00000000 	andeq	r0, r0, r0
     d00:	9fc60000 	svcls	0x00c60000
     d04:	9fec0000 	svcls	0x00ec0000
     d08:	00010000 	andeq	r0, r1, r0
     d0c:	00000050 	andeq	r0, r0, r0, asr r0
     d10:	00000000 	andeq	r0, r0, r0
     d14:	00a24200 	adceq	r4, r2, r0, lsl #4
     d18:	00a24800 	adceq	r4, r2, r0, lsl #16
     d1c:	7c000600 	stcvc	6, cr0, [r0], {-0}
     d20:	22007900 	andcs	r7, r0, #0, 18
     d24:	00a2489f 	umlaleq	r4, r2, pc, r8	; <UNPREDICTABLE>
     d28:	00a24c00 	adceq	r4, r2, r0, lsl #24
     d2c:	51000100 	mrspl	r0, (UNDEF: 16)
     d30:	0000a24c 	andeq	sl, r0, ip, asr #4
     d34:	0000a250 	andeq	sl, r0, r0, asr r2
     d38:	007c0006 	rsbseq	r0, ip, r6
     d3c:	9f220079 	svcls	0x00220079
	...
     d48:	00009f0e 	andeq	r9, r0, lr, lsl #30
     d4c:	0000a036 	andeq	sl, r0, r6, lsr r0
     d50:	96550001 	ldrbls	r0, [r5], -r1
     d54:	9e0000a1 	cdpls	0, 0, cr0, cr0, cr1, {5}
     d58:	010000a1 	smlatbeq	r0, r1, r0, r0
     d5c:	a1fa5500 	mvnsge	r5, r0, lsl #10
     d60:	a1fe0000 	mvnsge	r0, r0
     d64:	00010000 	andeq	r0, r1, r0
     d68:	00a23855 	adceq	r3, r2, r5, asr r8
     d6c:	00a26200 	adceq	r6, r2, r0, lsl #4
     d70:	55000100 	strpl	r0, [r0, #-256]	; 0x100
	...
     d7c:	00009f0e 	andeq	r9, r0, lr, lsl #30
     d80:	0000a00c 	andeq	sl, r0, ip
     d84:	0c590001 	mrrceq	0, 0, r0, r9, cr1
     d88:	2c0000a0 	stccs	0, cr0, [r0], {160}	; 0xa0
     d8c:	010000a0 	smlatbeq	r0, r0, r0, r0
     d90:	a1965100 	orrsge	r5, r6, r0, lsl #2
     d94:	a1a60000 			; <UNDEFINED> instruction: 0xa1a60000
     d98:	00010000 	andeq	r0, r1, r0
     d9c:	00a1fa59 	adceq	pc, r1, r9, asr sl	; <UNPREDICTABLE>
     da0:	00a20600 	adceq	r0, r2, r0, lsl #12
     da4:	59000100 	stmdbpl	r0, {r8}
     da8:	0000a238 	andeq	sl, r0, r8, lsr r2
     dac:	0000a250 	andeq	sl, r0, r0, asr r2
     db0:	50590001 	subspl	r0, r9, r1
     db4:	540000a2 	strpl	r0, [r0], #-162	; 0xa2
     db8:	010000a2 	smlatbeq	r0, r2, r0, r0
     dbc:	a2545100 	subsge	r5, r4, #0, 2
     dc0:	a2620000 	rsbge	r0, r2, #0
     dc4:	00060000 	andeq	r0, r6, r0
     dc8:	f8097479 			; <UNDEFINED> instruction: 0xf8097479
     dcc:	00009f1a 	andeq	r9, r0, sl, lsl pc
     dd0:	00000000 	andeq	r0, r0, r0
     dd4:	9f240000 	svcls	0x00240000
     dd8:	9f4d0000 	svcls	0x004d0000
     ddc:	00010000 	andeq	r0, r1, r0
     de0:	009f4d52 	addseq	r4, pc, r2, asr sp	; <UNPREDICTABLE>
     de4:	00a03600 	adceq	r3, r0, r0, lsl #12
     de8:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
     dec:	22007900 	andcs	r7, r0, #0, 18
     df0:	00a1969f 	umlaleq	r9, r1, pc, r6	; <UNPREDICTABLE>
     df4:	00a19e00 	adceq	r9, r1, r0, lsl #28
     df8:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
     dfc:	22007900 	andcs	r7, r0, #0, 18
     e00:	00a1fa9f 	umlaleq	pc, r1, pc, sl	; <UNPREDICTABLE>
     e04:	00a1fe00 	adceq	pc, r1, r0, lsl #28
     e08:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
     e0c:	22007900 	andcs	r7, r0, #0, 18
     e10:	00a2389f 	umlaleq	r3, r2, pc, r8	; <UNPREDICTABLE>
     e14:	00a26200 	adceq	r6, r2, r0, lsl #4
     e18:	75000600 	strvc	r0, [r0, #-1536]	; 0x600
     e1c:	22007900 	andcs	r7, r0, #0, 18
     e20:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     e24:	00000000 	andeq	r0, r0, r0
     e28:	009f2c00 	addseq	r2, pc, r0, lsl #24
     e2c:	009f3400 	addseq	r3, pc, r0, lsl #8
     e30:	73000300 	movwvc	r0, #768	; 0x300
     e34:	9f349f10 	svcls	0x00349f10
     e38:	9f440000 	svcls	0x00440000
     e3c:	000c0000 	andeq	r0, ip, r0
     e40:	01401803 	cmpeq	r0, r3, lsl #16
     e44:	00740600 	rsbseq	r0, r4, r0, lsl #12
     e48:	9f102322 	svcls	0x00102322
     e4c:	00009f44 	andeq	r9, r0, r4, asr #30
     e50:	00009f4d 	andeq	r9, r0, sp, asr #30
     e54:	005c0001 	subseq	r0, ip, r1
     e58:	00000000 	andeq	r0, r0, r0
     e5c:	2c000000 	stccs	0, cr0, [r0], {-0}
     e60:	6a00009f 	bvs	10e4 <CPSR_IRQ_INHIBIT+0x1064>
     e64:	040000a0 	streq	r0, [r0], #-160	; 0xa0
     e68:	10000a00 	andne	r0, r0, r0, lsl #20
     e6c:	00a1969f 	umlaleq	r9, r1, pc, r6	; <UNPREDICTABLE>
     e70:	00a1a600 	adceq	sl, r1, r0, lsl #12
     e74:	0a000400 	beq	1e7c <CPSR_IRQ_INHIBIT+0x1dfc>
     e78:	fa9f1000 	blx	fe7c4e80 <STACK_SVR+0xfa7c4e80>
     e7c:	060000a1 	streq	r0, [r0], -r1, lsr #1
     e80:	040000a2 	streq	r0, [r0], #-162	; 0xa2
     e84:	10000a00 	andne	r0, r0, r0, lsl #20
     e88:	00a2389f 	umlaleq	r3, r2, pc, r8	; <UNPREDICTABLE>
     e8c:	00a26200 	adceq	r6, r2, r0, lsl #4
     e90:	0a000400 	beq	1e98 <CPSR_IRQ_INHIBIT+0x1e18>
     e94:	009f1000 	addseq	r1, pc, r0
     e98:	00000000 	andeq	r0, r0, r0
     e9c:	8c000000 	stchi	0, cr0, [r0], {-0}
     ea0:	e00000a2 	and	r0, r0, r2, lsr #1
     ea4:	010000a2 	smlatbeq	r0, r2, r0, r0
     ea8:	a2e05100 	rscge	r5, r0, #0, 2
     eac:	a31e0000 	tstge	lr, #0
     eb0:	00040000 	andeq	r0, r4, r0
     eb4:	9f5101f3 	svcls	0x005101f3
     eb8:	0000a31e 	andeq	sl, r0, lr, lsl r3
     ebc:	0000a32a 	andeq	sl, r0, sl, lsr #6
     ec0:	2a510001 	bcs	1440ecc <_stack+0x13c0ecc>
     ec4:	320000a3 	andcc	r0, r0, #163	; 0xa3
     ec8:	040000a3 	streq	r0, [r0], #-163	; 0xa3
     ecc:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     ed0:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     ed4:	00000000 	andeq	r0, r0, r0
     ed8:	00a28c00 	adceq	r8, r2, r0, lsl #24
     edc:	00a2aa00 	adceq	sl, r2, r0, lsl #20
     ee0:	52000100 	andpl	r0, r0, #0, 2
     ee4:	0000a2e2 	andeq	sl, r0, r2, ror #5
     ee8:	0000a2ea 	andeq	sl, r0, sl, ror #5
     eec:	ea5c0001 	b	1700ef8 <_stack+0x1680ef8>
     ef0:	f00000a2 			; <UNDEFINED> instruction: 0xf00000a2
     ef4:	010000a2 	smlatbeq	r0, r2, r0, r0
     ef8:	a2f05400 	rscsge	r5, r0, #0, 8
     efc:	a2f60000 	rscsge	r0, r6, #0
     f00:	00030000 	andeq	r0, r3, r0
     f04:	f69f0474 			; <UNDEFINED> instruction: 0xf69f0474
     f08:	fc0000a2 	stc2	0, cr0, [r0], {162}	; 0xa2
     f0c:	010000a2 	smlatbeq	r0, r2, r0, r0
     f10:	a31e5400 	tstge	lr, #0, 8
     f14:	a3200000 	teqge	r0, #0
     f18:	00010000 	andeq	r0, r1, r0
     f1c:	00a32052 	adceq	r2, r3, r2, asr r0
     f20:	00a32600 	adceq	r2, r3, r0, lsl #12
     f24:	72000300 	andvc	r0, r0, #0, 6
     f28:	a3269f7f 	teqge	r6, #508	; 0x1fc
     f2c:	a32a0000 	teqge	sl, #0
     f30:	00010000 	andeq	r0, r1, r0
     f34:	00a32a52 	adceq	r2, r3, r2, asr sl
     f38:	00a32c00 	adceq	r2, r3, r0, lsl #24
     f3c:	5c000100 	stfpls	f0, [r0], {-0}
     f40:	0000a32c 	andeq	sl, r0, ip, lsr #6
     f44:	0000a332 	andeq	sl, r0, r2, lsr r3
     f48:	7f720003 	svcvc	0x00720003
     f4c:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
     f50:	00000000 	andeq	r0, r0, r0
     f54:	00a28c00 	adceq	r8, r2, r0, lsl #24
     f58:	00a30a00 	adceq	r0, r3, r0, lsl #20
     f5c:	50000100 	andpl	r0, r0, r0, lsl #2
     f60:	0000a30a 	andeq	sl, r0, sl, lsl #6
     f64:	0000a31e 	andeq	sl, r0, lr, lsl r3
     f68:	1e530001 	cdpne	0, 5, cr0, cr3, cr1, {0}
     f6c:	200000a3 	andcs	r0, r0, r3, lsr #1
     f70:	010000a3 	smlatbeq	r0, r3, r0, r0
     f74:	a3205000 	teqge	r0, #0
     f78:	a3240000 	teqge	r4, #0
     f7c:	00010000 	andeq	r0, r1, r0
     f80:	00a32453 	adceq	r2, r3, r3, asr r4
     f84:	00a32c00 	adceq	r2, r3, r0, lsl #24
     f88:	50000100 	andpl	r0, r0, r0, lsl #2
     f8c:	0000a32c 	andeq	sl, r0, ip, lsr #6
     f90:	0000a332 	andeq	sl, r0, r2, lsr r3
     f94:	00530001 	subseq	r0, r3, r1
     f98:	00000000 	andeq	r0, r0, r0
     f9c:	8c000000 	stchi	0, cr0, [r0], {-0}
     fa0:	e00000a2 	and	r0, r0, r2, lsr #1
     fa4:	010000a2 	smlatbeq	r0, r2, r0, r0
     fa8:	a2e05100 	rscge	r5, r0, #0, 2
     fac:	a30a0000 	movwge	r0, #40960	; 0xa000
     fb0:	00040000 	andeq	r0, r4, r0
     fb4:	9f5101f3 	svcls	0x005101f3
     fb8:	0000a30a 	andeq	sl, r0, sl, lsl #6
     fbc:	0000a312 	andeq	sl, r0, r2, lsl r3
     fc0:	12510001 	subsne	r0, r1, #1
     fc4:	180000a3 	stmdane	r0, {r0, r1, r5, r7}
     fc8:	030000a3 	movweq	r0, #163	; 0xa3
     fcc:	9f7f7100 	svcls	0x007f7100
     fd0:	0000a318 	andeq	sl, r0, r8, lsl r3
     fd4:	0000a32a 	andeq	sl, r0, sl, lsr #6
     fd8:	2a510001 	bcs	1440fe4 <_stack+0x13c0fe4>
     fdc:	2c0000a3 	stccs	0, cr0, [r0], {163}	; 0xa3
     fe0:	040000a3 	streq	r0, [r0], #-163	; 0xa3
     fe4:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
     fe8:	00a32c9f 	umlaleq	r2, r3, pc, ip	; <UNPREDICTABLE>
     fec:	00a33200 	adceq	r3, r3, r0, lsl #4
     ff0:	51000100 	mrspl	r0, (UNDEF: 16)
	...
     ffc:	0000a2e2 	andeq	sl, r0, r2, ror #5
    1000:	0000a2ea 	andeq	sl, r0, sl, ror #5
    1004:	ea530001 	b	14c1010 <_stack+0x1441010>
    1008:	0c0000a2 	stceq	0, cr0, [r0], {162}	; 0xa2
    100c:	010000a3 	smlatbeq	r0, r3, r0, r0
    1010:	a32a5500 	teqge	sl, #0, 10
    1014:	a3320000 	teqge	r2, #0
    1018:	00010000 	andeq	r0, r1, r0
    101c:	00000053 	andeq	r0, r0, r3, asr r0
    1020:	00000000 	andeq	r0, r0, r0
    1024:	00a2aa00 	adceq	sl, r2, r0, lsl #20
    1028:	00a2b000 	adceq	fp, r2, r0
    102c:	74000300 	strvc	r0, [r0], #-768	; 0x300
    1030:	a2b09f04 	adcsge	r9, r0, #4, 30
    1034:	a2b40000 	adcsge	r0, r4, #0
    1038:	00030000 	andeq	r0, r3, r0
    103c:	b49f7474 	ldrlt	r7, [pc], #1140	; 1044 <CPSR_IRQ_INHIBIT+0xfc4>
    1040:	bc0000a2 	stclt	0, cr0, [r0], {162}	; 0xa2
    1044:	030000a2 	movweq	r0, #162	; 0xa2
    1048:	9f787400 	svcls	0x00787400
    104c:	0000a2bc 			; <UNDEFINED> instruction: 0x0000a2bc
    1050:	0000a2c4 	andeq	sl, r0, r4, asr #5
    1054:	7c740003 	ldclvc	0, cr0, [r4], #-12
    1058:	00a2e09f 	umlaleq	lr, r2, pc, r0	; <UNPREDICTABLE>
    105c:	00a2ea00 	adceq	lr, r2, r0, lsl #20
    1060:	51000100 	mrspl	r0, (UNDEF: 16)
    1064:	0000a2ea 	andeq	sl, r0, sl, ror #5
    1068:	0000a2ee 	andeq	sl, r0, lr, ror #5
    106c:	ee560001 	cdp	0, 5, cr0, cr6, cr1, {0}
    1070:	f00000a2 			; <UNDEFINED> instruction: 0xf00000a2
    1074:	030000a2 	movweq	r0, #162	; 0xa2
    1078:	9f7c7600 	svcls	0x007c7600
    107c:	0000a2f0 	strdeq	sl, [r0], -r0
    1080:	0000a30c 	andeq	sl, r0, ip, lsl #6
    1084:	2a560001 	bcs	1581090 <_stack+0x1501090>
    1088:	320000a3 	andcc	r0, r0, #163	; 0xa3
    108c:	010000a3 	smlatbeq	r0, r3, r0, r0
    1090:	00005100 	andeq	r5, r0, r0, lsl #2
    1094:	00000000 	andeq	r0, r0, r0
    1098:	a3340000 	teqge	r4, #0
    109c:	a3be0000 			; <UNDEFINED> instruction: 0xa3be0000
    10a0:	00010000 	andeq	r0, r1, r0
    10a4:	00a3be51 	adceq	fp, r3, r1, asr lr
    10a8:	00a3cc00 	adceq	ip, r3, r0, lsl #24
    10ac:	f3000400 	vshl.u8	d0, d0, d0
    10b0:	cc9f5101 	ldfgts	f5, [pc], {1}
    10b4:	d20000a3 	andle	r0, r0, #163	; 0xa3
    10b8:	010000a3 	smlatbeq	r0, r3, r0, r0
    10bc:	00005100 	andeq	r5, r0, r0, lsl #2
    10c0:	00000000 	andeq	r0, r0, r0
    10c4:	a3340000 	teqge	r4, #0
    10c8:	a33c0000 	teqge	ip, #0
    10cc:	00010000 	andeq	r0, r1, r0
    10d0:	00a33c52 	adceq	r3, r3, r2, asr ip
    10d4:	00a34600 	adceq	r4, r3, r0, lsl #12
    10d8:	54000100 	strpl	r0, [r0], #-256	; 0x100
    10dc:	0000a346 	andeq	sl, r0, r6, asr #6
    10e0:	0000a34c 	andeq	sl, r0, ip, asr #6
    10e4:	4c520001 	mrrcmi	0, 0, r0, r2, cr1
    10e8:	580000a3 	stmdapl	r0, {r0, r1, r5, r7}
    10ec:	010000a3 	smlatbeq	r0, r3, r0, r0
    10f0:	a3585400 	cmpge	r8, #0, 8
    10f4:	a36a0000 	cmnge	sl, #0
    10f8:	00010000 	andeq	r0, r1, r0
    10fc:	00a3a252 	adceq	sl, r3, r2, asr r2
    1100:	00a3a400 	adceq	sl, r3, r0, lsl #8
    1104:	52000100 	andpl	r0, r0, #0, 2
    1108:	0000a3a4 	andeq	sl, r0, r4, lsr #7
    110c:	0000a3a8 	andeq	sl, r0, r8, lsr #7
    1110:	04720003 	ldrbteq	r0, [r2], #-3
    1114:	00a3a89f 	umlaleq	sl, r3, pc, r8	; <UNPREDICTABLE>
    1118:	00a3ae00 	adceq	sl, r3, r0, lsl #28
    111c:	52000100 	andpl	r0, r0, #0, 2
    1120:	0000a3cc 	andeq	sl, r0, ip, asr #7
    1124:	0000a3d2 	ldrdeq	sl, [r0], -r2
    1128:	00520001 	subseq	r0, r2, r1
    112c:	00000000 	andeq	r0, r0, r0
    1130:	34000000 	strcc	r0, [r0], #-0
    1134:	460000a3 	strmi	r0, [r0], -r3, lsr #1
    1138:	010000a3 	smlatbeq	r0, r3, r0, r0
    113c:	a3465000 	movtge	r5, #24576	; 0x6000
    1140:	a39c0000 	orrsge	r0, ip, #0
    1144:	00010000 	andeq	r0, r1, r0
    1148:	00a3ba53 	adceq	fp, r3, r3, asr sl
    114c:	00a3c800 	adceq	ip, r3, r0, lsl #16
    1150:	53000100 	movwpl	r0, #256	; 0x100
    1154:	0000a3cc 	andeq	sl, r0, ip, asr #7
    1158:	0000a3d2 	ldrdeq	sl, [r0], -r2
    115c:	00500001 	subseq	r0, r0, r1
    1160:	00000000 	andeq	r0, r0, r0
    1164:	6a000000 	bvs	116c <CPSR_IRQ_INHIBIT+0x10ec>
    1168:	ba0000a3 	blt	13fc <CPSR_IRQ_INHIBIT+0x137c>
    116c:	030000a3 	movweq	r0, #163	; 0xa3
    1170:	9f200800 	svcls	0x00200800
	...
    117c:	0000a366 	andeq	sl, r0, r6, ror #6
    1180:	0000a3ba 			; <UNDEFINED> instruction: 0x0000a3ba
    1184:	00550001 	subseq	r0, r5, r1
    1188:	00000000 	andeq	r0, r0, r0
    118c:	60000000 	andvs	r0, r0, r0
    1190:	7c0000a3 	stcvc	0, cr0, [r0], {163}	; 0xa3
    1194:	010000a3 	smlatbeq	r0, r3, r0, r0
    1198:	a37c5300 	cmnge	ip, #0, 6
    119c:	a37e0000 	cmnge	lr, #0
    11a0:	00030000 	andeq	r0, r3, r0
    11a4:	7e9f0472 	mrcvc	4, 4, r0, cr15, cr2, {3}
    11a8:	800000a3 	andhi	r0, r0, r3, lsr #1
    11ac:	030000a3 	movweq	r0, #163	; 0xa3
    11b0:	9f087200 	svcls	0x00087200
    11b4:	0000a380 	andeq	sl, r0, r0, lsl #7
    11b8:	0000a384 	andeq	sl, r0, r4, lsl #7
    11bc:	78720003 	ldmdavc	r2!, {r0, r1}^
    11c0:	00a3849f 	umlaleq	r8, r3, pc, r4	; <UNPREDICTABLE>
    11c4:	00a38800 	adceq	r8, r3, r0, lsl #16
    11c8:	72000300 	andvc	r0, r0, #0, 6
    11cc:	a39c9f7c 	orrsge	r9, ip, #124, 30	; 0x1f0
    11d0:	a3a20000 			; <UNDEFINED> instruction: 0xa3a20000
    11d4:	00010000 	andeq	r0, r1, r0
    11d8:	00a3a253 	adceq	sl, r3, r3, asr r2
    11dc:	00a3ba00 	adceq	fp, r3, r0, lsl #20
    11e0:	56000100 	strpl	r0, [r0], -r0, lsl #2
	...
    11ec:	0000a334 	andeq	sl, r0, r4, lsr r3
    11f0:	0000a3be 			; <UNDEFINED> instruction: 0x0000a3be
    11f4:	00710006 	rsbseq	r0, r1, r6
    11f8:	9f1aff08 	svcls	0x001aff08
    11fc:	0000a3be 			; <UNDEFINED> instruction: 0x0000a3be
    1200:	0000a3cc 	andeq	sl, r0, ip, asr #7
    1204:	01f30007 	mvnseq	r0, r7
    1208:	1aff0851 	bne	fffc3354 <STACK_SVR+0xfbfc3354>
    120c:	00a3cc9f 	umlaleq	ip, r3, pc, ip	; <UNPREDICTABLE>
    1210:	00a3d200 	adceq	sp, r3, r0, lsl #4
    1214:	71000600 	tstvc	r0, r0, lsl #12
    1218:	1aff0800 	bne	fffc3220 <STACK_SVR+0xfbfc3220>
    121c:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    1220:	00000000 	andeq	r0, r0, r0
    1224:	00a3dc00 	adceq	sp, r3, r0, lsl #24
    1228:	00a3e900 	adceq	lr, r3, r0, lsl #18
    122c:	50000100 	andpl	r0, r0, r0, lsl #2
    1230:	0000a3e9 	andeq	sl, r0, r9, ror #7
    1234:	0000a3f2 	strdeq	sl, [r0], -r2
    1238:	f2550001 	vhadd.s16	d16, d5, d1
    123c:	f50000a3 			; <UNDEFINED> instruction: 0xf50000a3
    1240:	010000a3 	smlatbeq	r0, r3, r0, r0
    1244:	a3f55000 	mvnsge	r5, #0
    1248:	a3f60000 	mvnsge	r0, #0
    124c:	00040000 	andeq	r0, r4, r0
    1250:	9f5001f3 	svcls	0x005001f3
	...
    125c:	0000a3dc 	ldrdeq	sl, [r0], -ip
    1260:	0000a3e2 	andeq	sl, r0, r2, ror #7
    1264:	e2510001 	subs	r0, r1, #1
    1268:	f20000a3 	vhadd.s8	d0, d16, d19
    126c:	010000a3 	smlatbeq	r0, r3, r0, r0
    1270:	a3f25400 	mvnsge	r5, #0, 8
    1274:	a3f50000 	mvnsge	r0, #0
    1278:	00010000 	andeq	r0, r1, r0
    127c:	00a3f551 	adceq	pc, r3, r1, asr r5	; <UNPREDICTABLE>
    1280:	00a3f600 	adceq	pc, r3, r0, lsl #12
    1284:	f3000400 	vshl.u8	d0, d0, d0
    1288:	009f5101 	addseq	r5, pc, r1, lsl #2
    128c:	00000000 	andeq	r0, r0, r0
    1290:	f8000000 			; <UNDEFINED> instruction: 0xf8000000
    1294:	120000a3 	andne	r0, r0, #163	; 0xa3
    1298:	010000a4 	smlatbeq	r0, r4, r0, r0
    129c:	a4125000 	ldrge	r5, [r2], #-0
    12a0:	a4840000 	strge	r0, [r4], #0
    12a4:	00010000 	andeq	r0, r1, r0
    12a8:	00a48455 	adceq	r8, r4, r5, asr r4
    12ac:	00a48700 	adceq	r8, r4, r0, lsl #14
    12b0:	50000100 	andpl	r0, r0, r0, lsl #2
    12b4:	0000a487 	andeq	sl, r0, r7, lsl #9
    12b8:	0000a488 	andeq	sl, r0, r8, lsl #9
    12bc:	01f30004 	mvnseq	r0, r4
    12c0:	00009f50 	andeq	r9, r0, r0, asr pc
    12c4:	00000000 	andeq	r0, r0, r0
    12c8:	a4120000 	ldrge	r0, [r2], #-0
    12cc:	a43a0000 	ldrtge	r0, [sl], #-0
    12d0:	00010000 	andeq	r0, r1, r0
    12d4:	00000056 	andeq	r0, r0, r6, asr r0
    12d8:	00000000 	andeq	r0, r0, r0
    12dc:	00a41c00 	adceq	r1, r4, r0, lsl #24
    12e0:	00a42300 	adceq	r2, r4, r0, lsl #6
    12e4:	51000100 	mrspl	r0, (UNDEF: 16)
	...
    12f0:	0000a416 	andeq	sl, r0, r6, lsl r4
    12f4:	0000a41a 	andeq	sl, r0, sl, lsl r4
    12f8:	1a510001 	bne	1441304 <_stack+0x13c1304>
    12fc:	1c0000a4 	stcne	0, cr0, [r0], {164}	; 0xa4
    1300:	010000a4 	smlatbeq	r0, r4, r0, r0
    1304:	a41c5400 	ldrge	r5, [ip], #-1024	; 0x400
    1308:	a41e0000 	ldrge	r0, [lr], #-0
    130c:	00010000 	andeq	r0, r1, r0
    1310:	00a41e51 	adceq	r1, r4, r1, asr lr
    1314:	00a42a00 	adceq	r2, r4, r0, lsl #20
    1318:	54000100 	strpl	r0, [r0], #-256	; 0x100
	...
    1324:	0000a452 	andeq	sl, r0, r2, asr r4
    1328:	0000a454 	andeq	sl, r0, r4, asr r4
    132c:	54510001 	ldrbpl	r0, [r1], #-1
    1330:	600000a4 	andvs	r0, r0, r4, lsr #1
    1334:	010000a4 	smlatbeq	r0, r4, r0, r0
    1338:	00005400 	andeq	r5, r0, r0, lsl #8
    133c:	00000000 	andeq	r0, r0, r0
    1340:	a4520000 	ldrbge	r0, [r2], #-0
    1344:	a4590000 	ldrbge	r0, [r9], #-0
    1348:	00010000 	andeq	r0, r1, r0
    134c:	00000051 	andeq	r0, r0, r1, asr r0
    1350:	00000000 	andeq	r0, r0, r0
    1354:	00a48800 	adceq	r8, r4, r0, lsl #16
    1358:	00a49600 	adceq	r9, r4, r0, lsl #12
    135c:	50000100 	andpl	r0, r0, r0, lsl #2
    1360:	0000a496 	muleq	r0, r6, r4
    1364:	0000a4ae 	andeq	sl, r0, lr, lsr #9
    1368:	00550001 	subseq	r0, r5, r1
    136c:	00000000 	andeq	r0, r0, r0
    1370:	88000000 	stmdahi	r0, {}	; <UNPREDICTABLE>
    1374:	9d0000a4 	stcls	0, cr0, [r0, #-656]	; 0xfffffd70
    1378:	010000a4 	smlatbeq	r0, r4, r0, r0
    137c:	a49d5100 	ldrge	r5, [sp], #256	; 0x100
    1380:	a4ae0000 	strtge	r0, [lr], #0
    1384:	00040000 	andeq	r0, r4, r0
    1388:	9f5101f3 	svcls	0x005101f3
	...
    1394:	0000a4b0 			; <UNDEFINED> instruction: 0x0000a4b0
    1398:	0000a50e 	andeq	sl, r0, lr, lsl #10
    139c:	0e500001 	cdpeq	0, 5, cr0, cr0, cr1, {0}
    13a0:	0e0000a5 	cdpeq	0, 0, cr0, cr0, cr5, {5}
    13a4:	040000a5 	streq	r0, [r0], #-165	; 0xa5
    13a8:	5001f300 	andpl	pc, r1, r0, lsl #6
    13ac:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
    13b0:	00000000 	andeq	r0, r0, r0
    13b4:	00a51000 	adceq	r1, r5, r0
    13b8:	00a52100 	adceq	r2, r5, r0, lsl #2
    13bc:	50000100 	andpl	r0, r0, r0, lsl #2
    13c0:	0000a521 	andeq	sl, r0, r1, lsr #10
    13c4:	0000a5b2 			; <UNDEFINED> instruction: 0x0000a5b2
    13c8:	00550001 	subseq	r0, r5, r1
    13cc:	00000000 	andeq	r0, r0, r0
    13d0:	10000000 	andne	r0, r0, r0
    13d4:	210000a5 	smlatbcs	r0, r5, r0, r0
    13d8:	010000a5 	smlatbeq	r0, r5, r0, r0
    13dc:	a5215100 	strge	r5, [r1, #-256]!	; 0x100
    13e0:	a52c0000 	strge	r0, [ip, #-0]!
    13e4:	00010000 	andeq	r0, r1, r0
    13e8:	00a52c57 	adceq	r2, r5, r7, asr ip
    13ec:	00a5b200 	adceq	fp, r5, r0, lsl #4
    13f0:	f3000400 	vshl.u8	d0, d0, d0
    13f4:	009f5101 	addseq	r5, pc, r1, lsl #2
    13f8:	00000000 	andeq	r0, r0, r0
    13fc:	2a000000 	bcs	1404 <CPSR_IRQ_INHIBIT+0x1384>
    1400:	4c0000a5 	stcmi	0, cr0, [r0], {165}	; 0xa5
    1404:	010000a5 	smlatbeq	r0, r5, r0, r0
    1408:	a5565600 	ldrbge	r5, [r6, #-1536]	; 0x600
    140c:	a56e0000 	strbge	r0, [lr, #-0]!
    1410:	00010000 	andeq	r0, r1, r0
    1414:	00a58456 	adceq	r8, r5, r6, asr r4
    1418:	00a59000 	adceq	r9, r5, r0
    141c:	56000100 	strpl	r0, [r0], -r0, lsl #2
    1420:	0000a590 	muleq	r0, r0, r5
    1424:	0000a5aa 	andeq	sl, r0, sl, lsr #11
    1428:	aa520001 	bge	1481434 <_stack+0x1401434>
    142c:	ae0000a5 	cdpge	0, 0, cr0, cr0, cr5, {5}
    1430:	060000a5 	streq	r0, [r0], -r5, lsr #1
    1434:	73007000 	movwvc	r7, #0
    1438:	009f1c00 	addseq	r1, pc, r0, lsl #24
    143c:	00000000 	andeq	r0, r0, r0
    1440:	36000000 	strcc	r0, [r0], -r0
    1444:	7a0000a5 	bvc	16e0 <CPSR_IRQ_INHIBIT+0x1660>
    1448:	010000a5 	smlatbeq	r0, r5, r0, r0
    144c:	a5845700 	strge	r5, [r4, #1792]	; 0x700
    1450:	a5b20000 	ldrge	r0, [r2, #0]!
    1454:	00010000 	andeq	r0, r1, r0
    1458:	00000057 	andeq	r0, r0, r7, asr r0
    145c:	00000000 	andeq	r0, r0, r0
    1460:	00a54400 	adceq	r4, r5, r0, lsl #8
    1464:	00a54c00 	adceq	r4, r5, r0, lsl #24
    1468:	50000100 	andpl	r0, r0, r0, lsl #2
    146c:	0000a556 	andeq	sl, r0, r6, asr r5
    1470:	0000a558 	andeq	sl, r0, r8, asr r5
    1474:	8c500001 	mrrchi	0, 0, r0, r0, cr1	; <UNPREDICTABLE>
    1478:	ae0000a5 	cdpge	0, 0, cr0, cr0, cr5, {5}
    147c:	010000a5 	smlatbeq	r0, r5, r0, r0
    1480:	00005000 	andeq	r5, r0, r0
    1484:	00000000 	andeq	r0, r0, r0
    1488:	a55e0000 	ldrbge	r0, [lr, #-0]
    148c:	a5600000 	strbge	r0, [r0, #-0]!
    1490:	00010000 	andeq	r0, r1, r0
    1494:	00a56050 	adceq	r6, r5, r0, asr r0
    1498:	00a57000 	adceq	r7, r5, r0
    149c:	70000300 	andvc	r0, r0, r0, lsl #6
    14a0:	a5849f7f 	strge	r9, [r4, #3967]	; 0xf7f
    14a4:	a5860000 	strge	r0, [r6]
    14a8:	00030000 	andeq	r0, r3, r0
    14ac:	009f7f70 	addseq	r7, pc, r0, ror pc	; <UNPREDICTABLE>
    14b0:	00000000 	andeq	r0, r0, r0
    14b4:	b4000000 	strlt	r0, [r0], #-0
    14b8:	c30000a5 	movwgt	r0, #165	; 0xa5
    14bc:	010000a5 	smlatbeq	r0, r5, r0, r0
    14c0:	a5c35000 	strbge	r5, [r3]
    14c4:	a67a0000 	ldrbtge	r0, [sl], -r0
    14c8:	00010000 	andeq	r0, r1, r0
    14cc:	00a67a58 	adceq	r7, r6, r8, asr sl
    14d0:	00a67d00 	adceq	r7, r6, r0, lsl #26
    14d4:	50000100 	andpl	r0, r0, r0, lsl #2
    14d8:	0000a67d 	andeq	sl, r0, sp, ror r6
    14dc:	0000a67e 	andeq	sl, r0, lr, ror r6
    14e0:	01f30004 	mvnseq	r0, r4
    14e4:	a67e9f50 	uhsaxge	r9, lr, r0
    14e8:	a6820000 	strge	r0, [r2], r0
    14ec:	00010000 	andeq	r0, r1, r0
    14f0:	00a68250 	adceq	r8, r6, r0, asr r2
    14f4:	00a6a600 	adceq	sl, r6, r0, lsl #12
    14f8:	58000100 	stmdapl	r0, {r8}
    14fc:	0000a6a6 	andeq	sl, r0, r6, lsr #13
    1500:	0000a6a9 	andeq	sl, r0, r9, lsr #13
    1504:	a9500001 	ldmdbge	r0, {r0}^
    1508:	aa0000a6 	bge	17a8 <CPSR_IRQ_INHIBIT+0x1728>
    150c:	040000a6 	streq	r0, [r0], #-166	; 0xa6
    1510:	5001f300 	andpl	pc, r1, r0, lsl #6
    1514:	00a6aa9f 	umlaleq	sl, r6, pc, sl	; <UNPREDICTABLE>
    1518:	00a74c00 	adceq	r4, r7, r0, lsl #24
    151c:	58000100 	stmdapl	r0, {r8}
	...
    1528:	0000a5b4 			; <UNDEFINED> instruction: 0x0000a5b4
    152c:	0000a5c3 	andeq	sl, r0, r3, asr #11
    1530:	c3510001 	cmpgt	r1, #1
    1534:	f60000a5 			; <UNDEFINED> instruction: 0xf60000a5
    1538:	010000a5 	smlatbeq	r0, r5, r0, r0
    153c:	a5f65600 	ldrbge	r5, [r6, #1536]!	; 0x600
    1540:	a5fc0000 	ldrbge	r0, [ip, #0]!
    1544:	00030000 	andeq	r0, r3, r0
    1548:	fc9f0874 	ldc2	8, cr0, [pc], {116}	; 0x74
    154c:	7e0000a5 	cdpvc	0, 0, cr0, cr0, cr5, {5}
    1550:	040000a6 	streq	r0, [r0], #-166	; 0xa6
    1554:	5101f300 	mrspl	pc, SP_irq	; <UNPREDICTABLE>
    1558:	00a67e9f 	umlaleq	r7, r6, pc, lr	; <UNPREDICTABLE>
    155c:	00a68200 	adceq	r8, r6, r0, lsl #4
    1560:	51000100 	mrspl	r0, (UNDEF: 16)
    1564:	0000a682 	andeq	sl, r0, r2, lsl #13
    1568:	0000a6aa 	andeq	sl, r0, sl, lsr #13
    156c:	01f30004 	mvnseq	r0, r4
    1570:	a6aa9f51 	ssatge	r9, #11, r1, asr #30
    1574:	a6e80000 	strbtge	r0, [r8], r0
    1578:	00010000 	andeq	r0, r1, r0
    157c:	00a6e856 	adceq	lr, r6, r6, asr r8
    1580:	00a74c00 	adceq	r4, r7, r0, lsl #24
    1584:	f3000400 	vshl.u8	d0, d0, d0
    1588:	009f5101 	addseq	r5, pc, r1, lsl #2
    158c:	00000000 	andeq	r0, r0, r0
    1590:	d4000000 	strle	r0, [r0], #-0
    1594:	7a0000a5 	bvc	1830 <CPSR_IRQ_INHIBIT+0x17b0>
    1598:	010000a6 	smlatbeq	r0, r6, r0, r0
    159c:	a6825400 	strge	r5, [r2], r0, lsl #8
    15a0:	a6a60000 	strtge	r0, [r6], r0
    15a4:	00010000 	andeq	r0, r1, r0
    15a8:	00a6a654 	adceq	sl, r6, r4, asr r6
    15ac:	00a6a900 	adceq	sl, r6, r0, lsl #18
    15b0:	72000200 	andvc	r0, r0, #0, 4
    15b4:	00a6aa08 	adceq	sl, r6, r8, lsl #20
    15b8:	00a74c00 	adceq	r4, r7, r0, lsl #24
    15bc:	54000100 	strpl	r0, [r0], #-256	; 0x100
	...
    15c8:	0000a5d4 	ldrdeq	sl, [r0], -r4
    15cc:	0000a5ea 	andeq	sl, r0, sl, ror #11
    15d0:	ea510001 	b	14415dc <_stack+0x13c15dc>
    15d4:	ec0000a5 	stc	0, cr0, [r0], {165}	; 0xa5
    15d8:	020000a5 	andeq	r0, r0, #165	; 0xa5
    15dc:	aa7c7600 	bge	1f1ede4 <_stack+0x1e9ede4>
    15e0:	e20000a6 	and	r0, r0, #166	; 0xa6
    15e4:	010000a6 	smlatbeq	r0, r6, r0, r0
    15e8:	00005100 	andeq	r5, r0, r0, lsl #2
    15ec:	00000000 	andeq	r0, r0, r0
    15f0:	a5d80000 	ldrbge	r0, [r8]
    15f4:	a66c0000 	strbtge	r0, [ip], -r0
    15f8:	00010000 	andeq	r0, r1, r0
    15fc:	00a68253 	adceq	r8, r6, r3, asr r2
    1600:	00a68400 	adceq	r8, r6, r0, lsl #8
    1604:	53000100 	movwpl	r0, #256	; 0x100
    1608:	0000a6aa 	andeq	sl, r0, sl, lsr #13
    160c:	0000a6ae 	andeq	sl, r0, lr, lsr #13
    1610:	ae530001 	cdpge	0, 5, cr0, cr3, cr1, {0}
    1614:	e00000a6 	and	r0, r0, r6, lsr #1
    1618:	010000a6 	smlatbeq	r0, r6, r0, r0
    161c:	a6e85000 	strbtge	r5, [r8], r0
    1620:	a7140000 	ldrge	r0, [r4, -r0]
    1624:	00010000 	andeq	r0, r1, r0
    1628:	00a72453 	adceq	r2, r7, r3, asr r4
    162c:	00a74c00 	adceq	r4, r7, r0, lsl #24
    1630:	53000100 	movwpl	r0, #256	; 0x100
	...
    163c:	0000a648 	andeq	sl, r0, r8, asr #12
    1640:	0000a66c 	andeq	sl, r0, ip, ror #12
    1644:	84500001 	ldrbhi	r0, [r0], #-1
    1648:	8e0000a6 	cdphi	0, 0, cr0, cr0, cr6, {5}
    164c:	010000a6 	smlatbeq	r0, r6, r0, r0
    1650:	a7125300 	ldrge	r5, [r2, -r0, lsl #6]
    1654:	a7180000 	ldrge	r0, [r8, -r0]
    1658:	00010000 	andeq	r0, r1, r0
    165c:	00000050 	andeq	r0, r0, r0, asr r0
    1660:	00000000 	andeq	r0, r0, r0
    1664:	00a5da00 	adceq	sp, r5, r0, lsl #20
    1668:	00a62800 	adceq	r2, r6, r0, lsl #16
    166c:	52000100 	andpl	r0, r0, #0, 2
    1670:	0000a6aa 	andeq	sl, r0, sl, lsr #13
    1674:	0000a6ba 			; <UNDEFINED> instruction: 0x0000a6ba
    1678:	ba520001 	blt	1481684 <_stack+0x1401684>
    167c:	e20000a6 	and	r0, r0, #166	; 0xa6
    1680:	0b0000a6 	bleq	1920 <CPSR_IRQ_INHIBIT+0x18a0>
    1684:	09007100 	stmdbeq	r0, {r8, ip, sp, lr}
    1688:	00761afe 	ldrshteq	r1, [r6], #-174	; 0xffffff52
    168c:	9f1c3822 	svcls	0x001c3822
    1690:	0000a6e8 	andeq	sl, r0, r8, ror #13
    1694:	0000a6ee 	andeq	sl, r0, lr, ror #13
    1698:	00520001 	subseq	r0, r2, r1
    169c:	00000000 	andeq	r0, r0, r0
    16a0:	e4000000 	str	r0, [r0], #-0
    16a4:	1e0000a5 	cdpne	0, 0, cr0, cr0, cr5, {5}
    16a8:	010000a6 	smlatbeq	r0, r6, r0, r0
    16ac:	a61e5000 	ldrge	r5, [lr], -r0
    16b0:	a6280000 	strtge	r0, [r8], -r0
    16b4:	00020000 	andeq	r0, r2, r0
    16b8:	a6aa0472 	sxtabge	r0, sl, r2, ror #8
    16bc:	a6ae0000 	strtge	r0, [lr], r0
    16c0:	00010000 	andeq	r0, r1, r0
    16c4:	00a6ae50 	adceq	sl, r6, r0, asr lr
    16c8:	00a6ba00 	adceq	fp, r6, r0, lsl #20
    16cc:	72000700 	andvc	r0, r0, #0, 14
    16d0:	fc090604 	stc2	6, cr0, [r9], {4}
    16d4:	a6ba9f1a 	ssatge	r9, #27, sl, lsl #30
    16d8:	a6ce0000 	strbge	r0, [lr], r0
    16dc:	000f0000 	andeq	r0, pc, r0
    16e0:	fe090071 	mcr2	0, 0, r0, cr9, cr1, {3}
    16e4:	2200761a 	andcs	r7, r0, #27262976	; 0x1a00000
    16e8:	09061c34 	stmdbeq	r6, {r2, r4, r5, sl, fp, ip}
    16ec:	e89f1afc 	ldm	pc, {r2, r3, r4, r5, r6, r7, r9, fp, ip}	; <UNPREDICTABLE>
    16f0:	ee0000a6 	cdp	0, 0, cr0, cr0, cr6, {5}
    16f4:	020000a6 	andeq	r0, r0, #166	; 0xa6
    16f8:	00047200 	andeq	r7, r4, r0, lsl #4
    16fc:	00000000 	andeq	r0, r0, r0
    1700:	f6000000 			; <UNDEFINED> instruction: 0xf6000000
    1704:	000000a5 	andeq	r0, r0, r5, lsr #1
    1708:	010000a6 	smlatbeq	r0, r6, r0, r0
    170c:	a6005600 	strge	r5, [r0], -r0, lsl #12
    1710:	a6120000 	ldrge	r0, [r2], -r0
    1714:	00050000 	andeq	r0, r5, r0
    1718:	385101f3 	ldmdacc	r1, {r0, r1, r4, r5, r6, r7, r8}^
    171c:	00a6b41c 	adceq	fp, r6, ip, lsl r4
    1720:	00a6bc00 	adceq	fp, r6, r0, lsl #24
    1724:	53000100 	movwpl	r0, #256	; 0x100
    1728:	0000a6bc 			; <UNDEFINED> instruction: 0x0000a6bc
    172c:	0000a6c0 	andeq	sl, r0, r0, asr #13
    1730:	78760002 	ldmdavc	r6!, {r1}^
	...
    173c:	0000a608 	andeq	sl, r0, r8, lsl #12
    1740:	0000a612 	andeq	sl, r0, r2, lsl r6
    1744:	285c0001 	ldmdacs	ip, {r0}^
    1748:	2c0000a6 	stccs	0, cr0, [r0], {166}	; 0xa6
    174c:	010000a6 	smlatbeq	r0, r6, r0, r0
    1750:	a64c5200 	strbge	r5, [ip], -r0, lsl #4
    1754:	a66c0000 	strbtge	r0, [ip], -r0
    1758:	00010000 	andeq	r0, r1, r0
    175c:	00a66c55 	adceq	r6, r6, r5, asr ip
    1760:	00a67400 	adceq	r7, r6, r0, lsl #8
    1764:	53000100 	movwpl	r0, #256	; 0x100
    1768:	0000a68c 	andeq	sl, r0, ip, lsl #13
    176c:	0000a6a9 	andeq	sl, r0, r9, lsr #13
    1770:	bc520001 	mrrclt	0, 0, r0, r2, cr1
    1774:	c00000a6 	andgt	r0, r0, r6, lsr #1
    1778:	010000a6 	smlatbeq	r0, r6, r0, r0
    177c:	a7125300 	ldrge	r5, [r2, -r0, lsl #6]
    1780:	a7160000 	ldrge	r0, [r6, -r0]
    1784:	00010000 	andeq	r0, r1, r0
    1788:	00000055 	andeq	r0, r0, r5, asr r0
    178c:	00000000 	andeq	r0, r0, r0
    1790:	00a60800 	adceq	r0, r6, r0, lsl #16
    1794:	00a61200 	adceq	r1, r6, r0, lsl #4
    1798:	56000100 	strpl	r0, [r0], -r0, lsl #2
    179c:	0000a628 	andeq	sl, r0, r8, lsr #12
    17a0:	0000a62c 	andeq	sl, r0, ip, lsr #12
    17a4:	56500001 	ldrbpl	r0, [r0], -r1
    17a8:	740000a6 	strvc	r0, [r0], #-166	; 0xa6
    17ac:	010000a6 	smlatbeq	r0, r6, r0, r0
    17b0:	a6945200 	ldrge	r5, [r4], r0, lsl #4
    17b4:	a6a90000 	strtge	r0, [r9], r0
    17b8:	00010000 	andeq	r0, r1, r0
    17bc:	00a6bc51 	adceq	fp, r6, r1, asr ip
    17c0:	00a6c000 	adceq	ip, r6, r0
    17c4:	52000100 	andpl	r0, r0, #0, 2
    17c8:	0000a712 	andeq	sl, r0, r2, lsl r7
    17cc:	0000a724 	andeq	sl, r0, r4, lsr #14
    17d0:	00520001 	subseq	r0, r2, r1
    17d4:	00000000 	andeq	r0, r0, r0
    17d8:	ec000000 	stc	0, cr0, [r0], {-0}
    17dc:	120000a5 	andne	r0, r0, #165	; 0xa5
    17e0:	020000a6 	andeq	r0, r0, #166	; 0xa6
    17e4:	129f3000 	addsne	r3, pc, #0
    17e8:	480000a6 	stmdami	r0, {r1, r2, r5, r7}
    17ec:	010000a6 	smlatbeq	r0, r6, r0, r0
    17f0:	a6825100 	strge	r5, [r2], r0, lsl #2
    17f4:	a6860000 	strge	r0, [r6], r0
    17f8:	00010000 	andeq	r0, r1, r0
    17fc:	00a6e851 	adceq	lr, r6, r1, asr r8
    1800:	00a6fa00 	adceq	pc, r6, r0, lsl #20
    1804:	31000200 	mrscc	r0, R8_usr
    1808:	00a6fa9f 	umlaleq	pc, r6, pc, sl	; <UNPREDICTABLE>
    180c:	00a70400 	adceq	r0, r7, r0, lsl #8
    1810:	51000100 	mrspl	r0, (UNDEF: 16)
	...

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
   0:	00009d04 	andeq	r9, r0, r4, lsl #26
   4:	00009d14 	andeq	r9, r0, r4, lsl sp
   8:	00009d14 	andeq	r9, r0, r4, lsl sp
   c:	00009d24 	andeq	r9, r0, r4, lsr #26
	...
  18:	00009f0e 	andeq	r9, r0, lr, lsl #30
  1c:	0000a054 	andeq	sl, r0, r4, asr r0
  20:	0000a196 	muleq	r0, r6, r1
  24:	0000a1a6 	andeq	sl, r0, r6, lsr #3
  28:	0000a1fa 	strdeq	sl, [r0], -sl	; <UNPREDICTABLE>
  2c:	0000a206 	andeq	sl, r0, r6, lsl #4
  30:	0000a238 	andeq	sl, r0, r8, lsr r2
  34:	0000a262 	andeq	sl, r0, r2, ror #4
	...
  40:	00009d24 	andeq	r9, r0, r4, lsr #26
  44:	0000a28a 	andeq	sl, r0, sl, lsl #5
	...
  50:	0000a28c 	andeq	sl, r0, ip, lsl #5
  54:	0000a332 	andeq	sl, r0, r2, lsr r3
	...
  60:	0000a334 	andeq	sl, r0, r4, lsr r3
  64:	0000a3d2 	ldrdeq	sl, [r0], -r2
	...
  70:	0000a3d4 	ldrdeq	sl, [r0], -r4
  74:	0000a3d6 	ldrdeq	sl, [r0], -r6
  78:	0000a3d8 	ldrdeq	sl, [r0], -r8
  7c:	0000a3da 	ldrdeq	sl, [r0], -sl	; <UNPREDICTABLE>
	...
  88:	0000a40e 	andeq	sl, r0, lr, lsl #8
  8c:	0000a410 	andeq	sl, r0, r0, lsl r4
  90:	0000a412 	andeq	sl, r0, r2, lsl r4
  94:	0000a43a 	andeq	sl, r0, sl, lsr r4
	...
  a0:	0000a3dc 	ldrdeq	sl, [r0], -ip
  a4:	0000a3f6 	strdeq	sl, [r0], -r6
  a8:	0000a3f8 	strdeq	sl, [r0], -r8
  ac:	0000a488 	andeq	sl, r0, r8, lsl #9
	...
  b8:	0000a488 	andeq	sl, r0, r8, lsl #9
  bc:	0000a4ae 	andeq	sl, r0, lr, lsr #9
	...
  c8:	0000a4b0 			; <UNDEFINED> instruction: 0x0000a4b0
  cc:	0000a50e 	andeq	sl, r0, lr, lsl #10
	...
  d8:	0000a510 	andeq	sl, r0, r0, lsl r5
  dc:	0000a5b2 			; <UNDEFINED> instruction: 0x0000a5b2
  e0:	0000a5b4 			; <UNDEFINED> instruction: 0x0000a5b4
  e4:	0000a74c 	andeq	sl, r0, ip, asr #14
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
  28:	1a011803 	bne	4603c <__bss_end__+0x31ff4>
  2c:	1c031b01 	stcne	11, cr1, [r3], {1}
  30:	22011e01 	andcs	r1, r1, #1, 28
  34:	Address 0x0000000000000034 is out of bounds.

