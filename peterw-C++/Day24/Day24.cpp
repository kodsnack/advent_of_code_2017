// Advent of Code 2017 - Day 24
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <iostream>
#include <optional>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using Component = pair<int, int>;
using Components = vector<Component>;
using Bridge = vector<Component>;

Component parseComponent(const string& componentStr)
{
	auto i = componentStr.find('/');
	auto c1 = stoi(componentStr.substr(0, i));
	auto c2 = stoi(componentStr.substr(i + 1));
	return make_pair(c1, c2);
}

Components parseComponents(const vector<string>& componentStr)
{
	Components comps;
	for(auto& componentStr : componentStr)
	{
		comps.push_back(parseComponent(componentStr));
	}
	return comps;
}

struct State
{
	int nextType{0};
	Components components;
	Bridge bridge;
	int bridgeStrength{0};
};

void printBridge(const Bridge& bridge)
{
	for(auto& c : bridge)
	{
		cout << c.first << "/" << c.second << "--";
	}
	cout << endl;
}

int findStrongestBridge(const vector<string>& componentsInput)
{
	Bridge bestBridge;
	int bestBridgeStrength{0};

	vector<State> states;
	State s;
	s.components = parseComponents(componentsInput);
	states.push_back(s);
	while(!states.empty())
	{
		auto s = states.back();
		states.pop_back();
		int type = s.nextType;

		auto i = s.components.begin(), end = s.components.end();
		bool found = false;
		while(i != end)
		{
			i = std::find_if(i, end,
			                 [type](auto&& t) { return (t.first == type || t.second == type); });
			if(i != end)
			{
				found = true;
				auto s2 = s;
				s2.nextType = (*i).first == type ? (*i).second : (*i).first;
				s2.bridge.push_back(*i);
				s2.bridgeStrength += (*i).first + (*i).second;
				s2.components.erase(find(s2.components.begin(), s2.components.end(), *i));
				states.push_back(s2);
				++i;
			}
		}
		if(!found)
		{
			if(s.bridgeStrength > bestBridgeStrength)
			{
				bestBridge = move(s.bridge);
				bestBridgeStrength = s.bridgeStrength;
			}
		}
	}
	//	printBridge(bestBridge);
	//	cout << bestBridgeStrength << endl;
	return bestBridgeStrength;
}

/*void unittest_part1()
{
    vector<string> input{"0/2", "2/2", "2/3", "3/4", "3/5", "0/1", "10/1", "9/10"};
    auto bestBridgeStrength = findStrongestBridge(input);
    assert(bestBridgeStrength == 31);
}*/

void solve_part1()
{
	auto input = readLines(INPUT_FILE);
	auto bestBridgeStrength = findStrongestBridge(input);
	cout << "Day 24 - part 1: " << bestBridgeStrength << endl;
}

// -- Part 2 --------------------------------------------------------------

int findStrongestLongestBridge(const vector<string>& componentsInput)
{
	Bridge bestBridge;
	int bestBridgeStrength{0};

	vector<State> states;
	State s;
	s.components = parseComponents(componentsInput);
	states.push_back(s);
	while(!states.empty())
	{
		auto s = states.back();
		states.pop_back();
		int type = s.nextType;

		auto i = s.components.begin(), end = s.components.end();
		bool found = false;
		while(i != end)
		{
			i = std::find_if(i, end,
			                 [type](auto&& t) { return (t.first == type || t.second == type); });
			if(i != end)
			{
				found = true;
				auto s2 = s;
				s2.nextType = (*i).first == type ? (*i).second : (*i).first;
				s2.bridge.push_back(*i);
				s2.bridgeStrength += (*i).first + (*i).second;
				s2.components.erase(find(s2.components.begin(), s2.components.end(), *i));
				states.push_back(s2);
				++i;
			}
		}
		if(!found)
		{
			if(s.bridge.size() > bestBridge.size() ||
			   (s.bridge.size() == bestBridge.size() && s.bridgeStrength > bestBridgeStrength))
			{
				bestBridge = move(s.bridge);
				bestBridgeStrength = s.bridgeStrength;
			}
		}
	}
	return bestBridgeStrength;
}

/*void unittest_part2()
{
    vector<string> input{"0/2", "2/2", "2/3", "3/4", "3/5", "0/1", "10/1", "9/10"};
    auto bestBridgeStrength = findStrongestLongestBridge(input);
    assert(bestBridgeStrength == 19);
}*/

void solve_part2()
{
	auto input = readLines(INPUT_FILE);
	auto bestBridgeStrength = findStrongestLongestBridge(input);
	cout << "Day 24 - part 2: " << bestBridgeStrength << endl;
}

//------------
int main()
{
	//	unittest_part1();
	solve_part1();
	//	unittest_part2();
	solve_part2();
	return 0;
}
