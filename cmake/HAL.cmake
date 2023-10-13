FetchContent_MakeAvailable(STM32CubeG4)

include(CMSIS)

set(STM32G4_DRIVER_SOURCE_DIR ${stm32cubeg4_SOURCE_DIR}/Drivers/STM32G4xx_HAL_Driver/Src)
set(STM32G4_DRIVER_INCLUDE_DIR ${stm32cubeg4_SOURCE_DIR}/Drivers/STM32G4xx_HAL_Driver/Inc)
set(STM32G431KB_LINKER_SCRIPT ${stm32cubeg4_SOURCE_DIR}/Projects/NUCLEO-G431KB/Templates/STM32CubeIDE/STM32G431KBTX_FLASH.ld)

function(add_stm32_target LIB_NAME COMPILE_DEF LINKER_SCRIPT)
    add_library(${LIB_NAME} INTERFACE)
    add_compile_definitions(${LIB_NAME} PUBLIC ${COMPILE_DEF})
    set_target_properties(${LIB_NAME} PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})
endfunction()

function(add_stm32g4_driver LIB_NAME DRIVER_NAME)
    add_library(stm32g4-${LIB_NAME}
        ${STM32G4_DRIVER_SOURCE_DIR}/stm32g4xx_hal_${DRIVER_NAME}.c
        ${STM32G4_DRIVER_SOURCE_DIR}/stm32g4xx_ll_${DRIVER_NAME}.c)
    target_link_libraries(stm32g4-${LIB_NAME} PUBLIC CMSIS)
    target_include_directories(stm32g4-${LIB_NAME}
        PUBLIC ${STM32G4_DRIVER_INCLUDE_DIR} ${PROJECT_SOURCE_DIR}/src/hal)

    add_library(stm32g4::${LIB_NAME} ALIAS stm32g4-${LIB_NAME})
endfunction()

add_stm32_target(stm32g431kb STM32G431xx ${STM32G431KB_LINKER_SCRIPT})

add_stm32g4_driver(timer tim)

