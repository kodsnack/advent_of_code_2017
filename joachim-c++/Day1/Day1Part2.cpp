#include <iostream>
#include <string>

int solve_day1_part2(const std::string& input) {
    int sum = 0;
    int n = input.length();
    int n_half = n / 2;

    for (int i = 0; i < n; ++i) {
        if (input[i % n] == input[(i + n_half) % n]) {
            sum += input[i % n] - '0';
        }
    }

    return sum;
}

int main() {
    std::string input;
    cin >> input;

    cout << "Day1 - Part2 Result: " << solve_day1_part2(input) << '\n';

    return 0;
}