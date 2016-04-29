
cmake_minimum_required( VERSION 2.8 )

project( kybOS C ASM)

#   Add any C compiler flags here. The C flags concerned with processor tuning
#   are in the toolchain files toolchain-arm-none-eabi-bcm2835.cmake, etc.
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O1" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostartfiles" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall" )
#set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostdlib" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffreestanding" )



#   Set the linker flags so that we use our "custom" linker script
set( CMAKE_EXE_LINKER_FLAGS "-Wl,-T,${PROJECT_SOURCE_DIR}/linker.ld" )

add_library( kybOS
    cstartup.c
    cstubs.c
    start.S
    ipc.c
    ipc.h)
