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

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    string line;
    long long sum=0;
    while (getline(cin, line)) {
        stringstream ss (line);
        long long num, mx=0, mn=100000;
        while (ss >> num) {
            amax(mx, num);
            amin(mn, num);
        }
        sum += (mx-mn);
    }
    cout << sum << "\n";
}

