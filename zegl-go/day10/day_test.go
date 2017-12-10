package day10

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 12, Part1(5, "3, 4, 1, 5"))
}

func TestSolvePart1(t *testing.T) {
	t.Log(Part1(256, "230,1,2,221,97,252,168,169,57,99,0,254,181,255,235,167"))
}

func TestPart2(t *testing.T) {
	tests := map[string]string{
		"":         "a2582a3a0e66e6e86e3812dcb672a272",
		"AoC 2017": "33efeb34ea91902bb2f59c9920caa6cd",
	}

	for input, expected := range tests {
		assert.Equal(t, expected, Part2(input), input)
	}
}

func TestSolvePart2(t *testing.T) {
	t.Log(Part2("230,1,2,221,97,252,168,169,57,99,0,254,181,255,235,167"))
}
