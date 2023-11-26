#include <iostream>
#include "pystrlib.hpp"

struct QuadraticFunc {
    int a, b, c;
    QuadraticFunc operator+(const QuadraticFunc &rhs) const { return (QuadraticFunc) { a + rhs.a, b + rhs.b, c + rhs.c }; }
    QuadraticFunc operator*(int rhs) const { return (QuadraticFunc) { a * rhs, b * rhs, c * rhs }; }
    bool operator<(const QuadraticFunc &rhs) const { return (a == rhs.a) ? ((b == rhs.b) ? (c < rhs.c) : (b < rhs.b)) : (a < rhs.a); }
};

struct Component {
    int a, v, x;
    QuadraticFunc get_dist_func() const { return ((QuadraticFunc) { a, 2 * v + a, 2 * x }) * ((a > 0 || (a == 0 && v >= 0)) ? 1 : -1); }
};

struct Particle {
    Component x, y, z;
    QuadraticFunc get_dist_func() const { return x.get_dist_func() + y.get_dist_func() + z.get_dist_func(); }
};

std::vector<Particle> particles;
std::vector<int> pos;

int main() {
    freopen("day20.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            std::vector<std::string> vec = lib::split(line, ", ");
            std::vector<std::string> vp = lib::split(vec[0].substr(3, vec[0].size() - 4), ","),
                                     vv = lib::split(vec[1].substr(3, vec[1].size() - 4), ","),
                                     va = lib::split(vec[2].substr(3, vec[2].size() - 4), ",");
            particles.push_back((Particle) {
                (Component) { std::stoi(va[0]), std::stoi(vv[0]), std::stoi(vp[0]) },
                (Component) { std::stoi(va[1]), std::stoi(vv[1]), std::stoi(vp[1]) },
                (Component) { std::stoi(va[2]), std::stoi(vv[2]), std::stoi(vp[2]) }
            });
        }
    }
    for (unsigned i = 0; i < particles.size(); ++i) pos.push_back(i);
    std::sort(pos.begin(), pos.end(), [](int p1, int p2) { return particles[p1].get_dist_func() < particles[p2].get_dist_func(); });
    std::cout << pos[0] << std::endl;
    return 0;
}