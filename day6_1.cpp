#include <iostream>
#include "pystrlib.hpp"
#include <set>

std::vector<int> mem;
int n;
std::set< std::vector<int> > S;

inline int get(int i) { return i >= n ? i - n : i; }

int main() {
    freopen("day6.txt", "r", stdin);
    {
        std::string line; std::getline(std::cin, line);
        std::vector<std::string> vec = lib::split(line, "\t");
        for (const std::string &str : vec) mem.push_back(std::stoi(str));
    }
    n = mem.size(); S.insert(mem);
    while (1) {
        int mi = 0;
        for (int i = 1; i < n; ++i)
            if (mem[i] > mem[mi]) mi = i;
        int ed = mem[mi] / n, op = mem[mi] % n; mem[mi] = 0;
        for (int i = 1; i <= op; ++i) mem[get(mi + i)] += ed + 1;
        for (int i = op + 1; i <= n; ++i) mem[get(mi + i)] += ed;
        if (S.count(mem)) break;
        S.insert(mem);
    }
    std::cout << S.size() << std::endl;
    return 0;
}