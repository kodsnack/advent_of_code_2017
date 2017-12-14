package main

import (
	"fmt"
	"sort"
	"strconv"
	"strings"

	"github.com/johansundell/advent_of_code_2017/johansundell-go/adventofcode2017"
)

func main() {
	data, err := adventofcode2017.GetInput("day2.txt")
	if err != nil {
		panic(err)
	}
	fmt.Println(getChecksum(data))
}

func getChecksum(str string) (sum, div int) {
	for _, s := range strings.Split(str, "\n") {
		input := make([]int, 0)
		for _, t := range strings.Split(s, "\t") {
			n, _ := strconv.Atoi(t)
			input = append(input, n)
		}
		sort.Ints(input)
		sum += input[len(input)-1] - input[0]
		div += getNiceDiv(input)
	}
	return
}

func getNiceDiv(input []int) int {
	for k, n := range input {
		for x, y := range input[k+1:] {
			if k != x && y%n == 0 {
				return y / n
			}
		}
	}
	return 0
}
