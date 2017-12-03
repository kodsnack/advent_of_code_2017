#include <iostream>
#include <string>

int solve_day1_part1(const std::string& input) {
    int sum = 0;
    int n = input.length();

    for (int i = 0; i < n; ++i) {
        if (input[i % n] == input[(i + 1) % n]) {
            sum += input[i % n] - '0';
        }
    }

    return sum;
}

int main() {
    std::string input;
    cin >> input;

    cout << "Day1 - Part1 Result: " << solve_day1_part1(input) << '\n';

    return 0;
}