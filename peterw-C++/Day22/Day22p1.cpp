// Advent of Code 2017 - Day 22
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <deque>
#include <iostream>
#include <string>
#include <utility>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using PatternRow = deque<bool>;
using Pattern = deque<PatternRow>;

Pattern parsePattern(const vector<string>& patternLines)
{
	Pattern pattern;
	for(auto& lineStr : patternLines)
	{
		PatternRow row;
		for(char c : lineStr)
		{
			switch(c)
			{
				case '#':
					row.push_back(true);
					break;
				case '.':
					row.push_back(false);
					break;
			}
		}
		pattern.push_back(row);
	}
	return pattern;
}

struct Vector2
{
	Vector2(int x = 0, int y = 0)
	    : x{x}
	    , y{y}
	{
	}

	Vector2& operator+=(const Vector2& that)
	{
		x += that.x;
		y += that.y;
		return *this;
	}

	int x{0}, y{0};
};

void expandPattern(Pattern& p)
{
	for(auto& row : p)
	{
		row.push_front(false);
		row.push_back(false);
	}
	deque<bool> row;
	row.resize(p[0].size());
	p.push_front(row);
	p.push_back(row);
}

struct State
{
	Pattern pattern;
	Vector2 pos;
	Vector2 dir{0, -1};
	int infectionCount{0};
};

int gridSize(const Pattern& pattern)
{
	auto n = (pattern.size() - 1) / 2;
	return n;
}

bool readAt(const Pattern& p, Vector2 pos)
{
	auto n = gridSize(p);
	if(pos.x < -n || pos.x > n || pos.y < -n || pos.y > n)
		return false;
	return p[n + pos.y][n + pos.x];
}

void writeAt(Pattern& p, Vector2 pos, bool v)
{
	while(true)
	{
		auto n = gridSize(p);
		if(pos.x < -n || pos.x > n || pos.y < -n || pos.y > n)
		{
			expandPattern(p);
		} else
		{
			break;
		}
	}
	auto n = gridSize(p);
	p[n + pos.y][n + pos.x] = v;
}

void turnRight(Vector2& dir)
{
	if(dir.x == 1)
	{
		dir = Vector2(0, 1);
	} else if(dir.x == -1)
	{
		dir = Vector2(0, -1);
	} else if(dir.y == 1)
	{
		dir = Vector2(-1, 0);
	} else
	{
		dir = Vector2(1, 0);
	}
}
void turnLeft(Vector2& dir)
{
	turnRight(dir);
	turnRight(dir);
	turnRight(dir);
}

void doBurst(State& s)
{
	if(readAt(s.pattern, s.pos))
	{
		turnRight(s.dir);
		writeAt(s.pattern, s.pos, false);
	} else
	{
		turnLeft(s.dir);
		writeAt(s.pattern, s.pos, true);
		s.infectionCount++;
	}
	s.pos += s.dir;
}

void printPattern(const Pattern& p)
{
	for(auto& row : p)
	{
		for(auto c : row)
		{
			cout << (c ? '#' : '.');
		}
		cout << endl;
	}
}

void unittest_part1()
{
	vector<string> lines = {"..#", "#..", "..."};
	State state;
	state.pattern = parsePattern(lines);
	printPattern(state.pattern);
	for(int i = 0; i < 70; i++)
	{
		doBurst(state);
		cout << "State after " << i + 1 << " bursts (infections=" << state.infectionCount << ")"
		     << endl;
		printPattern(state.pattern);
	}
	assert(state.infectionCount == 41);
}

void solve_part1()
{
	auto lines = readLines(INPUT_FILE);
	auto pattern = parsePattern(lines);

	State state;
	state.pattern = parsePattern(lines);
	for(int i = 0; i < 10000; i++)
	{
		doBurst(state);
	}
	cout << "Day 22 - part 1: " << state.infectionCount << endl;
}

//------------
int main()
{
	//	unittest_part1();
	solve_part1();
	return 0;
}
