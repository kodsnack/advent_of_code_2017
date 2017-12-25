#include <iostream>
#include <vector>

int main() {
    int ans1 = 0;
    int ans2 = 0;
    int data = 0;
    {
        bool done = false;
        bool innum = false;
        int num = 0;
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
                innum = true;

            } else {
                if(innum)
                data = num;
                num = 0;
                innum = false;
            }
        }
    }

    std::vector<int> v = {0};
    int pos = 0;

    for(int i = 1; i <= 2017; i++) {
        pos += data;
        pos %= v.size();
        pos++;
        if(pos >= v.size()) pos = 0;

        std::vector<int> tmp(v.begin(), v.begin()+pos);
        tmp.push_back(i);
        for(auto it = v.begin()+pos; it != v.end(); it++) tmp.push_back(*it);
        v.swap(tmp);
    }
    ans1 = v[pos+1 %v.size()];

    pos = 0;
    int size = 1;
    int zeropos = 0;
    for(int i = 1; i <= 50000000; i++) {
        pos += data;
        while(pos >= size) pos -= size;
        size++;
        pos++;
        if(pos >= size) pos = 0;

        if(pos == zeropos+1) {
            ans2 = i;
        } else if(pos == zeropos) {
            zeropos++;
        }
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
