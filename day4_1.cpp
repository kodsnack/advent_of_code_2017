#include <iostream>
#include "pystrlib.hpp"

int ans;

int main() {
    freopen("day4.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            std::vector<std::string> vec = lib::split(line, " ");
            std::sort(vec.begin(), vec.end());
            ans += std::unique(vec.begin(), vec.end()) == vec.end();
        }
    }
    std::cout << ans << std::endl;
    return 0;
}