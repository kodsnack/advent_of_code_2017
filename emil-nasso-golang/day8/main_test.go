package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1And2(t *testing.T) {
	assert.Equal(t, 1, highestVariableValue(execute(input("input_part1.txt"))))
	assert.Equal(t, 10, highestMemoryValue)
}
