package main

import (
	"reflect"
)

func SolveDag6(m []int) int {
	var pointer int
	cycle := 0

	mSnap := [][]int{}

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

	}

	return cycle
}
