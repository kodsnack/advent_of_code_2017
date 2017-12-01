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
