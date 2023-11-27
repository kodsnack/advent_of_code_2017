#include <iostream>

int code[2000], n, pt, c;

int main() {
    freopen("day5.txt", "r", stdin);
    while (std::cin >> code[n]) ++n;
    while (pt < n) pt += code[pt]++, ++c;
    std::cout << c << std::endl;
    return 0;
}