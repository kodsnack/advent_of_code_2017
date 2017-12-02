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

template<class T> void amax(T & a, const T & b) { a = max(a,b); }
template<class T> void amin(T & a, const T & b) { a = min(a,b); }

template<class T> T getinword () {
    T temp;
    cin >> temp;
    return temp;
}


int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    string line;
    long long sum=0;
    while (getline(cin, line)) {
        stringstream ss (line);
        long long num;
        vector<long long> numbers;
        while (ss >> num) {
            for (long long number : numbers) {
                if (max(number, num) % min(number, num) == 0) {
                    sum += max(number, num) / min(number, num);
                }
            }
            numbers.push_back(num);
        }
    }
    cout << sum << "\n";
}

