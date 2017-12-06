package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, true, passwordIsValidPart1("aa bb cc dd ee"))
	assert.Equal(t, false, passwordIsValidPart1("aa bb cc dd aa"))
	assert.Equal(t, true, passwordIsValidPart1("aa bb cc dd aaa"))
}

func TestMapStructBehavior(t *testing.T) {
	assert.Equal(t, true, passwordIsValidPart2("abcde fghij"))
	assert.Equal(t, false, passwordIsValidPart2("abcde xyz ecdab"))
	assert.Equal(t, true, passwordIsValidPart2("a ab abc abd abf abj"))
	assert.Equal(t, true, passwordIsValidPart2("iiii oiii ooii oooi oooo"))
	assert.Equal(t, false, passwordIsValidPart2("oiii ioii iioi iiio"))
}
