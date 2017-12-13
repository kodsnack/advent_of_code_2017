// Advent of Code 2017 - Day 11
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <iostream>
#include <regex>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

//-------------------
// Part 1
//-------------------

enum class Direction
{
	n,
	ne,
	se,
	s,
	sw,
	nw
};

vector<Direction> parsePathString(const string& pathStr)
{
	vector<Direction> steps;

	std::regex rgx(",");
	std::sregex_token_iterator iter(pathStr.begin(), pathStr.end(), rgx, -1);
	std::sregex_token_iterator end;
	for(; iter != end; ++iter)
	{
		auto dir = *iter;
		if(dir == "n")
		{
			steps.push_back(Direction::n);
		} else if(dir == "ne")
		{
			steps.push_back(Direction::ne);
		} else if(dir == "se")
		{
			steps.push_back(Direction::se);
		} else if(dir == "s")
		{
			steps.push_back(Direction::s);
		} else if(dir == "sw")
		{
			steps.push_back(Direction::sw);
		} else if(dir == "nw")
		{
			steps.push_back(Direction::nw);
		} else
		{
			throw exception();
		}
	}
	return steps;
}

struct Position
{
	int x{0}, y{0}, z{0};
};

Position doStep(const Position& position, Direction stepDir)
{
	auto newPos = position;
	switch(stepDir)
	{
		case Direction::n:
			newPos.y++;
			newPos.z++;
			break;
		case Direction::ne:
			newPos.x++;
			newPos.y++;
			break;
		case Direction::se:
			newPos.x++;
			newPos.z--;
			break;
		case Direction::s:
			newPos.y--;
			newPos.z--;
			break;
		case Direction::sw:
			newPos.x--;
			newPos.y--;
			break;
		case Direction::nw:
			newPos.x--;
			newPos.z++;
			break;
		default:
			throw exception();
	}
	return newPos;
}

int distanceFromCenter(const Position& position)
{
	return max(max(abs(position.x), abs(position.y)), abs(position.z));
}

Position doSteps(const Position& startPosition, vector<Direction> steps)
{
	auto pos = startPosition;
	for(auto stepDir : steps)
	{
		pos = doStep(pos, stepDir);
	}
	return pos;
}

/*void unitTest()
{
	// Unit test
	assert(distanceFromCenter(doSteps(Position{}, parsePathString("ne,ne,ne"))) == 3);
	assert(distanceFromCenter(doSteps(Position{}, parsePathString("ne,ne,sw,sw"))) == 0);
	assert(distanceFromCenter(doSteps(Position{}, parsePathString("ne,ne,s,s"))) == 2);
	assert(distanceFromCenter(doSteps(Position{}, parsePathString("se,sw,se,sw,sw"))) == 3);
}*/

void solve_part1()
{
	string input = readLines(INPUT_FILE).at(0);
	auto steps = parsePathString(input);
	auto finalPosition = doSteps(Position{}, steps);
	auto dist = distanceFromCenter(finalPosition);
	cout << "Day 11 - part 1: " << dist << endl;
}

//-------------------
// Part 2
//-------------------
void solve_part2()
{
	string input = readLines(INPUT_FILE).at(0);
	auto steps = parsePathString(input);

	int maxDistance{0};
	Position pos;
	for(auto stepDir : steps)
	{
		pos = doStep(pos, stepDir);
		maxDistance = max(maxDistance, distanceFromCenter(pos));
	}

	cout << "Day 11 - part 2: " << maxDistance << endl;
}

//------------------

int main()
{
//	unitTest();
	solve_part1();
	solve_part2();
	return 0;
}
