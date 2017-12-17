package day07

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOne(t *testing.T) {
	util.AssertEqual(t, "tknk", Load("input.1.sample.txt").FindBase().Name)
	util.LogInfof("My answer: %s", Load("input.1.txt").FindBase().Name)
}

func TestPartTwo(t *testing.T) {
	util.AssertEqual(t, 60, Load("input.1.sample.txt").FindBase().Balance())
	Load("input.1.txt").FindBase().Balance()
}
