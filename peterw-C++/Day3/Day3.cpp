// Advent of Code 2017 - Day 3
// Peter Westerström (digimatic)

#include <cassert>
#include <iostream>
#include <vector>

using namespace std;

//---------
// Part 1
//---------

// returns turn# and turns first cell
pair<int, int> turnFromPos(int pos)
{
	if(pos == 1)
		return make_pair(0, 1);
	int turn = 0;
	int cell = 1;
	do
	{
		turn++;
		auto turnCount = 8 * turn;
		cell += turnCount;
	} while(pos > cell);
	return make_pair(turn, cell - 8 * turn + 1);
}

pair<int, int> findMemoryXY(int pos)
{
	if(pos == 1)
		return make_pair(0, 0);

	auto[turn, cell] = turnFromPos(pos);

	// lower right
	int x = turn;
	int y = turn - 1;
	int sideLength = 2 * turn;
	int stepsLeft = pos - cell;
	if(stepsLeft == 0)
		return make_pair(x, y);
	if(stepsLeft < sideLength)
	{
		y -= stepsLeft;
		return make_pair(x, y);
	}
	y -= sideLength - 1;
	stepsLeft -= sideLength - 1;
	if(stepsLeft < sideLength)
	{
		x -= stepsLeft;
		return make_pair(x, y);
	}
	x -= sideLength;
	stepsLeft -= sideLength;
	if(stepsLeft < sideLength)
	{
		y += stepsLeft;
		return make_pair(x, y);
	}
	y += sideLength;
	stepsLeft -= sideLength;

	x += stepsLeft;
	return make_pair(x, y);
}

void solve_day3_part1()
{
	auto pos = findMemoryXY(289326 /* the input */);
	auto distance = abs(pos.first) + abs(pos.second);
	cout << "Day 3 - part 1: " << distance << endl;
}

//---------
// Part 2
//---------
using grid_t = vector<vector<int>>;
grid_t createGrid(int width, int height)
{
	vector<vector<int>> grid;
	grid.resize(height);
	for(int i = 0; i < height; ++i)
		grid[i].resize(width, 0);
	return grid;
}

int& gridAt(grid_t& grid, int x, int y)
{
	int l = (grid.size() - 1) / 2;
	return grid.at(l + y).at(l + x);
}
const int& gridAt(const grid_t& grid, int x, int y)
{
	int l = (grid.size() - 1) / 2;
	return grid.at(l + y).at(l + x);
}

void stepOne(const grid_t& grid, int& turn, int& x, int& y)
{
	if(x == turn && y == turn)
	{
		x++;
		turn++;
		return;
	}

	if(x == turn)
	{
		if(y > -turn)
		{
			y--;
			return;
		}
	}
	if(y == -turn)
	{
		if(x > -turn)
		{
			x--;
			return;
		}
	}
	if(x == -turn)
	{
		if(y < turn)
		{
			y++;
			return;
		}
	}
	assert(y == turn);
	if(x < turn)
	{
		x++;
		return;
	}
	assert(false);
}

/* // Alternative part 1 solution.
int part1_alt2()
{
    int pos = 289326;
    auto [maxTurn, cell] = turnFromPos(pos);
    int gridSize = 2*maxTurn+1;
    auto grid = createGrid(gridSize, gridSize);
    gridAt(grid, 0, 0) = 1;
    int x = 1;
    int y = 0;
    auto stepsLeft = pos-2;
    int turn = 1;
    while(stepsLeft>0)
    {
        stepOne(grid, turn, x, y);
        cout << "step to " << x << " " << y << " turn="<<turn << endl;
        stepsLeft--;
    }
    return abs(x)+abs(y);
}*/

int writeCell(grid_t& cellGrid, grid_t& sumGrid, int currentCel, int x, int y)
{
	int sum = 0;
	gridAt(cellGrid, x, y) = currentCel;
	if(gridAt(cellGrid, x - 1, y - 1) != 0 && gridAt(cellGrid, x - 1, y - 1) < currentCel)
		sum += gridAt(sumGrid, x - 1, y - 1);
	if(gridAt(cellGrid, x - 1, y) != 0 && gridAt(cellGrid, x - 1, y) < currentCel)
		sum += gridAt(sumGrid, x - 1, y);
	if(gridAt(cellGrid, x - 1, y + 1) != 0 && gridAt(cellGrid, x - 1, y + 1) < currentCel)
		sum += gridAt(sumGrid, x - 1, y + 1);
	if(gridAt(cellGrid, x, y - 1) != 0 && gridAt(cellGrid, x, y - 1) < currentCel)
		sum += gridAt(sumGrid, x, y - 1);
	if(gridAt(cellGrid, x, y + 1) != 0 && gridAt(cellGrid, x, y + 1) < currentCel)
		sum += gridAt(sumGrid, x, y + 1);
	if(gridAt(cellGrid, x + 1, y - 1) != 0 && gridAt(cellGrid, x + 1, y - 1) < currentCel)
		sum += gridAt(sumGrid, x + 1, y - 1);
	if(gridAt(cellGrid, x + 1, y) != 0 && gridAt(cellGrid, x + 1, y) < currentCel)
		sum += gridAt(sumGrid, x + 1, y);
	if(gridAt(cellGrid, x + 1, y + 1) != 0 && gridAt(cellGrid, x + 1, y + 1) < currentCel)
		sum += gridAt(sumGrid, x + 1, y + 1);
	gridAt(sumGrid, x, y) = sum;
	return sum;
}

int part2()
{
	int pos = 289326; // input
	auto[maxTurn, cell] = turnFromPos(pos);
	int gridSize = 2 * maxTurn + 1;
	auto cellGrid = createGrid(gridSize + 4, gridSize + 4);
	auto sumGrid = createGrid(gridSize + 4, gridSize + 4);
	gridAt(cellGrid, 0, 0) = 1;
	gridAt(sumGrid, 0, 0) = 1;
	int x = 1;
	int y = 0;
	int turn = 1;
	int writtenVal = -1;
	int currentCell = 2;
	do
	{
		writtenVal = writeCell(cellGrid, sumGrid, currentCell++, x, y);
		stepOne(cellGrid, turn, x, y);
	} while(writtenVal <= pos);
	return writtenVal;
}

void solve_day3_part2()
{
	auto r = part2();
	cout << "Day 3 - part 2: " << r << endl;
}

int main()
{
	solve_day3_part1();
	solve_day3_part2();
	return 0;
}
