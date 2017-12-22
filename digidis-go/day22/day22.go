package main

import (
	"fmt"
	"io/ioutil"
)

func main() {
	fmt.Printf("Part 1: %v, part 2: %v\n", run(1, 10000), run(2, 10000000))
}

func run(part, burts int) int {

	ig := make(map[string]int)
	grid, _ := ioutil.ReadFile("input.txt")
	var a, b int
	for _, m := range grid {
		switch m {
		case '#':
			ig[p(a, b)] = 2
		case '\n':
			b++
			a = 0
			continue
		}
		a++
	}

	x, y := (a-1)/2, b/2

	var dir, infected int

	for burts > 0 {

		p := p(x, y)

		switch ig[p] {
		case 0:
			dir = (dir + 3) % 4
		case 2:
			dir = (dir + 1) % 4
		case 3:
			dir = (dir + 2) % 4
		}

		switch part {
		case 1:
			ig[p] = (ig[p] + 2) % 4
		case 2:
			ig[p] = (ig[p] + 1) % 4
		}

		if ig[p] == 2 {
			infected++
		}

		switch dir {
		case 0:
			y--
		case 1:
			x++
		case 2:
			y++
		case 3:
			x--
		}

		burts--
	}

	return infected
}

func p(x, y int) string {
	return fmt.Sprintf("%v,%v", x, y)
}
