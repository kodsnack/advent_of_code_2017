package main

import (
	"fmt"
	"strings"

	"github.com/johansundell/advent_of_code_2017/johansundell-go/adventofcode2017"
)

func main() {
	data, err := adventofcode2017.GetInput("day4.txt")
	if err != nil {
		panic(err)
	}
	fmt.Println(countValid(data))
}

func countValid(str string) (sum, second int) {
	for _, word := range strings.Split(str, "\n") {
		if isValid(word, false) {
			sum++
			if isValid(word, true) {
				second++
			}
		}
	}
	return
}

func isValid(str string, useLevel2 bool) bool {
	words := make(map[string]int)
	for _, s := range strings.Fields(str) {
		words[s]++
	}
	for k, t := range words {
		if t != 1 {
			return false
		} else if useLevel2 {
			for s := range words {
				if k != s {
					if adventofcode2017.SortString(k) == adventofcode2017.SortString(s) {
						return false
					}
				}
			}
		}
	}
	return true
}
