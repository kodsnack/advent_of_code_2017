package day05

import (
	"AdventOfCode2017/util"
	"testing"
)

func calc(filename string) int {
	list := util.FileAsNumberArray(filename)
	index := 0
	steps := 0
	for index >= 0 && index < len(list) {
		//util.LogInfof("%+v [index=%d][%d]", list, index, list[index])
		if list[index] == 0 {
			//
			// Do nothing
			list[index]++
		} else {
			jump := list[index]
			list[index]++
			index += jump

		}
		steps++
	}
	return steps
}

func calcSecond(filename string) int {
	list := util.FileAsNumberArray(filename)
	index := 0
	steps := 0
	for index >= 0 && index < len(list) {
		//util.LogInfof("%+v [index=%d][%d]", list, index, list[index])
		if list[index] == 0 {
			//
			// Do nothing
			list[index]++
		} else {
			jump := list[index]
			if jump >= 3 {
				list[index]--
			} else {
				list[index]++
			}
			index += jump

		}
		steps++
	}
	return steps
}

func TestPartOne(t *testing.T) {

	//
	//

	util.AssertEqual(t, 5, calc("input.1.sample.txt"))
	util.LogInfof("My answer: %d", calc("input.1.txt"))
}

func TestPartTwo(t *testing.T) {

	//
	//

	util.AssertEqual(t, 10, calcSecond("input.1.sample.txt"))
	util.LogInfof("My answer: %d", calcSecond("input.1.txt"))
}
