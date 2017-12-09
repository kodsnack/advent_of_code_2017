package day6

import (
	"strconv"
	"strings"
)

func Part1(memory []int) int {
	iterations := 1
	seen := make(map[string]struct{})

	for {
		// Find largest
		largestVal := 0
		largestIndex := 0
		for index, val := range memory {
			if val > largestVal {
				largestIndex = index
				largestVal = val
			}
		}

		// Redistribute
		numOriginalBucket := memory[largestIndex]
		memory[largestIndex] = 0
		for i := 1; i <= numOriginalBucket; i++ {
			memory[(largestIndex+i)%len(memory)]++
		}

		k := memstr(memory)
		if _, ok := seen[k]; ok {
			return iterations
		}
		seen[k] = struct{}{}

		iterations++
	}
}

func Part2(memory []int) int {
	iterations := 1
	seen := make(map[string]int)

	for {
		// Find largest
		largestVal := 0
		largestIndex := 0
		for index, val := range memory {
			if val > largestVal {
				largestIndex = index
				largestVal = val
			}
		}

		// Redistribute
		numOriginalBucket := memory[largestIndex]
		memory[largestIndex] = 0
		for i := 1; i <= numOriginalBucket; i++ {
			memory[(largestIndex+i)%len(memory)]++
		}

		k := memstr(memory)
		if since, ok := seen[k]; ok {
			return iterations - since
		}
		seen[k] = iterations

		iterations++
	}
}

func memstr(memory []int) string {
	strs := make([]string, len(memory))
	for k, v := range memory {
		strs[k] = strconv.Itoa(v)
	}
	return strings.Join(strs, ",")
}
