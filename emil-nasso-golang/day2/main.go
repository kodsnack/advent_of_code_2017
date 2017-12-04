package main

import (
	"fmt"
	"io/ioutil"
	"sort"
	"strconv"
	"strings"
)

func main() {
	data, _ := ioutil.ReadFile("input.txt")
	numbers := prepareInput(data)
	fmt.Printf("Part 1: %d\n", calculatePart1Checksum(numbers))
	fmt.Printf("Part 2: %d\n", calculatePart2Checksum(numbers))
}

func prepareInput(input []byte) [][]int {
	cleanedInput := strings.TrimSpace(string(input))
	result := make([][]int, 0)
	for _, row := range strings.Split(cleanedInput, "\n") {
		resultRow := make([]int, 0)
		for _, col := range strings.Fields(row) {
			number, _ := strconv.Atoi(col)
			resultRow = append(resultRow, number)
		}
		result = append(result, resultRow)
	}
	return result
}

func calculatePart1Checksum(input [][]int) int {
	checksum := 0
	for _, row := range input {
		sort.Ints(row)
		checksum += row[len(row)-1] - row[0]
	}
	return checksum
}

func calculatePart2Checksum(input [][]int) int {
	checksum := 0
	for _, row := range input {
	row:
		for _, x := range row {
			for _, y := range row {
				if x == y {
					continue
				}
				if x%y == 0 {
					checksum += x / y
					break row
				}
			}
		}
	}
	return checksum
}
