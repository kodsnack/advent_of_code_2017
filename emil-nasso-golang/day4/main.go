package main

import (
	"fmt"
	"io/ioutil"
	"sort"
	"strings"
)

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	passwords := strings.Split(strings.TrimSpace(string(input)), "\n")
	part1ValidCount := 0
	part2ValidCount := 0
	for _, password := range passwords {
		if passwordIsValidPart1(password) {
			part1ValidCount++
		}
		if passwordIsValidPart2(password) {
			part2ValidCount++
		}
	}

	fmt.Println("Part 1:", part1ValidCount)
	fmt.Println("Part 2:", part2ValidCount)
}

func passwordIsValidPart1(password string) bool {

	words := strings.Fields(password)
	uniqueWords := make(map[string]bool, 0)
	for _, word := range words {
		uniqueWords[word] = true
	}
	return len(words) == len(uniqueWords)
}

func passwordIsValidPart2(password string) bool {
	words := strings.Fields(password)
	uniqueWords := make(map[string]bool, 0)
	for _, word := range words {
		letters := strings.Split(word, "")
		sort.Strings(letters)
		sortedWord := strings.Join(letters, "")
		uniqueWords[sortedWord] = true
	}
	return len(words) == len(uniqueWords)
}
