package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

var ports [][2]int
var used map[int]bool

func main() {
	data, _ := ioutil.ReadFile("input.txt")
	rows := strings.Split(string(data), "\n")
	var a, b int
	for _, r := range rows {
		fmt.Sscanf(r, "%d/%d", &a, &b)
		ports = append(ports, [2]int{a, b})
	}

	used = make(map[int]bool)
	for i, p := range ports {
		if p[0] == 0 {
			fmt.Printf("starting from %v\n", p)
			solve(i, p[1], 1, p[1]+p[0])
		}
		if p[1] == 0 {
			fmt.Printf("starting from %v\n", p)
			solve(i, p[0], 1, p[1]+p[0])
		}
	}

	fmt.Printf("Maximum strength %v\n", maxS)
	fmt.Printf("Maximum strength and length %v\n", maxSL)
}

var maxS, maxL, maxSL int

func solve(start, next, l, s int) {
	used[start] = true
	for i, p := range ports {
		if !used[i] && p[0] == next {
			solve(i, p[1], l+1, s+p[0]+p[1])
		}
		if !used[i] && p[1] == next {
			solve(i, p[0], l+1, s+p[0]+p[1])
		}
	}
	maxS = max(maxS, s)
	maxL = max(maxL, l)
	if l == maxL && s > maxSL {
		maxSL = s
	}
	used[start] = false
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
