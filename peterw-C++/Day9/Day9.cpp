// Advent of Code 2017 - Day 9
// Peter Westerström (digimatic)

#include "config.h"

#include <cassert>
#include <common/common.h>
#include <iostream>
#include <stack>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

int parseAndComputeScore(const string& input)
{
	int score = 0;
	stack<char> scopeStack;
	int depth = 0;
	for(char c : input)
	{
		switch(c)
		{
			case '{':
				if(scopeStack.empty() || (scopeStack.top() != '!' && scopeStack.top() != '<'))
				{
					depth++;
					scopeStack.push('{');
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '<':
				if(scopeStack.empty() || (scopeStack.top() != '!' && scopeStack.top() != '<'))
				{
					scopeStack.push('<');
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '>':
				if(!scopeStack.empty() && scopeStack.top() == '<')
				{
					scopeStack.pop();
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '}':
				if(!scopeStack.empty() && scopeStack.top() != '!' && scopeStack.top() != '<')
				{
					score += depth;
					depth--;
					scopeStack.pop();
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '!':
				if(!scopeStack.empty() && scopeStack.top() != '!')
				{
					scopeStack.push('!');
				} else if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			default:
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
		}
	}
	assert(scopeStack.empty());
	return score;
}

void solve_part1()
{
	// Unit test
	// assert(parseAndComputeScore("{}")==1);
	// assert(parseAndComputeScore("{{{}}}")==6);
	// assert(parseAndComputeScore("{{},{}}")==5);
	// assert(parseAndComputeScore("{{{},{},{{}}}}")==16);
	// assert(parseAndComputeScore("{<a>,<a>,<a>,<a>}")==1);
	// assert(parseAndComputeScore("{{<ab>},{<ab>},{<ab>},{<ab>}}")==9);
	// assert(parseAndComputeScore("{{<!!>},{<!!>},{<!!>},{<!!>}}")==9);
	// assert(parseAndComputeScore("{{<a!>},{<a!>},{<a!>},{<ab>}}")==3);

	auto input = readLines(INPUT_FILE).at(0);
	auto score = parseAndComputeScore(input);
	cout << "Day 9 - part 1: " << score << endl;
}

int parseAndComputeGarbage(const string& input)
{
	int garbageCount = 0;
	stack<char> scopeStack;
	int depth = 0;
	for(char c : input)
	{
		switch(c)
		{
			case '{':
				if(!scopeStack.empty() && scopeStack.top() == '<')
				{
					garbageCount++;
				}

				if(scopeStack.empty() || (scopeStack.top() != '!' && scopeStack.top() != '<'))
				{
					scopeStack.push('{');
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '<':
				if(!scopeStack.empty() && scopeStack.top() == '<')
				{
					garbageCount++;
				}

				if(scopeStack.empty() || (scopeStack.top() != '!' && scopeStack.top() != '<'))
				{
					scopeStack.push('<');
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '>':
				if(!scopeStack.empty() && scopeStack.top() == '<')
				{
					scopeStack.pop();
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '}':
				if(!scopeStack.empty() && scopeStack.top() == '<')
				{
					garbageCount++;
				}

				if(!scopeStack.empty() && scopeStack.top() != '!' && scopeStack.top() != '<')
				{
					scopeStack.pop();
				}
				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			case '!':
				if(!scopeStack.empty() && scopeStack.top() != '!')
				{
					scopeStack.push('!');
				} else if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
			default:
				if(!scopeStack.empty() && scopeStack.top() == '<')
				{
					garbageCount++;
				}

				if(!scopeStack.empty() && scopeStack.top() == '!')
				{
					scopeStack.pop();
				}
				break;
		}
	}
	assert(scopeStack.empty());
	return garbageCount;
}

void solve_part2()
{
	// Unit test
	// assert(parseAndComputeGarbage(R"raw(<{o"i!a,<{i<a>)raw")==10);

	auto input = readLines(INPUT_FILE).at(0);
	auto garbageAmount = parseAndComputeGarbage(input);
	cout << "Day 9 - part 2: " << garbageAmount << endl;
}

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
