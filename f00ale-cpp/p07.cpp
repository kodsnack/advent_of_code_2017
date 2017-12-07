#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <map>

struct item {
    item() : weight{0}, totw{0} {}
    int weight;
    int totw;
    std::string name;
    std::string parent;
    std::vector<std::string> children;
};

enum class State { name, num, chld };

std::string find_diff_node(std::map<std::string, item> & m, std::string r) {
    if(m[r].children.empty()) return r;

    std::map<int, int> weights;
    for(auto c : m[r].children) {
        weights[m[c].totw]++;
    }
    if(weights.size() < 2) return r;

    int cnt = 0;

    for(auto w : weights) {
        if(w.second == 1) cnt = w.first;
    }

    for(auto c : m[r].children) {
        if(m[c].totw == cnt) return find_diff_node(m, c);
    }
    return "";
}

int main() {
    std::string ans1;
    int ans2 = 0;

    std::map<std::string, item> m;
    State st = State::name;
    std::string name, chld;
    int num = 0;
    while(1) {
        char c;
        std::cin.get(c);
        if(!std::cin.good()) break;
        if(c == '\n') {
            st = State::name;
            if(!chld.empty()) {
                m[chld].parent = name;
                m[name].children.push_back(chld);
                chld.clear();
            }

            name.clear();
            chld.clear();
            continue;
        }
        switch(st) {
            case State::name:
                if(c != ' ') {
                    name.push_back(c);
                } else {
                    m[name].name = name;
                    st = State::num;
                    num = 0;
                }
                break;
            case State::num:
                if(c >= '0' && c <= '9') {
                    num *= 10;
                    num += c - '0';
                } else if(c == ')') {
                    m[name].weight = num;
                    num = 0;
                    st = State::chld;
                }
                break;
            case State::chld:
                if(c >= 'a' && c <= 'z') {
                    chld.push_back(c);
                } else {
                    if(!chld.empty()) {
                        m[chld].parent = name;
                        m[name].children.push_back(chld);
                        chld.clear();
                    }
                }
        }

    }

    for(auto & i : m) {
        if(i.second.parent.empty()) ans1 = i.first;
        if(i.second.children.empty()) i.second.totw = i.second.weight;
    }

    bool done = false;
    while(!done) {
        done = true;
        for(auto & i : m) {
            if(i.second.totw) continue;
            int tmp = 0;
            bool found = true;
            for(auto c : i.second.children) {
                if(m[c].totw == 0) { found = false; }
                else tmp += m[c].totw;
            }
            if(found) i.second.totw = i.second.weight + tmp;
            else done = false;
        }

    }

    auto n  = find_diff_node(m, ans1);

    auto w = m[n];
    auto p = m[w.parent];
    for(auto pc : p.children) {
        auto diff = w.totw - m[pc].totw;
        if(diff) {
            ans2 = w.weight - diff;
            break;
        }
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
