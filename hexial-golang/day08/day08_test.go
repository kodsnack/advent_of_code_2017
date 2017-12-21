package day08

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOne(t *testing.T) {
	util.AssertEqual(t, 1, NewCPU("input.1.sample.txt").LargestRegisterValue())
	util.LogInfof("My answer: %d", NewCPU("input.1.txt").LargestRegisterValue())
}

func TestPartTwo(t *testing.T) {
	util.AssertEqual(t, 10, NewCPU("input.1.sample.txt").alltTimeHigh)
	util.LogInfof("My answer: %d", NewCPU("input.1.txt").alltTimeHigh)
}
