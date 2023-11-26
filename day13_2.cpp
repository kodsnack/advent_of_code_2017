#include <iostream>
#include "pystrlib.hpp"
#include <utility>

std::vector< std::pair<int, int> > wall;

bool pass(int x) {
    for (const auto &[d, r] : wall)
        if (!((x + d) % r)) return false;
    return true;
}

int main() {
    freopen("day13.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            auto [D, _, R] = lib::partition(line, ": ");
            wall.emplace_back(std::stoi(D), (std::stoi(R) - 1) << 1);
        }
    }
    for (int i = 0; ; ++i)
        if (pass(i)) { std::cout << i << std::endl; return 0; }
}