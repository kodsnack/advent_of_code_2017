#include <iostream>
#include <complex>

int solve_day3_part1(const int& input) {
    std::complex<int> currentPosition = {0, 0};
    std::complex<int> currentDirection = {1, 0};
    int maxStepsBeforeTurn = 1;
    int currentSteps = 0;
    int maxTurnsBeforeIncrementSteps = 2;
    int currentTurns = 0;

    for (int i = 1; i < input; ++i) {
        currentPosition += currentDirection;
        ++currentSteps;

        if (currentSteps == maxStepsBeforeTurn) {
            ++turns;
            currentSteps = 0;
            currentDirection *= std::complex<int>(0, 1);
        }
        if (turns == maxTurnsBeforeIncrementSteps) {
            ++maxStepsBeforeTurn;
            currentTurns = 0;
        }
    }

    return abs(real(currentPosition)) + abs(imag(currentPosition));
}

int main() {
    std::cout << "Day3 - Part1 Result: " << solve_day3_part1(265149) << '\n';

    return 0;
}