package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

func main() {

	f, _ := os.Open("input.txt")

	var part1, part2 int

	scanner := bufio.NewScanner(f)
	for scanner.Scan() {

		words := strings.Fields(scanner.Text())

		count := make(map[string]bool)
		count2 := make(map[string]bool)

		valid := true
		valid2 := true

		for _, w := range words {

			if count[w] {
				valid = false
			}
			count[w] = true

			chars := strings.Split(w, "")
			sort.Strings(chars)
			w2 := strings.Join(chars, "")

			if count2[string(w2)] {
				valid2 = false
			}
			count2[string(w2)] = true
		}

		if valid {
			part1++
		}
		if valid2 {
			part2++
		}
	}
	f.Close()

	fmt.Printf("Part 1: %v, part 2: %v\n", part1, part2)

}
