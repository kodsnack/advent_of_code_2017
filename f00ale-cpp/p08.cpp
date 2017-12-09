#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <string>
#include <regex>

enum class Cmd { inc, dec };
enum class CmpOp { eq, gt, lt, gte, lte, neq };

struct Operation {
    std::string regname;
    Cmd cmd;
    int amount;
    std::string cmp_reg;
    CmpOp cmp;
    int cmp_data;
};

int main() {
    int ans1 = 0;
    int ans2 = 0;

    std::map<std::string, int> regs;
    std::vector<Operation> ops;

    std::regex line_regex(R"(([a-z]+) (inc|dec) (-?[0-9]+) if ([a-z]+) ([<>=!]{1,2}) (-?[0-9]+))");

    do {
        std::string tmp;
        getline(std::cin, tmp);
        if(tmp.empty()) continue;
        std::smatch m;
        std::regex_match(tmp, m, line_regex);
        if(m.size() < 6) continue;
        Operation op;
        op.regname = m[1];
        op.cmd = m[2] == "inc" ? Cmd::inc : Cmd::dec;
        op.amount = atoi(m[3].str().c_str());
        op.cmp_reg = m[4];
        op.cmp = [o=m[5]]{
            if(o == "==") return CmpOp::eq;
            else if(o == "<") return CmpOp::lt;
            else if(o == "<=") return CmpOp::lte;
            else if(o == ">") return CmpOp::gt;
            else if(o == ">=") return CmpOp::gte;
            else if(o == "!=") return CmpOp::neq;
            std::cout << "Cannot parse " << o << " into CmpOp!" << std::endl;
            return CmpOp::eq;
        }();
        op.cmp_data = atoi(m[6].str().c_str());
        ops.push_back(op);
    } while(std::cin.good());

    for(const auto & op : ops) {
        bool cond = [cmp=op.cmp,reg=op.cmp_reg,val=op.cmp_data,&regs]{
            switch(cmp) {
                case CmpOp::eq: return regs[reg] == val;
                case CmpOp::gt: return regs[reg] > val;
                case CmpOp::lt: return regs[reg] < val;
                case CmpOp::gte: return regs[reg] >= val;
                case CmpOp::lte: return regs[reg] <= val;
                case CmpOp::neq: return regs[reg] != val;
            }}();
        if(cond) {
            switch(op.cmd) {
                case Cmd::inc:
                    regs[op.regname] += op.amount;
                    break;
                case Cmd::dec:
                    regs[op.regname] -= op.amount;
                    break;
            }
            if(regs[op.regname] > ans2) ans2 = regs[op.regname];
        }
    }


    for(auto & p : regs) {
        if(p.second > ans1) ans1 = p.second;
    }

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
