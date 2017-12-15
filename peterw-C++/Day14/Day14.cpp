// Advent of Code 2017 - Day 14
// Peter Westerström (digimatic)

#include "KnotHash.h"
#include <array>
#include <iostream>
#include <string>


using namespace std;
using namespace std::string_literals;

auto input = "hfdlxzhv"s;

void solve_part1()
{
	int bitCount = 0;
	for(int row = 0; row < 128; row++)
	{
		auto rowStr = input + "-" + to_string(row);
		auto h = knotHash(rowStr);
		for(auto x : h)
		{
			while(x != 0)
			{
				if((x & 1) == 1)
				{
					bitCount++;
				}
				x = x >> 1;
			}
		}
	}

	cout << "Day 14 - part 1: " << bitCount << endl;
}

using Grid = std::array<std::array<bool, 128>, 128>;

Grid buildGrid(const string& input)
{
	Grid grid;
	for(int row = 0; row < 128; row++)
	{
		auto rowStr = input + "-" + to_string(row);
		auto h = knotHash(rowStr);
		int x0 = 0;
		for(auto c : h)
		{
			for(int x = 0; x < 8; x++)
			{
				grid[row][x0 + x] = (c & 128) != 0;
				c = c << 1;
			}
			x0 += 8;
		}
	}
	return grid;
}

bool clearAdjacent(Grid& grid, int x, int y)
{
	if(x < 0 || x >= 128 || y < 0 || y >= 128 || !grid[y][x])
		return false;

	grid[y][x] = false;
	clearAdjacent(grid, x + 1, y);
	clearAdjacent(grid, x - 1, y);
	clearAdjacent(grid, x, y + 1);
	clearAdjacent(grid, x, y - 1);
	return true;
}

void solve_part2()
{
	auto grid = buildGrid(input);
	int groupCount = 0;
	for(int y = 0; y < 128; ++y)
	{
		for(int x = 0; x < 128; ++x)
		{
			if(clearAdjacent(grid, x, y))
			{
				groupCount++;
			}
		}
	}

	cout << "Day 14 - part 2: " << groupCount << endl;
}

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
