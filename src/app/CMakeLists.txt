add_executable(app main.cpp)
target_link_libraries(app PRIVATE stm32g431kb::tim)
