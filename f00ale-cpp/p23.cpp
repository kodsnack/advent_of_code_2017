#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

int main() {
    int ans1 = 0;
    int ans2 = 0;

    enum class OP {
      set, sub, mul, jnz
    };
    std::map<std::string, OP> m {{"set", OP::set}, {"sub", OP::sub}, {"mul", OP::mul}, {"jnz", OP::jnz}};


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
	bool ign = false;
        while (!done) {
            char c;
            std::cin.get(c);
            if (!std::cin.good()) {
                done = true;
                c = '\n';
            }

	    if(ign && c != '\n') continue; 

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
	    } else if(c == '#') {
	      ign = true;
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
			    return -1;
                        }
                    }
                    d2 = 0;
                    d1 = 0;
                    have_cmd = false;
                    r1 = r2 = 0;
                    cmd.clear();
                    have_reg = false;
		    ign = false;
                } else {
                    if(!cmd.empty()) have_cmd = true;
                }

                num = 0;
                innum = false;
                neg = false;
            }
        }
    }

    std::map<char, int64_t> regs;
    
    for(int i = 0; i < 2; i++) {
      int pos = 0;
      int nmuls = 0;
      regs.clear();
      regs['a'] = i;

      while(pos >= 0 && pos < cmds.size()) {
        auto &cmd = cmds[pos];
        pos++;
        switch (cmd.op) {
            case OP::set:
                if (cmd.reg2) regs[cmd.reg1] = regs[cmd.reg2];
                else regs[cmd.reg1] = cmd.data2;
                break;
            case OP::mul:
                nmuls++;
                if (cmd.reg2) regs[cmd.reg1] *= regs[cmd.reg2];
                else regs[cmd.reg1] *= cmd.data2;
                break;
            case OP::sub:
	        if (cmd.reg2) regs[cmd.reg1] -= regs[cmd.reg2];
                else regs[cmd.reg1] -= cmd.data2;
                break;
            case OP::jnz:
                if ((cmd.reg1 && regs[cmd.reg1] != 0) || cmd.data1) {
                    pos--;
                    if (cmd.reg2) pos += regs[cmd.reg2];
                    else pos += cmd.data2;
		    if(i && cmd.data2 < 0) {
		      pos = cmds.size();
		    }
                }
                break;
            default:
                return -1;
        }
      }
      if(i == 0) ans1 = nmuls;
    }

    // find the two largest values
    auto it = std::max_element(cbegin(regs), cend(regs),
			       [](const auto & p1, const auto & p2) {
				 return p1.second < p2.second;
			       });

    auto endvalue = it->second;
    regs.erase(it);
    it = std::max_element(cbegin(regs), cend(regs),
			  [](const auto & p1, const auto & p2) {
			    return p1.second < p2.second;
			  });
    auto startvalue = it->second;
    auto cntreg = it->first;
    decltype(startvalue) inc = 0;
    
    // find increase on smaller value
    for(auto it = rbegin(cmds); it != rend(cmds); it++) {
      if(it->op == OP::sub && it->reg1 == cntreg) {
	inc = -it->data2;
	break;
      }
    }

    for(auto i = startvalue; i <= endvalue; i+=inc) {
      bool isprime = true;
      for(decltype(i) j = 2; isprime && j*j <= i; j++) {
	if(i % j == 0) isprime = false;
      }
      if(!isprime) ans2++;
    }
    
    std::cout << ans1 << std::endl;
    std::cout << ans2 << std::endl;
}
