cmake_minimum_required(VERSION 3.21)

project(OUTech-2014-Low-Level LANGUAGES C CXX)

include(FetchContent)

FetchContent_Declare(STM32CubeG4
                   GIT_REPOSITORY https://github.com/STMicroelectronics/STM32CubeG4.git
                   GIT_TAG v1.5.1
                   CONFIGURE_COMMAND ""
                   BUILD_COMMAND "")
FetchContent_MakeAvailable(STM32CubeG4)

add_library(CMSIS INTERFACE)
target_include_directories(CMSIS INTERFACE ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Include
    ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32G4xx/Include/)


set(STM32CubeG4_DRIVER_SOURCE_FILES stm32g4xx_hal.c)
set(STM32CubeG4_DRIVER_SOURCE_DIR ${stm32cubeg4_SOURCE_DIR}/Drivers/STM32G4xx_HAL_Driver/Src)
list(TRANSFORM STM32CubeG4_DRIVER_SOURCE_FILES PREPEND ${STM32CubeG4_DRIVER_SOURCE_DIR}/)

add_library(STM32CubeG4 ${STM32CubeG4_DRIVER_SOURCE_FILES})
target_link_libraries(STM32CubeG4 PRIVATE CMSIS)
target_include_directories(STM32CubeG4 PUBLIC ${stm32cubeg4_SOURCE_DIR}/Drivers/STM32G4xx_HAL_Driver/Inc src/)
set(STM32CubeG4_LINKER_SCRIPT ${stm32cubeg4_SOURCE_DIR}/Projects/NUCLEO-G431KB/Templates/STM32CubeIDE/STM32G431KBTX_FLASH.ld)
add_executable(app src/main.cpp)
add_compile_definitions(STM32G431xx)
target_link_libraries(app PRIVATE STM32CubeG4)
set_target_properties(app PROPERTIES LINK_DEPENDS ${STM32CubeG4_LINKER_SCRIPT})
