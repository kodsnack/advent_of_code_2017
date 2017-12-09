package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var (
	m         = make(map[string]int)
	maxMemory int
)

func getRegister(s string) int {
	if _, ok := m[s]; !ok {
		m[s] = 0
	}

	return m[s]
}

func jumpRegister(r string, t string, v int) {
	if t == "inc" {
		m[r] += v
	} else if t == "dec" {
		m[r] -= v
	}

	if m[r] > maxMemory {
		maxMemory = m[r]
	}
}

func getRegisterMax() int {
	maxValue := 0

	for _, v := range m {
		if v > maxValue {
			maxValue = v
		}
	}

	return maxValue
}

func main() {

	file, _ := os.Open("input")
	defer file.Close()

	fs := bufio.NewScanner(file)

	for fs.Scan() {
		v := strings.Split(fs.Text(), " ")

		a := v[0]
		b := v[1]
		c, _ := strconv.Atoi(v[2])
		e := v[4]
		f := v[5]
		g, _ := strconv.Atoi(v[6])

		switch check := f; check {
		case ">":
			if m[e] > g {
				jumpRegister(a, b, c)
			}
		case "<":
			if m[e] < g {
				jumpRegister(a, b, c)
			}
		case ">=":
			if m[e] >= g {
				jumpRegister(a, b, c)
			}
		case "==":
			if m[e] == g {
				jumpRegister(a, b, c)
			}
		case "!=":
			if m[e] != g {
				jumpRegister(a, b, c)
			}
		case "<=":
			if m[e] <= g {
				jumpRegister(a, b, c)
			}
		default:
			fmt.Printf("No switch for %s.\n", f)
		}
	}
	fmt.Printf("Current Max value is %d, Max value hold: %d..\n", getRegisterMax(), maxMemory)
}
