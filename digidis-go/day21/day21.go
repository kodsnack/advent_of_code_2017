package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strings"
)

var rs [][2]string

func main() {
	f, _ := os.Open("input.txt")
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		p := strings.Fields(scanner.Text())
		for i := 0; i < 4; i++ {
			rs = append(rs, [2]string{p[0], p[2]})
			rs = append(rs, [2]string{flip(p[0]), p[2]})
			p[0] = rotate(p[0])
		}
	}
	f.Close()

	m := ".#./..#/###"
	for step := 1; step <= 18; step++ {
		ms := split(m)
		for i := range ms {
			ms[i] = match(ms[i])
		}
		m = merge(ms)
		fmt.Printf("After step %v, %v pixels are on\n", step, strings.Count(m, "#"))
	}

}

func match(m string) string {
	for _, r := range rs {
		if m == r[0] {
			return r[1]
		}
	}
	panic("No match")
}

func split(m string) (out []string) {
	rows := strings.Split(m, "/")
	s := len(rows[0])
	switch {
	case s%2 == 0:
		for y := 0; y < s; y += 2 {
			for x := 0; x < s; x += 2 {
				out = append(out, rows[y][x:x+2]+"/"+rows[y+1][x:x+2])
			}
		}
	default:
		for y := 0; y < s; y += 3 {
			for x := 0; x < s; x += 3 {
				out = append(out, rows[y][x:x+3]+"/"+rows[y+1][x:x+3]+"/"+rows[y+2][x:x+3])
			}
		}

	}
	return out
}

func merge(ms []string) string {
	br := strings.Split(ms[0], "/")
	u := int(math.Sqrt(float64(len(ms))))
	rows := make([]string, u*len(br))
	k := 0
	for _, m := range ms {
		rs := strings.Split(m, "/")
		for j, r := range rs {
			rows[k+j] += r
		}
		if len(rows[k]) == len(rows) {
			k += len(rs)
		}
	}
	return strings.Join(rows, "/")
}

func rotate(p string) string {
	if len(p) == 5 {
		return string([]byte{p[1], p[4], '/', p[0], p[3]})
	}
	return string([]byte{p[2], p[6], p[10], '/', p[1], p[5], p[9], '/', p[0], p[4], p[8]})
}

func flip(p string) string {
	if len(p) == 5 {
		return string([]byte{p[1], p[0], '/', p[4], p[3]})
	}
	return string([]byte{p[2], p[1], p[0], '/', p[6], p[5], p[4], '/', p[10], p[9], p[8]})
}
