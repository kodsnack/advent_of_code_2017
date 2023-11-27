#include <iostream>
#include "pystrlib.hpp"

int ans;

int main() {
    std::string line;
    while (std::getline(std::cin, line)) {
        std::vector<std::string> vec = lib::split(line, "\t");
        std::vector<int> a;
        for (const std::string &str : vec) a.push_back(std::stoi(str));
        for (unsigned i = 0; i < a.size(); ++i)
            for (unsigned j = 0; j < a.size(); ++j)
                if (i != j && a[i] % a[j] == 0) ans += a[i] / a[j];
    }
    std::cout << ans << std::endl;
    return 0;
}