#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#define CATCH_CONFIG_RUNNER
#include <catch.hpp>
#include <iterator>
#include <numeric>
#include <unordered_map>


// 37 36 35 34 33 32 31
// 38 17 16 15 14 13 30
// 39 18  5  4  3 12 29
// 40 19  6  1  2 11 28
// 41 20  7  8  9 10 27
// 42 21 22 23 24 25 26
// 43 44 45 46 47 48 49

// 36 35 34 33 32 31 30
// 37 16 15 14 13 12 29
// 38 17  4  3  2 11 28
// 39 18  5  0  1 10 27
// 40 19  6  7  8  9 26
// 41 20 21 22 23 24 25
// 42 43 44 45 46 47 48

// 0->3-> 5-> 7-> 9
// 1->9->25->49->81
// 1->2->11->28
int ring(int n)
{
    return sqrt(n-1)/2.0 + 0.5;
}

int ring_width(int n)
{
    return n*2+1;
}

int ring_end(int n)
{
    return (n*2+1)*(n*2+1);
}

int steps_across(int n)
{
    auto r = ring(n);
    auto e = ring_end(r);
    auto v = (e - n) % (ring_width(r) - 1) - ring_width(r) / 2;
    return abs(v);
}

int manhattan_distance(int n)
{
    return ring(n) + steps_across(n);
}

TEST_CASE("ring number for a position can be queried")
{
    REQUIRE(ring(1) == 0);
    REQUIRE(ring(2) == 1);
    REQUIRE(ring(3) == 1);
    REQUIRE(ring(4) == 1);
    REQUIRE(ring(5) == 1);
    REQUIRE(ring(6) == 1);
    REQUIRE(ring(7) == 1);
    REQUIRE(ring(8) == 1);
    REQUIRE(ring(9) == 1);
    REQUIRE(ring(10) == 2);
    REQUIRE(ring(22) == 2);
    REQUIRE(ring(25) == 2);
    REQUIRE(ring(26) == 3);
    REQUIRE(ring(49) == 3);
}

TEST_CASE("highest number in ring is sqr(n*2+1)")
{
    REQUIRE(ring_end(0) == 1);
    REQUIRE(ring_end(1) == 9);
    REQUIRE(ring_end(2) == 25);
    REQUIRE(ring_end(3) == 49);
}

TEST_CASE("steps across can be calculated")
{
    REQUIRE(steps_across(23) == 0);
    REQUIRE(steps_across(46) == 0);
    REQUIRE(steps_across(19) == 0);
    REQUIRE(steps_across(40) == 0);
    REQUIRE(steps_across(17) == 2);
    REQUIRE(steps_across(32) == 2);
}

TEST_CASE("manhattan distance can be calculated")
{
    REQUIRE(manhattan_distance(12) == 3);
    REQUIRE(manhattan_distance(23) == 2);
    REQUIRE(manhattan_distance(1024) == 31);
}

struct coordinate
{
    int x;
    int y;
    friend bool operator==(coordinate c1, coordinate c2)
    {
        return std::tie(c1.x, c1.y) ==
               std::tie(c2.x, c2.y);
    }
    friend bool operator!=(coordinate c1, coordinate c2)
    {
        return !(c1 == c2);
    }
    friend std::ostream& operator<<(std::ostream& os, const coordinate& c)
    {
        return os << '(' << c.x << ", " << c.y << ')';
    }
};

struct vector
{
    int dx;
    int dy;
    friend bool operator==(vector v1, vector v2)
    {
        return std::tie(v1.dx, v1.dy) ==
               std::tie(v2.dx, v2.dy);
    }
    friend bool operator!=(vector v1, vector v2)
    {
        return !operator==(v1,v2);
    }
    friend std::ostream& operator<<(std::ostream& os, const vector& v)
    {
        return os << '(' << v.dx << ", " << v.dy << ')';
    }
};

vector left_turn(vector v)
{
    return { -v.dy, v.dx };
}

coordinate operator+(coordinate pos, vector v)
{
    return { pos.x + v.dx, pos.y + v.dy};
}

coordinate operator+(vector v, coordinate pos)
{
    return pos + v;
}

class walker
{
public:
    walker(vector v_, coordinate origo = { 0, 0 })
            : v{v_}, pos{origo}
    {
    }
    coordinate walk()
    {
        pos = pos + v;
        return pos;
    }
    void set_velocity(vector v_)
    {
        v = v_;
    }
    coordinate left_coord() const
    {
        return pos + left_turn(v);
    }
    void turn_left()
    {
        v = left_turn(v);
    }
private:
    vector v;
    coordinate pos;
};

