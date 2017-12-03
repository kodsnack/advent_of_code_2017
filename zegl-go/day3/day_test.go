package day3

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	tests := []struct {
		inp int
		exp int
	}{
		{1, 0},
		{12, 3},
		{23, 2},
		{1024, 31},
	}

	for _, tc := range tests {
		assert.Equal(t, tc.exp, Part1(tc.inp))
	}
}

func TestSolvePart1(t *testing.T) {
	t.Log(Part1(277678))
}

func TestSolvePart2(t *testing.T) {
	t.Log(Part2(277678))
}

func TestPosInRing(t *testing.T) {
	t.Log(posInRing(14))
}
