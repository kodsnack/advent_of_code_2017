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
#include <set>

template <typename R, typename P = std::less<>>
int find_target(const R& v, P predicate = P{})
{
    auto i = std::max_element(std::begin(v), std::end(v), predicate);
    return std::distance(std::begin(v), i);
}

template <typename T>
T distribute_numbers(T v, int idx)
{
    int pool = v[idx];
    v[idx] = 0;
    size_t i = 0;
    while (pool--)
    {
        v[(i + idx + 1) % v.size()]++;
        i++;
    }
    return v;
}

template <typename T>
std::pair<int,int> calc_redistributions(T v)
{
    std::map<T, int> previously_seen;
    int i = 0;
    int rv = 0;
    for (;;)
    {
        auto [iter, inserted] = previously_seen.insert({v,i});
        if (!inserted)
        {
            return {i, i-iter->second};
        }
        v = distribute_numbers(v, find_target(v));
        ++i;
    }
}

TEST_CASE("find_target finds the fist index with the largest number")
{
    REQUIRE(find_target(std::vector{2,3,5,1}) == 2);
    REQUIRE(find_target(std::vector{2,3,5,1,5}) == 2);
}

TEST_CASE("distribute_numbers zeroes the appointed cell, and smears its contents over the rest")
{
    REQUIRE(distribute_numbers(std::vector{0,2,7,0},2) == (std::vector{2,4,1,2}));
    REQUIRE(distribute_numbers(std::vector{2,4,1,2},1) == (std::vector{3,1,2,3}));
    REQUIRE(distribute_numbers(std::vector{3,1,2,3},0) == (std::vector{0,2,3,4}));
    REQUIRE(distribute_numbers(std::vector{0,2,3,4},3) == (std::vector{1,3,4,1}));
    REQUIRE(distribute_numbers(std::vector{1,3,4,1},2) == (std::vector{2,4,1,2}));
}

TEST_CASE("calc redistributions finds the number of distribute_numbers calls until a loop is found")
{
    REQUIRE(calc_redistributions(std::vector{0,2,7,0}).first == 5);
}
int main(int argc, char *argv[])
{
    int result = Catch::Session().run( argc, argv );
    if (result == 0)
    {
        std::vector<uint8_t> banks{4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3};
        auto [iter, delta] = calc_redistributions(banks);
        std::cout << "one=" <<  iter << '\n';
        std::cout << "two=" << delta << '\n';
    }
    return result;
}
