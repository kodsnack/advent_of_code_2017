package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	f, _ := os.Open("input.txt")

	programs := make(map[int][]int)

	defer f.Close()
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		p := strings.Fields(scanner.Text())
		i, _ := strconv.Atoi(p[0])
		programs[i] = []int{}
		for j := 2; j < len(p); j++ {
			k, _ := strconv.Atoi(strings.Trim(p[j], ","))
			programs[i] = append(programs[i], k)
		}
	}

	groups := make([]map[int]bool, 0)
	seen := make(map[int]bool)

	for p := range programs {
		if !seen[p] {
			group := make(map[int]bool)
			work := []int{p}
			for len(work) > 0 {
				w := work[0]
				work = work[1:]
				group[w] = true
				seen[w] = true
				for _, a := range programs[w] {
					if !group[a] {
						work = append(work, a)
					}
				}
			}
			groups = append(groups, group)
			if group[0] {
				fmt.Printf("Length of group with 0 is %v\n", len(group))
			}
		}
	}

	fmt.Printf("%v groups\n", len(groups))

}
