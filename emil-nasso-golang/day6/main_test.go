package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	steps, diff := solve([]int{0, 2, 7, 0})
	assert.Equal(t, 5, steps)
	assert.Equal(t, 4, diff)
}
