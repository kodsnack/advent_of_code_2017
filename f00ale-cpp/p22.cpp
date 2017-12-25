#include <iostream>
#include <map>
#include <tuple>

int main() {
  int ans1 = 0;
  int ans2 = 0;
  std::map<std::tuple<int,int>, char> m;
  int x = 0, y = 0;
  int dx = 0, dy = -1;
  
  {
    bool done = false;
    int row = 0;
    int col = 0;
    while(!done) {
      char c;
      std::cin.get(c);
      if(!std::cin.good()) {
	done = true;
	c = '\n';
      }
      if(c == '\n') {
	if(col) {
	  row++;
	  x = col / 2;
	  y = row / 2;
	}
	col = 0;
      }
      if(c == '.' || c == '#') {
	if(c == '#') {
	  m[{row,col}] = 'I';
	}
	col++;
      }      
    }
  }

  auto orig_m = m;
  auto ox = x;
  auto oy = y;
  
  for(int i = 0; i < 10000; i++) {
    auto & curr = m[{y,x}];
    if(curr == 'I') {
      auto ndx = -dy;
      dy = dx;
      dx = ndx;
      curr = 0;
    } else {
      auto ndx = dy;
      dy = -dx;
      dx = ndx;
      curr = 'I';
      ans1++;
    }
    x += dx;
    y += dy;
  }

  m.swap(orig_m);
  y = oy;
  x = ox;
  dy = -1;
  dx = 0;

  for(int i = 0; i < 10000000; i++) {
    auto & curr = m[{y,x}];
    if(curr == 'I') {
      auto ndx = -dy;
      dy = dx;
      dx = ndx;
      curr = 'F';
    } else if(curr == 'W') {
      ans2++;
      curr = 'I';
    } else if(curr == 'F') {
      dx *= -1;
      dy *= -1;
      curr = 0;
    } else {
      auto ndx = dy;
      dy = -dx;
      dx = ndx;
      curr = 'W';
    }
    x += dx;
    y += dy;
  }
  

  
  std::cout << ans1 << std::endl;
  std::cout << ans2 << std::endl;
}
