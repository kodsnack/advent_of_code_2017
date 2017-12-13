package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	data, _ := ioutil.ReadFile("input.txt")
	input := strings.Split(string(data), ",")
	fmt.Println("Part 1:", countSteps(input))
	fmt.Println("Part 1:", countFurthest(input))
}

type movementCount map[string]int

func reduceMovements(m movementCount) movementCount {
	for {
		switch true {
		case m["n"] > 0 && m["s"] > 0: // opposed
			m["n"]--
			m["s"]--
			continue
		case m["ne"] > 0 && m["sw"] > 0: // opposed
			m["ne"]--
			m["sw"]--
			continue
		case m["nw"] > 0 && m["se"] > 0: // opposed
			m["nw"]--
			m["se"]--
			continue

		case m["n"] > 0 && m["se"] > 0: // n + se = ne
			m["n"]--
			m["se"]--
			m["ne"]++
			continue
		case m["ne"] > 0 && m["s"] > 0: // ne + s = se
			m["ne"]--
			m["s"]--
			m["se"]++
			continue
		case m["se"] > 0 && m["sw"] > 0: // se + sw = s
			m["se"]--
			m["sw"]--
			m["s"]++
			continue
		case m["s"] > 0 && m["nw"] > 0: // s + nw = sw
			m["s"]--
			m["nw"]--
			m["sw"]++
			continue
		case m["s"] > 0 && m["n"] > 0: // sw + n = nw
			m["sw"]--
			m["n"]--
			m["nw"]++
			continue
		case m["nw"] > 0 && m["ne"] > 0: // nw + ne = n
			m["nw"]--
			m["ne"]--
			m["n"]++
			continue
		default:
			return m
		}
	}
}

func countSteps(input []string) int {

	directions := make(map[string]int)
	for _, direction := range input {
		directions[direction]++
	}

	directions = reduceMovements(directions)

	count := 0
	for _, c := range directions {
		count += c
	}
	return count
}

func countFurthest(input []string) int {
	furthest := 0
	var c int
	for i := range input {
		c = countSteps(input[0 : i+1])
		if c > furthest {
			furthest = c
		}
	}
	return furthest
}
