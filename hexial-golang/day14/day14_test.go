package day14

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOne(t *testing.T) {
	NewDiskDefrag("flqrgnkx").Debug(8)
	util.AssertEqual(t, 8108, NewDiskDefrag("flqrgnkx").used)
	util.AssertEqual(t, 8106, NewDiskDefrag("oundnydw").used)
}

func TestPartTwo(t *testing.T) {
	util.AssertEqual(t, 1242, NewDiskDefrag("flqrgnkx").CalcRegions())
	util.AssertEqual(t, 1164, NewDiskDefrag("oundnydw").CalcRegions())
}
