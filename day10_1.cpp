#include <iostream>
#include "pystrlib.hpp"
#include <algorithm>

std::vector<int> list;
int n = 256, skip_size, position;

inline void rotate_left(int r) {
    r %= n; if (r < 0) r += n;
    list.insert(list.end(), list.begin(), list.begin() + r);
    list.erase(list.begin(), list.begin() + r);
}

int main() {
    freopen("day10.txt", "r", stdin);
    for (int i = 0; i < n; ++i) list.push_back(i);
    {
        std::string line;
        std::cin >> line;
        for (const std::string &q : lib::split(line, ",")) {
            int len = std::stoi(q);
            std::reverse(list.begin(), list.begin() + len);
            rotate_left(len + skip_size); position += len + skip_size++;
        }
    }
    rotate_left(-position);
    std::cout << list[0] * list[1] << std::endl;
    return 0;
}