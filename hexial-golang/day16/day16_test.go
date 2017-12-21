package day16

import (
	"AdventOfCode2017/util"
	"testing"
)

func Test(t *testing.T) {
	//d := NewDance("sample", 5)
	//d.Move("s1")
	//d.State()

	util.LogInfof("%d", Fix(100, 42))

	util.AssertEqual(t, "baedc", NewDance("sample", 5).ExecutePartOne())
	util.AssertEqual(t, "kgdchlfniambejop", NewDance("input", 16).ExecutePartOne())
	util.AssertEqual(t, "fjpmholcibdgeakn", NewDance("input", 16).ExecutePartTwo())
}
