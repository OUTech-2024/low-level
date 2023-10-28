#include <catch2/catch_test_macros.hpp>

TEST_CASE("Test A", "[a]") {
  SECTION("Section 1") { REQUIRE(true); }
}
