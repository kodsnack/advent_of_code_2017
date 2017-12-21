// Advent of Code 2017 - Day 17
// Peter Westerström (digimatic)

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <forward_list>
#include <iostream>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using RingBuffer = vector<int>;

int fillBuffer(int skipLength, int count)
{
	RingBuffer b;
	b.reserve(count + 1);
	b.push_back(0);
	int pos = 0;
	for(int i = 1; i <= count; ++i)
	{
		pos += skipLength;
		pos = pos % b.size();
		auto it = b.begin() + (pos + 1);
		b.insert(it, i);
		pos += 1;
	}

	pos += 1;
	pos = pos % b.size();
	return b[pos];
}

void unittest_part1()
{
	auto b = fillBuffer(3, 2017);
	assert(b == 638);
}

void solve_part1()
{
	auto b = fillBuffer(377, 2017);
	cout << "Day 17 - part 1: " << b << endl;
}

// inital solution, works but is very slow. Took minutes to solve..
int fillBuffer2(int skipLength, int count)
{
	forward_list<int> b;
	b.push_front(0);
	auto pos = b.begin();
	for(int i = 1; i <= count; ++i)
	{
		if(i % 100000 == 0)
			cout << 100.0f * float(i) / float(count) << "\%" << endl;
		for(int j = 0; j < skipLength; ++j)
		{
			++pos;
			if(pos == b.end())
				pos = b.begin();
		}
		pos = b.insert_after(pos, i);
	}

	auto it = find(b.begin(), b.end(), 0);
	++it;
	if(it == b.end())
		it = b.begin();
	return *it;
}

// New solution that is fast
int fillBuffer2_v2(int skipLength, int count)
{
	int pos = 0;
	int valueAtPos1 = -1;
	for(int i = 1; i <= count; ++i)
	{
		auto length = i;
		pos = ((pos + skipLength) % length) + 1;
		if(pos==1)
		{
			valueAtPos1 = i;
		}
		if(pos==0)
			throw std::exception(); // we need to find another algorithm...
	}
	if(valueAtPos1==-1)
		throw std::exception(); // we need to find another algorithm...
	return valueAtPos1;
}

// inital solution, works but is very slow. Took minutes to solve..
void solve_part2()
{
	auto b = fillBuffer2(377, 50000000);
	cout << "Day 17 - part 2: " << b << endl;
}

// New solution that is fast
void solve_part2_v2()
{
	auto b = fillBuffer2_v2(377, 50000000);
	cout << "Day 17 - part 2: " << b << endl;
}

int main()
{
	unittest_part1();
	solve_part1();
//	solve_part2(); // inital slow solution
	solve_part2_v2();
	return 0;
}
