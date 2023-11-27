#include <iostream>
#include <random>

std::minstd_rand0 A;
std::minstd_rand B;

int n = 5000000, ans;

int main() {
    int a, b;
    std::cin >> a >> b;
    A.seed(a); B.seed(b);
    for (; n; --n) {
        int a = A(); while (a & 3) a = A();
        int b = B(); while (b & 7) b = B();
        if ((a & 65535) == (b & 65535)) ++ans;
    }
    std::cout << ans << std::endl;
    return 0;
}