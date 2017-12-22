// Advent of Code 2017 - Day 22 part 2
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

enum class NodeState : uint8_t
{
	Clean,
	Weakened,
	Infected,
	Flagged
};

using PatternRow = deque<NodeState>;
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
					row.push_back(NodeState::Infected);
					break;
				case '.':
					row.push_back(NodeState::Clean);
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
		row.push_front(NodeState::Clean);
		row.push_back(NodeState::Clean);
	}
	PatternRow row;
	row.resize(p[0].size(), NodeState::Clean);
	p.push_front(row);
	p.push_back(row);
}

void printPattern(const Pattern& p)
{
	for(auto& row : p)
	{
		for(auto c : row)
		{
			switch(c)
			{
				case NodeState::Clean:
					cout << '.';
					break;
				case NodeState::Weakened:
					cout << 'W';
					break;
				case NodeState::Infected:
					cout << '#';
					break;
				case NodeState::Flagged:
					cout << 'F';
					break;
			}
		}
		cout << endl;
	}
}
struct State
{
	Pattern pattern;
	Vector2 pos;
	Vector2 dir{0, -1};
	int infectionCount{0};

	void print() const
	{
		cout << "pos=" << pos.x << "," << pos.y << endl;
		cout << "dir=" << dir.x << "," << dir.y << endl;
		cout << "# = " << infectionCount << endl;
		printPattern(pattern);
	}
};

int gridSize(const Pattern& pattern)
{
	assert(pattern.size() % 2 == 1);
	assert(pattern[0].size() % 2 == 1);
	assert(pattern.size() == pattern[0].size());
	auto n = (pattern.size() - 1) / 2;
	return n;
}

NodeState readAt(const Pattern& p, Vector2 pos)
{
	auto n = gridSize(p);
	if(pos.x < -n || pos.x > n || pos.y < -n || pos.y > n)
		return NodeState::Clean;
	return p[n + pos.y][n + pos.x];
}

void writeAt(Pattern& p, Vector2 pos, NodeState v)
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
	switch(readAt(s.pattern, s.pos))
	{
		case NodeState::Clean:
			turnLeft(s.dir);
			writeAt(s.pattern, s.pos, NodeState::Weakened);
			break;
		case NodeState::Weakened:
			writeAt(s.pattern, s.pos, NodeState::Infected);
			s.infectionCount++;
			break;
		case NodeState::Infected:
			turnRight(s.dir);
			writeAt(s.pattern, s.pos, NodeState::Flagged);
			break;
		case NodeState::Flagged:
			turnRight(s.dir);
			turnRight(s.dir);
			writeAt(s.pattern, s.pos, NodeState::Clean);
			break;
		default:
			throw - 1;
	}
	s.pos += s.dir;
}

/*void unittest_part2()
{
    vector<string> lines = { "..#", "#..", "..." };
    State state;
    state.pattern = parsePattern(lines);
    int i=0;
    for(;i<8;i++)
    {
        doBurst(state);
    }
    assert(state.infectionCount==1);
    for(;i<100;i++)
    {
        doBurst(state);
    }
    assert(state.infectionCount == 26);
    for(;i<10000000;i++)
    {
        doBurst(state);
    }
    assert(state.infectionCount==2511944);
}*/

void solve_part2()
{
	auto lines = readLines(INPUT_FILE);
	auto pattern = parsePattern(lines);

	State state;
	state.pattern = parsePattern(lines);
	for(int i = 0; i < 10000000; i++)
	{
		doBurst(state);
	}
	cout << "Day 22 - part 2: " << state.infectionCount << endl;
}

//------------
int main()
{
	//	unittest_part2();
	solve_part2();
	return 0;
}
