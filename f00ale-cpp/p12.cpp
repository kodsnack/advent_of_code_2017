#include <iostream>
#include <vector>
#include <map>
#include <set>

int main() {
    int ans1 = 0;
    int ans2 = 0;

    std::map<int, std::set<int>> m;

    {
        int index = 0;
        bool got_index = false;
        int num = 0;
        bool got_num = false;
        bool done = false;
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
                    if (got_index) {
                        m[index].insert(num);
                    } else {
                        got_index = true;
                        index = num;
                    }
                }
                if (c == '\n') {
                    index = 0;
                    got_index = false;
                }
                num = 0;
                got_num = false;
            }
        }
    }
    
    for(auto & p : m) {
        bool done = false;
        while(!done) {
            auto s = p.second;
            done = true;
            for(auto i : p.second) {
                if(i == p.first) continue;
                if(!m[i].empty()) {
                    done = false;
                    s.insert(m[i].begin(), m[i].end());
                    m[i].clear();
                }
            }
            p.second = s;
        }
    }

    ans1 = m[0].size();
    for(auto & p : m) {
        if(!p.second.empty()) ans2++;
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
