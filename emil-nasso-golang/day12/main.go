package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type pipes map[string]*pipe

type pipe struct {
	group int
	ends  []string
}

func main() {
	pipes := input("input.txt")
	groupCount := markConnectionGroups(pipes)
	i := 0
	for _, p := range pipes {
		if p.group == 1 {
			i++
		}
	}
	fmt.Println("Part 1:", i)
	fmt.Println("Part 2:", groupCount)
}

func input(filename string) pipes {
	p := make(pipes)
	data, _ := ioutil.ReadFile(filename)
	for _, line := range strings.Split(string(data), "\n") {
		parts := strings.Split(line, " <-> ")
		start := parts[0]
		ends := strings.Split(parts[1], ", ")
		p[start] = &pipe{
			group: 0,
			ends:  ends,
		}
	}
	return p
}

func markConnectionGroups(p pipes) int {
	group := 1
	markConnection("0", p, group)
	for name, pipe := range p {
		if pipe.group == 0 {
			group++
			markConnection(name, p, group)
		}
	}
	return group
}

func markConnection(name string, p pipes, group int) {
	pipe := p[name]
	pipe.group = group
	for _, targetPipe := range p[name].ends {
		if p[targetPipe].group == 0 {
			markConnection(targetPipe, p, group)
		}
	}
}
