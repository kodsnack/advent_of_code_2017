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

std::string knot_hash(const std::string& key)
{
    rope r{256};
    return to_string(make_dense(hash_sequence(r, salted_key(key), 64)));
}


int hexval(char c)
{
  return c > '9' ? c - 'a' + 10 : c - '0';
}

int one_bits_in_hex_string(const std::string& s)
{
    static int ones[] = {
      0, // 0
      1, // 1
      1, // 2
      2, // 3
      1, // 4
      2, // 5
      2, // 6
      3, // 7
      1, // 8
      2, // 9
      2, // 10
      3, // 11
      2, // 12
      3, // 13
      3, // 14
      4, // 15
    };
    auto acc_bits = [](int prev, char c) { return prev + ones[hexval(c)];};
    return std::accumulate(std::begin(s), std::end(s), 0, acc_bits);
}


int ones_in_grid(const std::string& key)
{
  int sum = 0;
  for (int i = 0; i < 128; ++i)
  {
    std::ostringstream os;
    os << key << "-" << i;
    auto k = os.str();
    auto h = knot_hash(k);
    sum += one_bits_in_hex_string(h);
  }
  return sum;
}

std::vector<std::string> populate_grid(const std::string& key)
{
  std::vector<std::string> rv;
  for (int i = 0; i < 128; ++i)
  {
    std::ostringstream os;
    os << key << "-" << i;
    rv.push_back(knot_hash(os.str()));
  }
  return rv;
}
bool is_one(const std::vector<std::string>& grid, int x, int y)
{
  auto& s = grid[y];
  return hexval(s[x / 4]) & (1 << (3-(x & 0x3)));
}


void mark_group_visited(const std::vector<std::string> &vector, int x, int y, std::map<std::pair<int, int>, bool>& visited)
{
  if (x < 0 || x > 127) return;
  if (y < 0 || y > 127) return;
  if (!visited[{x,y}] && is_one(vector, x, y))
  {
    visited[{x,y}] = true;
    mark_group_visited(vector, x + 1, y, visited);
    mark_group_visited(vector, x - 1, y, visited);
    mark_group_visited(vector, x, y + 1, visited);
    mark_group_visited(vector, x, y - 1, visited);
  }

}

int count_groups(const std::vector<std::string>& grid)
{
  int groups=0;
  std::map<std::pair<int,int>, bool> visited;
  for (int y = 0; y < (int)grid.size(); ++y)
  {
    auto& s= grid[y];
    for (int x = 0; x < (int)grid[y].length()*4; ++x)
    {
      bool found = is_one(grid, x, y);
      if (found && !visited[{x, y}])
      {
        ++groups;
        mark_group_visited(grid, x, y, visited);
      }
    }
  }
  return groups;
}


TEST_CASE("calculate ones")
{
  REQUIRE(one_bits_in_hex_string("00001100ff") == 10);
}

TEST_CASE("ones in grid in example")
{
  REQUIRE(ones_in_grid("flqrgnkx") == 8108);
}

TEST_CASE("is_one")
{
  std::vector<std::string> grid{"0010","8000","ffff","0001"};
  REQUIRE(!is_one(grid, 0,0));
  REQUIRE(is_one(grid, 11,0));
  REQUIRE(is_one(grid,15,3));
}

TEST_CASE("count_ones")
{
  std::vector<std::string> grid{
    "0000",
    "1010",
    "1010",
    "0000"
  };
  REQUIRE(count_groups(grid) == 2);
}

int main(int argc, char *argv[])
{
    int result = Catch::Session().run( argc, argv );
    if (result == 0)
    {
      std::string key{"oundnydw"};
      std::cout << "one=" << ones_in_grid(key) << '\n';
      std::cout << "two=" << count_groups(populate_grid(key)) << '\n';
    }
    return result;
}
