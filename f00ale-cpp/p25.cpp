#include <iostream>
#include <vector>
#include <string>
int main() {
  int ans1 = 0;

  struct state {
    state(int v0, int d0, int s0, int v1, int d1, int s1)
      : val0(v0), val1(v1), delta0(d0), delta1(d1), state0(s0), state1(s1) {}
    int val0, val1;
    int delta0, delta1;
    int state0, state1;
  };
  std::vector<state> states;
  std::vector<int> tape_pos, tape_neg;
  int current = 0;
  int steps = 0;
  
  {
    bool have_start = false;
    bool have_steps = false;
    int num = 0;
    bool innum = false;
    std::string tmp;
    bool done = false;
    int c0, c1, v0, v1, d0, d1, s0, s1;
    c0 = c1 = v0 = v1 = d0 = d1 = s0 = s1 = 0;
    int ss = 0;
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
      } else if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
	tmp.push_back(c);
	innum = false;
      } else {
	if(c == '.' || c == ':') {
	  if(!have_start) {
	    current = 'A' - tmp[0];
	    have_start = true;
	  } else if(!have_steps && tmp == "steps") {
	    steps = num;
	    have_steps = true;
	  } else {
	    switch(ss) {
	    case 0: break;
	    case 1: break;
	    case 2: v0 = num; break;
	    case 3: d0 = (tmp == "right" ? 1 : -1); break;
	    case 4: s0 = tmp[0]-'A'; break;
	    case 5: break;
	    case 6: v1 = num; break;
	    case 7: d1 = (tmp == "right" ? 1 : -1); break;
	    case 8: s1 = tmp[0]-'A';	      
	    }
	    ss++;
	    if(ss >= 9) {
	      ss = 0;
	      states.emplace_back(v0, d0, s0, v1, d1, s1);
	    }
	  }
	  
	  num = 0;
	  innum = false;
	}
	tmp.clear();
      }
      
    }
  }

  int pos = 0;
  for(int i = 0; i < steps; i++) {
    auto & v = pos < 0 ? tape_neg : tape_pos;
    auto p = pos < 0 ? -pos : pos;
    while(p >= v.size()) v.push_back(0);
    
    auto val = v[p];

    v[p] = val ? states[current].val1 : states[current].val0;
    pos += val ? states[current].delta1 : states[current].delta0;
    current = val ? states[current].state1 : states[current].state0;
  }
  
  for(auto c : tape_pos) ans1+=c;
  for(auto c : tape_neg) ans1+=c;
  
  std::cout << ans1 << std::endl;
}
