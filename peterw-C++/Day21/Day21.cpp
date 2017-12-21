// Advent of Code 2017 - Day 21
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <iostream>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

using Pattern = vector<vector<bool>>;
using PatternRule = pair<Pattern, Pattern>;
using PatternRules = vector<PatternRule>;

Pattern parsePattern(const string& patternStr)
{
	Pattern pattern;

	vector<bool> line;
	for(char c : patternStr)
	{
		switch(c)
		{
			case '#':
				line.push_back(true);
				break;
			case '.':
				line.push_back(false);
				break;
			case '/':
				pattern.push_back(line);
				line.clear();
				break;
		}
	}
	if(!line.empty())
		pattern.push_back(line);
	return pattern;
}

PatternRule parsePatternRule(const string& patternRuleStr)
{
	PatternRule patternRule;

	auto pos = patternRuleStr.find(" => ");
	auto pstr1 = patternRuleStr.substr(0, pos);
	auto pstr2 = patternRuleStr.substr(pos + 4);
	auto patt1 = parsePattern(pstr1);
	auto patt2 = parsePattern(pstr2);
	return make_pair(patt1, patt2);
}

PatternRules parsePatternRules(const vector<string>& lines)
{
	PatternRules patternRules;
	for(auto& line : lines)
	{
		auto patternRule = parsePatternRule(line);
		patternRules.push_back(patternRule);
	}
	return patternRules;
}

Pattern createPattern(int patternSize)
{
	Pattern r;
	r.resize(patternSize);
	for(auto& l : r)
		l.resize(patternSize);
	return r;
}

Pattern read2x2At(const Pattern& p, int x, int y)
{
	auto r = createPattern(2);
	r[0][0] = p[y][x];
	r[0][1] = p[y][x + 1];
	r[1][0] = p[y + 1][x];
	r[1][1] = p[y + 1][x + 1];
	return r;
}

Pattern read3x3At(const Pattern& p, int x, int y)
{
	auto r = createPattern(3);

	r[0][0] = p[y][x];
	r[0][1] = p[y][x + 1];
	r[0][2] = p[y][x + 2];

	r[1][0] = p[y + 1][x];
	r[1][1] = p[y + 1][x + 1];
	r[1][2] = p[y + 1][x + 2];

	r[2][0] = p[y + 2][x];
	r[2][1] = p[y + 2][x + 1];
	r[2][2] = p[y + 2][x + 2];
	return r;
}

void writeAt(Pattern& r, const Pattern& p, int x, int y)
{
	auto d = p.size();
	for(int yi = 0; yi < d; ++yi)
	{
		for(int xi = 0; xi < d; ++xi)
		{
			r[y + yi][x + xi] = p[yi][xi];
		}
	}
}

struct Vector2
{
	Vector2(int x = 0, int y = 0)
	    : x{x}
	    , y{y}
	{
	}

	Vector2& operator+=(const Vector2& that)
	{
		x += that.x;
		y += that.y;
		return *this;
	}

	int x{0}, y{0};
};

bool patternVariantCompare(const Pattern& patt1, const Pattern& patt2, Vector2 center,
                           Vector2 deltaRight, Vector2 deltaDown)
{
	auto d = patt1.size();
	Vector2 p1 = center;
	for(int y2 = 0; y2 < d; ++y2)
	{
		auto p1b = p1;
		for(int x2 = 0; x2 < d; ++x2)
		{
			if(patt1[p1b.y][p1b.x] != patt2[y2][x2])
				return false;
			p1b += deltaRight;
		}
		p1 += deltaDown;
	}
	return true;
}

