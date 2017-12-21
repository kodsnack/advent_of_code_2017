#include <iostream>
#include <vector>
#include <map>
#include <deque>
#include <string>

int main() {
    std::string ans1;
    int ans2 = 0;
    std::vector<std::vector<char>> v;
    v.emplace_back();

    {
        bool done = false;
        while (!done) {
            char c;
            std::cin.get(c);
            if (!std::cin.good()) {
                done = true;
                c = '\n';
            }
            if(c == '\n') {
                if(!v.back().empty()) v.emplace_back();
            } else {
                v.back().push_back(c);
            }
        }
    }

    int x = 0, y = 0;
    // find start
    for(; x < v[y].size(); x++) {
        if(v[y][x] != ' ') break;
    }

    int dy = 1, dx = 0;
    bool done = false;
    while(!done) {
        ans2++;
        if(v[y][x] == ' ') {
            done = true;
        } else if(v[y][x] >= 'A' && v[y][x] <= 'Z') {
            ans1.push_back(v[y][x]);
            if(y+dy >= 0 && y+dy < v.size() && x+dx > 0 && x+dx < v[y+dy].size() && v[y+dy][x+dx] != ' ') {
                y += dy;
                x += dx;
            } else {
                done = true;
            }
        } else if(v[y][x] == '|' || v[y][x] == '-') {
            y+=dy;
            x+=dx;
        } else if(v[y][x] == '+') {
            if(dy) {
                dy = 0;
                if(x-1 >= 0 && v[y][x-1] != ' ') dx = -1;
                else dx = 1;
            } else {
                dx = 0;
                if(y-1 >= 0 && x < v[y-1].size() && v[y-1][x] != ' ') dy = -1;
                else dy = 1;
            }
            y += dy;
            x += dx;
        } else {
            return -1;
        }

    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
