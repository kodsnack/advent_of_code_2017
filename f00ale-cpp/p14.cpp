#include <iostream>
#include <vector>
#include <tuple>
#include <map>
#include <set>
#include <array>
#include <sstream>
#include <deque>

constexpr int len = 256;

std::array<int, 16> knothash(std::string input) {
    std::vector<int> data(len);
    for(int i = 0; i < len; i++) data[i] = i;

    input.push_back(17);
    input.push_back(31);
    input.push_back(73);
    input.push_back(47);
    input.push_back(23);

    int pos = 0;
    int skip = 0;
    for(int round = 0; round < 64; round++) {
        for (auto i : input) {
            auto c = data;
            for (int p = 0; p < i; p++) {
                auto f = (pos + i - p - 1) % len;
                auto t = (pos + p) % len;
                if (f < 0) f += len;
                if (t < 0) t += len;
                data[t] = c[f];
            }
            pos += i + skip;
            skip++;
        }
    }

    std::array<int, 16> dense;
    for(auto & c : dense) c = 0;

    for(int i = 0; i < len; i++) {
        dense[i/16] ^= data[i];
    }
    return dense;
}

int main() {
    int ans1 = 0;
    int ans2 = 0;

    std::string key;

    {
        bool done = false;
        while (!done) {
            char c;
            std::cin.get(c);
            if (!std::cin.good()) {
                done = true;
                c = '\n';
            }
            if (c >= 'a' && c <= 'z') {
                key.push_back(c);
            }
        }
    }
    std::array<std::array<bool, 128>, 128> a1;
    for(auto & r : a1) for(auto & c : r) c = false;

    for(int i = 0; i < 128; i++) {
        std::ostringstream tmp;
        tmp << key << "-" << i;
        auto hash = knothash(tmp.str());
        int col = 0;
        for(auto c : hash) {
            for(int x = 7; x >= 0; x--) {
                if(c & (1<<x)) {
                    a1[i][col] = true;
                } else {
                    a1[i][col] = false;
                }
                col++;
            }
        }
    }

    std::array<std::array<int, 128>, 128> a2;
    for(auto & r : a2) for(auto & c : r) c = 0;

    for(int y = 0; y < 128; y++) {
        for(int x = 0; x < 128; x++) {
            if(a1[y][x] && !a2[y][x]) {
                ans2++;
                std::deque<std::tuple<int,int>> q{ { y, x } };
                while(!q.empty()) {
                    auto [r, c] = q.front();
                    q.pop_front();
                    if(a1[r][c] && !a2[r][c]) {
                        a2[r][c] = ans2;
                        if(r > 0) q.emplace_back(r-1, c);
                        if(c > 0) q.emplace_back(r, c-1);
                        if(r < 127) q.emplace_back(r+1, c);
                        if(c < 127) q.emplace_back(r, c+1);
                    }
                }
            }
        }
    }
    for(auto r : a1) for(auto c : r) if(c) ans1++;

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;

}
