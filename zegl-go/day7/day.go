package day7

import (
	"regexp"
	"strconv"
	"strings"
)

func Part1(input string) string {
	// program -> parents
	programs := make(map[string][]string)

	allPrograms := make([]string, 0)

	r := regexp.MustCompile("([a-z]+)\\s\\(([0-9]+)\\)([\\s\\->a-z,]+)?")

	for _, row := range strings.Split(input, "\n") {
		inp := r.FindStringSubmatch(strings.TrimSpace(row))
		parent := inp[1]

		allPrograms = append(allPrograms, parent)

		if len(inp[3]) > 0 {
			for _, child := range strings.Split(inp[3][4:], ",") {
				child = strings.TrimSpace(child)
				programs[child] = append(programs[child], parent)
			}
		}
	}

	// Find program without parents
	for _, program := range allPrograms {
		if _, ok := programs[program]; !ok {
			return program
		}
	}

	return ""
}

type part2state struct {
	parents     map[string]string
	children    map[string][]string
	weights     map[string]int
	allPrograms []string
}

func Part2(input string) int {
	state := &part2state{
		parents:     make(map[string]string),
		children:    make(map[string][]string),
		weights:     make(map[string]int),
		allPrograms: make([]string, 0),
	}

	r := regexp.MustCompile("([a-z]+)\\s\\(([0-9]+)\\)([\\s\\->a-z,]+)?")

	for _, row := range strings.Split(input, "\n") {
		inp := r.FindStringSubmatch(strings.TrimSpace(row))
		parent := inp[1]

		state.allPrograms = append(state.allPrograms, parent)

		if n, err := strconv.Atoi(inp[2]); err == nil {
			state.weights[parent] = n
		} else {
			panic(err)
		}

		if len(inp[3]) > 0 {
			for _, child := range strings.Split(inp[3][4:], ",") {
				child = strings.TrimSpace(child)
				state.parents[child] = parent
				state.children[parent] = append(state.children[parent], child)
			}
		}
	}

	// Find program without parents
	var root string
	for _, program := range state.allPrograms {
		if _, ok := state.parents[program]; !ok {
			root = program
			break
		}
	}

	faultyProgram := state.findFirstWithBalance(root)

	siblings := state.children[state.parents[faultyProgram]]

	siblingsWeight := make(map[int][]string)

	for _, sibling := range siblings {
		w := state.weight(sibling)
		siblingsWeight[w] = append(siblingsWeight[w], sibling)
	}

	if len(siblingsWeight) > 1 {
		var wrongWeight string
		var correctWeight string

		for _, v := range siblingsWeight {
			if len(v) == 1 {
				wrongWeight = v[0]
			} else {
				correctWeight = v[0]
			}
		}

		diff := state.weight(wrongWeight) - state.weight(correctWeight)
		return state.weights[wrongWeight] - diff
	}

	return 0
}

func (s *part2state) findFirstWithBalance(program string) string {
	children := s.children[program]
	childrenWeight := make(map[int][]string)

	for _, sibling := range children {
		w := s.weight(sibling)
		childrenWeight[w] = append(childrenWeight[w], sibling)
	}

	if len(childrenWeight) > 1 {
		var wrongWeight string
		for _, v := range childrenWeight {
			if len(v) == 1 {
				wrongWeight = v[0]
			}
		}

		return s.findFirstWithBalance(wrongWeight)
	}

	return program
}

func (s *part2state) weight(program string) int {
	res := s.weights[program]

	// add weight of children
	for _, child := range s.children[program] {
		res += s.weight(child)
	}

	return res
}
