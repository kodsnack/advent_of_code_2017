package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, []int{3, 4, 2, 1, 0}, tyeKnot([]int{0, 1, 2, 3, 4}, []int{3, 4, 1, 5}))
}

func TestReverse(t *testing.T) {
	// From the start
	assert.Equal(t, []int{1, 2, 3, 4, 5}, reverse([]int{1, 2, 3, 4, 5}, 0, 0))
	assert.Equal(t, []int{1, 2, 3, 4, 5}, reverse([]int{1, 2, 3, 4, 5}, 0, 1))
	assert.Equal(t, []int{2, 1, 3, 4, 5}, reverse([]int{1, 2, 3, 4, 5}, 0, 2))
	assert.Equal(t, []int{3, 2, 1, 4, 5}, reverse([]int{1, 2, 3, 4, 5}, 0, 3))
	assert.Equal(t, []int{4, 3, 2, 1, 5}, reverse([]int{1, 2, 3, 4, 5}, 0, 4))
	assert.Equal(t, []int{5, 4, 3, 2, 1}, reverse([]int{1, 2, 3, 4, 5}, 0, 5))

	// Looping around
	assert.Equal(t, []int{5, 4, 3, 2, 1}, reverse([]int{1, 2, 3, 4, 5}, 3, 4))
	assert.Equal(t, []int{5, 2, 3, 4, 1}, reverse([]int{1, 2, 3, 4, 5}, 4, 2))
	assert.Equal(t, []int{4, 2, 3, 1, 5}, reverse([]int{1, 2, 3, 4, 5}, 3, 3))

	// Full swoops
	assert.Equal(t, []int{5, 4, 3, 2, 1}, reverse([]int{1, 2, 3, 4, 5}, 0, 5))
	assert.Equal(t, []int{2, 1, 5, 4, 3}, reverse([]int{1, 2, 3, 4, 5}, 1, 5))

	//Examples
	assert.Equal(t, []int{2, 1, 0, 3, 4}, reverse([]int{0, 1, 2, 3, 4}, 0, 3))
	assert.Equal(t, []int{4, 3, 0, 1, 2}, reverse([]int{2, 1, 0, 3, 4}, 3, 4))
	assert.Equal(t, []int{4, 3, 0, 1, 2}, reverse([]int{4, 3, 0, 1, 2}, 3, 1))
	assert.Equal(t, []int{3, 4, 2, 1, 0}, reverse([]int{4, 3, 0, 1, 2}, 1, 5))
}
