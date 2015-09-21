include(CMakeForceCompiler)
#   to use:
#   cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm-none-eabi.cmake ../

#    generic for no OS
set( CMAKE_SYSTEM_NAME          Generic )
set( CMAKE_SYSTEM_PROCESSOR     BCM2836 )

#   Set a toolchain path. You only need to set this if the toolchain isn't in
#   your system path. Don't forget a trailing path separator!
set( TC_PATH "" )

set( CROSS_COMPILE arm-none-eabi- )

CMAKE_FORCE_C_COMPILER( ${TC_PATH}${CROSS_COMPILE}gcc GNU )

set( CMAKE_OBJCOPY      ${TC_PATH}${CROSS_COMPILE}objcopy
    CACHE FILEPATH "The toolchain objcopy command " FORCE )

#   Set the CMAKE C flags
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=neon-vfpv4" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=hard" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv7-a" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mtune=cortex-a7" )
#set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
set( CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
