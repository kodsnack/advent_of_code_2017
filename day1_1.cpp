#include <iostream>
#include <cstring>

char str[5000];
int n, ans;

int main() {
    std::cin >> str;
    n = std::strlen(str);
    str[n] = str[0];
    for (int i = 0; i < n; ++i)
        if (str[i] == str[i + 1]) ans += str[i] - '0';
    std::cout << ans << std::endl;
    return 0;
}