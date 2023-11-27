#include <iostream>
#include <cmath>
#include <map>
#include "pystrlib.hpp"

struct QuadraticFunc {
    int a, b, c;
    QuadraticFunc operator-(const QuadraticFunc &rhs) const { return (QuadraticFunc) { a - rhs.a, b - rhs.b, c - rhs.c }; }
    std::pair< bool, std::vector<int> > get_root() {
        if (a != 0) {
            int delta = b * b - 4 * a * c, sq = std::sqrt(delta);
            if (sq * sq != delta) return std::make_pair(false, std::vector<int>());
            std::vector<int> ans;
            int v = -b + sq;
            if (v % (2 * a) == 0) ans.push_back(v / (2 * a));
            v = -b - sq;
            if (v % (2 * a) == 0) ans.push_back(v / (2 * a));
            return std::make_pair(false, ans);
        } else if (b != 0) {
            if (c % b == 0) return std::make_pair(false, std::vector<int>{ -c / b });
            return std::make_pair(false, std::vector<int>());
        } else return std::make_pair(c == 0, std::vector<int>());
    }
};

struct Component {
    int a, v, x;
    QuadraticFunc get_pos_func() const { return ((QuadraticFunc) { a, 2 * v + a, 2 * x }); }
};

struct Particle {
    Component x, y, z;
};

std::vector<Particle> particles;
int n;

std::map< int, std::vector< std::pair<int, int> > > M;
std::vector<int> collided;

inline bool contains(const std::pair< bool, std::vector<int> > &vec, int v) {
    if (vec.first) return true;
    for (int i : vec.second) if (v == i) return true;
    return false;
}

int main() {
    freopen("day20.txt", "r", stdin);
    {
        std::string line;
        while (std::getline(std::cin, line)) {
            std::vector<std::string> vec = lib::split(line, ", ");
            std::vector<std::string> vp = lib::split(vec[0].substr(3, vec[0].size() - 4), ","),
                                     vv = lib::split(vec[1].substr(3, vec[1].size() - 4), ","),
                                     va = lib::split(vec[2].substr(3, vec[2].size() - 4), ",");
            particles.push_back((Particle) {
                (Component) { std::stoi(va[0]), std::stoi(vv[0]), std::stoi(vp[0]) },
                (Component) { std::stoi(va[1]), std::stoi(vv[1]), std::stoi(vp[1]) },
                (Component) { std::stoi(va[2]), std::stoi(vv[2]), std::stoi(vp[2]) }
            });
        }
    }
    n = particles.size();
    collided.resize(n, 0);
    for (int i = 0; i < n; ++i)
        for (int j = i + 1; j < n; ++j) {
            auto xt = (particles[i].x.get_pos_func() - particles[j].x.get_pos_func()).get_root(),
                 yt = (particles[i].y.get_pos_func() - particles[j].y.get_pos_func()).get_root(),
                 zt = (particles[i].z.get_pos_func() - particles[j].z.get_pos_func()).get_root();
            bool found = false; int collide;
            if (!yt.first) std::swap(xt, yt);
            else if (!zt.first) std::swap(xt, zt);
            if (xt.first) found = true, collide = 0;
            else
                for (int v : xt.second)
                    if (v >= 0 && contains(yt, v) && contains(zt, v) && (!found || (found && v < collide)))
                        found = true, collide = v;
            if (found) {
                if (!M.count(collide)) M[collide] = std::vector< std::pair<int, int> >();
                M[collide].emplace_back(i, j);
            }
        }
    for (const auto &[x, y] : M) {
        for (auto [i, j] : y)
            if (collided[i] != 2 && collided[j] != 2)
                collided[i] = collided[j] = 1;
        std::replace(collided.begin(), collided.end(), 1, 2);
    }
    std::cout << std::count(collided.begin(), collided.end(), 0) << std::endl;
    return 0;
}