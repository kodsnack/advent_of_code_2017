package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

type rule struct {
	v bool
	p int
	n string
}

func main() {

	s, c, rules := parse()
	var pos, checksum int
	v := make(map[int]bool)

	for ; c > 0; c-- {
		i := v[pos]
		v[pos] = rules[s][i].v
		pos += rules[s][i].p
		s = rules[s][i].n
	}

	for i := range v {
		if v[i] {
			checksum++
		}
	}

	fmt.Printf("Checksum: %v\n", checksum)
}

func parse() (string, int, map[string]map[bool]rule) {
	data, _ := ioutil.ReadFile("input.txt")
	parts := strings.Split(string(data), "\n\n")

	rules := make(map[string]map[bool]rule)

	rows := strings.Split(parts[0], "\n")
	steps, _ := strconv.Atoi(strings.Fields(rows[1])[5])
	state := strings.TrimSuffix(strings.Fields(rows[0])[3], ".")

	for _, p := range parts[1:] {
		rows := strings.Split(p, "\n")
		s := strings.TrimSuffix(strings.Fields(rows[0])[2], ":")
		rules[s] = map[bool]rule{false: getRule(rows[1:]), true: getRule(rows[5:])}
	}

	return state, steps, rules
}

func getRule(f []string) rule {
	v := strings.HasSuffix(f[1], "1.")
	p := -1
	if strings.HasSuffix(f[2], "right.") {
		p = 1
	}
	nf := strings.Fields(f[3])
	n := strings.TrimSuffix(nf[len(nf)-1], ".")
	return rule{v, p, n}
}
