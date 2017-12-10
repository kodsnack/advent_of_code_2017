package main

import (
	"fmt"
)

var data map[string]int

func getData(x, y int) int {
	return data[fmt.Sprintf("%v,%v", x, y)]
}

func main() {

	input := 347991

	data = make(map[string]int)

	var x, y int
	dir := 0
	c := 1
	j := 1

	first := 0

	data["0,0"] = 1

	for i := 1; i < input; i++ {

		value := getData(x-1, y-1) + getData(x, y-1) + getData(x+1, y-1) + getData(x-1, y) + getData(x, y) + getData(x+1, y) + getData(x-1, y+1) + getData(x, y+1) + getData(x+1, y+1)
		data[fmt.Sprintf("%v,%v", x, y)] = value

		if first == 0 && value > input {
			first = value
		}

		switch dir {
		case 0:
			x++
		case 1:
			y--
		case 2:
			x--
		case 3:
			y++
		}

		j--

		if j == 0 {
			if dir == 1 || dir == 3 {
				c++
			}
			j = c
			dir = (dir + 1) % 4
		}
	}

	fmt.Printf("Part 1: %v, part 2: %v\n", dist(x, y), first)

}

func abs(x int) int {
	if x > 0 {
		return x
	}
	return -x
}

func dist(x, y int) int {
	return abs(x) + abs(y)
}
