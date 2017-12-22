package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

type rule3x3 struct {
	inputPattern  [3][3]string
	outputPattern [4][4]string
}

type rule2x2 struct {
	inputPattern  [2][2]string
	outputPattern [3][3]string
}

func main() {
	checkArgs()
	filedata := getFileData()
	part1(filedata)
	part2(filedata)
}

func part1(filedata []string) {
	rules3x3 := get3x3Rules(filedata)
	rules2x2 := get2x2Rules(filedata)

	pattern := createStartPattern()
	for i := 0; i < 5; i++ {
		if len(pattern)%2 == 0 {
			pattern = doProcess1(pattern, rules2x2)
		} else {
			pattern = doProcess2(pattern, rules3x3)
		}
	}

	fmt.Println("Part 1")
	lightsOn := getLightsOn(pattern)
	fmt.Println(" Lights on:", lightsOn)
}

func part2(filedata []string) {
	rules3x3 := get3x3Rules(filedata)
	rules2x2 := get2x2Rules(filedata)

	pattern := createStartPattern()
	for i := 0; i < 18; i++ {
		if len(pattern)%2 == 0 {
			pattern = doProcess1(pattern, rules2x2)
		} else {
			pattern = doProcess2(pattern, rules3x3)
		}
	}

	fmt.Println("Part 2")
	lightsOn := getLightsOn(pattern)
	fmt.Println(" Lights on:", lightsOn)
}

func getLightsOn(pattern [][]string) int {
	var lightsOn int
	for _, row := range pattern {
		for _, col := range row {
			if col == "#" {
				lightsOn++
			}
		}
	}
	return lightsOn
}

func printPattern(pattern [][]string) {
	for _, row := range pattern {
		fmt.Println(row)
	}
}

func doProcess2(pattern [][]string, rules []rule3x3) [][]string {
	cubes := make([][3][3]string, 0)

	// Break pixels up into 3x3 squares
	for x := 0; x < len(pattern); x += 3 {
		for y := 0; y < len(pattern); y += 3 {
			cube := [3][3]string{
				{pattern[x][y], pattern[x][y+1], pattern[x][y+2]},
				{pattern[x+1][y], pattern[x+1][y+1], pattern[x+1][y+2]},
				{pattern[x+2][y], pattern[x+2][y+1], pattern[x+2][y+2]},
			}
			cubes = append(cubes, cube)
		}
	}

	outputCubes := make([][4][4]string, 0)
	for _, cube := range cubes {
		output := find3x3Output(cube, rules)
		outputCubes = append(outputCubes, output)
	}

	firstRow := make([]string, 0)
	secondRow := make([]string, 0)
	thirdRow := make([]string, 0)
	fourthRow := make([]string, 0)
	newPattern := make([][]string, 0)

	nbrOfSides := len(pattern) / 3
	newLength := nbrOfSides + len(pattern)

	for _, outputCube := range outputCubes {

		for x := 0; x < 4; x++ {
			firstRow = append(firstRow, outputCube[0][x])
			secondRow = append(secondRow, outputCube[1][x])
			thirdRow = append(thirdRow, outputCube[2][x])
			fourthRow = append(fourthRow, outputCube[3][x])
		}
		if len(firstRow)%newLength == 0 ||
			len(outputCubes) == 1 {
			newPattern = append(newPattern, firstRow)
			newPattern = append(newPattern, secondRow)
			newPattern = append(newPattern, thirdRow)
			newPattern = append(newPattern, fourthRow)
			firstRow = make([]string, 0)
			secondRow = make([]string, 0)
			thirdRow = make([]string, 0)
			fourthRow = make([]string, 0)
		}
		if len(newPattern) == newLength {
			break
		}
	}
	return newPattern
}

func doProcess1(pattern [][]string, rules []rule2x2) [][]string {
	cubes := make([][2][2]string, 0)
	// Break pixels up into 2x2 squares
	for x := 0; x < len(pattern); x += 2 {
		for y := 0; y < len(pattern); y += 2 {
			cube := [2][2]string{
				{pattern[x][y], pattern[x][y+1]},
				{pattern[x+1][y], pattern[x+1][y+1]},
			}
			cubes = append(cubes, cube)
		}
	}

	outputCubes := make([][3][3]string, 0)
	for _, cube := range cubes {
		output := find2x2Output(cube, rules)
		outputCubes = append(outputCubes, output)
	}

	firstRow := make([]string, 0)
	secondRow := make([]string, 0)
	thirdRow := make([]string, 0)
	newPattern := make([][]string, 0)

	nbrOfSides := len(pattern) / 2
	newLength := nbrOfSides + len(pattern)

	for _, outputCube := range outputCubes {

		for i := 0; i < 3; i++ {
			// turn each cube into a 3x3 cube
			firstRow = append(firstRow, outputCube[0][i])
			secondRow = append(secondRow, outputCube[1][i])
			thirdRow = append(thirdRow, outputCube[2][i])
		}
		if len(firstRow)%newLength == 0 ||
			len(outputCubes) == 1 {
			newPattern = append(newPattern, firstRow)
			newPattern = append(newPattern, secondRow)
			newPattern = append(newPattern, thirdRow)
			firstRow = make([]string, 0)
			secondRow = make([]string, 0)
			thirdRow = make([]string, 0)
		}
		if len(newPattern) == newLength {
			break
		}
	}
	return newPattern
}

