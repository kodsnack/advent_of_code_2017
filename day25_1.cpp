#include <iostream>
#include "pystrlib.hpp"
#include <unordered_set>

int s, v_t[10], v_f[10], s_t[10], s_f[10], p_t[10], p_f[10], p, st;
std::unordered_set<int> tape;

inline void set(int p, int v) { if (v) tape.insert(p); else tape.erase(p); }

int main() {
    freopen("day25.txt", "r", stdin);
    {
        std::string line;
        std::getline(std::cin, line);
        p = 0; s = line[line.size() - 2] - 'A';
        std::getline(std::cin, line);
        std::vector<std::string> sp = lib::split(line, " ");
        st = std::stoi(sp[5]);
        std::getline(std::cin, line);

        int i = 0;
        while (std::getline(std::cin, line)) {
            std::getline(std::cin, line);
            std::getline(std::cin, line); v_f[i] = line[line.size() - 2] & 1;
            std::getline(std::cin, line); p_f[i] = line[line.size() - 3] == 'f' ? -1 : 1;
            std::getline(std::cin, line); s_f[i] = line[line.size() - 2] - 'A';
            std::getline(std::cin, line);
            std::getline(std::cin, line); v_t[i] = line[line.size() - 2] & 1;
            std::getline(std::cin, line); p_t[i] = line[line.size() - 3] == 'f' ? -1 : 1;
            std::getline(std::cin, line); s_t[i] = line[line.size() - 2] - 'A';
            std::getline(std::cin, line);
            ++i;
        }
    }
    for (int i = 0; i < st; ++i) {
        if (tape.count(p)) set(p, v_t[s]), p += p_t[s], s = s_t[s];
        else set(p, v_f[s]), p += p_f[s], s = s_f[s];
    }
    std::cout << tape.size() << std::endl;
    return 0;
}