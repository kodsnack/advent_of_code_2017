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

using Firewall = std::vector<int>;

Firewall configure_firewall(std::vector<std::string> v)
{
    Firewall rv;
    for (auto s : v)
    {
        char c;
        size_t layer;
        int depth;
        std::stringstream is{s};
        is >> layer >> c >> depth;
        if (rv.size() <= layer)
        {
            rv.resize(layer+1);
        }
        rv[layer] = depth;
    }
    return rv;
}

bool caught_at(int time_ps, const Firewall& fw, int delay = 0)
{
    auto v = fw[time_ps];
    return v > 0 && (time_ps + delay) % (v*2-2) == 0;
}

int fw_strength(const Firewall& fw, int delay = 0)
{
    auto rv = 0;
    for (size_t i = 0; i < fw.size(); ++i)
    {
        if (caught_at(i, fw, delay))
        {
            rv += (i + delay) * fw[i];
        }
    }
    return rv;
}

int min_delay(const Firewall& fw)
{
    int delay = 0;
    for (;;)
    {
        if (fw_strength(fw, delay) == 0) break;
        ++delay;
    }
    return  delay;
}
TEST_CASE("a firefwall can be configures from a list of value pairs")
{
    std::vector<std::string> conf{
            "0: 3",
            "1: 2",
            "4: 4",
            "6: 4"
    };
    auto fw = configure_firewall(conf);
    REQUIRE(fw[0] == 3);
    REQUIRE(fw[1] == 2);
    REQUIRE(fw[2] == 0);
    REQUIRE(fw[3] == 0);
    REQUIRE(fw[4] == 4);
    REQUIRE(fw[5] == 0);
    REQUIRE(fw[6] == 4);
}

TEST_CASE("you're caught when time equals fw layer at 0")
{
    Firewall fw{3,2,0,0, 4,0, 4};
    REQUIRE(caught_at(0,fw));
    REQUIRE(!caught_at(1,fw));
    REQUIRE(!caught_at(2,fw));
    REQUIRE(!caught_at(3,fw));
    REQUIRE(!caught_at(4,fw));
    REQUIRE(!caught_at(5,fw));
    REQUIRE(caught_at(6,fw));
}

TEST_CASE("fw strength is calculated from example")
{
    REQUIRE(fw_strength({3, 2, 0, 0, 4, 0, 4}) == 24);
}

TEST_CASE("delayed strength can be calculated")
{
    Firewall fw{3, 2, 0, 0, 4, 0, 4};
    REQUIRE(fw_strength(fw, 0) > 0);
    REQUIRE(fw_strength(fw, 1) > 0);
    REQUIRE(fw_strength(fw, 2) > 0);
    REQUIRE(fw_strength(fw, 3) > 0);
    REQUIRE(fw_strength(fw, 4) > 0);
    REQUIRE(fw_strength(fw, 5) > 0);
    REQUIRE(fw_strength(fw, 6) > 0);
    REQUIRE(fw_strength(fw, 7) > 0);
    REQUIRE(fw_strength(fw, 8) > 0);
    REQUIRE(fw_strength(fw, 9) > 0);
    REQUIRE(fw_strength(fw, 10) == 0);
}

TEST_CASE("min delay for example is 10")
{
    Firewall fw{3, 2, 0, 0, 4, 0, 4};
    REQUIRE(min_delay(fw) == 10);
}
int main(int argc, char *argv[])
{
    int result = Catch::Session().run( argc, argv );
    if (result == 0)
    {
        std::vector<std::string> conf{
                "0: 3",
                "1: 2",
                "2: 5",
                "4: 4",
                "6: 4",
                "8: 6",
                "10: 6",
                "12: 6",
                "14: 8",
                "16: 6",
                "18: 8",
                "20: 8",
                "22: 8",
                "24: 12",
                "26: 8",
                "28: 12",
                "30: 8",
                "32: 12",
                "34: 12",
                "36: 14",
                "38: 10",
                "40: 12",
                "42: 14",
                "44: 10",
                "46: 14",
                "48: 12",
                "50: 14",
                "52: 12",
                "54: 9",
                "56: 14",
                "58: 12",
                "60: 12",
                "64: 14",
                "66: 12",
                "70: 14",
                "76: 20",
                "78: 17",
                "80: 14",
                "84: 14",
                "86: 14",
                "88: 18",
                "90: 20",
                "92: 14",
                "98: 18"
        };
        auto fw = configure_firewall(conf);
        std::cout << "one=" << fw_strength(fw) << '\n';
        std::cout << "two=" << min_delay(fw) << '\n';
    }
    return result;
}
