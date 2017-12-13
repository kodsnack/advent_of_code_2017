#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <string>

int main() {
    int ans1 = 0;
    int ans2 = 0;
    std::string tmp;
    int x = 0;
    int y = 0;
    int z = 0;

    auto dist = [&]{ return std::max(abs(x), std::max(abs(y), abs(z))); };
    bool done = false;
    while(!done) {
        char c;
        std::cin.get(c);
        if (!std::cin.good()) {
            done = true;
            c = '\n'; // fake new-line at eof
        }
        if( !tmp.empty() && (c == ',' || c == '\n')) {
            if(tmp == "n") { y++; z--; }
            else if(tmp == "s") { y--; z++; }
            else if(tmp == "ne") { x++; z--; }
            else if(tmp == "nw") { x--; y++; }
            else if(tmp == "se") { x++; y--; }
            else if(tmp == "sw") { x--; z++; }
            else { std::cout << "error: " << tmp << std::endl; }
            tmp.clear();
            if(dist() > ans2) ans2 = dist();
        } else {
            tmp.push_back(c);
        }
    }

    ans1 = dist();
    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
