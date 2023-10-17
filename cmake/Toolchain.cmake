list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

include(Toolchain/FetchArmGccToolchainInfo)

set(COMPILER_INIT_FLAGS
    "--target=arm-none-eabi \
    -march=armv7e-m \
    -mcpu=cortex-m4 \
    -mfpu=fpv4-sp-d16 \
    -mfloat-abi=hard \
    -mthumb \
    -fno-exceptions \
    -nostdlib")

fetch_arm_gcc_toolchain_info(INCLUDE_DIRS)

set(CMAKE_ASM_COMPILER clang)
set(CMAKE_ASM_FLAGS_INIT "${COMPILER_INIT_FLAGS}")

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_FLAGS_INIT "${COMPILER_INIT_FLAGS}")
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${INCLUDE_DIRS})

set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_FLAGS_INIT "${COMPILER_INIT_FLAGS}")
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${INCLUDE_DIRS})
