package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

var checksum int

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Please provide which part and filename as argument. ")
		os.Exit(1)
	}
	fileName := os.Args[2]
	spreedsheet := getSpreadsheetData(fileName)

	if os.Args[1] == "1" {
		checksum = calculateChecksumPart1(spreedsheet)
	} else if os.Args[1] == "2" {
		checksum = calculateChecksumPart2(spreedsheet)
	} else {
		fmt.Println("Please enter 0 or 1 as part")
		os.Exit(1)
	}

	fmt.Println(checksum)
}

func getSpreadsheetData(fileName string) [][]int {
	file, err := os.Open(fileName)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	table := make([][]int, 0, 10)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		row := make([]int, 0, 10)
		currentLine := scanner.Text()
		chunks := strings.Fields(currentLine)
		for _, value := range chunks {
			valueAsInt, _ := strconv.Atoi(value)
			row = append(row, valueAsInt)
		}
		sort.Ints(row)
		table = append(table, row)
		row = row[:0]
	}
	return table
}

func calculateChecksumPart1(spreedsheet [][]int) int {
	checksum := 0
	for _, row := range spreedsheet {
		smallestInt := row[:1][0]
		biggestInt := row[len(row)-1]
		checksum += biggestInt - smallestInt
	}
	return checksum
}

func calculateChecksumPart2(spreedsheet [][]int) int {
	checksum := 0
	for _, row := range spreedsheet {
		for x, x1 := range row {
			for y, y1 := range row {
				if x == y {
					continue
				}
				if x1%y1 == 0 {
					checksum += x1 / y1
				}
			}
		}
	}
	return checksum
}
