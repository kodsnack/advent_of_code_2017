// Advent of Code 2017 - Day 19
// Peter Westerström (digimatic)

#include "config.h"

#include <cassert>
#include <common/common.h>
#include <iostream>
#include <string>
#include <utility>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

pair<int, string> walkAndcollect(const vector<string>& g)
{

	int y{0};
	pair<int, int> d(0, 1);
	int x = static_cast<int>(g.at(0).find('|'));
	string collected;
	int stepCount{1};
	while(true)
	{
		x += d.first;
		y += d.second;
		auto c = g[y][x];
		if(c == '+')
		{
			// We have to turn, detect new direction
			if(abs(d.first) > 0)
			{
				if(g[y + 1][x] != ' ')
				{
					d = make_pair(0, 1);
				} else if(g[y - 1][x] != ' ')
				{
					d = make_pair(0, -1);
				} else
				{
					// the end
					break;
				}
			} else
			{
				if(g[y][x + 1] != ' ')
				{
					d = make_pair(1, 0);
				} else if(g[y][x - 1] != ' ')
				{
					d = make_pair(-1, 0);
				} else
				{
					// the end
					break;
				}
			}
		} else if(c >= 'A' && c <= 'Z')
		{
			collected += c;
		} else if(c == ' ')
		{
			// the end
			break;
		}
		stepCount++;
	}
	return make_pair(stepCount, collected);
}

/*void unittest_part1()
{
    vector<string> g = {
        "     |          ",
        "     |  +--+    ",
        "     A  |  C    ",
        " F---|----E|--+ ",
        "     |  |  |  D ",
        "     +B-+  +--+ ",
        "                "};
    auto[steps, collected] = walkAndcollect(g);
    assert(collected == "ABCDEF");
    assert(steps == 38);
}*/

void solve_part1And2()
{
	auto g = readLines(INPUT_FILE);
	auto[steps, collected] = walkAndcollect(g);
	cout << "Day 19 - part 1: " << collected << endl;
	cout << "Day 19 - part 2: " << steps << endl;
}

int main()
{
	//	unittest_part1();
	solve_part1And2();
	return 0;
}
