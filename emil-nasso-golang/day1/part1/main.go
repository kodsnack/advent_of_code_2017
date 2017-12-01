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
	sum := 0
	var nextChar string
	for i, char := range input {
		if i == length-1 {
			nextChar = input[0]
		} else {
			nextChar = input[i+1]
		}

		if char == nextChar {
			charAsInt, _ := strconv.Atoi(char)
			sum += charAsInt
		}
	}
	fmt.Println(sum)
}
