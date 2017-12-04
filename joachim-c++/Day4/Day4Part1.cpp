#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <set>

const int solve_day4_part1() {
    std::string input;
    int valid = 0;

    while (std::getline(std::cin, input)) {
        std::stringstream ss(input);
        std::string word;
        std::set<std::string> uniqueWords;
        std::vector<std::string> words;

        while (ss >> word) {
            uniqueWords.insert(word);
            words.push_back(word);
        }

        if (uniqueWords.size() == words.size()) {
            valid++;
        }
    }

    return valid;
}

int main() {
    std::cout << "Day4 - Part1 Result: " << solve_day4_part1() << '\n';

    return 0;
}
