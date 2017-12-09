package day8

import (
	"io/ioutil"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 1.0, Part(`b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10`, 1))
}

func TestSolvePart1(t *testing.T) {
	c, err := ioutil.ReadFile("input.txt")
	if err != nil {
		t.Error(err)
	}

	t.Log(Part(strings.TrimSpace(string(c)), 1))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 10.0, Part(`b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10`, 2))
}

func TestSolvePart2(t *testing.T) {
	c, err := ioutil.ReadFile("input.txt")
	if err != nil {
		t.Error(err)
	}

	t.Log(Part(strings.TrimSpace(string(c)), 2))
}