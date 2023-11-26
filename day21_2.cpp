#include <iostream>
#include <cstring>
#include "pystrlib.hpp"

struct Pattern {
    int siz;
    char ch[6][6];
    Pattern(int _siz) : siz(_siz) { std::memset(ch, 0, sizeof(ch)); }
    Pattern rotate() const {
        Pattern ans(siz);
        for (int i = 0; i < siz; ++i)
            for (int j = 0; j < siz; ++j)
                ans.ch[j][siz - 1 - i] = ch[i][j];
        return ans;
    }
    Pattern flip() const {
        Pattern ans(siz);
        for (int i = 0; i < siz; ++i)
            for (int j = 0; j < siz; ++j)
                ans.ch[i][siz - 1 - j] = ch[i][j];
        return ans;
    }
    bool operator==(const Pattern &rhs) const {
        if (siz != rhs.siz) return false;
        for (int i = 0; i < siz; ++i)
            for (int j = 0; j < siz; ++j)
                if (ch[i][j] != rhs.ch[i][j]) return false;
        return true;
    }
    bool match(const Pattern &match) const {
        Pattern tmp = *this;
        for (int i = 0; i < 4; ++i) {
            if (tmp == match) return true;
            tmp = tmp.rotate();
        }
        tmp = tmp.flip();
        for (int i = 0; i < 4; ++i) {
            if (tmp == match) return true;
            tmp = tmp.rotate();
        }
        return false;
    }
    Pattern sub_pattern(int x, int y, int siz) const {
        Pattern ans(siz);
        for (int i = 0; i < siz; ++i)
            for (int j = 0; j < siz; ++j)
                ans.ch[i][j] = ch[x + i][y + j];
        return ans;
    }
    void copy_into(const Pattern &pattern, int x, int y) {
        for (int i = 0; i < pattern.siz; ++i)
            for (int j = 0; j < pattern.siz; ++j)
                ch[x + i][y + j] = pattern.ch[i][j];
    }
    int lit() const {
        int ans = 0;
        for (int i = 0; i < siz; ++i)
            for (int j = 0; j < siz; ++j)
                ans += ch[i][j] == '#';
        return ans;
    }
    friend std::ostream& operator<<(std::ostream &cout, const Pattern &pattern);
};

std::vector<Pattern> patterns;
int go[20000][9], lit[20000], cnt[20000], gcnt[20000];

Pattern read_pattern(const std::string &str) {
    std::vector<std::string> v = lib::split(str, "/");
    Pattern pattern(v.size());
    for (int i = 0; i < pattern.siz; ++i)
        for (int j = 0; j < pattern.siz; ++j)
            pattern.ch[i][j] = v[i][j];
    return pattern;
}

int get_order(const Pattern &pattern) {
    for (unsigned i = 0; i < patterns.size(); ++i)
        if (pattern.match(patterns[i])) return i;
    patterns.push_back(pattern); return patterns.size() - 1;
}

std::ostream& operator<<(std::ostream& cout, const Pattern &pattern) {
    for (int i = 0; i < pattern.siz; ++i)
        cout << pattern.ch[i] << std::endl;
    return cout;
}

inline void fill_into(char ch[6][6], int x, int y, char ch2[4][4]) {
    for (int i = 0; i < 3; ++i)
        for (int j = 0; j < 3; ++j)
            ch[x + i][y + j] = ch2[i][j];
}

int main() {
    freopen("day21.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            auto [f, _, t] = lib::partition(line, " => ");
            Pattern fp = read_pattern(f), tp = read_pattern(t);
            go[get_order(fp)][0] = get_order(tp);
        }
    }
    for (unsigned i = 0; i < patterns.size(); ++i)
        if (patterns[i].siz == 4) {
            Pattern pattern(6);
            pattern.copy_into(patterns[go[get_order(patterns[i].sub_pattern(0, 0, 2))][0]], 0, 0);
            pattern.copy_into(patterns[go[get_order(patterns[i].sub_pattern(0, 2, 2))][0]], 0, 3);
            pattern.copy_into(patterns[go[get_order(patterns[i].sub_pattern(2, 0, 2))][0]], 3, 0);
            pattern.copy_into(patterns[go[get_order(patterns[i].sub_pattern(2, 2, 2))][0]], 3, 3);
            go[i][0] = get_order(pattern.sub_pattern(0, 0, 2));
            go[i][1] = get_order(pattern.sub_pattern(0, 2, 2));
            go[i][2] = get_order(pattern.sub_pattern(0, 4, 2));
            go[i][3] = get_order(pattern.sub_pattern(2, 0, 2));
            go[i][4] = get_order(pattern.sub_pattern(2, 2, 2));
            go[i][5] = get_order(pattern.sub_pattern(2, 4, 2));
            go[i][6] = get_order(pattern.sub_pattern(4, 0, 2));
            go[i][7] = get_order(pattern.sub_pattern(4, 2, 2));
            go[i][8] = get_order(pattern.sub_pattern(4, 4, 2));
        }
    for (unsigned i = 0; i < patterns.size(); ++i) lit[i] = patterns[i].lit();
    cnt[get_order(read_pattern(".#./..#/###"))] = 1;
    for (int i = 0; i < 18; ++i) {
        std::memset(gcnt, 0, sizeof(gcnt));
        for (unsigned j = 0; j < patterns.size(); ++j)
            if (patterns[j].siz < 4) gcnt[go[j][0]] += cnt[j];
            else
                for (int k = 0; k < 9; ++k)
                    gcnt[go[j][k]] += cnt[j];
        std::memcpy(cnt, gcnt, sizeof(cnt));
    }
    int ans = 0;
    for (unsigned i = 0; i < patterns.size(); ++i)
        ans += lit[i] * cnt[i];
    std::cout << ans << std::endl;
    return 0;
}