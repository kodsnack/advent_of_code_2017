// Advent of Code 2017 - Day 13
// Peter Westerström (digimatic)

#include "config.h"

#include <common/common.h>
#include <iostream>
#include <string>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

struct Layer
{
	Layer(int range = 0)
	    : range{range}
	{
	}
	int range{0};
	int current{0};
	int direction{1}; // -1 or 1

	void step()
	{
		current = current + direction;
		if(current == range)
		{
			current = range - 2;
			direction = -1;
		} else if(current == -1)
		{
			current = 1;
			direction = 1;
		}
	}

	bool isCaught() const
	{
		if(range == 0)
			return false;
		return current == 0;
	}
};

struct Firewall
{
	vector<Layer> layers;

	void step()
	{
		for(auto& layer : layers)
		{
			layer.step();
		}
	}

	bool isCaught(int currentLayer) const
	{
		return (layers[currentLayer].isCaught());
	}

	int severity(int currentLayer) const
	{
		if(isCaught(currentLayer))
		{
			return currentLayer * layers[currentLayer].range;
		} else
		{
			return 0;
		}
	}
};

Firewall parseFirewall(const vector<string>& lines)
{
	Firewall f;
	for(auto line : lines)
	{
		size_t pos;
		auto depth = stoi(line, &pos);
		auto range = stoi(line.substr(pos + 1));
		if(depth >= f.layers.size())
			f.layers.resize(depth + 1);
		f.layers[depth] = Layer(range);
	}
	return f;
}

int walkAndComputeTotalSeverity(Firewall firewall)
{
	int totalSeverity{0};
	for(int currentPos = 0; currentPos < firewall.layers.size(); ++currentPos)
	{
		totalSeverity += firewall.severity(currentPos);
		firewall.step();
	}
	return totalSeverity;
}

void solve_part1()
{
	auto input = readLines(INPUT_FILE);
	auto firewall = parseFirewall(input);

	auto totalSeverity = walkAndComputeTotalSeverity(firewall);
	cout << "Day 13 - part 1: " << totalSeverity << endl;
}

bool walkFirewall(Firewall firewall)
{
	for(int currentPos = 0; currentPos < firewall.layers.size(); ++currentPos)
	{
		if(firewall.isCaught(currentPos))
			return true;
		firewall.step();
	}
	return false;
}

void solve_part2()
{
	auto input = readLines(INPUT_FILE);
	auto firewall = parseFirewall(input);

	int startDelay = 0;
	while(true)
	{
		bool caught = walkFirewall(firewall);
		if(!caught)
			break;
		firewall.step();
		startDelay++;
	}

	cout << "Day 13 - part 2: " << startDelay << endl;
}

int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
