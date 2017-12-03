#include <iostream>
#include <string>
#include <vector>
#include <sstream>

const int solve_day2_part1() {
    std::string input;
    int result;

    while (std::getline(std::cin, input)) {
        std::stringstream ss(input);
        std::vector<int> numbers;
        int number;

        while (ss >> number) {
            for (int n : numbers) {
                int maxVal = std::max(number, n);
                int minVal = std::min(number, n);
                if (maxVal % minVal == 0) {
                    result += maxVal / minVal;
                }
            }
            numbers.push_back(number);
        }
    }

    return result;
}

int main() {
    std::cout << "Day2 - Part2 Result: " << solve_day2_part1() << '\n';

    return 0;
}