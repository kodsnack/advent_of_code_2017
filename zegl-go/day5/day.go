package day5

import (
	"io/ioutil"
	"strconv"
	"strings"
)

func Part1(list []int) int {
	jumps := 0
	index := 0

	for {
		if index < 0 || index >= len(list) {
			return jumps
		}

		jumps++

		toJump := list[index]
		list[index] = list[index] + 1
		index += toJump
	}
}

func PartFromFile(file string, part int) int {
	content, err := ioutil.ReadFile(file)
	if err != nil {
		panic(err)
	}

	var list []int
	for _, nstr := range strings.Split(string(content), "\n") {
		if len(strings.TrimSpace(nstr)) == 0 {
			continue
		}
		if n, err := strconv.Atoi(nstr); err == nil {
			list = append(list, n)
		} else {
			panic(err)
		}
	}

	if part == 1 {
		return Part1(list)
	}
	return Part2(list)
}

func Part2(list []int) int {
	jumps := 0
	index := 0

	for {
		if index < 0 || index >= len(list) {
			return jumps
		}

		jumps++

		toJump := list[index]

		if toJump >= 3 {
			list[index] = list[index] - 1
		} else {
			list[index] = list[index] + 1
		}

		index += toJump
	}
}
