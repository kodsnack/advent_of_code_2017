package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	input := []int{0, 3, 0, 1, -3}
	assert.Equal(t, 5, part1(input))
}

func TestPart2(t *testing.T) {
	input := []int{0, 3, 0, 1, -3}
	assert.Equal(t, 10, part2(input))
}
