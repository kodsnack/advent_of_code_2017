package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type program struct {
	name      string
	weight    int
	weightSum int
	parent    *program
	children  []*program
}

func main() {

	programs := make(map[string]*program)

	var top *program

	f, _ := os.Open("input.txt")
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {

		v := strings.Fields(scanner.Text())
		name := v[0]

		if programs[name] == nil {
			programs[name] = &program{name: name, children: []*program{}}
		}

		programs[name].weight, _ = strconv.Atoi(v[1][1 : len(v[1])-1])

		if len(v) > 3 {
			children := strings.Split(strings.Join(v[3:], ""), ",")
			for _, p := range children {
				if programs[p] == nil {
					programs[p] = &program{name: p, children: []*program{}}
				}
				programs[p].parent = programs[name]
				programs[name].children = append(programs[name].children, programs[p])
			}
		}

		top = programs[name]
	}
	f.Close()

	for top.parent != nil {
		top = top.parent
	}
	fmt.Printf("Top: %v\n", top.name)

	getWeight(top)

}

var found bool

func getWeight(n *program) int {

	n.weightSum = n.weight
	for _, child := range n.children {
		n.weightSum += getWeight(child)
	}

	if !found {
		// check balance
		switch {
		case len(n.children) == 2:
			if n.children[0].weightSum != n.children[1].weightSum {
				panic("Could this happen?")
			}

		case len(n.children) > 2:
			counts := make(map[int]int)
			for _, child := range n.children {
				counts[child.weightSum]++
			}
			for k, j := range counts {
				if j == 1 {
					for c, child := range n.children {
						if child.weightSum == k {
							diff := child.weightSum - n.children[(c+1)%len(n.children)].weightSum
							fmt.Printf("Unbalanced child: %+v in node %+v\n", child, n)
							fmt.Printf("Weight should be adjusted to: %v\n", child.weight-diff)
							found = true
						}
					}
				}
			}
		}
	}

	return n.weightSum
}
