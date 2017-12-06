package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func castStringSliceToInt(s []string) []int {
	i := []int{}
	for _, v := range s {
		integer, _ := strconv.Atoi(v)
		i = append(i, integer)

	}
	return i
}

func day6Part1(i []int) int {
	pointer := 0
	steps := 0

	for {
		if pointer > len(i)-1 {
			break
		}
		steps++
		instruction := i[pointer]
		i[pointer]++
		pointer += instruction
	}
	return steps
}
func main() {
	input := []int{}
	file, _ := os.Open("input")
	defer file.Close()
	fileScanner := bufio.NewScanner(file)
	for fileScanner.Scan() {
		i, _ := strconv.Atoi(fileScanner.Text())
		input = append(input, i)
	}
	fmt.Println(day6Part1(input))
}
