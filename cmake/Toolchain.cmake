set(CMAKE_SYSTEM_NAME Generic)
set(ARM_ARCH armv7e-m)
set(ARM_CPU cortex-m4)
set(ARM_FPU fpv4-sp-d16)
set(ARM_FLOAT_ABI hard)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

include(Toolchain/FetchArmGccToolchainInfo)

fetch_arm_gcc_toolchain_info(ARM_GCC_EXECUTABLE INCLUDE_DIRS)

set(COMPILER_INIT_FLAGS
    "--target=arm-none-eabi \
    -march=${ARM_ARCH} \
    -mcpu=${ARM_CPU} \
    -mfpu=${ARM_FPU} \
    -mfloat-abi=${ARM_FLOAT_ABI} \
    -mthumb \
    -fno-exceptions \
    -fshort-enums")

set(CMAKE_EXE_LINKER_FLAGS
    "-fuse-ld=${ARM_GCC_EXECUTABLE} \
    -Wl,--specs=nosys.specs \
    -Wl,-march=${ARM_ARCH} \
    -Wl,-mcpu=${ARM_CPU} \
    -Wl,-mfpu=${ARM_FPU} \
    -Wl,-mfloat-abi=${ARM_FLOAT_ABI} \
    -Wl,-mthumb \
    -Wl,-L${CMAKE_BINARY_DIR}")

set(CMAKE_ASM_COMPILER clang)
set(CMAKE_ASM_FLAGS_INIT "${COMPILER_INIT_FLAGS}")

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_FLAGS_INIT "${COMPILER_INIT_FLAGS}")
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${INCLUDE_DIRS})

set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_FLAGS_INIT "${COMPILER_INIT_FLAGS}")
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${INCLUDE_DIRS})
