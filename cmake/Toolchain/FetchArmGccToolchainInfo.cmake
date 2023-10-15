function(fetch_arm_gcc_toolchain_info RETVAL_INCLUDE_DIRS)
  find_program(ARM_GCC_EXECUTABLE arm-none-eabi-gcc REQUIRED)
  file(TOUCH ${CMAKE_BINARY_DIR}/empty_file)

  __fetch_arm_gcc_toolchain_include_dirs(${ARM_GCC_EXECUTABLE} INCLUDE_DIRS)
  set(${RETVAL_INCLUDE_DIRS}
      ${INCLUDE_DIRS}
      PARENT_SCOPE)
endfunction()

function(__fetch_arm_gcc_toolchain_include_dirs ARM_GCC_EXECUTABLE
         RETVAL_INCLUDE_DIRS)
  execute_process(
    COMMAND ${ARM_GCC_EXECUTABLE} -E -Wp,-v -
    INPUT_FILE ${CMAKE_BINARY_DIR}/empty_file
    OUTPUT_QUIET
    ERROR_VARIABLE SEARCH_LOG)

  set(PREAMBLE "#include <...> search starts here:")
  string(FIND "${SEARCH_LOG}" "${PREAMBLE}" INCLUDE_DIRS_LOG_BEGIN)

  set(EPILOGUE "End of search list.")
  string(FIND "${SEARCH_LOG}" "${EPILOGUE}" INCLUDE_DIRS_LOG_END)

  set(INCLUDE_DIRS_LOG "")
  string(SUBSTRING "${SEARCH_LOG}" "${INCLUDE_DIRS_LOG_BEGIN}" -1
                   INCLUDE_DIRS_LOG)
  string(SUBSTRING "${INCLUDE_DIRS_LOG}" 0 "${INCLUDE_DIRS_LOG_END}"
                   INCLUDE_DIRS_LOG)
  string(REPLACE "${PREAMBLE}" "" INCLUDE_DIRS_LOG "${INCLUDE_DIRS_LOG}")
  string(REPLACE "${EPILOGUE}" "" INCLUDE_DIRS_LOG "${INCLUDE_DIRS_LOG}")

  set(INCLUDE_DIRS "")
  string(REGEX REPLACE "[ \t\r\n]+" ";" INCLUDE_DIRS "${INCLUDE_DIRS_LOG}")

  set(${RETVAL_INCLUDE_DIRS}
      ${INCLUDE_DIRS}
      PARENT_SCOPE)
endfunction()
