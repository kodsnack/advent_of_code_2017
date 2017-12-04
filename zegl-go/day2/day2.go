package day2

import (
	"strings"
	"strconv"
	"log"
	"math"
)

func Part1(input string) int {
	checksum := 0

	for _, row := range strings.Split(input, "\n") {

		largest := 0
		smallest := 0

		row = strings.TrimSpace(row)
		row = strings.Replace(row, " ", "\t", -1)

		for i, nStr := range strings.Split(row, "\t") {
			if n, err := strconv.Atoi(nStr); err == nil {
				if i == 0 {
					largest = n
					smallest = n
				}

				if n < smallest {
					smallest = n
				}

				if n > largest {
					largest = n
				}
			} else {
				log.Println(err)
			}
		}

		checksum += largest - smallest
	}

	return checksum
}

func Part2(input string) int {
	checksum := 0

	for _, row := range strings.Split(input, "\n") {
		row = strings.TrimSpace(row)
		row = strings.Replace(row, " ", "\t", -1)

		numbers := make([]int, 0)

		for _, nStr := range strings.Split(row, "\t") {
			if n, err := strconv.Atoi(nStr); err == nil {
				numbers = append(numbers, n)
			} else {
				log.Println(err)
			}
		}

		for i, n := range numbers {
			for _, nn := range numbers[i+1:] {
				f1 := float64(n)
				f2 := float64(nn)

				max := math.Max(f1, f2)
				min := math.Min(f1, f2)

				div := max / min

				if div == math.Trunc(div) {
					checksum += int(div)
				}
			}
		}
	}

	return checksum
}
