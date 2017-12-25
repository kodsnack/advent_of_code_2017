#include <iostream>
#include <vector>

int main() {
    std::string prg = "abcdefghijklmnop";

    struct step {
        step(char c, int a1, int a2) : cmd{c}, arg1{a1}, arg2{a2} {}
        char cmd; int arg1; int arg2;
    };
    std::vector<step> dance;
    {
        bool done = false;
        bool innum = false;
        int num = 0;
        char cmd = 0;
        bool havecmd = false;
        int arg1 = 0;
        int arg2 = 0;
        bool first = true;
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
            } else if (c >= 'a' && c <= 'z') {
                if(!havecmd) {
                    cmd = c;
                    havecmd = true;
                } else if(first) {
                    arg1 = c;
                    first = false;
                } else {
                    arg2 = c;
                }
            } else if(c == '/') {
                if(innum)
                    arg1 = num;
                num = 0;
                innum = false;
                first = false;
            } else {
                if(innum) {
                    if(first) {
                        arg1 = num;
                    } else {
                        arg2 = num;
                    }
                }
                if(havecmd) {
                    dance.emplace_back(cmd, arg1, arg2);
                }
                num = 0;
                innum = false;
                arg1 = arg2 = 0;
                first = true;
                havecmd = false;
            }
        }
    }

    std::vector<std::string> v;
    v.push_back(prg);

    while(1) {
        for (auto &s : dance) {
            switch (s.cmd) {
                case 's':
                    prg = prg.substr(prg.size() - s.arg1) + prg.substr(0, prg.size() - s.arg1);
                    break;
                case 'x':
                    std::swap(prg[s.arg1], prg[s.arg2]);
                    break;
                case 'p':
                    std::swap(prg[prg.find((char) s.arg1)], prg[prg.find((char) s.arg2)]);
                    break;
            }

        }
        if(prg == v[0]) {
            break;
        } else {
            v.push_back(prg);
        }
    }

    std::cout << v[1] << std::endl;
    std::cout << v[1000000000 % v.size()] << std::endl;
}
