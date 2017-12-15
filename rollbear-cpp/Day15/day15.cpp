#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#define CATCH_CONFIG_RUNNER
#include <catch.hpp>
#include <iterator>
#include <algorithm>
#include <functional>
#include <map>
#include <set>
#include <numeric>
#include <complex>

template <uint32_t factor>
class generator
{
public:
  generator(uint32_t seed, uint32_t m = 0) : prev{seed}, mask{m} {}
  uint32_t next()
  {
    do {
      prev = prev * factor % 2147483647;
    } while ((prev & mask) != 0);
    return prev;
  }
private:
  uint64_t prev;
  const uint32_t mask;
};

using A = generator<16807>;
using B = generator<48271>;

int match_count(A& a, B& b, int ceiling = 40'000'000)
{
  int count = 0;
  for (int i = 0; i < ceiling; ++i)
  {
    if ((a.next() & 0xffff) == (b.next() & 0xffff))
    {
      ++count;
    }
  }
  return count;
}

TEST_CASE("generator sequences")
{
  A a{65};
  B b{8921};

  REQUIRE(a.next() ==    1092455); REQUIRE(b.next() ==  430625591);
  REQUIRE(a.next() == 1181022009); REQUIRE(b.next() == 1233683848);
  REQUIRE(a.next() ==  245556042); REQUIRE(b.next() == 1431495498);
  REQUIRE(a.next() == 1744312007); REQUIRE(b.next() ==  137874439);
  REQUIRE(a.next() == 1352636452); REQUIRE(b.next() ==  285222916);
}

TEST_CASE("masked generators")
{
  A a{65, 0x3};
  B b{8921, 0x7};

  REQUIRE(a.next() == 1352636452); REQUIRE(b.next() == 1233683848);
  REQUIRE(a.next() == 1992081072); REQUIRE(b.next() ==  862516352);
  REQUIRE(a.next() ==  530830436); REQUIRE(b.next() == 1159784568);
  REQUIRE(a.next() == 1980017072); REQUIRE(b.next() == 1616057672);
  REQUIRE(a.next() ==  740335192); REQUIRE(b.next() ==  412269392);
}

int main(int argc, char *argv[])
{
    int result = Catch::Session().run( argc, argv );
    if (result == 0)
    {
      {
        A a{883};
        B b{879};
        std::cout<< "one=" << match_count(a,b) << '\n';
      }
      {
        A a{883, 0x3};
        B b{879, 0x7};
        std::cout<< "two=" << match_count(a,b, 5'000'000) << '\n';
      }
    }
    return result;
}
