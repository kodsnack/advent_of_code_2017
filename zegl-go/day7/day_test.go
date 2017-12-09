package day7

import (
	"testing"
	"github.com/stretchr/testify/assert"
	"io/ioutil"
	"strings"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, "tknk", Part1(`pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)`))
}

func TestSolvePart1(t *testing.T) {
	c, err := ioutil.ReadFile("input.txt")
	if err != nil {
		t.Error(err)
	}

	t.Log(Part1(strings.TrimSpace(string(c))))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 60, Part2(`pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)`))
}


func TestSolvePart2(t *testing.T) {
	c, err := ioutil.ReadFile("input.txt")
	if err != nil {
		t.Error(err)
	}

	t.Log(Part2(strings.TrimSpace(string(c))))
}
