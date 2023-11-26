#include <iostream>
#include "pystrlib.hpp"
#include <algorithm>
#include <iomanip>

std::vector<int> list, len;
int n = 256, skip_size, position;

inline void rotate_left(int r) {
    r %= n; if (r < 0) r += n;
    list.insert(list.end(), list.begin(), list.begin() + r);
    list.erase(list.begin(), list.begin() + r);
}

void round() {
    for (int i : len) {
        std::reverse(list.begin(), list.begin() + i);
        rotate_left(i + skip_size); position += i + skip_size++;
    }
}

int main() {
    freopen("day10.txt", "r", stdin);
    for (int i = 0; i < n; ++i) list.push_back(i);
    {
        std::string line;
        std::getline(std::cin, line);
        for (char q : line)
            len.push_back(q);
        len.push_back(17);
        len.push_back(31);
        len.push_back(73);
        len.push_back(47);
        len.push_back(23);
    }
    for (int i = 0; i < 64; ++i)
        round();
    rotate_left(-position);
    for (int i = 0; i < 256; i += 16) {
        int s = 0;
        for (int j = i; j < i + 16; ++j)
            s ^= list[j];
        std::cout << std::hex << std::setw(2) << std::setfill('0') << s;
    }
    std::cout << std::endl;
    return 0;
}