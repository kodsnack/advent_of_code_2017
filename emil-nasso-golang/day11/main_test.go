package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 3, countSteps([]string{"ne", "ne", "ne"}))
	assert.Equal(t, 0, countSteps([]string{"ne", "ne", "sw", "sw"}))
	assert.Equal(t, 2, countSteps([]string{"ne", "ne", "s", "s"}))
	assert.Equal(t, 3, countSteps([]string{"se", "sw", "se", "sw", "sw"}))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 3, countFurthest([]string{"ne", "ne", "ne"}))
	assert.Equal(t, 2, countFurthest([]string{"ne", "ne", "sw", "sw"}))
	assert.Equal(t, 2, countFurthest([]string{"ne", "ne", "s", "s"}))
	assert.Equal(t, 3, countFurthest([]string{"se", "sw", "se", "sw", "sw"}))
}
