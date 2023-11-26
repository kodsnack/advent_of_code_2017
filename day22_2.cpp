#include <iostream>
#include <map>
#include <cstring>

std::map< std::pair<int, int>, int > S;

constexpr int dx[4] = { -1, 0, 1, 0 }, dy[4] = { 0, 1, 0, -1 }, dl[4] = { 3, 0, 1, 2 };

int dir, x, y, n, m;

char map[100][100];

int main() {
    freopen("day22.txt", "r", stdin);
    while (std::cin >> map[n]) ++n;
    m = std::strlen(map[0]);
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < m; ++j)
            if (map[i][j] == '#') S[std::make_pair(i, j)] = 2;
            else S[std::make_pair(i, j)] = 0;
    x = n >> 1; y = m >> 1; dir = 0;
    int ans = 0;
    for (int i = 0; i < 10000000; ++i) {
        auto infected = S.find(std::make_pair(x, y));
        int state = infected == S.end() ? 0 : infected->second;
        S[std::make_pair(x, y)] = (state + 1) % 4;
        dir = (dir + dl[state]) % 4; x += dx[dir]; y += dy[dir];
        if (state == 1) ++ans;
    }
    std::cout << ans << std::endl;
    return 0;
}