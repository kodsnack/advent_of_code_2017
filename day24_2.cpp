#include <iostream>
#include "pystrlib.hpp"

int p1[100], p2[100], n, u[100], ans, len;

void dfs(int s, int v, int c) {
    if ((c == len && s > ans) || c > len) ans = s, len = c;
    for (int i = 0; i < n; ++i) {
        if (p1[i] == v && !u[i]) u[i] = 1, dfs(s + p1[i] + p2[i], p2[i], c + 1), u[i] = 0;
        if (p2[i] == v && !u[i]) u[i] = 1, dfs(s + p1[i] + p2[i], p1[i], c + 1), u[i] = 0;
    }
}

int main() {
    freopen("day24.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            auto [f, _, t] = lib::partition(line, "/");
            p1[n] = std::stoi(f); p2[n++] = std::stoi(t);
        }
    }
    dfs(0, 0, 0);
    std::cout << ans << std::endl;
    return 0;
}