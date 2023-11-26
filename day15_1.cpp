#include <iostream>
#include <random>

std::minstd_rand0 A;
std::minstd_rand B;

int n = 40000000, ans;

int main() {
    int a, b;
    std::cin >> a >> b;
    A.seed(a); B.seed(b);
    for (; n; --n)
        if ((A() & 65535) == (B() & 65535)) ++ans;
    std::cout << ans << std::endl;
    return 0;
}