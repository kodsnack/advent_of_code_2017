package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	checkUserInput()
	data := getFileData()
	memory := getMemory(data)
	partSelection := os.Args[1]
	runCorrectPart(partSelection, memory)
}

func checkUserInput() {
	if len(os.Args) < 3 {
		fmt.Println("Please provide part (1 or 2) and filename as arguments. ")
		fmt.Println(" Example:", "go run day6.go 1 memory.org")
		os.Exit(1)
	}
}

func getFileData() []string {
	filename := os.Args[2]
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	scanner := bufio.NewScanner(file)
	fileLines := make([]string, 0, 10)
	for scanner.Scan() {
		line := scanner.Text()
		fileLines = append(fileLines, line)
	}
	return fileLines
}

func getMemory(data []string) []int {
	memory := make([]int, 0, 1)
	for _, v := range data {
		chunks := strings.Fields(v)
		for _, chunk := range chunks {
			block, err := strconv.Atoi(chunk)
			if err != nil {
				fmt.Println(err)
				os.Exit(1)
			}
			memory = append(memory, block)
		}
	}
	return memory
}

func runCorrectPart(part string, blocks []int) {
	if part == "1" {
		// run part1
		cycles, _ := countCycles(blocks)
		fmt.Println("It took", cycles, "number of cycles")
	} else if part == "2" {
		_, cycles := countCycles(blocks)
		fmt.Println("It took", cycles, "number of cycles")
	} else {
		fmt.Println("Please enter 0 or 1 as part")
		os.Exit(1)
	}
}

func countCycles(blocks []int) (int, int) {
	var cycles int
	seenStates := make(map[string]int)
	for {
		maxBlock, index := findMaxBlock(blocks)
		redistribute(index, maxBlock, &blocks)
		cycles++
		state := getStateAsString(blocks)
		if seenStates[state] != 0 {
			return cycles, cycles - seenStates[state]
		}
		seenStates[state] = cycles
	}
	// return cycles
}

func findMaxBlock(blocks []int) (int, int) {
	var maxBlock int
	var index int
	for i, v := range blocks {
		if v > maxBlock {
			maxBlock = v
			index = i
		}
	}
	return maxBlock, index
}

func redistribute(index int, maxBlock int, blocks *[]int) {
	(*blocks)[index] = 0
	blocksLength := len(*blocks)
	for maxBlock > 0 {
		index++
		if index > blocksLength-1 {
			index = 0
		}
		(*blocks)[index]++
		maxBlock--
	}
}

func getStateAsString(blocks []int) string {
	var intBlocks []string
	for _, v := range blocks {
		intBlocks = append(intBlocks, strconv.Itoa(v))
	}
	return strings.Join(intBlocks, "")
}
