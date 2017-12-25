// Advent of Code 2017 - Day 23
// Peter Westerström (digimatic)

#include "config.h"

#include <array>
#include <common/common.h>
#include <iostream>
#include <memory>
#include <queue>
#include <string>
#include <variant>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using Value = int64_t;
using Register = char;
using Operand = variant<Value, Register>;
using RegisterValues = array<Value, 8>;
struct State;
Value evalOperand(const State& s, Operand op);

enum class Intr
{
	None,
	Stop
};

class Instr
{
public:
	virtual ~Instr() = default;
	virtual Intr execute(State& s) = 0;
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
class SubInstr : public Instr
{
public:
	SubInstr(Register x, Operand y)
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
class JnzInstr : public Instr
{
public:
	JnzInstr(Operand x, Operand y)
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
	State(const Program& program)
	    : program(program)
	{
		regs.fill(0);
	}
	void setRegister(Register r, Value v)
	{
		assert(r >= 'a' && r <= 'h');
		regs[r - 'a'] = v;
	}
	Value getRegister(Register r) const
	{
		assert(r >= 'a' && r <= 'h');
		return regs[r - 'a'];
	}

	void print() const
	{
		cout << "pc:" << pc << " ";
		for(int i = 0; i < 8; i++)
		{
			char c = 'a' + i;
			cout << c << ":" << getRegister(c) << " ";
		}
		cout << endl;
	}

	int pc{0};
	RegisterValues regs;
	const Program& program;
	int mulInvokeCount{0};
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
Intr SetInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, y));
	s.pc++;
	return Intr::None;
}
Intr SubInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, x) - evalOperand(s, y));
	s.pc++;
	return Intr::None;
}
Intr MulInstr::execute(State& s)
{
	s.setRegister(x, evalOperand(s, x) * evalOperand(s, y));
	s.pc++;
	s.mulInvokeCount++;
	return Intr::None;
}
Intr JnzInstr::execute(State& s)
{
	if(evalOperand(s, x) != 0)
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
	if(s[0] >= 'a' && s[0] <= 'h')
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

	if(is == "set")
	{
		return make_unique<SetInstr>(get<Register>(x), y);
	} else if(is == "sub")
	{
		return make_unique<SubInstr>(get<Register>(x), y);
	} else if(is == "mul")
	{
		return make_unique<MulInstr>(get<Register>(x), y);
	} else if(is == "jnz")
	{
		return make_unique<JnzInstr>(x, y);
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
	State s(p);
	while(true)
	{
		auto r = executeOne(s);
		if(r == Intr::Stop)
		{
			break;
		}
	};

	cout << "Day 23 - part 1: " << s.mulInvokeCount << endl;
}

void solve_part2()
{
	// the input program rewritten into C++
	auto a = 1;
	auto g = 0;
	auto h = 0;

	auto b = 93;
	auto c = b;
	if(a != 0)
	{
		b *= 100;
		b -= -100000;
		c = b;
		c -= -17000;
	}

	while(true)
	{
		auto f = 1;
		auto d = 2;
		do
		{
			// Loop replaced
			/*			auto e = 2;
			            do
			            {
			                if(d*e==b)
			                    f=0;
			                e++;
			            } while(e!=b);*/
			// with this
			if(b % d == 0)
			{
				f = 0;
				break;
			}
			// --

			d++;
		} while(d != b);

		if(f == 0)
			h++;
		if(b == c)
			break;
		b -= -17;
	}

	cout << "Day 23 - part 2: " << h << endl;
}

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
