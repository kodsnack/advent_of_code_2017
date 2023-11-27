#include <iostream>
#include "pystrlib.hpp"
#include <algorithm>

std::string str;

int n = 16;

inline void rotate_left(int r) {
    r %= n; (r < 0) && (r += n); (r >= n) && (r -= n);
    str = str.substr(n - r) + str.substr(0, n - r);
}

inline void swap(int a, int b) { std::swap(str[a], str[b]); }
inline int index(char ch) { return str.find(ch); }

int main() {
    freopen("day16.txt", "r", stdin);
    for (int i = 0; i < n; ++i) str += 'a' + i;
    {
        std::string line;
        std::cin >> line;
        std::vector<std::string> op = lib::split(line, ",");
        for (const std::string &str : op)
            if (str[0] == 's') rotate_left(std::stoi(str.substr(1)));
            else if (str[0] == 'x') {
                auto [x, _, y] = lib::partition(str.substr(1), "/");
                swap(std::stoi(x), std::stoi(y));
            } else if (str[0] == 'p') swap(index(str[1]), index(str[3]));
    }
    std::cout << str << std::endl;
    return 0;
}