func find2x2Output(cube [2][2]string, rules []rule2x2) [3][3]string {
	newCube := [3][3]string{}

	// #./.. => #.#/..#/#..
	for _, rule := range rules {
		if rule.inputPattern[0] == cube[0] &&
			rule.inputPattern[1] == cube[1] {
			newCube[0] = rule.outputPattern[0]
			newCube[1] = rule.outputPattern[1]
			newCube[2] = rule.outputPattern[2]
		}
	}
	return newCube
}

func find3x3Output(cube [3][3]string, rules []rule3x3) [4][4]string {
	newCube := [4][4]string{}

	// #../..#/#.. => ..../.###/.#../.#.#
	for _, rule := range rules {
		if rule.inputPattern[0] == cube[0] &&
			rule.inputPattern[1] == cube[1] &&
			rule.inputPattern[2] == cube[2] {
			newCube[0] = rule.outputPattern[0]
			newCube[1] = rule.outputPattern[1]
			newCube[2] = rule.outputPattern[2]
			newCube[3] = rule.outputPattern[3]
		}
	}
	return newCube
}

func createStartPattern() [][]string {
	pattern := make([][]string, 0)
	firstRow := []string{".", "#", "."}
	secondRow := []string{".", ".", "#"}
	thirdRow := []string{"#", "#", "#"}
	pattern = append(pattern, firstRow)
	pattern = append(pattern, secondRow)
	pattern = append(pattern, thirdRow)
	return pattern
}

// ---------- 3x3 Rules functions ----------
func get3x3Rules(data []string) []rule3x3 {
	rules3x3 := make([]rule3x3, 0)
	for _, line := range data {
		if len(line) > 30 {
			newRule := create3x3Rule(line)
			rules3x3 = append(rules3x3, newRule)
			// flipped
			flippedRule := createFlipped3x3Rule(newRule)
			rules3x3 = append(rules3x3, flippedRule)

			// rotated 90
			rotatedRule := createRotated3x3Rule(newRule)
			rules3x3 = append(rules3x3, rotatedRule)
			// flipped
			flippedRule = createFlipped3x3Rule(rotatedRule)
			rules3x3 = append(rules3x3, flippedRule)

			// rotated 180
			rotatedRule = createRotated3x3Rule(rotatedRule)
			rules3x3 = append(rules3x3, rotatedRule)
			// flipped
			flippedRule = createFlipped3x3Rule(rotatedRule)
			rules3x3 = append(rules3x3, flippedRule)

			// rotated 270
			rotatedRule = createRotated3x3Rule(rotatedRule)
			rules3x3 = append(rules3x3, rotatedRule)
			// flipped
			flippedRule = createFlipped3x3Rule(rotatedRule)
			rules3x3 = append(rules3x3, flippedRule)
		}
	}

	return rules3x3
}

func create3x3Rule(line string) rule3x3 {
	// .../.../... => #.#./#..#/#.##/#.#.
	chunks := strings.Fields(line)
	input := strings.Split(chunks[0], "/")
	output := strings.Split(chunks[2], "/")

	var inputTable [3][3]string
	var outputTable [4][4]string

	for i, pattern := range input {
		for k, ch := range pattern {
			inputTable[i][k] = string(ch)
		}
	}

	for i, pattern := range output {
		for k, ch := range pattern {
			outputTable[i][k] = string(ch)
		}
	}

	newRule := rule3x3{
		inputPattern:  inputTable,
		outputPattern: outputTable,
	}

	return newRule
}

func createFlipped3x3Rule(original rule3x3) rule3x3 {
	var firstRow [3]string
	y := 0
	for i := 2; i >= 0; i-- {
		firstRow[y] = original.inputPattern[0][i]
		y++
	}

	var secondRow [3]string
	y = 0
	for i := 2; i >= 0; i-- {
		secondRow[y] = original.inputPattern[1][i]
		y++
	}

	var thirdRow [3]string
	y = 0
	for i := 2; i >= 0; i-- {
		thirdRow[y] = original.inputPattern[2][i]
		y++
	}

	var inputTable [3][3]string
	inputTable[0] = firstRow
	inputTable[1] = secondRow
	inputTable[2] = thirdRow

	newRule := rule3x3{
		inputPattern:  inputTable,
		outputPattern: original.outputPattern,
	}

	return newRule
}

