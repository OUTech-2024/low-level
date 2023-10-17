function(add_stm32_common LIB_NAME TARGET_DEF LINKER_SCRIPT CMSIS_TARGET)
  add_library(${LIB_NAME} ${PROJECT_SOURCE_DIR}/src/hal/dummy.c)
  target_link_libraries(${LIB_NAME} PRIVATE ${CMSIS_TARGET})
  target_compile_definitions(${LIB_NAME} PUBLIC ${TARGET_DEF})
  target_include_directories(
    ${LIB_NAME}
    PUBLIC ${STM32G4_DRIVER_INCLUDE_DIR} ${PROJECT_SOURCE_DIR}/src/hal
           $<TARGET_PROPERTY:${CMSIS_TARGET},INTERFACE_INCLUDE_DIRECTORIES>)
  set_target_properties(${LIB_NAME} PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})
endfunction()

function(
  add_stm32_hals
  LIB_PREFIX
  COMMON_TARGET
  DRIVER_NAMES
  FAMILY
  DRIVER_SOURCE_DIR
  DRIVER_INCLUDE_DIR)
  __add_stm32_hal(${LIB_PREFIX}-hal ${DRIVER_SOURCE_DIR} ${FAMILY}
                  ${COMMON_TARGET})
  add_library(${LIB_PREFIX}::hal ALIAS ${LIB_PREFIX}-hal)

  foreach(DRIVER_NAME IN LISTS DRIVER_NAMES)
    __add_stm32_driver(${LIB_PREFIX}-${DRIVER_NAME} ${DRIVER_SOURCE_DIR}
                       ${FAMILY} ${DRIVER_NAME} ${COMMON_TARGET})
    add_library(${LIB_PREFIX}::${DRIVER_NAME} ALIAS
                ${LIB_PREFIX}-${DRIVER_NAME})
  endforeach()
endfunction()

function(__add_stm32_hal LIB_NAME DRIVER_SOURCE_DIR FAMILY COMMON_TARGET)
  add_library(${LIB_NAME} ${DRIVER_SOURCE_DIR}/${FAMILY}_hal.c)
  target_link_libraries(${LIB_NAME} PUBLIC ${COMMON_TARGET})
  set_target_properties(${LIB_NAME} PROPERTIES EXPORT_COMPILE_COMMANDS OFF)
  target_compile_definitions(${LIB_NAME} PUBLIC HAL_MODULE_ENABLED)
endfunction()

function(__add_stm32_driver LIB_NAME DRIVER_SOURCE_DIR FAMILY DRIVER_NAME
         COMMON_TARGET)
  string(TOUPPER ${DRIVER_NAME} UPPER_DRIVER_NAME)

  add_library(${LIB_NAME} ${DRIVER_SOURCE_DIR}/${FAMILY}_hal_${DRIVER_NAME}.c)

  set(EXTENSION_SOURCE_FILE
      ${DRIVER_SOURCE_DIR}/${FAMILY}_hal_${DRIVER_NAME}_ex.c)
  if(EXISTS ${EXTENSION_SOURCE_FILE})
    target_sources(${LIB_NAME} PRIVATE ${EXTENSION_SOURCE_FILE})
  endif()

  target_link_libraries(${LIB_NAME} PUBLIC ${COMMON_TARGET})
  set_target_properties(${LIB_NAME} PROPERTIES EXPORT_COMPILE_COMMANDS OFF)
  target_compile_definitions(${LIB_NAME}
                             PUBLIC HAL_${UPPER_DRIVER_NAME}_MODULE_ENABLED)
endfunction()
