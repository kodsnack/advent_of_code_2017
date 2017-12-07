package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	steps, redistributions := solve(input())
	fmt.Println("Part 1:", steps)
	fmt.Println("Part 2:", redistributions)
}

func input() []int {
	fileContents, _ := ioutil.ReadFile("input.txt")

	strs := strings.Fields(string(fileContents))
	ints := make([]int, 0)
	for _, s := range strs {
		i, _ := strconv.Atoi(s)
		ints = append(ints, i)
	}
	return ints
}

func solve(input []int) (int, int) {
	steps := 0
	seen := make(map[string]int, 0)
	for {
		duplicateFound, stepsBetweenOccurances := hasSeen(input, seen, steps)
		if duplicateFound {
			return steps, stepsBetweenOccurances
		}

		highestIndex := 0
		highestValue := 0
		for i, v := range input {
			if v > highestValue {
				highestIndex = i
				highestValue = v
			}
		}

		redistribute := input[highestIndex]
		input[highestIndex] = 0
		index := highestIndex + 1
		for {
			if redistribute == 0 {
				break
			}

			if index >= len(input) {
				index = 0
			}

			input[index]++

			redistribute--
			index++
		}
		steps++
	}

}

func hasSeen(input []int, seen map[string]int, step int) (bool, int) {
	hash := fmt.Sprint(input)
	if _, found := seen[hash]; found {
		return true, (step - seen[hash])
	}
	seen[hash] = step
	return false, 0
}
