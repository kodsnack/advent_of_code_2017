package main

import "math"

func rowDivisor(row [16]int) int {

	var min, max int = math.MaxInt32, 0

	for i := range row {
		for j := range row {
			if row[i] > row[j] && row[i]%row[j] == 0 {
				return row[i] / row[j]
			}
		}
	}
	return (max - min)
}
