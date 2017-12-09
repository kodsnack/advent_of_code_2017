package day5

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 5, Part1([]int{0, 3, 0, 1, -3}))
}

func TestSolvePart1(t *testing.T) {
	t.Log(PartFromFile("input.txt", 1))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 10, Part2([]int{0, 3, 0, 1, -3}))
}

func TestSolvePart2(t *testing.T) {
	t.Log(PartFromFile("input.txt", 2))
}
