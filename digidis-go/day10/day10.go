package main

import (
	"fmt"
	"strconv"
	"strings"
)

func main() {
	part1()
	part2()
}

func part1() {
	var lengths = strings.Split("183,0,31,146,254,240,223,150,2,206,161,1,255,232,199,88", ",")

	list := make([]int, 256)
	for i := 0; i < 256; i++ {
		list[i] = i
	}
	var pos, skip int

	for _, sl := range lengths {
		l, _ := strconv.Atoi(sl)

		reverse := make([]int, l)
		for k := 0; k < l; k++ {
			reverse[k] = list[(pos+k)%256]
		}
		for k := 0; k < l; k++ {
			list[(pos+k)%256] = reverse[l-k-1]
		}
		pos = (pos + l + skip) % 256
		skip++
	}

	fmt.Printf("Result 1 %v\n", list[0]*list[1])
}

func part2() {

	var input = "183,0,31,146,254,240,223,150,2,206,161,1,255,232,199,88"
	var lengths []int
	for l := range input {
		lengths = append(lengths, int(input[l]))
	}
	lengths = append(lengths, []int{17, 31, 73, 47, 23}...)

	list := make([]int, 256)

	for i := 0; i < 256; i++ {
		list[i] = i
	}
	var pos, skip int

	for round := 0; round < 64; round++ {
		for _, l := range lengths {

			reverse := make([]int, l)
			for k := 0; k < l; k++ {
				reverse[k] = list[(pos+k)%256]
			}
			for k := 0; k < l; k++ {
				list[(pos+k)%256] = reverse[l-k-1]
			}
			pos = (pos + l + skip) % 256
			skip++
		}
	}

	var hash [16]byte

	for u := 0; u < 16; u++ {
		h := byte(list[u*16+0])
		for v := 1; v < 16; v++ {
			h = h ^ byte(list[u*16+v])
		}
		hash[u] = h
	}

	fmt.Printf("Result 2 %x\n", hash)
}