func createRotated3x3Rule(original rule3x3) rule3x3 {
	var firstRow [3]string
	y := 0
	for i := 2; i >= 0; i-- {
		firstRow[y] = original.inputPattern[i][0]
		y++
	}

	var secondRow [3]string
	y = 0
	for i := 2; i >= 0; i-- {
		secondRow[y] = original.inputPattern[i][1]
		y++
	}

	var thirdRow [3]string
	y = 0
	for i := 2; i >= 0; i-- {
		thirdRow[y] = original.inputPattern[i][2]
		y++
	}

	var inputTable [3][3]string
	inputTable[0] = firstRow
	inputTable[1] = secondRow
	inputTable[2] = thirdRow
	newRule := rule3x3{
		inputPattern:  inputTable,
		outputPattern: original.outputPattern,
	}

	return newRule
}

// ---------- 2x2 Rules functions ----------
func get2x2Rules(data []string) []rule2x2 {
	rules2x2 := make([]rule2x2, 0)
	for _, line := range data {
		if len(line) < 30 {
			newRule := create2x2Rule(line)
			rules2x2 = append(rules2x2, newRule)
			// flipped
			flippedRule := createFlipped2x2Rule(newRule)
			rules2x2 = append(rules2x2, flippedRule)

			// rotated 90
			rotatedRule := createRotated2x2Rule(newRule)
			rules2x2 = append(rules2x2, rotatedRule)
			// flipped
			flippedRule = createFlipped2x2Rule(rotatedRule)
			rules2x2 = append(rules2x2, flippedRule)

			// rotated 180
			rotatedRule = createRotated2x2Rule(rotatedRule)
			rules2x2 = append(rules2x2, rotatedRule)
			// flipped
			flippedRule = createFlipped2x2Rule(rotatedRule)
			rules2x2 = append(rules2x2, flippedRule)

			// rotated 270
			rotatedRule = createRotated2x2Rule(rotatedRule)
			rules2x2 = append(rules2x2, rotatedRule)
			// flipped
			flippedRule = createFlipped2x2Rule(rotatedRule)
			rules2x2 = append(rules2x2, flippedRule)
		}
	}

	return rules2x2
}

func create2x2Rule(line string) rule2x2 {
	// ##/## => #.#/#.#/###
	chunks := strings.Fields(line)
	input := strings.Split(chunks[0], "/")
	output := strings.Split(chunks[2], "/")

	var inputTable [2][2]string
	var outputTable [3][3]string

	for i, pattern := range input {
		for k, ch := range pattern {
			inputTable[i][k] = string(ch)
		}
	}

	for i, pattern := range output {
		for k, ch := range pattern {
			outputTable[i][k] = string(ch)
		}
	}

	newRule := rule2x2{
		inputPattern:  inputTable,
		outputPattern: outputTable,
	}

	return newRule
}

func createFlipped2x2Rule(original rule2x2) rule2x2 {
	var firstRow [2]string
	y := 0
	for i := 1; i >= 0; i-- {
		firstRow[y] = original.inputPattern[0][i]
		y++
	}

	var secondRow [2]string
	y = 0
	for i := 1; i >= 0; i-- {
		secondRow[y] = original.inputPattern[1][i]
		y++
	}

	var inputTable [2][2]string
	inputTable[0] = firstRow
	inputTable[1] = secondRow

	newRule := rule2x2{
		inputPattern:  inputTable,
		outputPattern: original.outputPattern,
	}

	return newRule
}

func createRotated2x2Rule(original rule2x2) rule2x2 {
	var firstRow [2]string
	y := 0
	for i := 1; i >= 0; i-- {
		firstRow[y] = original.inputPattern[i][0]
		y++
	}

	var secondRow [2]string
	y = 0
	for i := 1; i >= 0; i-- {
		secondRow[y] = original.inputPattern[i][1]
		y++
	}

	var inputTable [2][2]string
	inputTable[0] = firstRow
	inputTable[1] = secondRow

	newRule := rule2x2{
		inputPattern:  inputTable,
		outputPattern: original.outputPattern,
	}

	return newRule
}

// ---------- Setup Functions ----------
func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide a filename to a file that contains the puzzle input as only argument. ")
		fmt.Println(" Example: go run day21.go puzzle.in")
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
