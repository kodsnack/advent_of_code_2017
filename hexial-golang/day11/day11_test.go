package day11

import (
	"AdventOfCode2017/util"
	"testing"
)

func TestPartOne(t *testing.T) {
	origo := new(Hexagon)
	util.AssertEqual(t, 3, NewHexagon("ne,ne,ne").Distance(origo))
	util.AssertEqual(t, 0, NewHexagon("ne,ne,sw,sw").Distance(origo))
	util.AssertEqual(t, 2, NewHexagon("ne,ne,s,s").Distance(origo))
	util.AssertEqual(t, 3, NewHexagon("se,sw,se,sw,sw").Distance(origo))
	util.LogInfof("My answer: %d", NewHexagon(util.FileAsLineArray("input")[0]).Distance(origo))
}
