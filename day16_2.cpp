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

int to[16], vis[16], from[16];
std::vector<std::string> op;

void do_round() {
    for (const std::string &str : op)
        if (str[0] == 's') rotate_left(std::stoi(str.substr(1)));
        else if (str[0] == 'x') {
            auto [x, _, y] = lib::partition(str.substr(1), "/");
            swap(std::stoi(x), std::stoi(y));
        } else if (str[0] == 'p') swap(index(str[1]), index(str[3]));
}

int main() {
    freopen("day16.txt", "r", stdin);
    for (int i = 0; i < n; ++i) str += 'a' + i;
    {
        std::string line;
        std::cin >> line;
        op = std::move(lib::split(line, ","));
    }
    std::vector<std::string> states;
    states.push_back(str);
    do do_round(), states.push_back(str); while (states.back() != states.front());
    states.pop_back();
    std::cout << states.size() << ' ' << states[1000000000 % states.size()] << std::endl;
    return 0;
}

// Do some research
