FetchContent_MakeAvailable(STM32CubeG4)

set(CMSIS_INCLUDE_DIR ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Include)
set(CMSIS_STM32G4_INCLUDE_DIR
    ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32G4xx/Include)

add_library(CMSIS INTERFACE)
target_include_directories(CMSIS INTERFACE ${CMSIS_INCLUDE_DIR}
                                           ${CMSIS_STM32G4_INCLUDE_DIR})
