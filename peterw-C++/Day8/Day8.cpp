// Advent of Code 2017 - Day 8
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <common/common.h>
#include <iostream>
#include <iterator>
#include <regex>
#include <string>
#include <unordered_map>
#include <vector>


using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using RegisterName = string;
using Value = int;
using RegisterValue = Value;

struct State
{
	unordered_map<RegisterName, Value> registerStates;
};

enum class CompareOperator
{
	Equal,
	NotEqual,
	Less,
	LessOrEqual,
	Greater,
	GreaterOrEqual
};

struct ConditionExpression
{
	RegisterName reg;
	CompareOperator compareOp;
	Value val;
};

enum class Operation
{
	inc,
	dec
};

struct OperationStatement
{
	RegisterName reg;
	Operation op;
	Value val;
};

struct Instruction
{
	OperationStatement opStmt;
	ConditionExpression condition;
};

using Program = vector<Instruction>;

Program readAndParseProgram(const string& programFile)
{
	Program program;

	auto inputLines = readLines(programFile);
	for(auto& line : inputLines)
	{
		regex r("(\\w+)\\s+(inc|dec)\\s+([+-]?\\d+)\\s+if\\s+(\\w+)\\s+([<>=!]+)\\s+([+-]?\\d+)");
		smatch m;
		bool b = regex_match(line, m, r);
		if(!b)
			continue;

		Instruction instr;

		// Op statement part
		instr.opStmt.reg = m[1].str();
		auto opstr = m[2].str();
		if(opstr == "inc")
		{
			instr.opStmt.op = Operation::inc;
		} else if(opstr == "dec")
		{
			instr.opStmt.op = Operation::dec;
		}
		auto opParamStr = m[3].str();
		instr.opStmt.val = stoi(opParamStr);

		// Condition part
		auto condRegStr = m[4];
		instr.condition.reg = condRegStr;
		auto condCompOpStr = m[5];
		if(condCompOpStr == "==")
		{
			instr.condition.compareOp = CompareOperator::Equal;
		} else if(condCompOpStr == "!=")
		{
			instr.condition.compareOp = CompareOperator::NotEqual;
		} else if(condCompOpStr == "<")
		{
			instr.condition.compareOp = CompareOperator::Less;
		} else if(condCompOpStr == ">")
		{
			instr.condition.compareOp = CompareOperator::Greater;
		} else if(condCompOpStr == "<=")
		{
			instr.condition.compareOp = CompareOperator::LessOrEqual;
		} else if(condCompOpStr == ">=")
		{
			instr.condition.compareOp = CompareOperator::GreaterOrEqual;
		}
		auto condCompRightValStr = m[6];
		instr.condition.val = stoi(condCompRightValStr);
		program.push_back(instr);
	}
	return program;
}

Value readRegister(const State& state, const RegisterName& regName)
{
	if(state.registerStates.find(regName) == state.registerStates.end())
	{
		return 0;
	} else
	{
		return state.registerStates.at(regName);
	}
}

void writeRegister(State& state, const RegisterName& regName, Value newValue)
{
	state.registerStates[regName] = newValue;
}

bool evaluateCompare(Value leftVal, CompareOperator compareOp, Value rightVal)
{
	switch(compareOp)
	{
		case CompareOperator::Equal:
			return leftVal == rightVal;
		case CompareOperator::NotEqual:
			return leftVal != rightVal;
		case CompareOperator::Less:
			return leftVal < rightVal;
		case CompareOperator::LessOrEqual:
			return leftVal <= rightVal;
		case CompareOperator::Greater:
			return leftVal > rightVal;
		case CompareOperator::GreaterOrEqual:
			return leftVal >= rightVal;
		default:
			throw std::exception();
	}
}

bool evaluateCondition(const State& state, ConditionExpression condition)
{
	auto val = readRegister(state, condition.reg);
	auto c = evaluateCompare(val, condition.compareOp, condition.val);
	return c;
}

void runOperation(State& state, const OperationStatement& stmt)
{
	auto regVal = readRegister(state, stmt.reg);
	switch(stmt.op)
	{
		case Operation::inc:
			writeRegister(state, stmt.reg, regVal + stmt.val);
			break;
		case Operation::dec:
			writeRegister(state, stmt.reg, regVal - stmt.val);
			break;
	}
}

void runProgram(State& state, const Program& program)
{
	for(auto& i : program)
	{
		if(evaluateCondition(state, i.condition))
		{
			runOperation(state, i.opStmt);
		}
	}
}

Value getMaxRegisterValue(const State& state)
{
	if(state.registerStates.empty())
		return 0;

	std::vector<Value> values;
	transform(state.registerStates.begin(), state.registerStates.end(), back_inserter(values),
	          [](auto& e) { return e.second; });
	auto maxElementIt = max_element(values.begin(), values.end());
	auto maxVal = *maxElementIt;
	return maxVal;
}

void solve_part1()
{
	auto program = readAndParseProgram(INPUT_FILE);

	State state;
	runProgram(state, program);

	auto maxVal = getMaxRegisterValue(state);
	cout << "Day 8 - part 1: " << maxVal << endl;
}

void solve_part2()
{
	auto program = readAndParseProgram(INPUT_FILE);

	State state;
	auto maxVal = 0;
	for(auto& i : program)
	{
		if(evaluateCondition(state, i.condition))
		{
			runOperation(state, i.opStmt);
			maxVal = max(maxVal, getMaxRegisterValue(state));
		}
	}

	cout << "Day 8 - part 2: " << maxVal << endl;
}

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
