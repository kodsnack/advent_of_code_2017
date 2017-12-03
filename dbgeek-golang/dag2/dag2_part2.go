package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
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

func main() {
	file, _ := os.Open("input")
	defer file.Close()
	result := []int{}
	fileScanner := bufio.NewScanner(file)
	for fileScanner.Scan() {
		intSlice := []float64{}
		for _, v := range strings.Split(fileScanner.Text(), "\t") {
			iv, _ := strconv.Atoi(v)
			intSlice = append(intSlice, float64(iv))
		}
		for i, _ := range intSlice {
			for ii, value := range intSlice {
				if math.Mod(intSlice[i], value) == 0 && ii != i {
					result = append(result, int(intSlice[i]/value))
				}
			}
		}
	}
	fmt.Println(SumSlice(result))
}
