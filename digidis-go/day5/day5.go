package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	part1()
	part2()
}

func part1() {
	f, _ := os.Open("input.txt")
	jumps := make([]int, 0)
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		i, _ := strconv.Atoi(scanner.Text())
		jumps = append(jumps, i)
	}
	f.Close()

	var pos, steps int
	for pos >= 0 && pos < len(jumps) {
		p := pos
		pos = pos + jumps[pos]
		jumps[p]++
		steps++
	}
	fmt.Printf("Answer: %v\n", steps)

}

func part2() {
	f, _ := os.Open("input.txt")
	jumps := make([]int, 0)
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		i, _ := strconv.Atoi(scanner.Text())
		jumps = append(jumps, i)
	}
	f.Close()

	var pos, steps int
	for pos >= 0 && pos < len(jumps) {
		p := pos
		pos = pos + jumps[pos]

		if jumps[p] >= 3 {
			jumps[p]--
		} else {
			jumps[p]++
		}

		steps++
	}
	fmt.Printf("Answer: %v\n", steps)

}
