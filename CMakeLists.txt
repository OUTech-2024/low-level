cmake_minimum_required(VERSION 3.21)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(OUTech-2014-Low-Level LANGUAGES ASM C CXX)

include(FetchContent)

FetchContent_Declare(
  STM32CubeG4
  GIT_REPOSITORY https://github.com/STMicroelectronics/STM32CubeG4.git
  GIT_TAG v1.5.1
  CONFIGURE_COMMAND "" BUILD_COMMAND "")

FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2
  GIT_TAG v3.4.0)

FetchContent_Declare(
  FakeIt
  GIT_REPOSITORY https://github.com/eranpeer/FakeIt
  GIT_TAG 2.4.0)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake
     ${catch2_SOURCE_DIR}/extras)
include(HAL)

add_subdirectory(src/app EXCLUDE_FROM_ALL)
add_subdirectory(test/unit EXCLUDE_FROM_ALL)
