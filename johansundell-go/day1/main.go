package main

import (
	"fmt"
	"strconv"

	"github.com/johansundell/advent_of_code_2017/johansundell-go/adventofcode2017"
)

func main() {
	data, err := adventofcode2017.GetInput("day1.txt")
	if err != nil {
		panic(err)
	}
	fmt.Println(calcSum(data), calcSum2(data))
}

func calcSum(str string) (sum int) {
	for i := 0; i < len(str); i++ {
		x, _ := strconv.Atoi(str[i : i+1])
		y, _ := getDigitInList(str, i, 1)
		if x == y {
			sum += x
		}
	}
	return
}

func calcSum2(str string) (sum int) {
	for i := 0; i < len(str); i++ {
		x, _ := strconv.Atoi(str[i : i+1])
		y, _ := getDigitInList(str, i, len(str)/2)
		if x == y {
			sum += x
		}
	}
	return
}

func getDigitInList(str string, currentPos, stepAhead int) (int, error) {
	if currentPos != 0 {
		str = str[currentPos:] + str[:currentPos-1]
	}
	return strconv.Atoi(str[stepAhead : stepAhead+1])
}
