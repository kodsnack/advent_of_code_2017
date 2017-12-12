package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {

	list := make([]int, 256)

	for i := range list {
		list[i] = i
	}

	fmt.Println("Part 1:", tyeKnot(list, input()))
}

func input() []int {
	data, _ := ioutil.ReadFile("input.txt")

	ints := make([]int, 0)
	var asInt int
	for _, i := range strings.Split(string(data), ",") {
		asInt, _ = strconv.Atoi(i)
		ints = append(ints, asInt)
	}
	return ints
}

func tyeKnot(list []int, lengths []int) []int {
	currentPosition := 0
	skipLength := 0
	for _, length := range lengths {
		list = reverse(list, currentPosition, length)
		currentPosition += length + skipLength
		skipLength++
		if currentPosition >= len(list) {
			currentPosition -= len(list)
		}
	}
	return list
}

func reverse(i []int, start int, length int) []int {
	if length == 0 {
		return i
	}
	// 0, 1, 2, 3, 4, 5
	// fmt.Println(i)
	switches := (length / 2)
	end := start + length - 1
	if end >= len(i) {
		end -= len(i)
	}

	for {
		if switches == 0 {
			break
		}
		switches--
		// fmt.Println("Switching", i[start], "and", i[end])
		i[start], i[end] = i[end], i[start]
		// fmt.Println("Got:", i)

		start++
		end--
		if end == -1 {
			end = len(i) - 1
		}
		if start == len(i) {
			start = 0
		}
	}

	return i
}
