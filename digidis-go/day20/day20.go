package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"time"
)

func main() {
	go run(1)
	go run(2)
	time.Sleep(1 * time.Second)
}

func run(part int) {
	f, _ := os.Open("input.txt")
	defer f.Close()
	scanner := bufio.NewScanner(f)
	ps := make([]*[9]int, 0)
	for scanner.Scan() {
		var i [9]int
		fmt.Sscanf(scanner.Text(), "p=<%d,%d,%d>, v=<%d,%d,%d>, a=<%d,%d,%d>", &i[0], &i[1], &i[2], &i[3], &i[4], &i[5], &i[6], &i[7], &i[8])
		ps = append(ps, &i)
	}

	for {
		c := math.MaxInt64
		var ci, count int
		pos := make(map[string][]int)

		for k, p := range ps {

			if p == nil {
				continue
			}
			count++

			// vel
			p[3] += p[6]
			p[4] += p[7]
			p[5] += p[8]
			// pos
			p[0] += p[3]
			p[1] += p[4]
			p[2] += p[5]

			d := abs(p[0]) + abs(p[1]) + abs(p[2])

			t := fmt.Sprintf("%v,%v,%v", p[0], p[1], p[2])
			pos[t] = append(pos[t], k)

			if d < c {
				c = d
				ci = k
			}
		}

		if part == 2 {
			fmt.Printf("%v particles left\n", count)
			for _, k := range pos {
				if len(k) > 1 {
					for _, l := range k {
						ps[l] = nil
					}
				}
			}
		} else {
			fmt.Printf("%v is closest\n", ci)
		}

	}

}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}
