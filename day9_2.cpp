#include <cstdio>
#include <stack>
#include <iostream>

std::stack<char> lb;
int ans;

int main() {
    freopen("day9.txt", "r", stdin);
    char ch; bool cancel = false;
    while ((ch = getchar()) != -1) {
        if (cancel) { cancel = false; continue; }
        if (ch == '!') { cancel = true; continue; }
        if (lb.size() && lb.top() == '<') {
            if (ch == '>') lb.pop();
            else ++ans;
        } else {
            if (ch == '{') lb.push('{');
            else if (ch == '}') lb.pop();
            else if (ch == '<') lb.push('<');
        }
    }
    std::cout << ans << std::endl;
    return 0;
}