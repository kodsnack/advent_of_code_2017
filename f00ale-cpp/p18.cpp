#include <iostream>
#include <vector>
#include <map>
#include <deque>

int main() {
    int ans1 = 0;
    int ans2 = 0;

    enum class OP {
        snd, set, add, mul, mod, rcv, jgz
    };
    std::map<std::string, OP> m {{"snd", OP::snd}, {"set", OP::set}, {"add", OP::add},
                                 {"mul", OP::mul}, {"mod", OP::mod}, {"rcv", OP::rcv},
                                 {"jgz", OP::jgz}};

    struct Cmd {
        Cmd(OP o, char r1, char r2, int d1, int d2) : op(o), reg1(r1), reg2(r2), data1(d1), data2(d2) {}
        OP op;
        char reg1;
        char reg2;
        int64_t data1;
        int64_t data2;
    };

    std::vector<Cmd> cmds;

    {
        bool done = false;
        bool innum = false;
        std::string cmd;
        char r1 = 0;
        char r2 = 0;
        int num = 0;
        bool neg = false;
        int d1 = 0;
        int d2 = 0;
        bool have_cmd = false;
        bool have_reg = false;
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
            } else if(c == '-') {
                neg = true;
            } else if(c>='a' && c <= 'z') {
                if(!have_cmd) cmd.push_back(c);
                else {
                    if(have_reg) {
                        r2 = c;
                    } else {
                        r1 = c;
                        have_reg = true;
                    }
                }
            } else {
                if(innum) {
                    if(have_reg) d2 = neg ? -num : num;
                    else { d1 =  neg ? -num : num; have_reg = true;}
                }
                if(c == '\n') {
                    if(have_cmd) {
                        auto it = m.find(cmd);
                        if(it != m.end()) {
                            cmds.emplace_back(it->second, r1, r2, d1, d2);
                        } else {
                            std::cout << "unknown command " << cmd << std::endl;
                        }
                    }
                    d2 = 0;
                    d1 = 0;
                    have_cmd = false;
                    r1 = r2 = 0;
                    cmd.clear();
                    have_reg = false;
                } else {
                    if(!cmd.empty()) have_cmd = true;
                }

                num = 0;
                innum = false;
                neg = false;
            }
        }
    }

    std::map<char, int64_t> regs0, regs1;
    regs1['p'] = 1;
    int pos0 = 0, pos1 = 0;
    std::deque<int64_t> snd0, snd1;
    bool zero = true;

    do {
        auto & snd = zero ? snd1 : snd0;
        auto & rcv = zero ? snd0 : snd1;
        auto & regs = zero ? regs0 : regs1;
        auto & pos = zero ? pos0 : pos1;
        bool blocked = false;

        while(!blocked) {
            auto &cmd = cmds[pos];
            pos++;
            switch (cmd.op) {
                case OP::snd:
                    snd.push_back(regs[cmd.reg1]);
                    break;
                case OP::add:
                    if (cmd.reg2) regs[cmd.reg1] += regs[cmd.reg2];
                    else regs[cmd.reg1] += cmd.data2;
                    break;
                case OP::set:
                    if (cmd.reg2) regs[cmd.reg1] = regs[cmd.reg2];
                    else regs[cmd.reg1] = cmd.data2;
                    break;
                case OP::mul:
                    if (cmd.reg2) regs[cmd.reg1] *= regs[cmd.reg2];
                    else regs[cmd.reg1] *= cmd.data2;
                    break;
                case OP::mod:
                    if (cmd.reg2) regs[cmd.reg1] %= regs[cmd.reg2];
                    else regs[cmd.reg1] %= cmd.data2;
                    break;
                case OP::rcv:
                    if (!rcv.empty()) {
                        regs[cmd.reg1] = rcv.front();
                        rcv.pop_front();
                    } else {
                        pos--;
                        blocked = true;
                    }
                    break;
                case OP::jgz:
                    if ((cmd.reg1 && regs[cmd.reg1] > 0) || cmd.data1) {
                        pos--;
                        if (cmd.reg2) pos += regs[cmd.reg2];
                        else pos += cmd.data2;
                    }
                    break;
                default:
                    return -1;
            }
        }
        if(zero && !ans1 && !snd.empty()) ans1 = snd.back();
        if(!zero) ans2 += snd.size();
        zero = !zero;
    } while(!snd0.empty() || !snd1.empty());

    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
