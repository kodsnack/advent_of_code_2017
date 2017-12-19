package day15

import (
	"strconv"
	"fmt"
	"log"
)

func Part1(numA, numB int64) int {
	factorA := int64(16807)
	factorB := int64(48271)

	matches := 0

	for i := 0; i < 40000000; i ++ {
		numA = (numA * factorA) % 2147483647
		numB = (numB * factorB) % 2147483647

		binA := fmt.Sprintf("%032s", strconv.FormatInt(numA, 2))
		binB := fmt.Sprintf("%032s", strconv.FormatInt(numB, 2))

		if binA[len(binA)-16:] == binB[len(binB)-16:] {
			matches++
		}
	}

	return matches
}

func Part2(numA, numB int64) int {
	factorA := int64(16807)
	factorB := int64(48271)

	divA := int64(4)
	divB := int64(8)

	matches := 0

	for i := 0; i < 5000000; i ++ {

		for {
			numA = (numA * factorA) % 2147483647
			if numA%divA == 0 {
				break
			}
		}
		for {
			numB = (numB * factorB) % 2147483647
			if numB%divB == 0 {
				break
			}
		}

		binA := fmt.Sprintf("%032s", strconv.FormatInt(numA, 2))
		binB := fmt.Sprintf("%032s", strconv.FormatInt(numB, 2))

		if binA[len(binA)-16:] == binB[len(binB)-16:] {
			matches++
			log.Println(i, matches)
		}
	}

	return matches
}
