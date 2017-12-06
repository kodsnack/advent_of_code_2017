package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {
	input := prepareInput("input.txt")
	fmt.Println("Part 1:", part1(input))

	input = prepareInput("input.txt")
	fmt.Println("Part 2:", part2(input))
}

func prepareInput(filename string) []int {
	data, _ := ioutil.ReadFile(filename)
	lines := strings.Split(strings.TrimSpace(string(data)), "\n")
	numbers := make([]int, 0)
	for _, line := range lines {
		if number, err := strconv.Atoi(line); err == nil {
			numbers = append(numbers, number)
		} else {
			log.Fatal(err.Error())
		}
	}
	return numbers
}

func part1(playingField []int) int {
	currentPosition := 0
	iteration := 0

	for {
		nextPosition := currentPosition + playingField[currentPosition]

		playingField[currentPosition]++

		currentPosition = nextPosition
		iteration++

		if currentPosition < 0 || currentPosition >= len(playingField) {
			break
		}
	}
	return iteration
}

func part2(playingField []int) int {
	currentPosition := 0
	iteration := 0

	for {
		nextPosition := currentPosition + playingField[currentPosition]

		if playingField[currentPosition] >= 3 {
			playingField[currentPosition]--
		} else {
			playingField[currentPosition]++
		}

		currentPosition = nextPosition
		iteration++

		if currentPosition < 0 || currentPosition >= len(playingField) {
			break
		}
	}
	return iteration
}
