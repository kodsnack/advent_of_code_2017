package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func getNumbers(v string) []int {
	parts := strings.Fields(v)
	list := make([]int, 0)
	for _, p := range parts {
		i, _ := strconv.Atoi(p)
		list = append(list, i)
	}
	return list
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {

	f, _ := os.Open("input.txt")

	var checksum, checksum2 int

	scanner := bufio.NewScanner(f)
	for scanner.Scan() {

		p := getNumbers(scanner.Text())

		rowMin := 99999
		rowMax := 0

		for _, v := range p {

			rowMin = min(rowMin, v)
			rowMax = max(rowMax, v)

			for _, u := range p {
				if u > v && (u%v == 0) {
					checksum2 += (u / v)
				}
			}
		}

		checksum += (rowMax - rowMin)
	}
	f.Close()

	fmt.Printf("Checksum 1: %v, checksum 2: %v\n", checksum, checksum2)

}
