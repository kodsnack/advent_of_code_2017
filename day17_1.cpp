#include <iostream>

int len;

struct Node { int nxt, val; } lst[3000];
int pos, cnt;

int main() {
    std::cin >> len;
    for (int i = 1; i <= 2017; ++i) {
        for (int j = 0; j < len; ++j) pos = lst[pos].nxt;
        lst[++cnt].val = i; lst[cnt].nxt = lst[pos].nxt; lst[pos].nxt = cnt; pos = cnt;
    }
    std::cout << lst[lst[pos].nxt].val << std::endl;
    return 0;
}