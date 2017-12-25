#include <iostream>
#include <array>
#include <vector>
#include <tuple>
#include <algorithm>
using r2 = std::tuple<std::array<std::array<bool,2>,2>, std::array<std::array<bool,3>,3>>;
using r3 = std::tuple<std::array<std::array<bool,3>,3>, std::array<std::array<bool,4>,4>>;

void print(auto & a) {
  for(auto & r : a) {
    for(int i = 0; i < r.size(); i++) std::cout << (r[i]?'#':'.');
    std::cout << std::endl;
  }
}

auto rot(auto a) {
  const auto N = a.size();
  for(typename std::remove_const<decltype(N)>::type x = 0; x < N/2; x++) {
    for(auto y = x; y < N-x-1; y++) {
      auto t = a[x][y];
      a[x][y] = a[y][N-1-x];
      a[y][N-1-x] = a[N-1-x][N-1-y];
      a[N-1-x][N-1-y] = a[N-1-y][x];
      a[N-1-y][x] = t;
    }
  }
  return a;
}

auto flipy(auto a) {
  const auto N = a.size();
  for(typename std::remove_const<decltype(N)>::type r = 0; r < N; r++) {
    for(decltype(r) c = 0; c < N/2; c++) {
      std::swap(a[r][c], a[r][N-1-c]);
    }
  }
  return a;
}

auto flipx(auto a) {
  const auto N = a.size();
  for(typename std::remove_const<decltype(N)>::type r = 0; r < N; r++) {
    for(decltype(r) c = 0; c < N/2; c++) {
      std::swap(a[c][r], a[N-1-c][r]);
    }
  }
  return a;
}

auto findmod(auto a, const auto & rules) {
  auto l = [&](const auto&p) { return std::get<0>(p) == a; };
  for(int i = 0; i < 4; i++) {
    a = flipx(rot(a));
    auto it = std::find_if(std::begin(rules), std::end(rules), l);
    if(it != std::end(rules)) return std::get<1>(*it);
    a = flipy(a);
    it = std::find_if(std::begin(rules), std::end(rules), l);
    if(it != std::end(rules)) return std::get<1>(*it);
    a = flipx(a);
    it = std::find_if(std::begin(rules), std::end(rules), l);
    if(it != std::end(rules)) return std::get<1>(*it);
    a = flipy(a);
    it = std::find_if(std::begin(rules), std::end(rules), l);
    if(it != std::end(rules)) return std::get<1>(*it);
  }
  std::cout << "could not find rule for:" << std::endl;
  print(a);
  exit(-1);
}

int main() {
  int ans1 = 0;
  int ans2 = 0;
  std::vector<r2> rule2;
  std::vector<r3> rule3;

  std::vector<std::vector<bool>> grid = {{false, true, false}, {false, false, true}, {true, true, true}};
  
  {
    bool done = false;
    std::vector<bool> v;
    while(!done) {
      char c;
      std::cin.get(c);
      if(!std::cin.good()) {
	c = '\n';
	done = true;
      }

      if(c == '#') v.push_back(true);
      else if(c == '.') v.push_back(false);
      else if(c == '\n') {
	if(v.size() == 4+9) {
	  std::array<std::array<bool, 2>, 2> a2 = { v[0], v[1], v[2], v[3] };
	  std::array<std::array<bool, 3>, 3> a3 = { v[4], v[5], v[6], v[7], v[8], v[9], v[10], v[11], v[12] };
	  rule2.emplace_back(a2, a3); 
	} else if(v.size() == 9+16) {
	  std::array<std::array<bool, 3>, 3> a3 = { v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8] };
	  std::array<std::array<bool, 4>, 4> a4 = { v[9], v[10], v[11], v[12], v[13], v[14], v[15], v[16], v[17], v[18], v[19], v[20], v[21], v[22], v[23], v[24] };
	  rule3.emplace_back(a3, a4); 
	}
	
	v.clear();
      }
    }
  }

  for(int i = 0; i < 18; i++) {
    if(i == 5) {
      for(auto & r : grid) {
	for(int i = 0; i < r.size(); i++) {
	  if(r[i]) ans1++;
	}
      }
    }

    decltype(grid) newgrid;
    if(grid.size() % 2 == 0) {
      for(int y = 0; y < grid.size(); y+=2) {
	auto offs = newgrid.size();
	for(int x = 0; x < grid.size(); x+=2) {
	  std::array<std::array<bool, 2>, 2> s = { grid[y][x], grid[y][x+1], grid[y+1][x], grid[y+1][x+1] };

	  auto q = findmod(s, rule2);
	  for(int r = 0; r < q.size(); r++) {
	    if(offs+r >= newgrid.size()) newgrid.emplace_back();
	    for(int c = 0; c < q[r].size(); c++) {
	      newgrid[offs+r].push_back(q[r][c]);
	    }
	  }

	}
      }
    } else if(grid.size() % 3 == 0) {
      for(int y = 0; y < grid.size(); y+=3) {
	auto offs = newgrid.size();
	for(int x = 0; x < grid.size(); x+=3) {
	  std::array<std::array<bool, 3>, 3> s = { grid[y][x], grid[y][x+1], grid[y][x+2], grid[y+1][x], grid[y+1][x+1], grid[y+1][x+2], grid[y+2][x], grid[y+2][x+1], grid[y+2][x+2] };
	  auto q = findmod(s, rule3);
	  for(int r = 0; r < q.size(); r++) {
	    if(offs+r >= newgrid.size()) newgrid.emplace_back();
	    for(int c = 0; c < q[r].size(); c++) {
	      newgrid[offs+r].push_back(q[r][c]);
	    }
	  }
	}
      }
    }
    grid.swap(newgrid);
  }

  for(auto & r : grid) {
    for(int i = 0; i < r.size(); i++) {
      if(r[i]) ans2++;
    }
  }  
  
  std::cout << ans1 << std::endl;
  std::cout << ans2 << std::endl;
}
