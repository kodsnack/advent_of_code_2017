#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

int main() {
    std::vector<int> v;
    std::map<std::vector<int>, int> s;
    while(1) {
        int i;
        std::cin >> i;
        if(!std::cin.good()) break;
        v.push_back(i);
    }

    int ans1 = 0;

    while(1) {
        if(s[v]) break;
        ans1++;
        s[v] = ans1;
        auto it = std::max_element(std::begin(v), std::end(v));
        auto tmp = *it;
        *it = 0;
        for(decltype(tmp) i = 0; i < tmp; i++) {
            it++;
            if(it == v.end()) it = v.begin();
            (*it)++;
        }
    }

    int ans2 = ans1 - s[v] + 1;

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
