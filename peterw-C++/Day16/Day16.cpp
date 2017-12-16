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

	void apply(string& state) const
	{
		const auto len = state.length();
		state = state.substr(len - count, count) + state.substr(0, len - count);
	}
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

	void apply(string& state) const
	{
		swap(state[posA], state[posB]);
	}
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

	void apply(string& state) const
	{
		auto pos1 = state.find(nameA);
		auto pos2 = state.find(nameB);
		swap(state[pos1], state[pos2]);
	}
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

void applyMoves(string& state, const Moves& moves)
{
	for(auto& m : moves)
	{
		std::visit([&state](auto&& dm) { dm.apply(state); }, m);
	}
}

/*void unittest_part1()
{
    string state = "abcde";
    string movesStr = "s1,x3/4,pe/b";
    auto moves = parseMoves(movesStr);
    applyMoves(state, moves);
    assert(state == "baedc");
}*/

void solve_part1()
{
	auto input = readLines(INPUT_FILE).at(0);
	auto moves = parseMoves(input);
	auto state = "abcdefghijklmnop"s;
	applyMoves(state, moves);
	cout << "Day 16 - part 1: " << state << endl;
}

void solve_part2()
{
	auto input = readLines(INPUT_FILE).at(0);
	auto moves = parseMoves(input);
	auto state0 = "abcdefghijklmnop"s;

	vector<string> dances;
	dances.push_back(state0);
	auto state = state0;
	while(true)
	{
		applyMoves(state, moves);
		if(state == state0)
			break;
		dances.push_back(state);
	};
	auto finalState = dances[1000000000 % dances.size()];
	cout << "Day 16 - part 2: " << finalState << endl;
}

int main()
{
	//	unittest_part1();
	solve_part1();
	solve_part2();
	return 0;
}
