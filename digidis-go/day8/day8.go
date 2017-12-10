package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {

	registers := make(map[string]int)
	globalMax := 0

	f, _ := os.Open("input.txt")
	defer f.Close()
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {

		p := strings.Fields(scanner.Text())

		valid := false
		r := p[0]
		i := registers[p[4]]
		j, _ := strconv.Atoi(p[6])
		val, _ := strconv.Atoi(p[2])

		switch p[5] {
		case ">":
			valid = i > j
		case "<":
			valid = i < j
		case ">=":
			valid = i >= j
		case "==":
			valid = i == j
		case "<=":
			valid = i <= j
		case "!=":
			valid = i != j
		default:
			panic("unknown condition " + p[5])
		}

		if valid {
			switch p[1] {
			case "inc":
				registers[r] += val
			case "dec":
				registers[r] -= val
			default:
				panic("unknown instruction " + p[5])
			}
			if registers[r] > globalMax {
				globalMax = registers[r]
			}
		}
	}

	max := 0
	for r := range registers {
		if registers[r] > max {
			max = registers[r]
		}
	}

	fmt.Printf("Max: %v, global max: %v\n", max, globalMax)

}
