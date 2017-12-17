package day09

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOne(t *testing.T) {
	util.AssertEqual(t, 1, ParseStreamString("{}", false))
	util.AssertEqual(t, 6, ParseStreamString("{{{}}}", false))
	util.AssertEqual(t, 5, ParseStreamString("{{},{}}", false))
	util.AssertEqual(t, 16, ParseStreamString("{{{},{},{{}}}}", false))
	util.AssertEqual(t, 1, ParseStreamString("{<a>,<a>,<a>,<a>}", false))
	util.AssertEqual(t, 9, ParseStreamString("{{<ab>},{<ab>},{<ab>},{<ab>}}", false))
	util.AssertEqual(t, 9, ParseStreamString("{{<!!>},{<!!>},{<!!>},{<!!>}}", false))
	util.AssertEqual(t, 3, ParseStreamString("{{<a!>},{<a!>},{<a!>},{<ab>}}", false))
	util.LogInfof("My answer: %d", ParseStreamString(util.FileAsLineArray("input.1.txt")[0], false))
}

func TestPartTwo(t *testing.T) {
	util.LogInfof("My answer: %d", ParseStreamString(util.FileAsLineArray("input.1.txt")[0], true))
}
