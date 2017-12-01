#include <bits/stdc++.h>
using namespace std;

#if DEBUG
#include "prettyprint.hpp"
#define PRINTLN(x) \
    cerr << x << "\n"
#define PRINTSP(x) \
    cerr << x << " "
#else
#define PRINTLN(x)
#define PRINTSP(x)
#endif

int main() {
    string numbers;
    cin >> numbers;
    int sum = 0;
    for (int i=0; i < numbers.size(); i++) {
        if (numbers[(i+numbers.size()/2) % numbers.size()] == numbers[i]) {
            sum += numbers[i] - '0';
        }
    }
    cout << sum << "\n";
}
