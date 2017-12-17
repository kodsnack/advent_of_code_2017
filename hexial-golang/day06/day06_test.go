package day06

import (
	"AdventOfCode2017/util"
	"testing"
)

func compare(a, b []int) bool {
	for i, v := range a {
		if v != b[i] {
			return false
		}
	}
	return true
}

func lookForTwoAlike(history [][]int) (bool, int) {
	if len(history) == 0 {
		util.LogPanicf("Empty history")
	}
	for i1 := 0; i1 < len(history); i1++ {
		for i2 := 0; i2 < len(history); i2++ {
			if i2 != i1 && compare(history[i1], history[i2]) {
				if i2 > i1 {
					return true, i2 - i1
				} else {
					return true, i1 - i2
				}
			}
		}
	}
	return false, 0
}

func redistribute(b []int) []int {
	//util.LogInfof("****************")
	banks := make([]int, len(b))
	if copy(banks, b) != len(b) {
		util.LogPanicf("Didn't copy everything")
	}
	//
	// Look for highest
	highest := 0
	for i := range banks {
		if banks[i] > banks[highest] {
			highest = i
		}
	}
	num := banks[highest]
	banks[highest] = 0
	index := highest + 1
	if index >= len(banks) {
		index = 0
	}
	for i := 0; i < num; i++ {
		banks[index]++
		index++
		if index == len(banks) {
			index = 0
		}
	}
	return banks
}

func calc(filename string, second bool) int {
	history := make([][]int, 0)
	banks := util.FileAsTabbedSingleLineNumbers(filename)
	history = append(history, banks)
	cycle := 0

	for {
		//
		history = append(history, redistribute(history[cycle]))
		//util.LogInfof("%+v", history)
		cycle++
		//
		alike, size := lookForTwoAlike(history)
		if alike && !second {
			return cycle
		}
		if alike && second {
			return size
		}
		if cycle%1000 == 1 {
			util.LogInfof("cycle: %d", cycle)
		}
	}
}

func TestPartOne(t *testing.T) {

	//
	//

	util.AssertEqual(t, 5, calc("input.1.sample.txt", false))
	util.LogInfof("My answer: %d", calc("input.1.txt", false))
}

func TestPartTwo(t *testing.T) {
	//
	//

	util.AssertEqual(t, 4, calc("input.1.sample.txt", true))
	util.LogInfof("My answer: %d", calc("input.1.txt", true))

}
