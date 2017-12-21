package day04

import (
	"AdventOfCode2017/util"
	"sort"
	"strings"
	"testing"
)

func DoPartOne(filename string, anagram bool) int {
	lines := util.FileAsWordArray(filename)
	var count int
	for _, line := range lines {
		if CheckPartOne(line, anagram) {
			count++
		}
	}
	return count
}

func CheckPartOne(in []string, anagram bool) bool {
	m := make(map[string]bool)
	util.LogInfof("*****************")
	for _, s := range in {
		if anagram {
			r := strings.NewReader(s)
			sl := make([]string, len(s))
			for i := 0; i < len(s); i++ {
				b, _ := r.ReadByte()
				sl[i] = string(b)
			}
			sort.Strings(sl)
			var ss string
			for i := 0; i < len(s); i++ {
				ss += sl[i]
			}
			s = ss
		}
		if _, ok := m[s]; ok {
			util.LogInfof("%s: false", s)
			return false
		}
		util.LogInfof("%s: true", s)
		m[s] = true
	}
	return true
}

func TestPartOne(t *testing.T) {

	//
	//

	util.AssertEqual(t, 2, DoPartOne("input.part.one.sample.txt", false))
	util.LogInfof("My answer: %d", DoPartOne("input.part.one.txt", false))
}

func TestPartTwo(t *testing.T) {

	//
	//

	util.AssertEqual(t, 3, DoPartOne("input.part.two.sample.txt", true))
	util.LogInfof("My answer: %d", DoPartOne("input.part.two.txt", true))
}
