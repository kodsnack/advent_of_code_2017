package day9

import (
	"io/ioutil"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	cases := map[string]int{
		"{}":                            1,
		"{{{}}}":                        6,
		"{{},{}}":                       5,
		"{{{},{},{{}}}}":                16,
		"{<a>,<a>,<a>,<a>}":             1,
		"{{<ab>},{<ab>},{<ab>},{<ab>}}": 9,
		"{{<!!>},{<!!>},{<!!>},{<!!>}}": 9,
		"{{<a!>},{<a!>},{<a!>},{<ab>}}": 3,
	}

	for inp, exp := range cases {
		assert.Equal(t, exp, Part(inp, 1), inp)
	}
}

func TestSolvePart1(t *testing.T) {
	c, err := ioutil.ReadFile("input.txt")
	if err != nil {
		t.Error(err)
	}

	t.Log(Part(strings.TrimSpace(string(c)), 1))
}

func TestPart2(t *testing.T) {
	cases := map[string]int{
		"<>":                  0,
		"<random characters>": 17,
		"<<<<>":               3,
		"<{!>}>":              2,
		"<!!>":                0,
		"<!!!>>":              0,
		"<{o\"i!a,<{i<a>":      10,
	}

	for inp, exp := range cases {
		assert.Equal(t, exp, Part(inp, 2), inp)
	}
}



func TestSolvePart2(t *testing.T) {
	c, err := ioutil.ReadFile("input.txt")
	if err != nil {
		t.Error(err)
	}

	t.Log(Part(strings.TrimSpace(string(c)), 2))
}
