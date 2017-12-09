// Advent of Code 2017 - Day 5
// Peter Westerström (digimatic)

#include "config.h"

#include <common/common.h>
#include <iostream>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

vector<int> readAndParseInput()
{
	auto inputLines = readLines(INPUT_FILE);
	vector<int> offsetList;
	for(auto offsetStr : inputLines)
	{
		size_t pos;
		auto offset = stoi(offsetStr, &pos);
		offsetList.push_back(offset);
	}
	return offsetList;
}

void solve_part1()
{
	auto offsetList = readAndParseInput();
	auto length = offsetList.size();
	int currentIndex = 0;
	int stepCount = 0;
	while(currentIndex >= 0 && currentIndex < length)
	{
		currentIndex += offsetList[currentIndex]++;
		stepCount++;
	}
	cout << "Day 5 - part 1: " << stepCount << endl;
}

void solve_part2()
{
	auto offsetList = readAndParseInput();
	auto length = offsetList.size();
	int currentIndex = 0;
	int stepCount = 0;
	while(currentIndex >= 0 && currentIndex < length)
	{
		auto offset = offsetList[currentIndex];
		if(offset >= 3)
		{
			offsetList[currentIndex]--;
		} else
		{
			offsetList[currentIndex]++;
		}
		currentIndex += offset;
		stepCount++;
	}
	cout << "Day 5 - part 2: " << stepCount << endl;
}

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
