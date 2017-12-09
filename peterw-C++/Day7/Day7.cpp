// Advent of Code 2017 - Day 7
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <iostream>
#include <iterator>
#include <memory>
#include <regex>
#include <string>
#include <variant>
#include <vector>

using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

struct Tower
{
	string name;
	int weight;
	vector<string> subTowers;
};

vector<Tower> readAndParse()
{
	vector<Tower> towers;

	auto inputLines = readLines(INPUT_FILE);
	for(auto& line : inputLines)
	{
		Tower tower;

		regex r("(\\w+)\\s+\\((\\d+)\\)(\\s+->\\s*(.*))?");
		smatch m;
		bool b = regex_match(line, m, r);
		auto l = m.size();
		tower.name = m[1].str();
		tower.weight = stoi(m[2].str());

		vector<string> subtowerNames;
		if(m[3].matched)
		{
			auto subTowersStr = m[4].str();
			regex rgx(",\\s+");
			sregex_token_iterator iter(subTowersStr.begin(), subTowersStr.end(), rgx, -1);
			std::sregex_token_iterator end;
			for(; iter != end; ++iter)
			{
				auto s = *iter;
				tower.subTowers.push_back(s);
			}
		}
		towers.push_back(tower);
	}
	return towers;
}

struct TowerNode
{
	string name;
	int weight;
	vector<shared_ptr<TowerNode>> subTowers;
};

struct TowerTree
{
	vector<shared_ptr<TowerNode>> rootNodes;
};

TowerTree buildTowerTree(vector<Tower>& towers)
{
	TowerTree tree;
	for(auto& tower : towers)
	{
		auto towerNode = make_unique<TowerNode>();
		towerNode->name = tower.name;
		towerNode->weight = tower.weight;
		tree.rootNodes.push_back(move(towerNode));
	}

	auto allNodes = tree.rootNodes;

	for(auto& tower : towers)
	{
		if(tower.subTowers.empty())
			continue;

		auto name = tower.name;
		auto nodeIt = find_if(allNodes.begin(), allNodes.end(),
		                      [name](auto& node) { return node->name == name; });
		assert(nodeIt != allNodes.end());
		auto node = *nodeIt;

		for(auto& subName : tower.subTowers)
		{
			auto subIt = find_if(tree.rootNodes.begin(), tree.rootNodes.end(),
			                     [subName](auto& node) { return node->name == subName; });
			assert(subIt != tree.rootNodes.end());
			auto subTower = (*subIt);
			node->subTowers.push_back(subTower);
			tree.rootNodes.erase(subIt);
		}
	}
	return tree;
}

struct Weight
{
	Weight(int value)
	    : value{value}
	{
	}
	int value;
};
struct WeightCorrection
{
	WeightCorrection(int value)
	    : value{value}
	{
	}
	int value;
};
using WeightOrCorrection = variant<Weight, WeightCorrection>;

WeightOrCorrection getTotalWeightOrCorrection(const TowerNode& node)
{
	if(node.subTowers.empty())
		return Weight(node.weight);

	auto w = getTotalWeightOrCorrection(*(node.subTowers.at(0)));
	if(holds_alternative<WeightCorrection>(w))
		return w;

	vector<pair<shared_ptr<TowerNode>, int>> weights;
	weights.reserve(node.subTowers.size());
	auto totalWeight = node.weight;
	for(auto child : node.subTowers)
	{
		auto w = getTotalWeightOrCorrection(*child);
		if(holds_alternative<WeightCorrection>(w))
			return w;
		auto childWeight = get<Weight>(w).value;
		weights.push_back(make_pair(child, childWeight));
		totalWeight += childWeight;
	}
	sort(weights.begin(), weights.end(), [](auto& a, auto& b) { return a.second < b.second; });
	if(weights.size() >= 3)
	{
		auto lastIndex = weights.size() - 1;
		if(weights[0].second != weights[lastIndex].second)
		{
			if(weights[0].second != weights[1].second)
			{
				auto diff = weights[0].second - weights[1].second;
				return WeightCorrection(weights[0].first->weight - diff);
			} else
			{
				auto diff = weights[lastIndex].second - weights[0].second;
				return WeightCorrection(weights[lastIndex].first->weight - diff);
			}
		}
	}
	return Weight(totalWeight);
}

void solve_part1And2()
{
	// Part1
	auto towers = readAndParse();
	auto towerTree = buildTowerTree(towers);
	assert(towerTree.rootNodes.size() == 1);
	auto root = towerTree.rootNodes.at(0);
	cout << "Day 7 - part 1: " << root->name << endl;

	// Part2
	auto correctWeight = getTotalWeightOrCorrection(*root);
	auto w = get<WeightCorrection>(correctWeight).value;
	cout << "Day 7 - part 2: " << w << endl;
}

int main()
{
	solve_part1And2();
	return 0;
}
