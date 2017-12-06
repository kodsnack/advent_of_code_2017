package main

import (
	"fmt"
	"strconv"
)

func findMaxIntArray(arr *[]int) (int, int) {
	var index, value = 0, 0
	for i, v := range *arr {
		if v > value {
			index = i
			value = v
		}
	}
	return index, value
}

func redistribute(mem *[]int) {
	i, v := findMaxIntArray(mem)
	(*mem)[i] = 0
	distribute(mem, v, (i+1)%len(*mem))
}

func distribute(mem *[]int, v int, startIndex int) {

	i := startIndex
	for v > 0 {
		(*mem)[i]++
		i = (i + 1) % len(*mem)
		v--
	}
}

func strInSlice(a string, arr *[]string) int {
	for i, b := range *arr {
		if b == a {
			return i
		}
	}
	return -1
}

func makehash(arr *[]int) string {

	s := ""
	for _, v := range *arr {
		s += strconv.Itoa(v) + "."
	}
	return s
}

func main() {

	var initialState = []int{5, 1, 10, 0, 1, 7, 13, 14, 3, 12, 8, 10, 7, 12, 0, 6}
	var memory = initialState

	var hash = "dummy"
	var hashes []string
	gen := 0
	found := -1

	for found == -1 {
		redistribute(&memory)
		gen++
		hash = makehash(&memory)
		found = strInSlice(hash, &hashes)
		hashes = append(hashes, hash)
	}
	fmt.Printf("Repeated memory pattern found from generation %d. Generation %d: Memory = %v\n", found, gen, memory)
}
