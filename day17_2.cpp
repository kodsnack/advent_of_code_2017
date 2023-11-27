#include <iostream>
#include <random>
#include <vector>

struct Node {
    int ls, rs, val, siz;
    unsigned key;
} tr[50000005];
int root, cnt;
std::mt19937 RND;

inline void push_up(int k) { tr[k].siz = tr[tr[k].ls].siz + tr[tr[k].rs].siz + 1; }
inline int new_node(int v) { tr[++cnt] = (Node) { 0, 0, v, 1, RND()}; return cnt; }

void split(int k, int sz, int &x, int &y) {
    if (!k) { x = y = 0; return; }
    if (tr[tr[k].ls].siz < sz) x = k, split(tr[k].rs, sz - tr[tr[k].ls].siz - 1, tr[k].rs, y);
    else y = k, split(tr[k].ls, sz, x, tr[k].ls);
    push_up(k);
}
int merge(int x, int y) {
    if (!x || !y) return x | y;
    if (tr[x].key < tr[y].key) { tr[x].rs = merge(tr[x].rs, y); push_up(x); return x; }
    else { tr[y].ls = merge(x, tr[y].ls); push_up(y); return y; }
}

void insert(int pos, int val) {
    int x, y;
    split(root, pos, x, y);
    root = merge(merge(x, new_node(val)), y);
}

void traverse(int k, std::vector<int> &r) {
    if (tr[k].ls) traverse(tr[k].ls, r);
    r.push_back(tr[k].val);
    if (tr[k].rs) traverse(tr[k].rs, r);
}
std::vector<int> to_vec() {
    std::vector<int> r;
    traverse(root, r);
    return r;
}

int len, pos;

int main() {
    std::cin >> len;
    insert(0, 0); pos = 0;
    for (int i = 1; i <= 50000000; ++i) {
        pos = (pos + len) % tr[root].siz;
        insert(++pos, i);
    }
    std::vector<int> num = to_vec();
    for (int i = 0; i <= 50000000; ++i)
        if (num[i] == 0) {
            std::cout << num[(i + 1) % 50000001] << std::endl;
            return 0;
        }
    return 0;
}