#include <iostream>
#include <set>
#include <cstring>

std::set< std::pair<int, int> > S;

constexpr int dx[4] = { -1, 0, 1, 0 }, dy[4] = { 0, 1, 0, -1 };

int dir, x, y, n, m;

char map[100][100];

int main() {
    freopen("day22.txt", "r", stdin);
    while (std::cin >> map[n]) ++n;
    m = std::strlen(map[0]);
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < m; ++j)
            if (map[i][j] == '#') S.emplace(i, j);
    x = n >> 1; y = m >> 1; dir = 0;
    int ans = 0;
    for (int i = 0; i < 10000; ++i) {
        auto infected = S.find(std::make_pair(x, y));
        if (infected != S.end()) dir = (dir + 1) % 4, S.erase(infected);
        else dir = (dir + 3) % 4, S.emplace(x, y), ++ans;
        x += dx[dir], y += dy[dir];
    }
    std::cout << ans << std::endl;
    return 0;
}