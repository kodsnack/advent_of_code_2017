package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	fmt.Printf("Part1: %d\n", part1(string(input)))
	fmt.Printf("Part2: %d\n", part2(string(input)))
}

func part1(input string) int {
	chars := strings.Split(input, "")

	length := len(chars)
	sum := 0
	var nextChar string
	for i, char := range chars {
		if i == length-1 {
			nextChar = chars[0]
		} else {
			nextChar = chars[i+1]
		}

		if char == nextChar {
			charAsInt, _ := strconv.Atoi(char)
			sum += charAsInt
		}
	}
	return sum
}

func part2(input string) int {
	chars := strings.Split(input, "")

	length := len(chars)
	stepsForward := length / 2
	sum := 0
	var nextCharPos int
	for i, char := range chars {
		nextCharPos = i + stepsForward
		if nextCharPos > length-1 {
			nextCharPos -= length
		}

		if char == chars[nextCharPos] {
			charAsInt, _ := strconv.Atoi(char)
			sum += charAsInt
		}
	}
	return sum
}
