#pragma once

#define TICK_INT_PRIORITY 0
#define HSE_STARTUP_TIMEOUT 100UL
#define LSE_STARTUP_TIMEOUT 5000UL

#define assert_param(...)

#include <stm32g4xx_hal_def.h>
#include <stm32g4xx_hal_cortex.h>
#include <stm32g4xx_hal_flash.h>
#include <stm32g4xx_hal_gpio.h>
#include <stm32g4xx_hal_rcc.h>
#include <stm32g4xx_hal_pwr.h>
#include <stm32g4xx_ll_rcc.h>
#include <stm32g4xx_hal_dma.h>
#include <stm32g4xx_hal_tim.h>
