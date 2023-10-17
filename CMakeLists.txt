cmake_minimum_required(VERSION 3.21)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(OUTech-2014-Low-Level LANGUAGES ASM C CXX)

include(FetchContent)

FetchContent_Declare(
  STM32CubeG4
  GIT_REPOSITORY https://github.com/STMicroelectronics/STM32CubeG4.git
  GIT_TAG v1.5.1
  CONFIGURE_COMMAND "" BUILD_COMMAND "")

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(HAL)

add_subdirectory(src/app EXCLUDE_FROM_ALL)
