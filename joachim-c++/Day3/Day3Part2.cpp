#include <iostream>
#include <complex>
#include <map>
#include <vector>

int solve_day3_part2(const int& input) {
    std::complex<int> currentPosition = {0, 0};
    std::complex<int> currentDirection = {1, 0};
    int maxStepsBeforeTurn = 1;
    int currentSteps = 0;
    int maxTurnsBeforeIncrementSteps = 2;
    int currentTurns = 0;
    std::map<std::pair<int, int>, int> visitedPositions;
    visitedPositions[{real(currentPosition), imag(currentPosition)}] = 1;
    std::vector<std::pair<int, int> > neighborsDirections = {{1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}};

    while (visitedPositions[{real(currentPosition), imag(currentPosition)}] < input) {
        currentPosition += currentDirection;
        ++currentSteps;

        for (const auto& [x, y] : neighborsDirections) {
            visitedPositions[{real(currentPosition), imag(currentPosition)}] += visitedPositions[{real(currentPosition) + x, imag(currentPosition) + y}];
        }

        if (currentSteps == maxStepsBeforeTurn) {
            ++currentTurns;
            currentSteps = 0;
            currentDirection *= std::complex<int>(0, 1);
        }
        if (currentTurns == maxTurnsBeforeIncrementSteps) {
            ++maxStepsBeforeTurn;
            currentTurns = 0;
        }
    }

    return visitedPositions[{real(currentPosition), imag(currentPosition)}];
}

int main() {
    std::cout << "Day3 - Part2 Result: " << solve_day3_part2(265149) << '\n';

    return 0;
}