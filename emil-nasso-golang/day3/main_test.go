package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 0, part1(1))
	assert.Equal(t, 2, part1(9))
	assert.Equal(t, 3, part1(12))
	assert.Equal(t, 2, part1(23))
	assert.Equal(t, 31, part1(1024))
}

func TestCalculateValueForPosition(t *testing.T) {
	numbers := make(map[position]int, 0)

	numbers[position{-1, -1}] = 1
	numbers[position{-1, 0}] = 1
	numbers[position{-1, 1}] = 1

	numbers[position{0, -1}] = 1
	numbers[position{0, 0}] = 1
	numbers[position{0, 1}] = 1

	numbers[position{1, -1}] = 1
	numbers[position{1, 0}] = 1
	numbers[position{1, 1}] = 1

	assert.Equal(t, 8, calculateValueForPosition(position{0, 0}, numbers))
	assert.Equal(t, 3, calculateValueForPosition(position{2, 0}, numbers))
	assert.Equal(t, 1, calculateValueForPosition(position{2, 2}, numbers))
	assert.Equal(t, 1, calculateValueForPosition(position{-2, -2}, numbers))
	assert.Equal(t, 5, calculateValueForPosition(position{0, 1}, numbers))

}
