#include <iostream>
#include <vector>
#include <tuple>

int main() {
    int ans1 = 0;
    int ans2 = 0;
    std::vector<std::tuple<int,int>> v;
    {
        bool done = false;
        int num = 0;
        bool got_num = false;
        bool got_depth = false;
        int depth = 0;
        int range = 0;
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
                got_num = true;
            } else {
                if (got_num) {
                    if (!got_depth) {
                        depth = num;
                        got_depth = true;
                    } else {
                        range = num;
                    }
                }
                if (c == '\n' && got_num) {
                    v.emplace_back(depth, 2*(range-1));
                    got_depth = false;
                }
                num = 0;
                got_num = false;
            }
        }
    }

    for(const auto & i : v) {
        auto [d, p] = i;
        if(d % p == 0) ans1 += d * (p/2 + 1);
    }

    bool done = (ans1 == 0);
    while(!done) {
        ans2++;
        done = true;
        for(const auto & i : v) {
            if((std::get<0>(i)+ans2) % std::get<1>(i) == 0) { 
                done = false;
                break;
            }
        }
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;

}
