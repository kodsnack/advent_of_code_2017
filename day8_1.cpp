#include <iostream>
#include <unordered_map>
#include "pystrlib.hpp"
#include <functional>

int reg[2005];

std::unordered_map<std::string, int> mapping;
int c;

inline int get_order(const std::string &str) { return mapping.count(str) ? mapping[str] : (mapping[str] = ++c); }

inline std::function<bool(int, int)> get_comp(const std::string &str) {
    if (str == "<") return std::less<int>();
    else if (str == ">") return std::greater<int>();
    else if (str == "<=") return std::less_equal<int>();
    else if (str == ">=") return std::greater_equal<int>();
    else if (str == "==") return std::equal_to<int>();
    else return std::not_equal_to<int>();
}

int main() {
    freopen("day8.txt", "r", stdin);
    int v = 0;
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            std::vector<std::string> vec = lib::split(line, " ");
            if (get_comp(vec[5])(reg[get_order(vec[4])], std::stoi(vec[6])))
                ((reg[get_order(vec[0])] += std::stoi(vec[2]) * (vec[1] == "inc" ? 1 : -1)) > v) && (v = reg[get_order(vec[0])]);
        }
    }
    std::cout << v << std::endl;
    return 0;
}