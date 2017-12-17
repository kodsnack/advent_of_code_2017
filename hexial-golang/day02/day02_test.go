package day02

import (
	"AdventOfCode2017/util"
	"testing"
)

func calcPartOne(filename string) int {
	//util.LogInfof("*****************")
	numbers := util.CSVNumbers(filename)
	sum := 0
	for _, row := range numbers {
		min := -1
		max := -1
		for _, num := range row {
			if min == -1 || min > num {
				min = num
			}
			if max == -1 || max < num {
				max = num
			}
		}
		sum += max - min
	}
	return sum
}

func TestPartOne(t *testing.T) {
	//util.AssertEqual(t, 18, calcPartOne("input.sample.txt"))
	util.LogInfof("Answer: %d", calcPartOne("input.txt"))
}

func calcPartTwo(filename string) int {
	numbers := util.CSVNumbers(filename)
	sum := 0
	for _, row := range numbers {
		for i := 0; i < len(row); i++ {
			for j := 0; j < len(row); j++ {
				if j != i && row[i] > row[j] {
					if row[i]%row[j] == 0 {
						sum += int(row[i] / row[j])
					}
				}
			}
		}
	}
	return sum
}

func TestPartTwo(t *testing.T) {
	util.AssertEqual(t, 9, calcPartTwo("input.2.sample.txt"))
	util.LogInfof("Answer: %d", calcPartTwo("input.2.txt"))
}
