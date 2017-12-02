package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestExamplesPart1(t *testing.T) {
	assert.Equal(t, 3, part1("1122"))
	assert.Equal(t, 4, part1("1111"))
	assert.Equal(t, 0, part1("1234"))
	assert.Equal(t, 9, part1("91212129"))
}

func TestExamplesPart2(t *testing.T) {
	assert.Equal(t, 6, part2("1212"))
	assert.Equal(t, 0, part2("1221"))
	assert.Equal(t, 4, part2("123425"))
	assert.Equal(t, 12, part2("123123"))
	assert.Equal(t, 4, part2("12131415"))
}
