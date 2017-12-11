package day11

import (
	"strings"
	"math"
)

func Part1(input string) int {
	return part(1, input)
}

func Part2(input string) int {
	return part(2, input)
}

func part(part int, input string) int {
	x := 0
	y := 0

	maxDistance := math.Inf(-1)

	for _, move := range strings.Split(input, ",") {
		switch move {
		case "n":
			y++
		case "ne":
			x++
		case "nw":
			y++
			x--
		case "s":
			y--
		case "se":
			y--
			x++
		case "sw":
			x--
		}

		xx := float64(x)
		yy := float64(y)
		dist := (math.Abs(xx) + math.Abs(xx+yy) + math.Abs(yy)) / 2
		maxDistance = math.Max(maxDistance, dist)
	}

	if part == 1 {
		xx := float64(x)
		yy := float64(y)
		dist := (math.Abs(xx) + math.Abs(xx+yy) + math.Abs(yy)) / 2
		return int(dist)
	}

	return int(maxDistance)
}
