#include <iostream>
#include <cstring>

char map[300][300];
int n, m, x, y, dir, c;

constexpr int dx[4] = { 0, 1, 0, -1 }, dy[4] = { 1, 0, -1, 0 };
// RDLU

inline bool in_range(int x, int y) { return 0 <= x && x < n && 0 <= y && y < m; }

int main() {
    freopen("day19.txt", "r", stdin);
    while (std::cin.getline(map[n], 299)) ++n;
    m = std::strlen(map[0]);
    for (int i = 0; i < m; ++i)
        if (map[0][i] != ' ') { dir = 1; x = 0; y = i; break; }
    while (1) {
        x += dx[dir]; y += dy[dir]; ++c;
        if (!in_range(x, y) || map[x][y] == ' ') break;
        if (map[x][y] == '+') {
            if (dir & 1)
                if (in_range(x + dx[0], y + dy[0]) && map[x + dx[0]][y + dy[0]] != ' ') dir = 0;
                else dir = 2;
            else
                if (in_range(x + dx[1], y + dy[1]) && map[x + dx[1]][y + dy[1]] != ' ') dir = 1;
                else dir = 3;
        }
    }
    std::cout << c << std::endl;
    return 0;
}