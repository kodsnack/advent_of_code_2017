#include <iostream>
#include "pystrlib.hpp"

long long reg[8];

struct Operand {
    Operand() {}
    Operand(const std::string &s) { std::isalpha(s[0]) ? (type = 1, value = s[0] - 'a') : (type = 0, value = std::stoi(s)); }
    int type, value;
    operator long long () const { return type ? reg[value] : value; }
    long long operator=(long long v) { return type ? (reg[value] = v) : value; }
} op1[100], op2[100];

int code[100], n, pt, ls;

#define SET 1
#define SUB 2
#define MUL 3
#define JNZ 4

int main() {
    freopen("day23.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            std::vector<std::string> vec = lib::split(line, " ");
            if (vec[0] == "set") code[n] = SET, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "sub") code[n] = SUB, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "mul") code[n] = MUL, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "jnz") code[n] = JNZ, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            ++n;
        }
    }
    int ans = 0;
    while (pt < n) {
        switch (code[pt]) {
            case SET: op1[pt] = (long long) op2[pt]; ++pt; break;
            case SUB: op1[pt] = op1[pt] - op2[pt]; ++pt; break;
            case MUL: op1[pt] = op1[pt] * op2[pt]; ++ans; ++pt; break;
            case JNZ: if (op1[pt]) pt += op2[pt]; else ++pt; break;
        }
    }
    std::cout << ans << std::endl;
    return 0;
}