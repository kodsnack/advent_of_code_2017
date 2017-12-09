package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestInput(t *testing.T) {
	assertInput(t, 1, 0, `{}`)
	assertInput(t, 3, 17, `{{<a!>},{<a!>},{<a!>},{<ab>}}`)
	assertInput(t, 1, 10, `{<{o"i!a,<{i<a>}`)
}

func assertInput(t *testing.T, expectedScore, expectedGarbageCount int, i string) {
	s, c := input(i)
	assert.Equal(t, expectedScore, score(s))
	assert.Equal(t, expectedGarbageCount, c)
}
