FetchContent_MakeAvailable(STM32CubeG4)

set(CMSIS_INCLUDE_DIR ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Include)
set(CMSIS_STM32G4_INCLUDE_DIR
    ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32G4xx/Include)
set(CMSIS_STM32G4_SOURCE_DIR
    ${stm32cubeg4_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32G4xx/Source)
set(CMSIS_STM32G4_SYSTEM_FILE
    ${CMSIS_STM32G4_SOURCE_DIR}/Templates/system_stm32g4xx.c)

add_library(cmsis-common INTERFACE)
target_include_directories(cmsis-common INTERFACE ${CMSIS_INCLUDE_DIR})

add_library(cmsis-stm32g4 INTERFACE)
target_link_libraries(cmsis-stm32g4 INTERFACE cmsis-common)
target_include_directories(cmsis-stm32g4 INTERFACE ${CMSIS_STM32G4_INCLUDE_DIR})
target_sources(cmsis-stm32g4 INTERFACE ${CMSIS_STM32G4_SYSTEM_FILE})
