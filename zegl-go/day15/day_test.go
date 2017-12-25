package day15

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 588, Part1(65, 8921))
}

func TestSolvePart1(t *testing.T) {
	t.Log(Part1(516, 190))
}

func TestSolvePart2(t *testing.T) {
	t.Log(Part2(516, 190))
}
