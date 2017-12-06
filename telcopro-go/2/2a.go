package main

import "math"

func rowdiff(row [16]int) int {

	var min, max int = math.MaxInt32, 0

	for _, i := range row {
		if i < min {
			min = i
		}
		if i > max {
			max = i
		}
	}
	return (max - min)
}
