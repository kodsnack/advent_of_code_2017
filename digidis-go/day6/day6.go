package main

import (
	"fmt"
	"strconv"
	"strings"
)

var (
	input = "4	10	4	1	8	4	9	14	5	1	14	15	0	15	3	5"
)

func main() {
	var part1, part2 int

	numbers := getNumbers(input)
	states := make(map[string]bool)

	states[state(numbers)] = true

	steps := 0
	loop := false
	loopState := ""

	for {
		maxi := 0
		for i := range numbers {
			if numbers[i] > numbers[maxi] {
				maxi = i
			}
		}

		c := numbers[maxi]
		numbers[maxi] = 0

		j := (maxi + 1) % len(numbers)
		for c > 0 {
			numbers[j]++
			c--
			j = (j + 1) % len(numbers)
		}
		steps++

		if loop && state(numbers) == loopState {
			part2 = steps
			break
		}
		if !loop && states[state(numbers)] {
			loop = true
			loopState = state(numbers)
			part1 = steps
			steps = 0
		}

		states[state(numbers)] = true
	}

	fmt.Printf("Answer 1: %v, answer 2: %v\n", part1, part2)
}

func state(numbers []int) (s string) {
	for _, i := range numbers {
		s = s + "," + strconv.Itoa(i)
	}
	return s
}

func getNumbers(v string) []int {
	parts := strings.Fields(v)
	list := make([]int, 0)
	for _, p := range parts {
		i, _ := strconv.Atoi(p)
		list = append(list, i)
	}
	return list
}
