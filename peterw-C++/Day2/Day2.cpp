// Advent of Code 2017 - Day 2
// Peter Westerström (digimatic)

#include "config.h"

#include <common/common.h>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

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

void solve_day2_part1()
{
	int checksum = 0;
	auto lines = readLines(INPUT_FILE);
	for(auto& line : lines)
	{
		auto numbers = parseLine(line);
		auto [ minValIt, maxValIt ] = minmax_element(numbers.begin(), numbers.end());
		checksum += *maxValIt - *minValIt;
	}

	cout << "Day 2 - part 1: " << checksum << endl;
}

int findDivisableAndDivide(const vector<int>& numbers)
{
	int l = numbers.size();
	for(int i=0;i<l-1;++i)
	{
		for(int j=i+1;j<l;++j)
		{
			if(numbers[i] % numbers[j] == 0)
			{
				return numbers[i] / numbers[j];
			} else if(numbers[j] % numbers[i] == 0)
			{
				return numbers[j] / numbers[i];
			}
		}
	}
	throw std::exception();
}

void solve_day2_part2()
{
	int checksum = 0;
	auto lines = readLines(INPUT_FILE);
	for(auto& line : lines)
	{
		auto numbers = parseLine(line);
		auto n = findDivisableAndDivide(numbers);
		checksum += n;
	}

	cout << "Day 2 - part 2: " << checksum << endl;
}

int main()
{
	solve_day2_part1();
	solve_day2_part2();
	return 0;
}
