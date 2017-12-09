#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <string>

int main() {
    int ans1 = 0;
    int ans2 = 0;

    int level = 0;
    bool garbage = false;
    bool ignore = false;
    while(1) {
        char c;
        std::cin.get(c);
        if(!std::cin.good()) break;
        if(!garbage) {
            switch (c) {
                case '<':
                    garbage = true;
                    break;
                case '{':
                    level++;
                    break;
                case '}':
                    ans1 += level;
                    level--; break;
            }
        } else {
            if(ignore) { ignore=false; continue;}
            else if(c == '!') ignore = true;
            else if(c == '>') garbage = false;
            else ans2++;
        }
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
