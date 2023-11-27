#include <iostream>

int a[505][505], x = 250, y = 250, n;

inline int sum(int x, int y) { return a[x - 1][y - 1] + a[x - 1][y] + a[x - 1][y + 1] + a[x][y - 1] + a[x][y] + a[x][y + 1] + a[x + 1][y - 1] + a[x + 1][y] + a[x + 1][y + 1]; }

int main() {
    std::cin >> n;
    a[x][y] = 1;
    for (int len = 2; ; len += 2) {
        ++x; a[x][y] = sum(x, y);
        for (int i = 1; i < len; ++i) {
            ++y; a[x][y] = sum(x, y);
            if (a[x][y] > n) { std::cout << a[x][y] << std::endl; return 0; }
        }
        for (int i = 0; i < len; ++i) {
            --x; a[x][y] = sum(x, y);
            if (a[x][y] > n) { std::cout << a[x][y] << std::endl; return 0; }
        }
        for (int i = 0; i < len; ++i) {
            --y; a[x][y] = sum(x, y);
            if (a[x][y] > n) { std::cout << a[x][y] << std::endl; return 0; }
        }
        for (int i = 0; i < len; ++i) {
            ++x; a[x][y] = sum(x, y);
            if (a[x][y] > n) { std::cout << a[x][y] << std::endl; return 0; }
        }
    }
}