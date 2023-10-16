FetchContent_MakeAvailable(STM32CubeG4)

include(CMSIS)

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
set(STM32G431KB_LINKER_SCRIPT
    ${stm32cubeg4_SOURCE_DIR}/Projects/NUCLEO-G431KB/Templates/STM32CubeIDE/STM32G431KBTX_FLASH.ld
)

function(
  add_stm32_targets
  LIB_PREFIX
  DRIVER_NAMES
  FAMILY
  TARGET_COMPILE_DEF
  LINKER_SCRIPT
  DRIVER_SOURCE_DIR
  DRIVER_INCLUDE_DIR
  CMSIS_SYSTEM_FILE
  CMSIS_INCLUDE_DIR)
  __add_stm32_hal(${LIB_PREFIX}-hal ${FAMILY} ${TARGET_COMPILE_DEF}
                  ${LIB_PREFIX} ${DRIVER_SOURCE_DIR} ${DRIVER_INCLUDE_DIR})
  add_library(${LIB_PREFIX}::hal ALIAS ${LIB_PREFIX}-hal)

  __add_cmsis_driver(${LIB_PREFIX}-cmsis ${FAMILY} ${TARGET_COMPILE_DEF}
                     ${LIB_PREFIX} ${CMSIS_SYSTEM_FILE} ${CMSIS_INCLUDE_DIR})
  add_library(${LIB_PREFIX}::cmsis ALIAS ${LIB_PREFIX}-cmsis)

  foreach(DRIVER_NAME IN LISTS DRIVER_NAMES)
    __add_stm32_driver(
      ${LIB_PREFIX}-${DRIVER_NAME}
      ${DRIVER_NAME}
      ${FAMILY}
      ${TARGET_COMPILE_DEF}
      ${LIB_PREFIX}
      ${DRIVER_SOURCE_DIR}
      ${DRIVER_INCLUDE_DIR})
    add_library(${LIB_PREFIX}::${DRIVER_NAME} ALIAS
                ${LIB_PREFIX}-${DRIVER_NAME})
  endforeach()
endfunction()

function(link_stm32g4_targets LIB_PREFIX)
  target_link_libraries(${LIB_PREFIX}-tim PRIVATE ${LIB_PREFIX}-dma
                                                  ${LIB_PREFIX}-hal)
  target_link_libraries(
    ${LIB_PREFIX}-hal PRIVATE ${LIB_PREFIX}-cmsis ${LIB_PREFIX}-cortex
                              ${LIB_PREFIX}-flash ${LIB_PREFIX}-rcc)
  target_link_libraries(${LIB_PREFIX}-rcc PRIVATE ${LIB_PREFIX}-gpio
                                                  ${LIB_PREFIX}-pwr)
endfunction()

function(
  __add_stm32_driver
  LIB_NAME
  DRIVER_NAME
  FAMILY
  TARGET_COMPILE_DEF
  LINKER_SCRIPT
  DRIVER_SOURCE_DIR
  DRIVER_INCLUDE_DIR)
  string(TOUPPER ${DRIVER_NAME} UPPER_DRIVER_NAME)

  add_library(${LIB_NAME} ${DRIVER_SOURCE_DIR}/${FAMILY}_hal_${DRIVER_NAME}.c)

  set(EXTENSION_SOURCE_FILE
      ${DRIVER_SOURCE_DIR}/${FAMILY}_hal_${DRIVER_NAME}_ex.c)
  if(EXISTS ${EXTENSION_SOURCE_FILE})
    target_sources(${LIB_NAME} PRIVATE ${EXTENSION_SOURCE_FILE})
  endif()

  target_link_libraries(${LIB_NAME} PUBLIC CMSIS)
  target_include_directories(${LIB_NAME} PUBLIC ${DRIVER_INCLUDE_DIR}
                                                ${PROJECT_SOURCE_DIR}/src/hal)
  set_target_properties(${LIB_NAME} PROPERTIES EXPORT_COMPILE_COMMANDS OFF)
  target_compile_definitions(
    ${LIB_NAME} PUBLIC HAL_${UPPER_DRIVER_NAME}_MODULE_ENABLED
                       ${TARGET_COMPILE_DEF})
endfunction()

function(
  __add_stm32_hal
  LIB_NAME
  FAMILY
  TARGET_COMPILE_DEF
  LINKER_SCRIPT
  DRIVER_SOURCE_DIR
  DRIVER_INCLUDE_DIR)
  add_library(${LIB_NAME} ${DRIVER_SOURCE_DIR}/${FAMILY}_hal.c)

  target_link_libraries(${LIB_NAME} PUBLIC CMSIS)
  target_include_directories(${LIB_NAME} PUBLIC ${DRIVER_INCLUDE_DIR}
                                                ${PROJECT_SOURCE_DIR}/src/hal)
  set_target_properties(${LIB_NAME} PROPERTIES EXPORT_COMPILE_COMMANDS OFF)
  target_compile_definitions(${LIB_NAME} PUBLIC HAL_MODULE_ENABLED
                                                ${TARGET_COMPILE_DEF})
endfunction()

function(
  __add_cmsis_driver
  LIB_NAME
  FAMILY
  TARGET_COMPILE_DEF
  LINKER_SCRIPT
  SYSTEM_FILE
  INCLUDE_DIR)
  add_library(${LIB_NAME} ${SYSTEM_FILE})

  target_link_libraries(${LIB_NAME} PUBLIC CMSIS)
  target_include_directories(${LIB_NAME} PUBLIC ${INCLUDE_DIR})
  set_target_properties(${LIB_NAME} PROPERTIES EXPORT_COMPILE_COMMANDS OFF)
  target_compile_definitions(${LIB_NAME} PUBLIC ${TARGET_COMPILE_DEF})
endfunction()

add_stm32_targets(
  stm32g431kb
  "${STM32G4_DRIVER_NAMES}"
  stm32g4xx
  STM32G431xx
  ${STM32G431KB_LINKER_SCRIPT}
  ${STM32G4_DRIVER_SOURCE_DIR}
  ${STM32G4_DRIVER_INCLUDE_DIR}
  ${CMSIS_STM32G4_SYSTEM_FILE}
  ${CMSIS_STM32G4_INCLUDE_DIR})
link_stm32g4_targets(stm32g431kb)
