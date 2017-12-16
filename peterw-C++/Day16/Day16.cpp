// Advent of Code 2017 - Day 16
// Peter Westerström (digimatic)

#include "config.h"

#include <cassert>
#include <common/common.h>
#include <iostream>
#include <regex>
#include <string>
#include <variant>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

struct SpinMove
{
	SpinMove(int count)
	    : count{count}
	{
	}
	int count;
};
struct ExchangeMove
{
	ExchangeMove(int a, int b)
	    : posA(a)
	    , posB(b)
	{
	}
	int posA;
	int posB;
};
struct PartnerMove
{
	PartnerMove(char a, char b)
	    : nameA(a)
	    , nameB(b)
	{
	}
	char nameA;
	char nameB;
};
using Move = variant<SpinMove, ExchangeMove, PartnerMove>;
using Moves = vector<Move>;

Moves parseMoves(const string& movesString)
{
	Moves moves;
	regex rgx(",");
	sregex_token_iterator iter(movesString.begin(), movesString.end(), rgx, -1);
	sregex_token_iterator end;
	for(; iter != end; ++iter)
	{
		auto moveStr = (*iter).str();
		if(moveStr[0] == 's')
		{
			moves.push_back(SpinMove(stoi(moveStr.substr(1))));
		} else if(moveStr[0] == 'x')
		{
			size_t i;
			auto a = stoi(moveStr.substr(1), &i);
			auto b = stoi(moveStr.substr(2 + i));
			moves.push_back(ExchangeMove(a, b));
		} else if(moveStr[0] == 'p')
		{
			char a = moveStr[1];
			char b = moveStr[3];
			moves.push_back(PartnerMove(a, b));
		}
	}
	return moves;
}

template <class... Ts> struct overloaded : Ts...
{
	using Ts::operator()...;
};
template <class... Ts> overloaded(Ts...)->overloaded<Ts...>;

string applyMove(const string& state0, Move danceMove)
{
	return std::visit(overloaded{[state0](SpinMove arg) {
		                             auto len = state0.length();
		                             return state0.substr(len - arg.count, arg.count) +
		                                    state0.substr(0, len - arg.count);
	                             },

	                             [state0](ExchangeMove arg) {
		                             auto state = state0;
		                             swap(state[arg.posA], state[arg.posB]);
		                             return state;
	                             },
	                             [state0](PartnerMove arg) {
		                             auto state = state0;
		                             auto pos1 = state0.find(arg.nameA);
		                             auto pos2 = state0.find(arg.nameB);
		                             swap(state[pos1], state[pos2]);
		                             return state;
	                             }},
	                  danceMove);
}

string applyMoves(const string& state0, const Moves& moves)
{
	auto state = state0;
	for(auto& dancemove : moves)
	{
		state = applyMove(state, dancemove);
	}
	return state;
}

void unittest_part1()
{
	string state = "abcde";
	string movesStr = "s1,x3/4,pe/b";
	auto moves = parseMoves(movesStr);
	auto state1 = applyMoves(state, moves);
	assert(state1 == "baedc");
}

void solve_part1()
{
	auto input = readLines(INPUT_FILE).at(0);
	auto moves = parseMoves(input);
	auto finalState = applyMoves("abcdefghijklmnop"s, moves);
	cout << "Day 16 - part 1: " << finalState << endl;
}

void solve_part2()
{
	auto input = readLines(INPUT_FILE).at(0);
	auto moves = parseMoves(input);
	auto state = "abcdefghijklmnop"s;
	for(int i = 0; i < 1000000000; ++i)
	{
		state = applyMoves(state, moves);
	}
	cout << "Day 16 - part 2: " << state << endl;
}

int main()
{
	unittest_part1();
	solve_part1();
	solve_part2();
	return 0;
}
