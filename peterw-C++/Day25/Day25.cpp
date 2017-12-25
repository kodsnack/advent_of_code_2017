// Advent of Code 2017 - Day 25
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <deque>
#include <iostream>
#include <string>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

enum class Direction
{
	Left,
	Right
};
class State;

class NextState
{
public:
	NextState(int v, Direction dir, int nextState)
	    : writeValue(v)
	    , dir(dir)
	    , state(nextState)
	{
	}
	int writeValue;
	Direction dir;
	int state; // 0 for A, 1 for B etc..

	void apply(State& s);
};

class StateNode
{
public:
	StateNode(NextState s0, NextState s1)
	    : next{s0, s1}
	{
	}
	NextState next[2];

	void apply(State& state);
};

class Tape
{
public:
	Tape()
	{
		tape.push_back(0);
	}

	int tapeZeroOffset{0};
	deque<int> tape;

	int position{0};

	void moveLeft()
	{
		position--;
		if(tapeZeroOffset + position < 0)
		{
			tape.push_front(0);
			tapeZeroOffset++;
		}
	}
	void moveRight()
	{
		position++;
		if(tapeZeroOffset + position >= tape.size())
		{
			tape.push_back(0);
		}
	}
	int read()
	{
		return tape[position + tapeZeroOffset];
	}
	void write(int value)
	{
		tape[position + tapeZeroOffset] = value;
	}

	void print()
	{
		for(int i = 0; i < tape.size(); ++i)
		{
			if(i - tapeZeroOffset == position)
			{
				cout << "[";
				cout << tape[i];
				cout << "] ";
			} else
			{
				cout << " " << tape[i] << "  ";
			}
		}
	}
};

class StateMachine
{
public:
	StateMachine(const vector<StateNode>& states)
	    : states(states)
	{
	}
	vector<StateNode> states;

	void apply(State& s);
};

class State
{
public:
	Tape tape;
	int currentState{0};

	void print()
	{
		tape.print();
		cout << " (" << currentState << ")" << endl;
	}
};

void StateNode::apply(State& s)
{
	next[s.tape.read()].apply(s);
}

void NextState::apply(State& s)
{
	s.tape.write(writeValue);
	if(dir == Direction::Left)
		s.tape.moveLeft();
	else
		s.tape.moveRight();
	s.currentState = state;
}

void StateMachine::apply(State& s)
{
	states[s.currentState].apply(s);
}

/*void unittest_part1()
{
    vector<StateNode> sn = {{{1, Direction::Right, 1}, {0, Direction::Left, 1}},
                            {{1, Direction::Left, 0}, {1, Direction::Right, 0}}};
    StateMachine sm(sn);
    State s;
    s.print();
    for(int i = 0; i < 6; i++)
    {
        sm.apply(s);
        s.print();
    }
    auto n = count(s.tape.tape.begin(), s.tape.tape.end(), 1);
    cout << n << endl;
    assert(n == 3);
}*/

void solve_part1()
{
	vector<StateNode> sn = {
	    {{1, Direction::Right, 1}, {0, Direction::Right, 5}}, // 0 A
	    {{0, Direction::Left, 1}, {1, Direction::Left, 2}},   // 1 B
	    {{1, Direction::Left, 3}, {0, Direction::Right, 2}},  // 2 C
	    {{1, Direction::Left, 4}, {1, Direction::Right, 0}},  // 3 D
	    {{1, Direction::Left, 5}, {0, Direction::Left, 3}},   // 4 E
	    {{1, Direction::Right, 0}, {0, Direction::Left, 4}},  // 5 F
	};
	StateMachine sm(sn);
	State s;
	for(int i = 0; i < 12425180; i++)
	{
		sm.apply(s);
	}
	auto n = count(s.tape.tape.begin(), s.tape.tape.end(), 1);
	cout << "Day 25 - part 1: " << n << endl;
}

//------------
int main()
{
	//	unittest_part1();
	solve_part1();
	return 0;
}
