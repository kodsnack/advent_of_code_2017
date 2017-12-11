// Advent of Code 2017 - Day 10
// Peter Westerström (digimatic)

#include "config.h"

#include <array>
#include <cassert>
#include <common/common.h>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

//-------------------
// Part 1
//-------------------

// the input for part 1
vector<int> lengths = {63, 144, 180, 149, 1, 255, 167, 84, 125, 65, 188, 0, 2, 254, 229, 24};

template <int N = 256> int doSwaps(const vector<int> lengths)
{
	array<int, N> circularList;
	for(int i = 0; i < N; i++)
		circularList[i] = i;
	int position = 0;
	int skip = 0;
	for(auto length : lengths)
	{
		for(int i = 0; i < length / 2; ++i)
		{
			int j1 = position + i;
			int j2 = position + length - 1 - i;
			swap(circularList[j1 % N], circularList[j2 % N]);
		}
		position += length + skip++;
		position = position % N;
	}

	auto product = circularList[0] * circularList[1];
	return product;
}

void solve_part1()
{
	assert(doSwaps<5>({3, 4, 1, 5}) == 12);

	auto product = doSwaps<256>(lengths);
	cout << "Day 10 - part 1: " << product << endl;
}

//-------------------
// Part 2
//-------------------

template <int N = 256>
int doSwaps(const vector<int> lengths, array<int, N>& circularList, int& position, int& skip)
{
	for(auto length : lengths)
	{
		for(int i = 0; i < length / 2; ++i)
		{
			int j1 = position + i;
			int j2 = position + length - 1 - i;
			swap(circularList[j1 % N], circularList[j2 % N]);
		}
		position += length + skip++;
		position = position % N;
	}

	auto product = circularList[0] * circularList[1];
	return product;
}

vector<int> getLengths()
{
	auto input = readLines(INPUT_FILE).at(0);
	vector<int> lengths;
	for(char c : input)
	{
		lengths.push_back(static_cast<int>(c));
	}
	vector<int> lengthsSuffix = {17, 31, 73, 47, 23};
	lengths.insert(lengths.end(), lengthsSuffix.begin(), lengthsSuffix.end());
	return lengths;
}

template <int N = 256> auto getStartList()
{
	array<int, N> circularList;
	for(int i = 0; i < N; i++)
		circularList[i] = i;
	return circularList;
}

auto computeSparseHash()
{
	auto lengths = getLengths();

	auto circularList = getStartList<256>();
	int position = 0;
	int skip = 0;
	for(int i = 0; i < 64; i++)
	{
		doSwaps<256>(lengths, circularList, position, skip);
	}

	return circularList;
}

auto computeDenseHash(const array<int, 256>& sparseHash)
{
	array<int, 16> denseHash;
	for(int i = 0; i < 16; ++i)
	{
		denseHash[i] = 0;
		for(int j = 0; j < 16; ++j)
		{
			denseHash[i] ^= sparseHash[16 * i + j];
		}
	}

	return denseHash;
}

std::string toHex(const array<int, 16>& values)
{
	std::stringstream stream;
	for(int v : values)
	{
		stream << setfill('0') << setw(2) << std::hex << static_cast<unsigned int>(v);
	}
	return stream.str();
}

void solve_part2()
{
	auto sparseHash = computeSparseHash();
	auto denseHash = computeDenseHash(sparseHash);
	auto hexStr = toHex(denseHash);
	cout << "Day 10 - part 2: " << hexStr << endl;
}

//------------------

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
