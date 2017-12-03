package main

import (
	"fmt"
	"strconv"
	"os"
)

var sum int

func main() {
	testString := os.Args[2]

	if os.Args[1] == "1" {
		sum = partOne(testString)
	} else if os.Args[1] == "2" {
		sum = partTwo(testString)
	}
	fmt.Println(sum)
}

func partOne(x string) int {
	sum := 0
	lastInt := 0
	for _, v := range x {
		currentNbr, _ := strconv.Atoi(string(v))
		if lastInt == currentNbr {
			sum += lastInt
		}
		lastInt = currentNbr
	}
	
	firstInt, _ := strconv.Atoi(x[:1])
	if lastInt == firstInt {
		sum += lastInt
	}
	return sum
}

func partTwo(x string) int {
	halfway := len(x) / 2
	nextToCheck := halfway
	sum := 0
	for _, v := range x {
		currentNbr, _ := strconv.Atoi(string(v))
		if nextToCheck == len(x) {
			nextToCheck = 0
		}
		checkAgainst, _ := strconv.Atoi(x[nextToCheck:nextToCheck+1])
		if currentNbr == checkAgainst {
			sum += currentNbr
		}
		nextToCheck++
	}
	return sum
}
