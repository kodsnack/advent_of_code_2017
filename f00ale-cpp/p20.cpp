#include <iostream>
#include <vector>
#include <limits>
#include <algorithm>
#include <tuple>

int main() {
  int ans1 = 0;
  int ans2 = 0;
  
  struct particle {
    int idx;
    int x, y, z;
    int vx, vy, vz;
    int ax, ay, az;
    particle(int i, int _x, int _y, int _z, int _vx, int _vy, int _vz, int _ax, int _ay, int _az)
      : idx(i), x(_x), y(_y), z(_z), vx(_vx), vy(_vy), vz(_vz), ax(_ax), ay(_ay), az(_az) {}
  };

  std::vector<particle> p;
  {
    bool done = false;
    bool neg = false;
    bool innum = false;
    int num = 0;
    std::vector<int> v;
    int idx = 0;
    while(!done) {
      char c;
      std::cin.get(c);
      if(!std::cin.good()) {
	c = '\n';
	done = true;
      }
      if(c >= '0' && c <= '9') {
	num *= 10;
	num += c - '0';
	innum = true;
      } else if(c == '-') {
	neg = true;
      } else if(innum) {
	if(neg) num *= -1;
	v.push_back(num);
	num = 0;
	neg = false;
	innum = false;	
      }
      if(c == '\n') {
	if(v.size() == 9) {
	  p.emplace_back(idx++, v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
	}
	v.clear();
      }
      
    }
  }

  auto p1 = p;
  
  for(int i = 0; i < 1000; i++) {
    auto md = std::numeric_limits<int>::max();
    for(auto & e : p1) {
      e.vx += e.ax;
      e.vy += e.ay;
      e.vz += e.az;

      e.x += e.vx;
      e.y += e.vy;
      e.z += e.vz;

      auto d = abs(e.x) + abs(e.y) + abs(e.z);
      if(d < md) {
	md = d;
	ans1 = e.idx;
      }
    }
  }

  for(int i = 0; i < 1000; i++) {
    for(auto & e : p) {
      e.vx += e.ax;
      e.vy += e.ay;
      e.vz += e.az;

      e.x += e.vx;
      e.y += e.vy;
      e.z += e.vz;
    }
    std::sort(begin(p), end(p), [](auto & e1, auto & e2) { return std::tie(e1.x, e1.y, e1.z) < std::tie(e2.x, e2.y, e2.z); });

    bool done = true;
    do {
      done = true;
      for(auto it1 = std::begin(p); it1 != std::end(p); it1++) {
	auto it2 = it1;
	for(; it2 != std::end(p) && it1->x == it2->x && it1->y == it2->y && it1->z == it2->z; it2++) {};
	if(std::distance(it1, it2) > 1) {
	  p.erase(it1, it2);
	  done = false;
	  break;
	}
      }
    } while(!done);
    
  }

  ans2 = p.size();
  
  std::cout << ans1 << std::endl;
  std::cout << ans2 << std::endl;
}
