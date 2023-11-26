// se: (1, 0)
// ne: (0, 1)
// n: (-1, 1)
// nw: (-1, 0)
// sw: (0, -1)
// s: (1, -1)

// \|
// -s-
//  |\

#include <iostream>
#include "pystrlib.hpp"
#include <cmath>

constexpr int dx[6] = { 1, 0, -1, -1, 0, 1 }, dy[6] = { 0, 1, 1, 0, -1, -1 };
int x, y;

inline int get_d(const std::string &str) {
    if (str == "se") return 0;
    if (str == "ne") return 1;
    if (str == "n") return 2;
    if (str == "nw") return 3;
    if (str == "sw") return 4;
    if (str == "s") return 5;
    return -1;
}

int dist(int x, int y) { return (x * y >= 0) ? (std::abs(x) + std::abs(y)) : (std::max(std::abs(x), std::abs(y))); }

int main() {
    freopen("day11.txt", "r", stdin);
    int ans = 0;
    {
        std::string line; std::cin >> line;
        std::vector<std::string> steps = lib::split(line, ",");
        for (const std::string &str : steps) {
            int d = get_d(str);
            x += dx[d]; y += dy[d]; ans = std::max(ans, dist(x, y));
        }
    }
    std::cout << ans << std::endl;
    return 0;
}