package day6

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 5, Part1([]int{0, 2, 7, 0}))
}

func TestSolvePart1(t *testing.T) {
	t.Log(Part1([]int{4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5}))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 4, Part2([]int{0, 2, 7, 0}))
}

func TestSolvePart2(t *testing.T) {
	t.Log(Part2([]int{4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5}))
}
