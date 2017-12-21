package day18

import (
	"AdventOfCode2017/util"
	"testing"
)

func Test1(t *testing.T) {
	util.Debug = false
	util.AssertEqual(t, 4, NewOperatingSystem("sample", 1).PartOne())
	util.AssertEqual(t, 1187, NewOperatingSystem("input", 1).PartOne())
}

func Test2(t *testing.T) {
	util.Debug = false
	util.AssertEqual(t, 3, NewOperatingSystem("sample_2", 2).PartTwo())
	util.AssertEqual(t, 5969, NewOperatingSystem("input", 2).PartTwo())
}
