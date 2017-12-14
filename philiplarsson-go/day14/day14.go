package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const gridsize = 127

func init() {
	if len(os.Args) != 2 {
		fmt.Println("Please enter the puzzle input as the only argument. ")
		fmt.Println(" Example: go run day14.go flqrgnkx")
		os.Exit(1)
	}
}

func main() {
	puzzleInput := os.Args[1]
	inputRows := appendDashAndNumber(puzzleInput)
	knotHashes := getKnotHash(inputRows)
	binaryRows := hashToBinary(knotHashes)
	part1(binaryRows)
	part2(binaryRows)
}

func part1(binaryRows [][]string) {
	squares := countOnes(binaryRows)
	fmt.Println("Part 1")
	fmt.Println(" Number of squares:", squares)
}

func part2(binaryRows [][]string) {
	grid := createGrid(binaryRows)
	regions := calculateRegions(grid)
	fmt.Println("Part 2")
	fmt.Println(" Number of regions:", regions)
}

func appendDashAndNumber(input string) []string {
	rows := make([]string, 0)
	for i := 0; i < 128; i++ {
		rows = append(rows, fmt.Sprintf("%s-%d", input, i))
	}
	return rows
}

func getKnotHash(input []string) []string {
	knotHashes := make([]string, 0)

	inputAsASCII := getInputAsASCII(input)

	for i := 0; i < len(inputAsASCII); i++ {
		ASCIIInput := inputAsASCII[i]
		knotHash := createKnotHash(ASCIIInput)
		knotHashes = append(knotHashes, knotHash)
	}
	return knotHashes
}

func doElvesHash(list *[256]int, input []int, currentPosition int, skipSize int) (int, int) {
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

func reverseArray(list *[256]int, currentPosition int, inputValue int) {
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

func getInputAsASCII(input []string) [][]int {
	inputAsASCII := make([][]int, 0)
	for _, line := range input {
		currentLine := make([]int, 0)
		for _, ch := range line {
			currentLine = append(currentLine, int(ch))
		}
		endSequence := []int{17, 31, 73, 47, 23}
		currentLine = append(currentLine, endSequence...)
		inputAsASCII = append(inputAsASCII, currentLine)
	}

	return inputAsASCII
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

// createKnotHash and related functions taken from my solution
// on day 10.
func createKnotHash(input []int) string {
	var list [256]int

	// Fill list
	for i := range list {
		list[i] = i
	}

	// Do 64 rounds, keep currentPosition and skipSize between rounds
	currentPosition := 0
	skipSize := 0
	for i := 0; i < 64; i++ {
		currentPosition, skipSize = doElvesHash(&list, input, currentPosition, skipSize)
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
	return hashAsHex
}

func hashToBinary(input []string) [][]string {
	binaries := make([][]string, 0)

	for _, hash := range input {
		binaryLine := make([]string, 0)
		for _, ch := range hash {
			hex := string(ch)
			ui, err := strconv.ParseUint(hex, 16, 64)
			if err != nil {
				log.Fatal(err)
			}
			binary := fmt.Sprintf("%04b", ui)
			binaryLine = append(binaryLine, binary)
		}
		binaries = append(binaries, binaryLine)
	}
	return binaries
}

func countOnes(input [][]string) int {
	var ones int
	for _, row := range input {
		for _, fourBits := range row {
			for _, bit := range fourBits {
				if string(bit) == "1" {
					ones++
				}
			}
		}
	}
	return ones
}

// printGrid is a helper function
func printGrid(grid [][]int) {
	for _, row := range grid {
		for _, col := range row {
			fmt.Print(col)
		}
		fmt.Println()
	}
}

func createGrid(binaryRows [][]string) [][]int {
	grid := make([][]int, 0)
	for _, row := range binaryRows {
		newRow := make([]int, 0)
		for _, fourBits := range row {
			for _, bit := range fourBits {
				i, err := strconv.Atoi(string(bit))
				if err != nil {
					log.Fatal(err)
				}
				newRow = append(newRow, i)
			}
		}
		grid = append(grid, newRow)
	}
	return grid
}

func calculateRegions(grid [][]int) int {
	var regions int
	// Gå igenom varje bit
	// Om biten är en etta
	// öka regions med ett
	// markera alla grannar med 2
	// rinse and repeat!
	for y, row := range grid {
		for x, col := range row {
			if col == 1 {
				regions++
				markNeighborRegions(grid, x, y)
			}
		}
	}
	return regions
}

func markNeighborRegions(grid [][]int, x int, y int) {
	// grid is grid[y][x]

	if neighborAboveIsOne(grid, x, y) {
		grid[y-1][x] = 2
		markNeighborRegions(grid, x, y-1)
	}
	if neighborRightIsOne(grid, x, y) {
		grid[y][x+1] = 2
		markNeighborRegions(grid, x+1, y)
	}
	if neighborBelowIsOne(grid, x, y) {
		grid[y+1][x] = 2
		markNeighborRegions(grid, x, y+1)
	}
	if neighborLeftIsOne(grid, x, y) {
		grid[y][x-1] = 2
		markNeighborRegions(grid, x-1, y)
	}
}

func neighborAboveIsOne(grid [][]int, x int, y int) bool {
	if (y - 1) < 0 {
		return false
	}
	return grid[y-1][x] == 1
}

func neighborRightIsOne(grid [][]int, x int, y int) bool {
	if (x + 1) > gridsize {
		return false
	}
	return grid[y][x+1] == 1
}

func neighborBelowIsOne(grid [][]int, x int, y int) bool {
	if (y + 1) > gridsize {
		return false
	}
	return grid[y+1][x] == 1
}

func neighborLeftIsOne(grid [][]int, x int, y int) bool {
	if (x - 1) < 0 {
		return false
	}
	return grid[y][x-1] == 1
}
