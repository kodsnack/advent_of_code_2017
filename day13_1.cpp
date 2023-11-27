#include <iostream>
#include "pystrlib.hpp"
#include <utility>

int main() {
    freopen("day13.txt", "r", stdin);
    int ans = 0;
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            auto [D, _, R] = lib::partition(line, ": ");
            int d = std::stoi(D), r = std::stoi(R);
            !(d % ((r - 1) << 1)) && (ans += d * r);
        }
    }
    std::cout << ans << std::endl;
    return 0;
}