// Advent of Code 2017 - Day 20
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <iostream>
#include <string>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

struct Vector3
{
	Vector3(int x = 0, int y = 0, int z = 0)
	    : x{x}
	    , y{y}
	    , z{z} {};
	int x, y, z;

	int distance() const
	{
		return abs(x) + abs(y) + abs(z);
	}

	Vector3& operator+=(const Vector3& p)
	{
		x += p.x;
		y += p.y;
		z += p.z;
		return *this;
	}

	bool operator==(const Vector3& p) const
	{
		return x == p.x && y == p.y && z == p.z;
	}
};

struct Particle
{
	Vector3 p;
	Vector3 v;
	Vector3 a;

	void step()
	{
		v += a;
		p += v;
	}
};

using Particles = vector<Particle>;

Vector3 parseVector3(const string& vecStr)
{
	size_t pos{0};
	size_t count;
	auto x = stoi(vecStr.substr(pos), &count);
	pos += count + 1;
	auto y = stoi(vecStr.substr(pos), &count);
	pos += count + 1;
	auto z = stoi(vecStr.substr(pos), &count);
	return Vector3(x, y, z);
}

Particle parseParticle(const string& particleStr)
{
	Particle part;
	size_t pos{0};
	pos = particleStr.find("p=<");
	part.p = parseVector3(particleStr.substr(pos + 3));

	pos = particleStr.find("v=<");
	part.v = parseVector3(particleStr.substr(pos + 3));

	pos = particleStr.find("a=<");
	part.a = parseVector3(particleStr.substr(pos + 3));

	return part;
}

Particles parseParticles(const vector<string>& particleLines)
{
	vector<Particle> particles;
	for(auto& partStr : particleLines)
	{
		particles.push_back(parseParticle(partStr));
	}
	return particles;
}

void updateParticles(Particles& particles)
{
	for(auto& p : particles)
	{
		p.step();
	}
}

void solve_part1()
{
	auto particles = parseParticles(readLines(INPUT_FILE));
	auto minIt = min_element(particles.begin(), particles.end(), [](auto&& p1, auto&& p2) {
		return p1.a.distance() < p2.a.distance();
	});
	auto i = distance(particles.begin(), minIt);
	cout << "Day 20 - part 1: " << i << endl;
}

//------------
// part 2
//------------

void removeCollisions(Particles& particles)
{
	for(auto it1 = particles.begin(); it1 != particles.end();)
	{
		bool didCollide = false;
		for(auto it2 = it1 + 1; it2 != particles.end();)
		{
			if(it1->p == it2->p)
			{
				it2 = particles.erase(it2);
				didCollide = true;
			} else
			{
				++it2;
			}
		}

		if(didCollide)
		{
			it1 = particles.erase(it1);
		} else
		{
			++it1;
		}
	}
}

void solve_part2()
{
	auto particles = parseParticles(readLines(INPUT_FILE));
	for(int i = 0; i < 50; ++i)
	{
		updateParticles(particles);
		removeCollisions(particles);
		cout << "t=" << i << ", particle count: " << particles.size() << endl;
	}
	cout << "Day 20 - part 2: " << particles.size() << endl;
}

//------------
int main()
{
	solve_part1();
	solve_part2();
	return 0;
}
