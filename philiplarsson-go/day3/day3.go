package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"time"
)

var steps int

const TableSize = 20

func main() {
	checkForCorrectArgs()

	input := os.Args[2]
	puzzleInput, err := strconv.Atoi(input)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	if os.Args[1] == "1" {
		steps = calculateSteps1(puzzleInput, 0)
		fmt.Println("Number of steps is", steps)
	} else if os.Args[1] == "2" {
		// fuckit, bruteforce
		value := bruteforceSpiral(puzzleInput)
		fmt.Println("Value is:", value)
	} else {
		fmt.Println("Please enter 0 or 1 as part")
		os.Exit(1)
	}

}

func checkForCorrectArgs() {
	if len(os.Args) < 3 {
		fmt.Println("Please provide which part and filename as argument. ")
		os.Exit(1)
	}
}

func calculateSteps1(input int, stepsTaken int) int {
	time.Sleep(100 * time.Millisecond)
	side := findSideFor(input)
	cubeMax := side * side

	cornerPieces := make([]int, 0, 4)
	for i := 0; i < 4; i++ {
		cornerPieces = append(cornerPieces, cubeMax-(side-1)*i)
	}

	middlePoint := findMiddlepointFor(input, cornerPieces, side)
	stepsToMiddlePoint := math.Abs(float64(middlePoint - input))
	stepsTaken += int(stepsToMiddlePoint)

	// We are now at middlepoint and can walk straight towards 1
	// Steps left is side / 2 (int divisin)
	stepsTaken += side / 2
	return stepsTaken
}

func findSideFor(nbr int) int {
	return findSide(nbr, 1)
}

func findSide(nbr, s int) int {
	if nbr-s*s > 0 {
		return findSide(nbr, s+2)
	}

	return s
}

func findMiddlepointFor(input int, cornerPieces []int, side int) int {
	trueMiddlePoint := math.MaxInt32
	for _, v1 := range cornerPieces {
		testMiddlePoint := v1 - side/2
		if math.Abs(float64(testMiddlePoint-input)) < math.Abs(float64(trueMiddlePoint-input)) {
			trueMiddlePoint = testMiddlePoint
		}
	}
	return trueMiddlePoint
}

func bruteforceSpiral(input int) int {
	var table [TableSize][TableSize]int
	currentX := TableSize / 2
	currentY := TableSize / 2
	table[currentY][currentX] = 1
	fmt.Println("Starting on", currentX, currentY)
	for i := 0; i < 100; i++ {
		currentX, currentY = addValueToTable(&table, currentX, currentY)
		time.Sleep(100 * time.Millisecond)
		printArray(table)
		fmt.Println()
		currentValue := getTableValue(currentX, currentY, table)
		if currentValue > input {
			return currentValue
		}
	}

	return 1
}

func setTableValue(x int, y int, table *[TableSize][TableSize]int, value int) {
	table[y][x] = value
	fmt.Println("Setting [", x, ",", y, "]", "to:", value)
}

func getTableValue(x int, y int, table [TableSize][TableSize]int) int {
	return table[y][x]
}

func printArray(arr [TableSize][TableSize]int) {
	for _, row := range arr {
		for _, col := range row {
			fmt.Print("[", col, "]")
		}
		fmt.Println()
	}
}

func addValueToTable(table *[TableSize][TableSize]int, x int, y int) (int, int) {
	fmt.Println("Im on:", x, y)

	if shouldGoUp(x, y, *table) {
		setTableValue(x, y-1, table, getValueFor(x, y-1, *table))
		fmt.Println("Going up")
		return x, y - 1
	} else if shouldGoLeft(x, y, *table) {
		setTableValue(x-1, y, table, getValueFor(x-1, y, *table))
		fmt.Println("Going left")
		return x - 1, y
	} else if shouldGoRight(x, y, *table) {
		setTableValue(x+1, y, table, getValueFor(x+1, y, *table))
		fmt.Println("Going right")
		return x + 1, y
	} else if shouldGoDown(x, y, *table) {
		setTableValue(x, y+1, table, getValueFor(x, y+1, *table))
		fmt.Println("Going down")
		return x, y + 1
	}
	fmt.Println("should not do anything")
	return 1, 1
}

func shouldGoRight(x int, y int, table [TableSize][TableSize]int) bool {
	// om den jag är på är satt
	// om höger är tom
	if getTableValue(x, y, table) != 0 &&
		getTableValue(x+1, y, table) == 0 {
		return true
	}

	return false
}

func shouldGoUp(x int, y int, table [TableSize][TableSize]int) bool {
	// om ovan är tom
	// om till vänster är satt
	if getTableValue(x, y-1, table) == 0 &&
		getTableValue(x-1, y, table) != 0 {
		return true
	}
	return false
}

func shouldGoLeft(x int, y int, table [TableSize][TableSize]int) bool {
	// om vänster är tom
	// om denna är satt
	// under är satt
	if getTableValue(x-1, y, table) == 0 &&
		getTableValue(x, y, table) != 0 &&
		getTableValue(x, y+1, table) != 0 {
		return true
	}
	return false
}

func shouldGoDown(x int, y int, table [TableSize][TableSize]int) bool {
	// om denna är satt
	// om nedan är tom
	// om höger är satt
	if getTableValue(x, y, table) != 0 &&
		getTableValue(x, y+1, table) == 0 &&
		getTableValue(x+1, y, table) != 0 {
		return true
	}
	return false
}

func getValueFor(x int, y int, table [TableSize][TableSize]int) int {
	sum := 0
	for x1 := x - 1; x1 <= x+1; x1++ {
		for y1 := y - 1; y1 <= y+1; y1++ {
			sum += getTableValue(x1, y1, table)
		}
	}
	return sum
}
