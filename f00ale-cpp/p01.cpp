#include <iostream>
#include <vector>

int get() {
  char input = 0;
  std::cin >> input;
  if(input >= '0' || input <= '9') return input-'0';
  else if(!std::cin.good()) return -1;
  else return 0;
}

int main() {
  int first = 0, last = 0, input = 0;
  std::vector<int> nums;

  while(1) {
    input = get();
    if(input == 0) continue;
    if(input < 0) break;
    nums.push_back(input);
  }

  auto size = nums.size();
  int ans1 = 0;
  for(decltype(size) i = 0; i < size; i++) {
    if(nums[i] == nums[(i+1)%size]) ans1 += nums[i];
  }
  std::cout << ans1 << std::endl;

  int ans2 = 0;
  for(decltype(size) i = 0; i < size; i++) {
    if(nums[i] == nums[(i+size/2)%size]) ans2 += nums[i];
  }

  std::cout << ans2 << std::endl;

  return 0;
}

