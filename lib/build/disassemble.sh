#!/bin/sh

arm-none-eabi-objdump -D ./libkybOS.a > ./libkybOS.asm
arm-none-eabi-nm ./libkybOS.a > ./libkybOS.nm
