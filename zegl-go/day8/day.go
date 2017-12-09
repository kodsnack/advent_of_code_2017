package day8

import (
	"math"
	"strconv"
	"strings"
)

func Part(program string, part int) float64 {
	registries := make(map[string]int)

	registryVal := func(reg string) int {
		if val, ok := registries[reg]; ok {
			return val
		}
		return 0
	}

	largestEver := math.Inf(-1)

	for _, instruction := range strings.Split(program, "\n") {
		parts := strings.Split(instruction, " ")

		partToEdit := parts[0]
		incOrDec := parts[1]
		amount, err := strconv.Atoi(parts[2])
		if err != nil {
			panic(err)
		}
		// parts[3] is always "if"
		condReg := parts[4]
		condCond := parts[5]
		condVal, err := strconv.Atoi(parts[6])
		if err != nil {
			panic(err)
		}

		valueOfCondReg := registryVal(condReg)
		var res bool

		switch condCond {
		case "==":
			res = valueOfCondReg == condVal
		case ">":
			res = valueOfCondReg > condVal
		case ">=":
			res = valueOfCondReg >= condVal
		case "<":
			res = valueOfCondReg < condVal
		case "<=":
			res = valueOfCondReg <= condVal
		case "!=":
			res = valueOfCondReg != condVal
		}

		if res {
			if incOrDec == "inc" {
				registries[partToEdit] = registryVal(partToEdit) + amount
			} else {
				registries[partToEdit] = registryVal(partToEdit) - amount
			}

			largestEver = math.Max(largestEver, float64(registries[partToEdit]))
		}
	}

	if part == 1 {
		largest := math.Inf(-1)
		for _, val := range registries {
			largest = math.Max(largest, float64(val))
		}

		return largest
	}

	return largestEver
}
