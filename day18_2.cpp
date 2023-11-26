#include <iostream>
#include "pystrlib.hpp"
#include <queue>

struct Operand {
    Operand() {}
    Operand(const std::string &s) { std::isalpha(s[0]) ? (type = 1, value = s[0] - 'a') : (type = 0, value = std::stoi(s)); }
    int type, value;
} op1[100], op2[100];

int code[100], n;

#define SND 1
#define SET 2
#define ADD 3
#define MUL 4
#define MOD 5
#define RCV 6
#define JGZ 7

#define _INT_TYPE long long

struct program {
    _INT_TYPE reg[26];
    _INT_TYPE value(const Operand &op) const { return op.type ? reg[op.value] : op.value; }
    _INT_TYPE & ref(const Operand &op) { return reg[op.value]; }
    int pt, ts;
    program *p;
    std::queue<_INT_TYPE> Q;
    bool run_until_block() {
        while (0 <= pt && pt < n) {
            switch (code[pt]) {
                case SND: p->Q.push(value(op1[pt])); ++ts; ++pt; break;
                case SET: ref(op1[pt]) = value(op2[pt]); ++pt; break;
                case ADD: ref(op1[pt]) += value(op2[pt]); ++pt; break;
                case MUL: ref(op1[pt]) *= value(op2[pt]); ++pt; break;
                case MOD: ref(op1[pt]) %= value(op2[pt]); ++pt; break;
                case RCV: if (Q.empty()) return false; ref(op1[pt]) = Q.front(); Q.pop(); ++pt; break;
                case JGZ: if (value(op1[pt]) > 0) pt += value(op2[pt]); else ++pt; break;
            }
        }
        return true;
    }
    bool wait() { return pt < 0 || pt >= n || (code[pt] == RCV && Q.empty()); }
} p[2];

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
    p[0].reg[15] = 0; p[1].reg[15] = 1;
    p[0].p = p + 1; p[1].p = p;
    while (1) {
        if (p[0].run_until_block()) { std::cout << p[1].ts << std::endl; return 0; }
        p[1].run_until_block();
        if (p[0].wait() && p[1].wait()) { std::cout << p[1].ts << std::endl; return 0; }
    }
}