package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func SumSlice(p []int) int {
	sum := 0
	for _, v := range p {
		sum += v
	}
	return sum
}

func GetDiffFromSlice(p []string) int {
	intSlice := []int{}
	for _, v := range p {
		iv, _ := strconv.Atoi(v)
		intSlice = append(intSlice, iv)
	}
	sort.Ints(intSlice)
	return intSlice[len(intSlice)-1] - intSlice[0]
}

func main() {
	file, _ := os.Open("input")
	defer file.Close()
	rowDiff := []int{}
	fileScanner := bufio.NewScanner(file)
	for fileScanner.Scan() {
		rowDiff = append(rowDiff, GetDiffFromSlice(strings.Split(fileScanner.Text(), "\t")))
	}
	fmt.Println(SumSlice(rowDiff))
}