bool patternVariantsCompare(const Pattern& p1, const Pattern& p2)
{
	if(p1.size() != p2.size())
		return false;
	assert(p1.size() == p2.size());
	auto d = static_cast<int>(p1.size());

	return
	    // Rotated
	    patternVariantCompare(p1, p2, Vector2(0, 0), Vector2(1, 0), Vector2(0, 1)) ||
	    patternVariantCompare(p1, p2, Vector2(d - 1, 0), Vector2(0, 1), Vector2(-1, 0)) ||
	    patternVariantCompare(p1, p2, Vector2(d - 1, d - 1), Vector2(-1, 0), Vector2(0, -1)) ||
	    patternVariantCompare(p1, p2, Vector2(0, d - 1), Vector2(0, -1), Vector2(1, 0)) ||
	    // Mirrored
	    patternVariantCompare(p1, p2, Vector2(0, 0), Vector2(0, 1), Vector2(1, 0)) ||
	    patternVariantCompare(p1, p2, Vector2(d - 1, 0), Vector2(-1, 0), Vector2(0, 1)) ||
	    patternVariantCompare(p1, p2, Vector2(d - 1, d - 1), Vector2(0, -1), Vector2(-1, 0)) ||
	    patternVariantCompare(p1, p2, Vector2(0, d - 1), Vector2(1, 0), Vector2(0, -1));
}

Pattern findAndApplyPatternRule(const PatternRules& patternRules, const Pattern& inputPattern)
{
	for(auto& patternRule : patternRules)
	{
		if(patternVariantsCompare(patternRule.first, inputPattern))
		{
			return patternRule.second;
		}
	}
	throw std::exception(); // no pattern that match
}

Pattern generateNext(const Pattern& p, const PatternRules& patternRules)
{
	auto d = static_cast<int>(p[0].size());
	if(d % 2 == 0)
	{
		auto outputPattern = createPattern((d / 2) * 3);
		for(int y = 0; y < d; y += 2)
		{
			for(int x = 0; x < d; x += 2)
			{
				auto subPatt = read2x2At(p, x, y);
				auto newPatt = findAndApplyPatternRule(patternRules, subPatt);
				writeAt(outputPattern, newPatt, x / 2 * 3, y / 2 * 3);
			}
		}
		return outputPattern;
	} else
	{
		auto outputPattern = createPattern((d / 3) * 4);
		for(int y = 0; y < d; y += 3)
		{
			for(int x = 0; x < d; x += 3)
			{
				auto subPatt = read3x3At(p, x, y);
				auto newPatt = findAndApplyPatternRule(patternRules, subPatt);
				writeAt(outputPattern, newPatt, x / 3 * 4, y / 3 * 4);
			}
		}
		return outputPattern;
	}
}

const Pattern startPattern = {{false, true, false}, {false, false, true}, {true, true, true}};

void printPattern(const Pattern& p)
{
	for(auto& row : p)
	{
		for(auto c : row)
		{
			cout << (c ? '#' : '.');
		}
		cout << endl;
	}
}

int countPixelsSet(const Pattern& p)
{
	int count{0};
	for(auto& row : p)
	{
		for(auto c : row)
		{
			if(c)
				count++;
		}
	}
	return count;
}

/*void unittest_part1()
{
    vector<string> lines = {"../.# => ##./#../...",
                            ".#./..#/### => #..#/..../..../#..#"};
    auto patterns = parsePatternRules(lines);

    auto g = startPattern;
    cout << "0:" << endl;
    printPattern(g);
    for(int i = 1; i <= 2; i++)
    {
        g = generateNext(g, patterns);
        cout << i << ":" << endl;
        printPattern(g);
    }
    assert(countPixelsSet(g) == 12);
}*/

void solve_part1And2()
{
	auto lines = readLines(INPUT_FILE);
	auto patterns = parsePatternRules(lines);

	auto g = startPattern;
	for(int i = 0; i < 5; i++)
	{
		g = generateNext(g, patterns);
	}
	cout << "Day 21 - part 1: " << countPixelsSet(g) << endl;

	for(int i = 0; i < 18 - 5; i++)
	{
		g = generateNext(g, patterns);
	}
	cout << "Day 21 - part 2: " << countPixelsSet(g) << endl;
}

//------------
int main()
{
	//	unittest_part1();
	solve_part1And2();
	return 0;
}
