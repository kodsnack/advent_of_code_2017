package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type layer struct {
	Depth   int
	Range   int
	Scanner int
	dir     int
}

func main() {

	delay := 0

	f, _ := os.Open("input.txt")
	defer f.Close()
	scanner := bufio.NewScanner(f)
	layers := make([]*layer, 100)
	maxDepth := 0

	for scanner.Scan() {
		p := strings.Split(scanner.Text(), ": ")
		d, _ := strconv.Atoi(p[0])
		r, _ := strconv.Atoi(p[1])
		layers[d] = &layer{Depth: d, Range: r, Scanner: 0, dir: 0}
		if d > maxDepth {
			maxDepth = d
		}
	}
	f.Close()

	for {

		// set up scanner positions
		for _, l := range layers {
			if l != nil {
				s := delay % ((l.Range - 1) * 2)
				switch {
				case s < l.Range-1:
					l.Scanner = s
					l.dir = 0
				case s >= l.Range-1:
					l.Scanner = 2*(l.Range-1) - s
					l.dir = 1
				}
			}
		}

		pos := -1
		caught := 0
		severity := 0

		for pos < maxDepth {

			pos++
			l := layers[pos]
			if l != nil && l.Scanner == 0 {
				caught++
				if delay > 0 {
					break // abort early
				}
				severity += l.Depth * l.Range
			}

			//advance scanners
			for _, l := range layers {
				if l == nil {
					continue
				}
				if l.dir == 0 {
					l.Scanner++
					if l.Scanner == l.Range-1 {
						l.dir = 1
					}
				} else {
					l.Scanner--
					if l.Scanner == 0 {
						l.dir = 0
					}
				}
			}
		}

		if delay == 0 {
			fmt.Printf("Times caught %v\n", caught)
			fmt.Printf("Severity %v\n", severity)
		}
		if caught == 0 {
			fmt.Printf("Escaped after delaying %v\n", delay)
			break
		}
		if delay%100000 == 0 {
			fmt.Printf("%v\n", delay)
		}
		delay++

	}

}
