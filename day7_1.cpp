#include <iostream>
#include "pystrlib.hpp"
#include <unordered_map>

struct edge { int to, nxt; } G[2005];
int cnt, head[2005], wei[2005], indgr[2005];

std::unordered_map<std::string, int> mapping;
std::string back[2005];

int cm;

inline int get_order(const std::string &str) {
    if (mapping.count(str)) return mapping[str];
    back[++cm] = str; return mapping[str] = cm;
}
inline void add_edge(int f, int t) { G[++cnt] = (edge) { t, head[f] }; head[f] = cnt; ++indgr[t]; }

int main() {
    freopen("day7.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            auto [f, _, t] = lib::partition(line, " -> ");
            auto [n, __, w] = lib::partition(f, " (");
            int i = get_order(n);
            wei[i] = std::stoi(w);
            if (t != "") {
                std::vector<std::string> to = lib::split(t, ", ");
                for (const std::string &s : to) add_edge(i, get_order(s));
            }
        }
    }
    for (int i = 1; i <= cm; ++i)
        if (!indgr[i]) std::cout << back[i] << std::endl;
    return 0;
}