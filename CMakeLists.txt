
cmake_minimum_required( VERSION 2.8 )

project( kybOS C ASM)

#   Add any C compiler flags here. The C flags concerned with processor tuning
#   are in the toolchain files toolchain-arm-none-eabi-bcm2835.cmake, etc.
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O1" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostartfiles" )

#   Set the linker flags so that we use our "custom" linker script
set( CMAKE_EXE_LINKER_FLAGS "-Wl,-T,${PROJECT_SOURCE_DIR}/linker.ld" )

add_executable( kybOS
    main.c
    cstartup.c
    cstubs.c
    start.S
    armtimer.c
    armtimer.h
    base.h
    gpio.c
    gpio.h
    interrupts.c
    interrupts.h 
    uart.c
    uart.h
    control.c
    control.h
    prog1.c
    prog1.h
    pcb.c
    pcb.h
    threading.c
    threading.h
    dispatcher.c
    dispatcher.h )

add_custom_command(
    TARGET kybOS POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ./kybOS -O binary ./kernel.img
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Convert the ELF output file to a binary image" )
