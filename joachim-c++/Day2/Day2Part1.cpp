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
            numbers.push_back(number);
        }
               
        auto [minIt, maxIt] = minmax_element(numbers.begin(), numbers.end());

        result += *max - *min;
    }

    return result;
}

int main() {
    std::cout << "Day2 - Part1 Result: " << solve_day2_part1() << '\n';

    return 0;
}