#include <stm32g4xx_hal.h> // IWYU pragma: keep
#include <stm32g4xx_hal_tim.h>

int main() {
  HAL_TIM_Encoder_Init(nullptr, nullptr);

  return 0;
}
