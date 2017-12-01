#include <iostream>

int get() {
  char input = 0;
  std::cin >> input;
  if(input >= '0' || input <= '9') return input-'0';
  else if(!std::cin.good()) return -1;
  else return 0;
}

int main() {
  int first = 0, last = 0, input = 0;
  int ans = 0;
  first = last = get();

  while(1) {
    input = get();
    if(input == 0) continue;
    if(input < 0) break;
    if(input == last) ans += input;
    last = input;
  }
  if(last == first) ans += first;
  std::cout << ans << std::endl;
  return 0;
}

