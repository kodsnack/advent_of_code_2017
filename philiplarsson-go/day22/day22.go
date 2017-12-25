package main

import (
	"bufio"
	"fmt"
	"log"
	"os"

	"github.com/philiplarsson/matricepoint"
	"github.com/philiplarsson/strmatrice"
)

const width = 2000
const height = 2000

func main() {
	checkArgs()
	filedata := getFiledata()

	part1(filedata)
	part2(filedata)
}

func part1(filedata []string) {
	matrice := strmatrice.New(width, height)
	fillMatrice(&matrice, filedata)

	// fillMatrice starts att 500
	xMiddlePoint := 500 + len(filedata)/2
	yMiddlePoint := 500 + len(filedata)/2

	startPoint := matricepoint.New(matrice)
	startPoint.Set(xMiddlePoint, yMiddlePoint)
	currentDirection := "up"
	var infections int
	for i := 0; i < 10000; i++ {
		currentDirection = walkPointPart1(&startPoint, &matrice, currentDirection, &infections)
	}
	fmt.Println("Part 1")
	fmt.Println(" Infections:", infections)
}

func part2(filedata []string) {
	matrice := strmatrice.New(width, height)
	fillMatrice(&matrice, filedata)

	// fillMatrice starts att 500
	xMiddlePoint := 500 + len(filedata)/2
	yMiddlePoint := 500 + len(filedata)/2

	startPoint := matricepoint.New(matrice)
	startPoint.Set(xMiddlePoint, yMiddlePoint)
	currentDirection := "up"
	var infections int
	for i := 0; i < 10000000; i++ {
		currentDirection = walkPointPart2(&startPoint, &matrice, currentDirection, &infections)
	}
	fmt.Println("Part 2")
	fmt.Println(" Infections:", infections)
}

func walkPointPart1(point *matricepoint.Point, matrice *strmatrice.Matrice, currentDirection string, infections *int) string {
	// If the current node is infected, it turns to its right. Otherwise, it turns to its left. (Turning is done in-place; the current node does not change.)
	// If the current node is clean, it becomes infected. Otherwise, it becomes cleaned. (This is done after the node is considered for the purposes of changing direction.)
	// The virus carrier moves forward one node in the direction it is facing.
	currentX := point.GetX()
	currentY := point.GetY()
	if point.GetValue() == "#" {
		currentDirection = getDirectionRight(currentDirection)
		matrice.Set(currentX, currentY, ".")
	} else {
		currentDirection = getDirectionLeft(currentDirection)
		(*infections)++
		matrice.Set(currentX, currentY, "#")
	}

	point.MoveInDirection(currentDirection)

	return currentDirection
}

func walkPointPart2(point *matricepoint.Point, matrice *strmatrice.Matrice, currentDirection string, infections *int) string {
	// Decide which way to turn based on the current node:
	// Modify the state of the current node, as described above.
	// The virus carrier moves forward one node in the direction it is facing.
	// weakened as W and flagged as F

	currentX := point.GetX()
	currentY := point.GetY()
	if point.GetValue() == "#" {
		// # = infected
		// If it is infected, it turns right.
		// Infected nodes become flagged.
		currentDirection = getDirectionRight(currentDirection)
		matrice.Set(currentX, currentY, "F")
	} else if point.GetValue() == "." {
		// . = clean
		// If it is clean, it turns left.
		// Clean nodes become weakened.
		currentDirection = getDirectionLeft(currentDirection)
		matrice.Set(currentX, currentY, "W")
	} else if point.GetValue() == "W" {
		// W = weakened
		// If it is weakened, it does not turn, and will continue moving in the same direction.
		// Weakened nodes become infected.
		matrice.Set(currentX, currentY, "#")
		(*infections)++
	} else if point.GetValue() == "F" {
		// F = flagged
		// If it is flagged, it reverses direction, and will go back the way it came.
		// Flagged nodes become clean.
		currentDirection = getDirectionBack(currentDirection)
		matrice.Set(currentX, currentY, ".")
	}
	point.MoveInDirection(currentDirection)

	return currentDirection
}

func getDirectionRight(current string) string {
	switch current {
	case "up":
		return "right"
	case "right":
		return "down"
	case "left":
		return "up"
	case "down":
		return "left"
	}
	return ""
}

func getDirectionLeft(current string) string {
	switch current {
	case "up":
		return "left"
	case "right":
		return "up"
	case "left":
		return "down"
	case "down":
		return "right"
	}
	return ""
}

func getDirectionBack(current string) string {
	switch current {
	case "up":
		return "down"
	case "right":
		return "left"
	case "left":
		return "right"
	case "down":
		return "up"
	}
	return ""
}

func fillMatrice(matrice *strmatrice.Matrice, data []string) {
	fillWithDots(matrice)
	startPoint := 500
	x := startPoint
	y := startPoint
	for _, node := range data {
		for _, ch := range node {
			matrice.Set(x, y, string(ch))
			x++
		}
		y++
		x = startPoint
	}
}

func fillWithDots(matrice *strmatrice.Matrice) {
	for x := 0; x < height; x++ {
		for y := 0; y < width; y++ {
			matrice.Set(x, y, ".")
		}
	}
}

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide a filename to a file that contains the puzzle input as first and only argument. ")
		fmt.Println(" Example: go run day22.go puzzle.in")
		os.Exit(1)
	}
}

func getFiledata() []string {
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
