package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {

	programs := []byte("abcdefghijklmnop")

	row, _ := ioutil.ReadFile("input.txt")
	instructions := strings.Split(string(row), ",")

	p2 := make([]byte, 16)
	var u, v int
	dances := 0

	for dances < 1000000000 {

		for _, i := range instructions {
			switch i[0] {
			case 's':
				j, _ := strconv.Atoi(i[1:])
				start := 16 - (j % 16)
				for j := range p2 {
					p2[j] = programs[(j+start)%16]
				}
				copy(programs, p2)

			case 'x':
				fmt.Sscanf(i[1:], "%d/%d", &u, &v)
				programs[u], programs[v] = programs[v], programs[u]

			case 'p':
				for j := range programs {
					if programs[j] == i[1] {
						u = j
					}
					if programs[j] == i[3] {
						v = j
					}
				}
				programs[u], programs[v] = programs[v], programs[u]

			default:
				panic("Bad instruction")
			}
		}

		dances++

		if dances == 1 {
			fmt.Printf("First pattern %s\n", programs)
		}

		if bytes.Compare(programs, []byte("abcdefghijklmnop")) == 0 {
			fmt.Printf("Repeat after %v\n", dances)
			repeat := dances
			for dances+repeat <= 1000000000 {
				dances += repeat
			}
			fmt.Printf("Repeating until %v\n", dances)
		}
	}

	fmt.Printf("Final pattern %s\n", programs)
}
