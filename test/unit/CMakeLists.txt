FetchContent_MakeAvailable(Catch2)
FetchContent_MakeAvailable(FakeIt)

include(Catch)

target_compile_definitions(Catch2 PUBLIC CATCH_CONFIG_NO_POSIX_SIGNALS)

function(add_unit_test TEST_NAME TEST_FILE)
  add_executable(${TEST_NAME} main.cpp ${TEST_FILE})
  target_link_libraries(${TEST_NAME} PRIVATE Catch2::Catch2WithMain
                                             FakeIt::FakeIt-catch)
  add_dependencies(check ${TEST_NAME})
  set_target_properties(${TEST_NAME} PROPERTIES EXPORT_COMPILE_COMMANDS ON)

  if(NOT CMAKE_CROSSCOMPILING)
    catch_discover_tests(${TEST_NAME} PROPERTIES LABELS check)
  endif()
endfunction()

if(CMAKE_CROSSCOMPILING)
  add_custom_target(check)
else()
  add_custom_target(check COMMAND ctest -L check --output-on-failure)
endif()

add_unit_test(my_test my_test.cpp)
