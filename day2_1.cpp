#include <iostream>
#include "pystrlib.hpp"

int ans;

int main() {
    std::string line;
    while (std::getline(std::cin, line)) {
        std::vector<std::string> vec = lib::split(line, "\t");
        int maxv = std::stoi(vec[0]), minv = maxv;
        for (const std::string &str : vec) {
            int v = std::stoi(str);
            if (v < minv) minv = v;
            if (v > maxv) maxv = v;
        }
        ans += maxv - minv;
    }
    std::cout << ans << std::endl;
    return 0;
}