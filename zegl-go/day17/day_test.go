package day17

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 638, Part1(3, 2017))
}

func TestSolvePart1(t *testing.T) {
	t.Log(Part1(343, 2017))

	// low: 343
}

func TestSolvePart2(t *testing.T) {
	t.Log(Part2(343))
}
