package day4

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func TestIsValid(t *testing.T) {
	assert.True(t, isValid("aa bb cc dd ee"))
	assert.False(t, isValid("aa bb cc dd aa"))
	assert.True(t, isValid("aa bb cc dd aaa"))
}


func TestSolvePart1(t *testing.T) {
	t.Log(Part1("input-part-1.txt", 1))
}

func TestIsValidPart2(t *testing.T) {
	tests := map[string]bool{
		"abcde fghij": true,
		"abcde xyz ecdab": false,
		"a ab abc abd abf abj": true,
		"iiii oiii ooii oooi oooo": true,
		"oiii ioii iioi iiio": false,
	}

	for in, expected := range tests {
		assert.Equal(t, expected, isValidPart2(in), in)
	}
}

func TestSolvePart2(t *testing.T) {
	t.Log(Part1("input-part-1.txt", 2))
}
