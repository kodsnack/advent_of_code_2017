#include <iostream>
#include "pystrlib.hpp"
#include <unordered_map>
#include <cstdlib>

struct edge { int to, nxt; } G[2005];
int cnt, head[2005], wei[2005], indgr[2005], root, sum[2005];

std::unordered_map<std::string, int> mapping;
std::string back[2005];

int cm;

inline int get_order(const std::string &str) {
    if (mapping.count(str)) return mapping[str];
    back[++cm] = str; return mapping[str] = cm;
}
inline void add_edge(int f, int t) { G[++cnt] = (edge) { t, head[f] }; head[f] = cnt; ++indgr[t]; }

void dfs(int u) {
    sum[u] = wei[u];
    for (int i = head[u]; i; i = G[i].nxt) dfs(G[i].to), sum[u] += sum[G[i].to];
    std::vector< std::pair<int, int> > to_v;
    for (int i = head[u]; i; i = G[i].nxt) to_v.emplace_back(sum[G[i].to], G[i].to);
    std::sort(to_v.begin(), to_v.end());
    if (to_v.size() && to_v[0].first != to_v.back().first) {
        if (to_v[1].first == to_v[0].first) std::cout << wei[to_v.back().second] - (to_v.back().first - to_v[0].first) << std::endl;
        else std::cout << wei[to_v[0].second] - (to_v.back().first - to_v[0].first) << std::endl;
        std::exit(0);
    }
}

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
        if (!indgr[i]) root = i;
    dfs(root);
    return 0;
}