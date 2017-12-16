package main

import "fmt"

func main() {
	fmt.Printf("Part 1: %v, part 2: %v\n", part1(), part2())
}

func part2() int {
	var match, pairs int
	a := 873
	b := 583
	for pairs < 5000000 {
		for {
			a = (a * 16807) % 2147483647
			if a%4 == 0 {
				break
			}
		}
		for {
			b = (b * 48271) % 2147483647
			if b%8 == 0 {
				break
			}
		}
		if a&0xFFFF == b&0xFFFF {
			match++
		}
		pairs++
	}
	return match
}

func part1() int {
	var match, pairs int
	a := 873
	b := 583
	for pairs < 40000000 {
		a = (a * 16807) % 2147483647
		b = (b * 48271) % 2147483647

		if a&0xFFFF == b&0xFFFF {
			match++
		}
		pairs++
	}
	return match
}

// much slower...
func part2Channels() {
	av := make(chan int)
	bv := make(chan int)

	go func(a int) {
		for {
			a = (a * 16807) % 2147483647
			if a%4 == 0 {
				av <- a
			}
		}
	}(873)

	go func(b int) {
		for {
			b = (b * 48271) % 2147483647
			if b%8 == 0 {
				bv <- b
			}
		}
	}(583)

	match := 0
	pairs := 0
	for pairs < 5000000 {
		a := <-av
		b := <-bv
		if a&0xFFFF == b&0xFFFF {
			match++
			fmt.Printf("%v matches\n", match)
		}
		pairs++
	}
}
