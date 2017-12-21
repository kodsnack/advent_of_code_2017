package day03

import (
	"AdventOfCode2017/util"
	"math"
	"testing"
)

const (
	right = iota
	up    = iota
	left  = iota
	down  = iota
)

func Manhattan(max float64, j float64) int {
	//
	// Make spiral
	l := int(math.Ceil(math.Sqrt(max)))
	if l%2 == 0 {
		l++
	}
	util.LogInfof("l=%d", l)
	v := make([][]float64, l)
	for i := 0; i < len(v); i++ {
		v[i] = make([]float64, l)
	}
	//
	// Populate spiral
	x := l / 2
	y := l / 2
	dir := right
	v[y][x] = float64(1)
	x++
	for i := 2; i <= int(l*l); i++ {
		v[y][x] = float64(i)
		if dir == right {
			if v[y-1][x] == 0 {
				dir = up
				y--
			} else {
				x++
			}
		} else if dir == up {
			if v[y][x-1] == 0 {
				dir = left
				x--
			} else {
				y--
			}
		} else if dir == left {
			if v[y+1][x] == 0 {
				dir = down
				y++
			} else {
				x--
			}
		} else if dir == down {
			if v[y][x+1] == 0 {
				dir = right
				x++
			} else {
				y++
			}
		}
	}
	//
	// Debug
	//for i := 0; i < len(v); i++ {
	//	util.LogInfof("%v", v[i])
	//}
	//
	// Calculate distance
	//
	// Find source
	x2 := l / 2
	y2 := l / 2
	var x1 int
	var y1 int
	for x := 0; x < l; x++ {
		for y := 0; y < l; y++ {
			if v[y][x] == j {
				x1 = x
				y1 = y
			}
		}
	}
	var p1, p2, q1, q2 int
	if x1 > x2 {
		p1 = x1
		p2 = x2
	} else {
		p1 = x2
		p2 = x1
	}
	if y1 > y2 {
		q1 = y1
		q2 = y2
	} else {
		q1 = y2
		q2 = y1
	}
	util.LogInfof("p1=%d q1=%d", p1, q1)
	util.LogInfof("p2=%d q2=%d", q1, q2)
	distance := (p1 - p2) + (q1 - q2)

	//for i, val1 := range vector1 {
	//	distance += math.Abs(val1 - vector2[i])
	//}

	return distance
}

func Manhattan2(max float64) float64 {
	//
	// Make spiral
	l := int(math.Ceil(math.Sqrt(max)))
	if l%2 == 0 {
		l++
	}
	util.LogInfof("l=%d", l)
	v := make([][]float64, l)
	for i := 0; i < len(v); i++ {
		v[i] = make([]float64, l)
	}
	//
	// Populate spiral
	x := l / 2
	y := l / 2
	dir := right
	v[y][x] = float64(1)
	x++
	for i := 2; i <= int(l*l); i++ {
		util.LogInfof("*************************")
		for i := 0; i < len(v); i++ {
			util.LogInfof("%v", v[i])
		}

		//
		var sum float64
		sum += v[y+1][x]
		sum += v[y-1][x]
		sum += v[y][x+1]
		sum += v[y][x-1]

		sum += v[y-1][x-1]
		sum += v[y-1][x+1]
		sum += v[y+1][x-1]
		sum += v[y+1][x+1]

		if sum > max {
			return sum
		}

		//
		//
		v[y][x] = sum
		if dir == right {
			if v[y-1][x] == 0 {
				dir = up
				y--
			} else {
				x++
			}
		} else if dir == up {
			if v[y][x-1] == 0 {
				dir = left
				x--
			} else {
				y--
			}
		} else if dir == left {
			if v[y+1][x] == 0 {
				dir = down
				y++
			} else {
				x--
			}
		} else if dir == down {
			if v[y][x+1] == 0 {
				dir = right
				x++
			} else {
				y++
			}
		}
	}
	return 0
}

func TestPartOne(t *testing.T) {

	//
	//

	util.AssertEqual(t, 0, Manhattan(23, 1))
	util.AssertEqual(t, 3, Manhattan(23, 12))
	util.AssertEqual(t, 2, Manhattan(23, 23))
	util.AssertEqual(t, 31, Manhattan(1024, 1024))
	util.LogInfof("Answer: %d", Manhattan(312051, 312051))
}

func TestPartTwo(t *testing.T) {

	//
	//

	util.LogInfof("Answer: %f", Manhattan2(312051))
}
