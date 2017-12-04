#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

int main() {
    std::vector<std::vector<std::string>> v(1);
    std::string tmp;
    while(1) {
        char c = 0;
        std::cin.get(c);
        if(!std::cin.good()) break;
        if(c >= 'a' && c <= 'z') tmp.push_back(c);
        else {
            if(!tmp.empty()) {
                v.back().push_back(tmp);
                tmp.clear();
            }
            if (c == '\n' && !v.back().empty()) v.push_back(std::vector<std::string>());
        }
    }
    if(v.back().empty()) v.pop_back();

    int ans1 = 0, ans2 = 0;
    for(auto pp : v) { // copies
        std::sort(std::begin(pp), std::end(pp));
        if(std::adjacent_find(std::begin(pp), std::end(pp)) == std::end(pp)) {
            ans1++;
            for(auto & w : pp) std::sort(std::begin(w), std::end(w));
            std::sort(std::begin(pp), std::end(pp));
            if(std::adjacent_find(std::begin(pp), std::end(pp)) == std::end(pp)) ans2++;
        }
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
