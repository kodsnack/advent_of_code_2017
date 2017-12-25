package main

import (
	"fmt"
)

type rule struct {
	v int
	p int
	n string
}

func main() {
	rules := map[string][2]rule{
		"F": [2]rule{rule{0, 1, "C"}, rule{0, 1, "E"}},
		"A": [2]rule{rule{1, 1, "B"}, rule{0, -1, "D"}},
		"B": [2]rule{rule{1, 1, "C"}, rule{0, 1, "F"}},
		"C": [2]rule{rule{1, -1, "C"}, rule{1, -1, "A"}},
		"D": [2]rule{rule{0, -1, "E"}, rule{1, 1, "A"}},
		"E": [2]rule{rule{1, -1, "A"}, rule{0, 1, "B"}},
	}

	s := "A"
	steps := 12302209

	var pos, checksum int
	v := make(map[int]int)

	for c := 0; c < steps; c++ {
		i := v[pos]
		v[pos] = rules[s][i].v
		pos += rules[s][i].p
		s = rules[s][i].n
	}

	for _, i := range v {
		checksum += i
	}

	fmt.Printf("Checksum: %v\n", checksum)
}
