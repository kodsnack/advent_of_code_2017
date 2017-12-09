package main

import (
	"reflect"
	"strconv"
	"strings"
)

func s(s []int) string {

	ss := []string{}

	for _, v := range s {
		ss = append(ss, strconv.Itoa(v))
	}

	return strings.Join(ss, "")

}

func SolveDag6_part2(m []int) int {
	var pointer int
	cycle := 0

	mSnap := [][]int{}
	mc := make(map[string]int)

	for {
		cycle++
		maxIdx := func(p []int) int {
			maxValue := 0
			i := 0
			for idx, v := range p {
				if v > maxValue {
					maxValue = v
					i = idx
				}
			}
			return i
		}(m)

		x := m[maxIdx]
		m[maxIdx] = 0

		if maxIdx+1 > len(m)-1 {
			pointer = 0
		} else {
			pointer = maxIdx + 1
		}
		for valueToDist := x; valueToDist > 0; valueToDist-- {
			m[pointer]++
			if pointer == len(m)-1 {
				pointer = 0
			} else {
				pointer++
			}
		}
		if func(ii []int, ms [][]int) bool {
			for _, v := range ms {
				if reflect.DeepEqual(ii, v) {
					return true

				}
			}

			return false

		}(m, mSnap) {
			break
		}
		tmp := make([]int, len(m))
		copy(tmp, m)
		mSnap = append(mSnap, tmp)
		mc[s(m)] = cycle
	}

	return cycle - mc[s(m)]
}
