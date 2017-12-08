#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <string>

int main() {
    int ans1 = 0;
    int ans2 = 0;

    std::map<std::string, int> regs;

    std::string name, reg2;
    std::string tmp;
    enum class State { reg, op1, num, cond, reg2, op2, val };
    State st = State::reg;
    bool op1 = false;
    int num = 0;
    int val = 0;
    bool neg = false;
    bool num_seen;
    enum class CmpOp { eq, gt, lt, gte, lte, neq };
    CmpOp cmp = CmpOp::eq;
    while(1) {
        char c;
        std::cin.get(c);
        if(!std::cin.good()) break;

        switch(st) {
            case State::reg:
                if(c >= 'a' && c <= 'z') tmp.push_back(c);
                else {
                    name = tmp;
                    tmp.clear();
                    st = State::op1;
                }
                break;
            case State::op1:
                if(c >= 'a' && c <= 'z') tmp.push_back(c);
                else if(!tmp.empty()) {
                    if(tmp == "inc") op1 = true;
                    else if(tmp == "dec") op1 = false;
                    else { std::cout << tmp << " not inc/dec" << std::endl;}
                    tmp.clear();
                    st = State::num;
                }
                break;
            case State::num: {
                if(c >= '0' && c <= '9') {
                    num *= 10;
                    num += c - '0';
                    num_seen = true;
                } else if(c == '-') {
                    neg = true;
                } else if(num_seen) {
                  if(neg) num*=-1;
                  st = State::cond;
                    neg = false;
                    num_seen = false;
                }
            }
            break;
            case State::cond:
                if(c >= 'a' && c <= 'z') {
                    tmp.push_back(c);
                } else if(tmp == "if") {
                    st = State::reg2;
                    tmp.clear();
                }
                break;
            case State::reg2:
                if(c >= 'a' && c <= 'z') tmp.push_back(c);
                else if(!tmp.empty()){
                    reg2 = tmp;
                    tmp.clear();
                    st = State::op2;
                }
                break;
            case State::op2:
                if(c == '=' || c == '<' || c == '>' || c == '!') {
                    tmp.push_back(c);
                } else if(!tmp.empty()) {
                    if(tmp == "==") cmp = CmpOp::eq;
                    else if(tmp == "<") cmp = CmpOp::lt;
                    else if(tmp == ">") cmp = CmpOp::gt;
                    else if(tmp == "<=") cmp = CmpOp::lte;
                    else if(tmp == ">=") cmp = CmpOp::gte;
                    else if(tmp == "!=") cmp = CmpOp::neq;
                    else {std::cout << "cannot decode " << tmp << std::endl;}
                    tmp.clear();
                    st = State::val;
                }
                break;
            case State::val:
                if(c >= '0' && c <= '9') {
                    val *= 10;
                    val += c - '0';
                    num_seen = true;
                } else if(c == '-') {
                    neg = true;
                } else if(num_seen) {
                    if(neg) val*=-1;
                    neg = false;
                    num_seen = false;
                }
                break;
        }
        if(c == '\n' && !name.empty()) {
            bool cond = [&]{
                switch(cmp) {
                    case CmpOp::eq: return regs[reg2] == val;
                    case CmpOp::gt: return regs[reg2] > val;
                    case CmpOp::lt: return regs[reg2] < val;
                    case CmpOp::gte: return regs[reg2] >= val;
                    case CmpOp::lte: return regs[reg2] <= val;
                    case CmpOp::neq: return regs[reg2] != val;
                }}();

            if(cond) {
                if(op1) {
                    regs[name] += num;
                } else {
                    regs[name] -= num;
                }
            }
            if(regs[name] > ans2) ans2 = regs[name];
            name.clear();
            reg2.clear();
            tmp.clear();
            val = 0;
            num = 0;
            op1 = false;
            neg = false;
            num_seen = false;
            st = State::reg;
        }
    }

    for(auto & p : regs) {
        if(p.second > ans1) ans1 = p.second;
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
