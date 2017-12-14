package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	row, _ := ioutil.ReadFile("input.txt")
	var dist, maxdist int
	var q, r int
	for _, s := range strings.Split(string(row), ",") {
		switch s {
		case "n":
			q--
		case "s":
			q++
		case "ne":
			r++
			q--
		case "sw":
			r--
			q++
		case "nw":
			r--
		case "se":
			r++
		}

		dist = (abs(q) + abs(r) + abs(-q-r)) / 2

		if dist > maxdist {
			maxdist = dist
		}
	}

	fmt.Printf("Distance %v\n", dist)
	fmt.Printf("Max distance %v\n", maxdist)
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}
