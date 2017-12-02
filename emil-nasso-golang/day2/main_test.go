package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestExamplePart1(t *testing.T) {
	input := prepareInput([]byte("5 1 9 5\n7 5 3\n2 4 6 8"))
	assert.Equal(t, calculatePart1Checksum(input), 18)
}

func TestExamplePart2(t *testing.T) {
	input := prepareInput([]byte("5 9 2 8\n9 4 7 3\n3 8 6 5"))
	assert.Equal(t, 9, calculatePart2Checksum(input))
}
