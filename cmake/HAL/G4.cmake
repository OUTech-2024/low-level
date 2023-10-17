FetchContent_MakeAvailable(STM32CubeG4)

include(HAL/Common)

set(STM32G4_DRIVER_NAMES
    cortex
    dma
    flash
    gpio
    pwr
    rcc
    tim)
set(STM32G4_DRIVER_SOURCE_DIR
    ${stm32cubeg4_SOURCE_DIR}/Drivers/STM32G4xx_HAL_Driver/Src)
set(STM32G4_DRIVER_INCLUDE_DIR
    ${stm32cubeg4_SOURCE_DIR}/Drivers/STM32G4xx_HAL_Driver/Inc)
set(STM32G431KB_TEMPLATE_DIR
    ${stm32cubeg4_SOURCE_DIR}/Projects/NUCLEO-G431KB/Templates/STM32CubeIDE)
set(STM32G431KB_LINKER_SCRIPT
    ${STM32G431KB_TEMPLATE_DIR}/STM32G431KBTX_FLASH.ld)

function(add_stm32g4_hals LIB_PREFIX COMMON_TARGET DRIVER_NAMES)
  add_stm32_hals(${LIB_PREFIX} ${COMMON_TARGET} "${DRIVER_NAMES}" stm32g4xx
                 ${STM32G4_DRIVER_SOURCE_DIR} ${STM32G4_DRIVER_INCLUDE_DIR})
  __link_stm32g4_hal(${LIB_PREFIX})
endfunction()

function(__link_stm32g4_hal LIB_PREFIX)
  target_link_libraries(${LIB_PREFIX}-tim PRIVATE ${LIB_PREFIX}-dma
                                                  ${LIB_PREFIX}-hal)
  target_link_libraries(
    ${LIB_PREFIX}-hal PRIVATE ${LIB_PREFIX}-cortex ${LIB_PREFIX}-flash
                              ${LIB_PREFIX}-rcc)
  target_link_libraries(${LIB_PREFIX}-rcc PRIVATE ${LIB_PREFIX}-gpio
                                                  ${LIB_PREFIX}-pwr)
endfunction()
