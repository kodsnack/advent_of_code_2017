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

class rope {
public:
    rope(size_t length) : data(length){ std::iota(std::begin(data), std::end(data), 0);}
    int& operator[](size_t n)
    {
        return data[n % data.size()];
    }
    int operator[](size_t n) const
    {
        return data[n % data.size()];
    }
    bool operator==(std::vector<int> list)
    {
        return std::equal(std::begin(data), std::end(data),
                          std::begin(list), std::end(list));
    }
    friend std::ostream& operator<<(std::ostream& os, const rope& r)
    {
        os << "{";
        const char* separator = " ";
        for (auto i : r.data)
        {
            os << separator << i;
            separator = ", ";
        }
        return os << " }";
    }
private:
    std::vector<int> data;
};

template <typename T>
void reverse(T& r, size_t b, size_t length)
{
    while (length > 1)
    {
        std::swap(r[b], r[b + length - 1]);
        b+= 1;
        length -= 2;
    }
}

class hash
{
public:
    rope& tie(rope& r, size_t length)
    {
        reverse(r, cursor, length);
        cursor += length + skip;
        ++skip;
        return r;
    }
private:
    size_t cursor = 0;
    size_t skip = 0;
};

rope& hash_sequence(rope& r, std::vector<int> key, int times = 1)
{
    hash h;
    while (times--)
    {
        for (auto i : key) h.tie(r, i);
    }
    return r;
}

std::vector<int> salted_key(const std::string& s)
{
    std::vector<int> rv(std::begin(s), std::end(s));
    for (auto i : { 17, 31, 73, 47, 23})
        rv.push_back(i);
    return rv;

}


std::vector<int> make_dense(const rope& r)
{
    std::vector<int> rv(16);
    for (size_t i = 0; i < 16; ++i)
    {
        for (size_t j = 0; j < 16; ++j)
        {
            rv[i] ^= r[i*16+j];
        }
    }
    return rv;
}

std::string to_string(const std::vector<int>& v)
{
    std::ostringstream os;
    for (auto i : v) os << std::hex << std::setw(2) << std::setfill('0') << i;
    return os.str();
}

TEST_CASE("example know does the right thing")
{
    rope r(5);
    hash h;
    REQUIRE(h.tie(r, 3) == (std::vector{2,1,0,3,4}));
    REQUIRE(h.tie(r, 4) == (std::vector{4,3,0,1,2}));
    REQUIRE(h.tie(r, 1) == (std::vector{4,3,0,1,2}));
    REQUIRE(h.tie(r, 5) == (std::vector{3,4,2,1,0}));
}

TEST_CASE("hash_sequence does it all in one go")
{
    rope r(5);
    REQUIRE(hash_sequence(r, {3,4,1,5}) == (std::vector{3,4,2,1,0}));
}

TEST_CASE("salted_key works from example string")
{
    REQUIRE(salted_key("1,2,3") == (std::vector{49,44,50,44,51,17,31,73,47,23}));
}

TEST_CASE("foo")
{

    {
        rope r(256);
        REQUIRE(to_string(make_dense(hash_sequence(r, salted_key(""), 64))) == "a2582a3a0e66e6e86e3812dcb672a272");
    }
    {
        rope r(256);
        REQUIRE(to_string(make_dense(hash_sequence(r, salted_key("AoC 2017"), 64))) == "33efeb34ea91902bb2f59c9920caa6cd");
    }
    {
        rope r(256);
        REQUIRE(to_string(make_dense(hash_sequence(r, salted_key("1,2,3"), 64))) == "3efbe78a8d82f29979031a4aa0b16a9d");
    }
    {
        rope r(256);
        REQUIRE(to_string(make_dense(hash_sequence(r, salted_key("1,2,4"), 64))) == "63960835bcdc130f0b66d7ff4f6a5a8e");
    }
}
int main(int argc, char *argv[])
{
    int result = Catch::Session().run( argc, argv );
    if (result == 0)
    {
        {
            std::vector key{83, 0, 193, 1, 254, 237, 187, 40, 88, 27, 2, 255, 149, 29, 42, 100};
            rope r(256);
            hash_sequence(r, key);
            std::cout << "one=" << r[0] * r[1] << '\n';
        }
        {
            rope r(256);
            std::cout << "two=" << to_string(make_dense(hash_sequence(r, salted_key("83,0,193,1,254,237,187,40,88,27,2,255,149,29,42,100"), 64))) << '\n';
        }
    }
    return result;
}
