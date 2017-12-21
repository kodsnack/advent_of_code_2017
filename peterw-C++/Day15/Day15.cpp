// Advent of Code 2017 - Day 13
// Peter Westerström (digimatic)

#include <cassert>
#include <common/common.h>
#include <iostream>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

template <unsigned int multiplier, typename Criteria> class Generator
{
public:
	Generator(unsigned int startValue)
	    : current(startValue)
	{
	}

	unsigned int getCurrent() const
	{
		return current;
	}

	unsigned int next()
	{
		Criteria c;
		do
		{
			current = static_cast<unsigned int>(
			    (static_cast<uint64_t>(current) * static_cast<uint64_t>(multiplier)) %
			    0x7fffffffULL);
		} while(!c(current));
		return current;
	}

private:
	unsigned int current;
};

template <typename GeneratorA, typename GeneratorB>
int countPairs(GeneratorA& a, GeneratorB& b, int pairCount)
{
	int matchCount{0};
	for(int i = 0; i < pairCount; i++)
	{
		a.next();
		b.next();
		if((a.getCurrent() & 0xffff) == (b.getCurrent() & 0xffff))
			matchCount++;
	}
	return matchCount;
}

struct AnyOk
{
	bool operator()(unsigned int v) const
	{
		return true;
	}
};

/*void unittest()
{
    Generator<16807, AnyOk> a(65);
    Generator<48271, AnyOk> b(8921);
    auto matchCount = countPairs(a, b, 40000000);
    assert(matchCount == 588);
}*/

void solve_part1()
{
	Generator<16807, AnyOk> a(679);
	Generator<48271, AnyOk> b(771);
	auto matchCount = countPairs(a, b, 40000000);
	cout << "Day 15 - part 1: " << matchCount << endl;
}

struct DividableBy4
{
	bool operator()(unsigned int v) const
	{
		return v % 4 == 0;
	}
};

struct DividableBy8
{
	bool operator()(unsigned int v) const
	{
		return v % 8 == 0;
	}
};

/*void unittest2()
{
    Generator<16807, DividableBy4> a(65);
    Generator<48271, DividableBy8> b(8921);
    auto matchCount = countPairs(a, b, 5000000);
    assert(matchCount == 309);
}*/

void solve_part2()
{
	Generator<16807, DividableBy4> a(679);
	Generator<48271, DividableBy8> b(771);
	auto matchCount = countPairs(a, b, 5000000);
	cout << "Day 15 - part 2: " << matchCount << endl;
}

int main()
{
	//	unittest();
	solve_part1();
	//	unittest2();
	solve_part2();
	return 0;
}
