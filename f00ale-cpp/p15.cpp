#include <iostream>

int main() {
    int ans1 = 0;
    int ans2 = 0;
    uint64_t a = 0;
    uint64_t b = 0;
    {
        bool done = false;
        bool innum = false;
        int num = 0;
        bool havea = false;
        while (!done) {
            char c;
            std::cin.get(c);
            if (!std::cin.good()) {
                done = true;
                c = '\n';
            }
            if (c >= '0' && c <= '9') {
                num *= 10;
                num += c - '0';
                innum = true;
            } else {
                if(innum) {
                    if (havea) b = num;
                    else {
                        a = num;
                        havea = true;
                    }
                }
                num = 0;
                innum = false;
            }
        }
    }

    auto a1 = a;
    auto b1 = b;

    for(int i = 0; i < 40000000; i++) {
        a1 *= 16807;
        b1 *= 48271;
        a1 %= 2147483647;
        b1 %= 2147483647;
        if((a1 & 0xffff) == (b1 & 0xffff)) ans1++;
    }

    auto a2 = a;
    auto b2 = b;

    for(int i = 0; i < 5000000; i++) {
        do {
            a2 *= 16807;
            a2 %= 2147483647;
        } while(a2 & 3);
        do {
            b2 *= 48271;
            b2 %= 2147483647;
        } while(b2 & 7);
        if((a2 & 0xffff) == (b2 & 0xffff)) ans2++;
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;

}
