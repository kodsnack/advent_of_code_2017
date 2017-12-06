package day3

import (
	"math"
)

func Part1(input int) int {
	x, y := posInRing(input)
	fx := math.Abs(float64(x))
	fy := math.Abs(float64(y))

	return int(fx + fy)
}

// 0: 1
// 1: 3*2 + 1*2 =
// 2: 5*2 + 3*2 == (n*2+1)*2 + (n*2-1)*2
// 3: 7*2 + 5*2
func itemsInRing(ring int) int {
	if ring == 0 {
		return 1
	}

	return (ring*2+1)*2 + (ring*2-1)*2
}

func posInRing(input int) (int, int) {
	sum := 0
	for ring := 0; ; ring++ {
		firstInRing := sum + 1

		//  0, 0
		//  0, 1
		// -1, 2
		// -2, 3
		// -3, 4
		firstInRingPos := [2]int{0 - ring + 1, ring}
		if ring == 0 {
			firstInRingPos = [2]int{0, 0}
		}

		rc := itemsInRing(ring)
		sum += rc
		if sum >= input {

			currPos := firstInRingPos
			q := rc / 4
			delta := [2]int{1, 0} // up

			nextDelta := map[int][2]int{
				-1 + firstInRing + q:   {0, -1}, // left
				-1 + firstInRing + q*2: {-1, 0}, // down
				-1 + firstInRing + q*3: {0, 1},  // right
			}

			for i := firstInRing; i < sum; i ++ {
				if i == input {
					return currPos[0], currPos[1]
				}

				if d, ok := nextDelta[i]; ok {
					delta = d
				}

				currPos[0] += delta[0]
				currPos[1] += delta[1]
			}
			break
		}
	}

	return 0, 0
}

func Part2(input int) int {
	memory := make(map[int]map[int]int)
	memory[0] = map[int]int{0: 1}

	for ring := 1; ; ring++ {

		// First item in ring
		x := 0 - ring + 1
		y := ring

		rc := itemsInRing(ring)
		q := rc / 4

		nextDelta := map[int][2]int{
			q*1 - 1: {0, -1}, // left
			q*2 - 1: {-1, 0}, // down
			q*3 - 1: {0, 1},  // right
		}

		delta := [2]int{1, 0} // up

		for i := 0; i < rc; i++ {
			if _, ok := memory[x]; !ok {
				memory[x] = make(map[int]int)
			}

			sum := sumOfSurrounding(memory, x, y)
			if sum > input {
				return sum
			}

			memory[x][y] = sum

			if d, ok := nextDelta[i]; ok {
				delta = d
			}

			x += delta[0]
			y += delta[1]
		}
	}

	return 0
}

func sumOfSurrounding(memory map[int]map[int]int, x, y int) int {
	sum := 0

	neighbors := [][2]int{
		{1, -1}, {1, 0}, {1, 1},
		{0, -1}, {0, 1},
		{-1, -1}, {-1, 0}, {-1, 1},
	}

	for _, d := range neighbors {
		if mm, ok := memory[x+d[0]]; ok {
			if v, ok := mm[y+d[1]]; ok {
				sum += v
			}
		}
	}

	return sum
}