TEST_CASE("vector turn left gives expected resunlt")
{
    REQUIRE(left_turn({1,0}) == (vector{0,1}));
    REQUIRE(left_turn({0,1}) == (vector{-1,0}));
    REQUIRE(left_turn({-1,0}) == (vector{0,-1}));
    REQUIRE(left_turn({0,-1}) == (vector{1,0}));
}

TEST_CASE("coordinate plus vector gives another coordinate")
{
    REQUIRE((coordinate{3, 2}) + (vector{1,0}) == (coordinate{4,2}));
    REQUIRE((coordinate{3, 3}) + (vector{-1,-1}) == (coordinate{2,2}));
}

TEST_CASE("walk follows a straight line")
{
    walker v{{1,0}};
    REQUIRE(v.walk() == (coordinate{1,0}));
    REQUIRE(v.walk() == (coordinate{2,0}));
    REQUIRE(v.walk() == (coordinate{3,0}));
}

TEST_CASE("turn left changes direction")
{
    walker v{{1,0}};
    v.walk();
    v.turn_left();
    REQUIRE(v.walk() == (coordinate{1,1}));
    REQUIRE(v.walk() == (coordinate{1,2}));
    v.turn_left();
    REQUIRE(v.walk() == (coordinate{0,2}));
    REQUIRE(v.walk() == (coordinate{-1,2}));
    v.turn_left();
    REQUIRE(v.walk() == (coordinate{-1,1}));
    REQUIRE(v.walk() == (coordinate{-1,0}));
    v.turn_left();
    REQUIRE(v.walk() == (coordinate{0,0}));
}

TEST_CASE("left_coord works in all directions")
{
    walker v{{1,0}};
    v.walk(); // 1,0 R
    REQUIRE(v.left_coord() == (coordinate{1,1}));
    v.walk(); // 2,0 R
    REQUIRE(v.left_coord() == (coordinate{2,1}));
    v.turn_left(); // 2,0 U
    REQUIRE(v.left_coord() == (coordinate{1,0}));
    v.walk(); // 2,1 U
    REQUIRE(v.left_coord() == (coordinate{1,1}));
    v.turn_left(); // 2,1 L
    REQUIRE(v.left_coord() == (coordinate{2,0}));
    v.walk(); // 1,1 L
    REQUIRE(v.left_coord() == (coordinate{1,0}));
    v.turn_left(); // 1,1 D
    REQUIRE(v.left_coord() == (coordinate{2,1}));
    v.walk(); // 1,0 D
    REQUIRE(v.left_coord() == (coordinate{2,0}));
    v.turn_left(); // 1,0 R
    REQUIRE(v.left_coord() == (coordinate{1,1}));
    v.walk(); // 2,0 R
    REQUIRE(v.left_coord() == (coordinate{2,1}));
}
namespace std {
    template <>
    struct hash<coordinate>
    {
        size_t operator()(coordinate c) const noexcept
        {
            return hash<int>{} (c.x*1000 + c.y);
        }
    };
}
class storage
{
public:
    int sum_of_neighbours(coordinate c) const
    {
        int sum = 0;
        for (auto dx : { -1, 0, 1})
        {
            for (auto dy : { -1, 0, 1})
            {
                if (auto v = value_at(c + vector{dx, dy}))
                {
                    sum += *v;
                }
            }
        }
        return sum;
    }

    std::optional<int> value_at(coordinate c) const
    {
        std::optional<int> rv;
        if (auto i = data.find(c); i != data.end())
        {
            rv = i->second;
        }
        return rv;
    }
    int& operator[](coordinate c) { return data[c];}
private:
    std::unordered_map<coordinate, int> data;
};


int main(int argc, char *argv[])
{
    int result = Catch::Session().run( argc, argv );
    if (result == 0)
    {
        const int input = 347991;
        std::cout << "one=" << manhattan_distance(input) << '\n';
        storage s;
        s[coordinate{0,0}] = 1;
        walker w{vector{1,0}};
        for (;;)
        {
            auto pos = w.walk();
            auto sum = s.sum_of_neighbours(pos);
            s[pos] = sum;
            std::cout << pos << " => " << sum << '\n';
            if (sum > input)
            {
                std::cout << "two=" << sum << '\n';
                break;
            }
            if (!s.value_at(w.left_coord()))
            {
                w.turn_left();
            }
        }
    }
    return result;
}
