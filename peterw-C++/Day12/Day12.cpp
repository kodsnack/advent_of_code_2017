// Advent of Code 2017 - Day 12
// Peter Westerström (digimatic)

#include "config.h"

#include <algorithm>
#include <cassert>
#include <common/common.h>
#include <iostream>
#include <queue>
#include <regex>
#include <string>


using namespace std;
using namespace std::string_literals;
using namespace westerstrom;

//-------------------
// Part 1
//-------------------

struct Node
{
	Node(int id = -1)
	    : id{id}
	{
	}
	int id{-1};
	vector<int> children;
	bool visited{false};
};

using Graph = vector<Node>;

Graph parseLines(const vector<string>& inputLines)
{
	Graph g;
	regex rgx("(\\w+) <-> (.*)");
	regex rgx2(",\\s+");

	for(auto line : inputLines)
	{
		smatch m;
		bool b = regex_match(line, m, rgx);
		Node node(stoi(m[1].str()));

		auto childrenListStr = m[2].str();

		sregex_token_iterator iter(childrenListStr.begin(), childrenListStr.end(), rgx2, -1);
		std::sregex_token_iterator end;
		for(; iter != end; ++iter)
		{
			node.children.push_back(stoi(*iter));
		}
		g.resize(node.id + 1);
		g[node.id] = node;
	}
	return g;
}

Graph readAndParse()
{
	auto inputLines = readLines(INPUT_FILE);
	return parseLines(inputLines);
}

int traverse(Graph& g, int start)
{
	int visitedCount = 0;
	queue<int> pending;
	pending.push(start);
	while(!pending.empty())
	{
		auto n = pending.front();
		pending.pop();
		if(!g[n].visited)
		{
			visitedCount++;
			g[n].visited = true;
			for(auto c : g[n].children)
			{
				pending.push(c);
			}
		}
	}
	return visitedCount;
}

/*void unittest()
{
    vector<string> lines = {
        "0 <-> 2",
        "1 <-> 1",
        "2 <-> 0, 3, 4",
        "3 <-> 2, 4",
        "4 <-> 2, 3, 6",
        "5 <-> 6",
        "6 <-> 4, 5" };
    
    auto graph = parseLines(lines);
    assert(graph.size() == 7);
    assert(graph[0].children.size() == 1);
    assert(graph[1].children.size() == 1);
    assert(graph[2].children.size() == 3);
    assert(graph[3].children.size() == 2);
    auto visitedCount = traverse(graph, 0);
    assert(visitedCount == 6);
}*/

void solve_part1()
{
	auto graph = readAndParse();
	auto visitedCount = traverse(graph, 0);
	cout << "Day 12 - part 1: " << visitedCount << endl;
}

//-------------------
// Part 2
//-------------------

int isolatedGroupCount(Graph& g)
{
	int groupCount = 0;
	for(int i = 0; i < g.size(); ++i)
	{
		if(!g[i].visited)
		{
			traverse(g, i);
			groupCount++;
		}
	}
	return groupCount;
}

/*void unittest2()
{
    vector<string> lines = {
        "0 <-> 2",
        "1 <-> 1",
        "2 <-> 0, 3, 4",
        "3 <-> 2, 4",
        "4 <-> 2, 3, 6",
        "5 <-> 6",
        "6 <-> 4, 5" };

    auto graph = parseLines(lines);
    auto groupCount = isolatedGroupCount(graph);
    assert(groupCount == 2);
}*/

void solve_part2()
{
	auto graph = readAndParse();
	auto groupCount = isolatedGroupCount(graph);
	cout << "Day 12 - part 2: " << groupCount << endl;
}

//------------------

int main()
{
	//	unittest();
	solve_part1();
	//	unittest2();
	solve_part2();
	return 0;
}
