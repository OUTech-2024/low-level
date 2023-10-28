add_executable(app main.cpp)
target_link_libraries(app PRIVATE stm32g431kb::tim)
set_target_properties(app PROPERTIES EXPORT_COMPILE_COMMANDS ON)
