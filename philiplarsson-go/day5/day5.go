package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	checkUserInput()
	lines := getFileData()
	if os.Args[1] == "1" {
		steps := runInstructionsPart1(lines)
		fmt.Println("It took", steps, "to reach the exit")
	} else if os.Args[1] == "2" {
		steps := runInstructionsPart2(lines)
		fmt.Println("It took", steps, "to reach the exit")
	} else {
		fmt.Println("Please enter 0 or 1 as part")
		os.Exit(1)
	}
}

func checkUserInput() {
	if len(os.Args) < 3 {
		fmt.Println("Please provide part (1 or 2) and filename as arguments. ")
		fmt.Println(" Example:", "go run day4.go 2 passwords.org")
		os.Exit(1)
	}
}

func getFileData() []int {
	filename := os.Args[2]
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	scanner := bufio.NewScanner(file)
	numbers := make([]int, 0, 10)
	for scanner.Scan() {
		line := scanner.Text()
		lineAsInt, err := strconv.Atoi(line)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		numbers = append(numbers, lineAsInt)
	}
	return numbers
}

func runInstructionsPart1(instructions []int) int {
	var steps int
	var i int
	for {
		lastInstructionIndex := i
		i += instructions[i]
		instructions[lastInstructionIndex]++
		steps++
		if i > len(instructions)-1 {
			return steps
		}
	}
}

func runInstructionsPart2(instructions []int) int {
	var steps int
	var i int
	for {
		lastInstructionIndex := i
		offset := instructions[i]
		i += offset
		if offset >= 3 {
			instructions[lastInstructionIndex]--
		} else {
			instructions[lastInstructionIndex]++
		}
		steps++
		if i > len(instructions)-1 {
			return steps
		}
	}
}
