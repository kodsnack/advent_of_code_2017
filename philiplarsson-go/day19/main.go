package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"./pkg/point"
	"./pkg/matrice"
	"strings"
)

const up string = "up"
const right string = "right"
const down string = "down"
const left string = "left"

func main() {
	checkArgs()
	filedata := getFileData()
	height := len(filedata)
	width := len(filedata[0])
	matrix := matrice.New(height, width)
	matrix.FillMatrice(filedata)
	// printMatrix(matrix)
	part1(&matrix)
	// matrix.showSurrounding(67, 47, 10)
}

func part1(matrix *matrice.Matrice) {
	p := point.New(*matrix)
	startingX := findStartingX(*matrix)
	p.Set(startingX, 0)
	letters, steps := walkPath(&p, matrix)
	fmt.Println("Part 1")
	fmt.Println(" Letters are:", structToString(letters))
	fmt.Println("Part 2")
	fmt.Printf(" We took %d steps. \n", steps)
}

// walkPath walks the matrix path and collects letters.
// the collected letters and number of steps taken are returned
func walkPath(p *point.Point, matrix *matrice.Matrice) ([]string, int) {
	currentDirection := down
	letters := make([]string, 0)
	var nextChar string
	// steps is one since we count the starting point as gone one step
	steps := 1
	for {
		switch currentDirection {
		case down:
			nextChar = p.CheckDown()
		case right:
			nextChar = p.CheckRight()
		case up:
			nextChar = p.CheckUp()
		case left:
			nextChar = p.CheckLeft()
		}

		if nextChar == "|" || nextChar == "-" {
			p.MoveInDirection(currentDirection)
			steps++
		} else if nextChar == "+" {
			p.MoveInDirection(currentDirection)
			steps++
		} else if isLetter(nextChar) {
			letters = append(letters, nextChar)
			p.MoveInDirection(currentDirection)
			steps++
		} else if nextChar == " " {
			currentDirection = findNextDirection(currentDirection, *p)
		}

		if len(currentDirection) == 0 {
			// we have no other direction to go to
			return letters, steps
		}
	}
}

func findNextDirection(currentDirection string, p point.Point) string {
	possibleDirections := make([]string, 0)
	if p.CheckDown() != " " {
		possibleDirections = append(possibleDirections, down)
	}
	if p.CheckLeft() != " " {
		possibleDirections = append(possibleDirections, left)
	}
	if p.CheckUp() != " " {
		possibleDirections = append(possibleDirections, up)
	}
	if p.CheckRight() != " " {
		possibleDirections = append(possibleDirections, right)
	}
	var dontGoTowards string
	if currentDirection == up {
		dontGoTowards = down
	} else if currentDirection == right {
		dontGoTowards = left
	} else if currentDirection == down {
		dontGoTowards = up
	} else if currentDirection == left {
		dontGoTowards = right
	}

	for _, possibleDirection := range possibleDirections {
		if possibleDirection != dontGoTowards {
			// we don't want to go back in same direction
			return possibleDirection
		}
	}
	return ""
}

func isLetter(str string) bool {
	alpha := "abcdefghijklmnopqrstuvxyz"

	for _, char := range str {
		if !strings.Contains(alpha, strings.ToLower(string(char))) {
			return false
		}
	}
	return true
}

func printMatrix(matrix matrice.Matrice) {
	for i, row := range matrix.GetTable() {
		fmt.Print(i, ":")
		for _, col := range row {
			if len(col) == 0 {
				fmt.Print(" ")
			} else {
				fmt.Print(col)
			}
		}
		fmt.Println()
	}
}

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please enter filename as first and only argument. ")
		fmt.Println(" Example: go run day19.go puzzle.in")
		os.Exit(1)
	}
}

func getFileData() []string {
	filename := os.Args[1]
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0)
	for scanner.Scan() {
		line := scanner.Text()
		filedata = append(filedata, line)
	}
	return filedata
}

func structToString(chars []string) string {
	return strings.Join(chars, "")
}

func findStartingX(matrix matrice.Matrice) int {
	// starting point is according to the instructions just off the top of the diagram
	for x, value := range matrix.GetTable()[0] {
		if value == "|" {
			return x
		}
	}
	return 0
}
