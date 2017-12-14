package day12

import "testing"
import (
	"github.com/stretchr/testify/assert"
	"io/ioutil"
	"strings"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 6, Part1(`0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5`))
}

func TestSolvePart1(t *testing.T) {
	data, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	t.Log(Part1(strings.TrimSpace(string(data))))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 2, Part2(`0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5`))
}



func TestSolvePart2(t *testing.T) {
	data, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	t.Log(Part2(strings.TrimSpace(string(data))))
}