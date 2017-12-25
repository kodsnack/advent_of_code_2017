#include <iostream>
#include <vector>
#include <tuple>

void findstrong(int s, std::vector<std::tuple<int, int>> & v,
		int & a1, int & a2, int & longstr,
		int len = 0, int strength = 0) {
  if(strength > a1) a1 = strength;
  if(len == longstr && strength > a2) a2 = strength;
  if(len > longstr) { longstr = len; a2 = strength; }
  for(auto it = std::begin(v); it != std::end(v); it++) {
    auto [a,b] = *it;
    if(a == s || b == s) {
      *it = {-1,-1};
      if(a == s) {
	findstrong(b, v, a1, a2, longstr, len+1, strength + a + b);
      } else {
	findstrong(a, v, a1, a2, longstr, len+1, strength + a + b);
      }
      *it = {a, b};
    }
  }
}

int main() {
  int ans1 = 0;
  int ans2 = 0;
  std::vector<std::tuple<int, int>> v;
  {
    bool done = false;
    bool innum = false;
    bool havenum1 = false;
    int num1 = 0;
    int num = 0;
    while(!done) {
      char c;
      std::cin.get(c);
      if(!std::cin.good()) {
	done = true;
	c = '\n';	
      }
      if(c >= '0' && c <= '9') {
	num *= 10;
	num += c - '0';
	innum = true;
      } else if(c == '/') {
	num1 = num;
	num = 0;
	innum = false;
	havenum1 = true;
      } else if(c == '\n') {
	if(havenum1) {
	  v.emplace_back(num1, num);
	}
	num = 0;
	innum = false;
	num1 = 0;
	havenum1 = false;
      }      
    }
  }
  int tmp = 0;
  findstrong(0, v, ans1, ans2, tmp);

  std::cout << ans1 << std::endl;
  std::cout << ans2 << std::endl;
}
