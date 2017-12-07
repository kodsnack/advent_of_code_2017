// Advent of Code 2017 - Day 6
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <common/common.h>
#include <iostream>
#include <iterator>
#include <string>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using state_t = vector<int>;

vector<int> parseLine(const string& line)
{
	vector<int> numbers;
	auto remaining = line;
	while(!remaining.empty())
	{
		size_t taken = 0;
		auto n = std::stoi(remaining, &taken);
		numbers.push_back(n);
		remaining = remaining.substr(taken);
	}
	return numbers;
}

state_t readAndParseInput()
{
	auto inputLine = readLines(INPUT_FILE).at(0);
	auto startState = parseLine(inputLine);
	return startState;
}

state_t redistribute(const state_t& state0)
{
	state_t state = state0;
	auto it = max_element(state.begin(), state.end());
	auto n = *it;
	*it = 0;
	while(n > 0)
	{
		if(++it == state.end())
			it = state.begin();
		(*it)++;
		n--;
	}
	return state;
}

pair<int, int> redistributeLoop(state_t state)
{
	vector<state_t> statesSeen;
	int cycle = 0;
	do
	{
		statesSeen.push_back(state);
		state = redistribute(state);
		cycle++;
	} while(find(statesSeen.begin(), statesSeen.end(), state) == statesSeen.end());
	auto it = find(statesSeen.begin(), statesSeen.end(), state);
	auto dist = distance(it, statesSeen.end());
	return make_pair(cycle, static_cast<int>(dist));
}

void solve_part1And2()
{
	auto state0 = readAndParseInput();
	//	state_t state0 = { 0, 2, 7, 0 };

	auto[cycles, repeatDistance] = redistributeLoop(state0);
	cout << "Day 6 - part 1: " << cycles << endl;
	cout << "Day 6 - part 2: " << repeatDistance << endl;
}

int main()
{
	solve_part1And2();
	return 0;
}
