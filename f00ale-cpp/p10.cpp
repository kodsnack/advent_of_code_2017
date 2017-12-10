#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <string>

constexpr int len = 256;

int main() {
    int ans1 = 0;
    std::string ans2;

    std::vector<int> input;
    std::vector<int> input2;
    int tmp = 0;
    bool have_num = false;
    while(1) {
        char c;
        std::cin.get(c);
        if(!std::cin.good()) break;
        if(c == '\n') continue;
        input2.push_back((int)c);
        if(c >= '0' && c <= '9') {
            tmp *= 10;
            tmp += c - '0';
            have_num = true;
        } else if(have_num) {
            input.push_back(tmp);
            tmp = 0;
            have_num = false;
        }
    }

    input2.push_back(17);
    input2.push_back(31);
    input2.push_back(73);
    input2.push_back(47);
    input2.push_back(23);

    if(have_num) input.push_back(tmp);

    std::vector<int> data(len);
    for(int i = 0; i < len; i++) data[i] = i;

    int pos = 0;
    int skip = 0;
    for(auto i : input) {
        auto c = data;
        for(int p = 0; p < i; p++){
            auto f = (pos+i-p-1) % len;
            auto t = (pos+p) % len;
            if(f < 0) f+=len;
            if(t < 0) t+= len;
            data[t] = c[f];
        }
        pos += i + skip;
        skip++;
    }

    ans1 = data[0]*data[1];

    for(int i = 0; i < len; i++) data[i] = i;

    pos = 0;
    skip = 0;
    for(int round = 0; round < 64; round++) {
        for (auto i : input2) {
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

    std::vector<int> dense(16);
    for(int i = 0; i < len; i++) {
        dense[i/16] ^= data[i];
    }

    for(auto c : dense) {
        auto to_hex = [](int i) {
            if(i < 10) return '0'+i;
            else return 'a'+i-10;
        };
        ans2.push_back(to_hex(c/16));
        ans2.push_back(to_hex(c%16));
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
