package day12

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOneAndTwo(t *testing.T) {
	util.AssertEqual(t, 6, len(NewVillage(util.FileAsLineArray("sample")).GetProgram(0).Group()))
	util.LogInfof("My answer: %d", len(NewVillage(util.FileAsLineArray("input")).GetProgram(0).Group()))
	util.LogInfof("My answer part two: %d", len(NewVillage(util.FileAsLineArray("input")).Group()))
}
