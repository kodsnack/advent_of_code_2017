#include <iostream>
#include <vector>
#include <algorithm>
#include <bitset>

namespace hash {

std::vector<int> list, len;
int n = 256, skip_size, position;

inline void rotate_left(int r) {
    r %= n; if (r < 0) r += n;
    list.insert(list.end(), list.begin(), list.begin() + r);
    list.erase(list.begin(), list.begin() + r);
}

void round() {
    for (int i : len) {
        std::reverse(list.begin(), list.begin() + i);
        rotate_left(i + skip_size); position += i + skip_size++;
    }
}

std::bitset<128> hash(const std::string &str) {
    list.clear(); len.clear(); skip_size = 0; position = 0;
    for (int i = 0; i < n; ++i) list.push_back(i);
    {
        for (char q : str)
            len.push_back(q);
        len.push_back(17);
        len.push_back(31);
        len.push_back(73);
        len.push_back(47);
        len.push_back(23);
    }
    for (int i = 0; i < 64; ++i)
        round();
    rotate_left(-position);
    std::bitset<128> final;
    for (int i = 0; i < 256; i += 16) {
        int s = 0, p = i >> 1;
        for (int j = i; j < i + 16; ++j)
            s ^= list[j];
        for (int j = p + 7; j >= p; --j)
            final[j] = s & 1, s >>= 1;
    }
    return final;
}

}

std::string key;
int ans;

int main() {
    std::cin >> key; key += "-";
    for (int i = 0; i < 128; ++i)
        ans += hash::hash(key + std::to_string(i)).count();
    std::cout << ans << std::endl;
    return 0;
}