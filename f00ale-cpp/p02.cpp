#include <iostream>
#include <vector>
#include <algorithm>


int main() {
  std::vector<std::vector<int>> v(1);
  int input = 0;
  char c = 0;
  while(1) {
    std::cin.get(c);
    if(!std::cin.good()) break;
    if(c >= '0' && c <= '9') { input *= 10; input += c - '0'; }
    else {
      if(input) v.back().push_back(input);
      input = 0;
      if(c == '\n') v.push_back(std::vector<int>());
    }
  }
  if(input) v.back().push_back(input);

  int ans1 = 0;
  for(auto & r : v) {
    int max = [&]{auto it = std::max_element(r.begin(), r.end()); if(it!=r.end()) return *it; return 0; }();
    int min = [&]{auto it = std::min_element(r.begin(), r.end()); if(it!=r.end()) return *it; return 0; }();
    ans1 += max-min;
  }
  std::cout << ans1 << std::endl;

  int ans2 = 0;
  for(auto & r : v) {
    for(auto it1 = std::begin(r); it1 != std::end(r); it1++) {
      for(auto it2 = std::begin(r); it2 != std::end(r); it2++) {
        if(it1 == it2) continue;
        if(*it1 % *it2 == 0) ans2 += *it1 / *it2;
      }
    }
  }
  std::cout << ans2 << std::endl;
}
