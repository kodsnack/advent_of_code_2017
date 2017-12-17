package day15

import (
	"AdventOfCode2017/util"
	"testing"
)

func Test(t *testing.T) {
	util.AssertEqual(t, 588, Duel(NewGenerator(16807, 65), NewGenerator(48271, 8921), 40000000))
	util.AssertEqual(t, 619, Duel(NewGenerator(16807, 591), NewGenerator(48271, 393), 40000000))
	util.AssertEqual(t, 309, Duel(NewGeneratorMultiple(16807, 65, 4), NewGeneratorMultiple(48271, 8921, 8), 5000000))
	util.AssertEqual(t, 290, Duel(NewGeneratorMultiple(16807, 591, 4), NewGeneratorMultiple(48271, 393, 8), 5000000))
}
