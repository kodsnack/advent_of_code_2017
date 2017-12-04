// Advent of Code 2017 - Day 4
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <common/common.h>
#include <iostream>
#include <regex>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

vector<string> input;

template <typename WordCompare> bool parseAndValidateLine(const string& line)
{
	vector<string> words;

	regex rgx("\\s+");
	sregex_token_iterator iter(line.begin(), line.end(), rgx, -1);
	sregex_token_iterator end;
	while(iter != end)
	{
		auto word = *iter;
		if(find_if(words.begin(), words.end(),
		           [word](string& word2) { return WordCompare{}(word, word2); }) != words.end())
			return false;
		words.push_back(word);
		++iter;
	}
	return true;
}

template <typename WordCompare> int countValidPasswordPhases(const vector<string>& lines)
{
	int validCount = 0;
	for(auto& line : lines)
	{
		if(parseAndValidateLine<WordCompare>(line))
			validCount++;
	}
	return validCount;
}

void solve_day2_part1()
{
	auto validCount = countValidPasswordPhases<equal_to<string>>(input);
	cout << "Day 4 - part 1: " << validCount << endl;
}

auto getWordLetterCounts(const string& word)
{
	unordered_map<char, int> letterCount;
	for(auto c : word)
	{
		if(letterCount.find(c) == letterCount.end())
		{
			letterCount[c] = 1;
		} else
		{
			letterCount[c]++;
		}
	}
	return letterCount;
}

struct IsAnagram
{
	bool operator()(const string& w1, const string& w2)
	{
		auto c1 = getWordLetterCounts(w1);
		auto c2 = getWordLetterCounts(w2);
		return c1 == c2;
	}
};

void solve_day2_part2()
{
	auto letterCount = countValidPasswordPhases<IsAnagram>(input);
	cout << "Day 4 - part 2: " << letterCount << endl;
}

int main()
{
	input = readLines(INPUT_FILE);
	solve_day2_part1();
	solve_day2_part2();
	return 0;
}
