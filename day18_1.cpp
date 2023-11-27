#include <iostream>
#include "pystrlib.hpp"

long long reg[26];

struct Operand {
    Operand() {}
    Operand(const std::string &s) { std::isalpha(s[0]) ? (type = 1, value = s[0] - 'a') : (type = 0, value = std::stoi(s)); }
    int type, value;
    operator long long () const { return type ? reg[value] : value; }
    long long operator=(long long v) { return type ? (reg[value] = v) : value; }
} op1[100], op2[100];

int code[100], n, pt, ls;

#define SND 1
#define SET 2
#define ADD 3
#define MUL 4
#define MOD 5
#define RCV 6
#define JGZ 7

int main() {
    freopen("day18.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            std::vector<std::string> vec = lib::split(line, " ");
            if (vec[0] == "snd") code[n] = SND, op1[n] = Operand(vec[1]);
            else if (vec[0] == "set") code[n] = SET, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "add") code[n] = ADD, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "mul") code[n] = MUL, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "mod") code[n] = MOD, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            else if (vec[0] == "rcv") code[n] = RCV, op1[n] = Operand(vec[1]);
            else if (vec[0] == "jgz") code[n] = JGZ, op1[n] = Operand(vec[1]), op2[n] = Operand(vec[2]);
            ++n;
        }
    }
    while (pt < n) {
        switch (code[pt]) {
            case SND: ls = op1[pt]; ++pt; break;
            case SET: op1[pt] = (long long) op2[pt]; ++pt; break;
            case ADD: op1[pt] = op1[pt] + op2[pt]; ++pt; break;
            case MUL: op1[pt] = op1[pt] * op2[pt]; ++pt; break;
            case MOD: op1[pt] = op1[pt] % op2[pt]; ++pt; break;
            case RCV: if (op1[pt]) { std::cout << ls; return 0; } ++pt; break;
            case JGZ: if (op1[pt] > 0) pt += op2[pt]; else ++pt; break;
        }
    }
    return 0;
}