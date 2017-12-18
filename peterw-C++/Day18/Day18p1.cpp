// Advent of Code 2017 - Day 18
// Peter Westerström (digimatic)

#include "config.h"

#include <array>
#include <common/common.h>
#include <iostream>
#include <memory>
#include <string>
#include <variant>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using Value = int64_t;
using Register = char;
using Operand = variant<Value, Register>;
using RegisterValues = array<Value, 26>;
struct State;
Value evalOperand(const State& s, Operand op);

enum class Intr
{
	None,
	Stop,
	Play,
	Recover
};

class Instr
{
public:
	virtual ~Instr() = default;
	virtual Intr execute(State& s) = 0;
};

class SndInstr : public Instr
{
public:
	SndInstr(Operand x)
	    : x{x}
	{
	}
	Intr execute(State& s) override;

private:
	Operand x;
};
class SetInstr : public Instr
{
public:
	SetInstr(Register x, Operand y)
	    : x{x}
	    , y{y}
	{
	}
	Intr execute(State& s) override;

private:
	Register x;
	Operand y;
};
class AddInstr : public Instr
{
public:
	AddInstr(Register x, Operand y)
	    : x{x}
	    , y{y}
	{
	}
	Intr execute(State& s) override;

private:
	Register x;
	Operand y;
};
class MulInstr : public Instr
{
public:
	MulInstr(Register x, Operand y)
	    : x{x}
	    , y{y}
	{
	}
	Intr execute(State& s) override;

private:
	Register x;
	Operand y;
};
class ModInstr : public Instr
{
public:
	ModInstr(Register x, Operand y)
	    : x{x}
	    , y{y}
	{
	}
	Intr execute(State& s) override;

private:
	Register x;
	Operand y;
};
class RcvInstr : public Instr
{
public:
	RcvInstr(Operand x)
	    : x{x}
	{
	}
	Intr execute(State& s) override;

private:
	Operand x;
};
class JgzInstr : public Instr
{
public:
	JgzInstr(Operand x, Operand y)
	    : x{x}
	    , y{y}
	{
	}
	Intr execute(State& s) override;

private:
	Operand x;
	Operand y;
};

using Program = vector<unique_ptr<Instr>>;
struct State
{
	State(Program&& program)
	    : program(move(program))
	{
		regs.fill(0);
	}
	void setRegister(Register r, Value v)
	{
		regs[r - 'a'] = v;
	}
	Value getRegister(Register r) const
	{
		return regs[r - 'a'];
	}

	void print() const
	{
		cout << "pc:" << pc << " ";
		for(int i = 0; i <= 25; i++)
		{
			char c = 'a' + i;
			cout << c << ":" << getRegister(c) << " ";
		}
		cout << endl;
	}

	int pc{0};
	RegisterValues regs;
	Value latestSound{0};
	bool recoverSound{false};
	const Program program;
};

Value evalOperand(const State& s, Operand op)
{
	if(auto val = get_if<Value>(&op))
	{
		return *val;
	} else if(auto r = get_if<Register>(&op))
	{
		return s.getRegister(*r);
	}
	throw std::exception();
}

Intr SndInstr::execute(State& s)
{
	s.latestSound = evalOperand(s, x);
	s.pc++;
	return Intr::Play;
}
Intr SetInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, y));
	s.pc++;
	return Intr::None;
}
Intr AddInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, x) + evalOperand(s, y));
	s.pc++;
	return Intr::None;
}
Intr MulInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, x) * evalOperand(s, y));
	s.pc++;
	return Intr::None;
}
Intr ModInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, x) % evalOperand(s, y));
	s.pc++;
	return Intr::None;
}
Intr RcvInstr::execute(State& s)
{
	s.pc++;
	if(evalOperand(s, x) != 0)
	{
		return Intr::Recover;
	} else
	{
		return Intr::None;
	}
}
Intr JgzInstr::execute(State& s)
{
	if(evalOperand(s, x) > 0)
	{
		s.pc += evalOperand(s, y);
	} else
	{
		s.pc++;
	}
	return Intr::None;
}

//
Operand parseOperand(const string& s)
{
	if(s[0] >= 'a' && s[0] <= 'z')
	{
		return s[0];
	} else
	{
		auto v = stoi(s);
		return static_cast<Value>(v);
	}
}

unique_ptr<Instr> parseInstr(const string& instrStr)
{
	auto is = instrStr.substr(0, 3);
	auto sepPos = instrStr.find(' ', 5);
	auto xs = instrStr.substr(4, sepPos - 4);
	auto x = parseOperand(xs);
	Operand y;
	if(sepPos != string::npos)
	{
		auto ys = instrStr.substr(sepPos + 1);
		y = parseOperand(ys);
	}

	if(is == "snd")
	{
		return make_unique<SndInstr>(x);
	} else if(is == "set")
	{
		return make_unique<SetInstr>(get<Register>(x), y);
	} else if(is == "add")
	{
		return make_unique<AddInstr>(get<Register>(x), y);
	} else if(is == "mul")
	{
		return make_unique<MulInstr>(get<Register>(x), y);
	} else if(is == "mod")
	{
		return make_unique<ModInstr>(get<Register>(x), y);
	} else if(is == "rcv")
	{
		return make_unique<RcvInstr>(get<Register>(x));
	} else if(is == "jgz")
	{
		return make_unique<JgzInstr>(x, y);
	}
	throw std::exception();
}

Program parseProgram(const vector<string>& lines)
{
	Program p;
	for(auto& line : lines)
	{
		auto instr = parseInstr(line);
		p.push_back(move(instr));
	}
	return p;
}

Intr executeOne(State& s)
{
	if(s.pc < 0 || s.pc >= s.program.size())
		return Intr::Stop;

	auto& i = s.program[s.pc];
	return i->execute(s);
}

void solve_part1()
{
	auto input = readLines(INPUT_FILE);
	auto p = parseProgram(input);
	State s(move(p));
	do
	{
		auto r = executeOne(s);
		if(r == Intr::Recover)
			break;
		if(r == Intr::Stop)
			throw std::exception();
	} while(true);

	cout << "Day 18 - part 1: " << s.latestSound << endl;
}

int main()
{
	solve_part1();
	return 0;
}
