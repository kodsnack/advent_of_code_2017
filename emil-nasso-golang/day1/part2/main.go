package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	args := os.Args[1:]
	input := strings.Split(args[0], "")

	length := len(input)
	stepsForward := length / 2
	sum := 0
	var nextCharPos int
	for i, char := range input {
		nextCharPos = i + stepsForward
		if nextCharPos > length-1 {
			nextCharPos -= length
		}

		if char == input[nextCharPos] {
			charAsInt, _ := strconv.Atoi(char)
			sum += charAsInt
		}
	}
	fmt.Println(sum)
}
