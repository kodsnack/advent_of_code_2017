package main

import (
	"fmt"
	"strconv"
)

var grid [128][128]bool

func main() {
	input := "hxtvlmkl" // "flqrgnkx"
	var total, regions int

	for i := 0; i < 128; i++ {
		nh := knotHash(input + "-" + strconv.Itoa(i))
		var bits string
		for k := 0; k < 16; k++ {
			bits += fmt.Sprintf("%.8b", nh[k])
		}
		for a := 0; a < len(bits); a++ {
			grid[i][a] = (bits[a] == '1')
		}
	}

	for y := 0; y < 128; y++ {
		for x := 0; x < 128; x++ {
			if grid[y][x] {
				total += trace(x, y)
				regions++
			}
		}
	}

	fmt.Printf("Total bits %v\n", total)
	fmt.Printf("Regions %v\n", regions)
}

func trace(x, y int) (bits int) {
	grid[y][x] = false
	if x > 0 && grid[y][x-1] {
		bits += trace(x-1, y)
	}
	if x < 127 && grid[y][x+1] {
		bits += trace(x+1, y)
	}
	if y < 127 && grid[y+1][x] {
		bits += trace(x, y+1)
	}
	if y > 0 && grid[y-1][x] {
		bits += trace(x, y-1)
	}
	return bits + 1
}

func knotHash(input string) [16]byte {

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

	return hash

}
