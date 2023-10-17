include(CMSIS)
include(HAL/Common)
include(HAL/G4)

add_stm32_common(stm32g431kb-common STM32G431xx ${STM32G431KB_LINKER_SCRIPT}
                 cmsis-stm32g4)

add_stm32g4_hals(stm32g431kb stm32g431kb-common "${STM32G4_DRIVER_NAMES}")
