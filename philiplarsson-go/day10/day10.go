package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

const ListSize = 256

func main() {
	var list [ListSize]int
	if os.Args[1] == "1" {
		// Part 1
		inputLengths := getInputAsNumbers()
		for i := 0; i < ListSize; i++ {
			list[i] = i
		}
		doElvesHash(&list, inputLengths, 0, 0)
		fmt.Printf("Multiplying the first two elements gives us %d\n", list[0]*list[1])
	} else if os.Args[1] == "2" {
		// Part 2
		inputLengths := getInputAsAscii()

		// Fill list
		for i, _ := range list {
			list[i] = i
		}
		// Do 64 rounds, keep currentPosition and skipSize between rounds
		currentPosition := 0
		skipSize := 0
		for i := 0; i < 64; i++ {
			currentPosition, skipSize = doElvesHash(&list, inputLengths, currentPosition, skipSize)
		}

		// Calculate denseHash
		var denseHash []int
		hash := 0
		for i := 0; i < len(list); i = i + 16 {
			for j := i; j < i+16; j++ {
				hash ^= list[j]
			}
			denseHash = append(denseHash, hash)
			hash = 0
		}

		// Create densehash as Hex
		hashAsHex := toHex(denseHash)
		fmt.Println("As hex:", hashAsHex, "length:", len(hashAsHex))
	} else {
		fmt.Println("Please provide part 1 or 2.")
		os.Exit(1)
	}
}

func getInputAsNumbers() []int {
	inputSlice := make([]int, 0)
	if len(os.Args) < 3 {
		fmt.Println("Please enter the part and puzzle input as arguments. ")
		os.Exit(1)
	}
	input := strings.Split(os.Args[2], ",")
	for _, v := range input {
		valAsInt, err := strconv.Atoi(v)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		inputSlice = append(inputSlice, valAsInt)
	}
	return inputSlice
}

func getInputAsAscii() []int {
	inputSlice := make([]int, 0)
	if len(os.Args) < 3 {
		fmt.Println("Please enter the part and puzzle input as arguments. ")
		os.Exit(1)
	}
	input := os.Args[2]
	for _, v := range input {
		inputSlice = append(inputSlice, int(v))
	}
	endSequence := []int{17, 31, 73, 47, 23}
	inputSlice = append(inputSlice, endSequence...)
	return inputSlice
}

func doElvesHash(list *[ListSize]int, input []int, currentPosition int, skipSize int) (int, int) {
	for _, inputValue := range input {
		reverseArray(list, currentPosition, inputValue)
		currentPosition += (inputValue + skipSize)
		for currentPosition > len(*list)-1 {
			currentPosition -= len(*list)
		}
		skipSize++
	}
	return currentPosition, skipSize
}

func reverseArray(list *[ListSize]int, currentPosition int, inputValue int) {
	valuesToBeReversed := make([]int, 0)
	startPosition := currentPosition
	for i := 0; i < inputValue; i++ {
		valuesToBeReversed = append(valuesToBeReversed, (*list)[currentPosition])
		currentPosition++
		for currentPosition > len(*list)-1 {
			currentPosition -= len(*list)
		}
	}

	for i := len(valuesToBeReversed) - 1; i >= 0; i-- {
		(*list)[startPosition] = valuesToBeReversed[i]
		startPosition++
		if startPosition > len(*list)-1 {
			startPosition = 0
		}
	}
}

func toHex(list []int) string {
	var hex []string
	for _, v := range list {
		newHex := strconv.FormatInt(int64(v), 16)
		if len(newHex) < 2 {
			hex = append(hex, "0"+newHex)
		} else {
			hex = append(hex, newHex)
		}
	}
	hexAsString := strings.Join(hex, "")
	return hexAsString
}
