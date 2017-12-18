package main

import "fmt"

var input = 382

func main() {
	fmt.Printf("after 2017: %v\n", part1())
	fmt.Printf("after 0: %v\n", part2())
}

func part1() int {
	value, pos := 1, 0
	buffer := []int{0}
	for value <= 2017 {
		pos = (pos + input) % value
		buffer = append(buffer, 0)
		copy(buffer[pos+2:], buffer[pos+1:])
		buffer[pos+1] = value
		pos++
		value++
	}
	return buffer[pos+1]
}

func part2() int {
	value, pos, after := 1, 0, 0
	for value <= 50000000 {
		pos = (pos + input) % value
		if pos == 0 {
			after = value
		}
		pos++
		value++
	}
	return after
}
