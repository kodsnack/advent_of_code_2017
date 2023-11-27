#include <iostream>
#include <cmath>

int n, x, y;

int main() {
    std::cin >> n;
    int s = ((int) std::ceil(std::sqrt(n))) | 1;
    int os = s & -2, v = s * s - n, hs = os >> 1;
    if (v < os) x = hs - v, y = -hs;
    else if (v < 2 * os) x = -hs, y = -hs + (v - os);
    else if (v < 3 * os) x = -hs + (v - 2 * os), y = hs;
    else if (v < 4 * os) x = hs, y = hs - (v - 3 * os);
    std::cout << std::abs(x) + std::abs(y) << std::endl;
    return 0;
}