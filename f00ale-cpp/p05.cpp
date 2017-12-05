#include <iostream>
#include <vector>

int main() {
    std::vector<int> v;
    while(1) {
        int tmp = 0;
        std::cin >> tmp;
        if(!std::cin.good()) break;
        v.push_back(tmp);
    }
    auto v2 = v;

    size_t i = 0;
    int ans1 = 0;
    while(i < v.size()) {
        auto ni = i + v[i];
        v[i]++;
        i = ni;
        ans1++;
    }
    std::cout << ans1 << std::endl;

    v = v2;
    int ans2 = 0;
    i = 0;
    while(i < v.size()) {
        auto ni = i + v[i];
        if(v[i] >= 3) v[i]--;
        else v[i]++;
        i = ni;
        ans2++;
    }

    std::cout << ans2 << std::endl;
}
