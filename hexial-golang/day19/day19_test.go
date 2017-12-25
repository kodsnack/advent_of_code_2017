package day19

import (
	"AdventOfCode2017/util"
	"testing"
)

type direction int

const (
	up    direction = iota
	down  direction = iota
	left  direction = iota
	right direction = iota
)

func DoMaze(filename string) (int, string) {
	runes := util.FileAsRuneArray(filename)
	var x, y int
	h, w := len(runes), len(runes[0])
	//
	// Find start point
	for x = 0; runes[y][x] == ' '; x++ {
	}
	util.LogDebugf("x=%d", x)
	//
	//
	letters := ""
	var steps int
	//
	// Start direction
	var dir direction
	dir = down
	//
	//
	for {
		util.LogDebugf("rune=%c dir=%d y=%d,x=%d", runes[y][x], dir, y, x)
		if runes[y][x] >= 'A' && runes[y][x] <= 'Z' {
			letters += string(runes[y][x])
		}
		if dir == down && y+1 < h && runes[y+1][x] != ' ' {
			steps++
			y++
		} else if dir == up && y-1 >= 0 && runes[y-1][x] != ' ' {
			steps++
			y--
		} else if dir == left && x-1 >= 0 && runes[y][x-1] != ' ' {
			steps++
			x--
		} else if dir == right && x+1 < w && runes[y][x+1] != ' ' {
			steps++
			x++
		} else {
			if dir != up && y+1 < h && runes[y+1][x] != ' ' {
				dir = down
			} else if dir != down && y-1 >= 0 && runes[y-1][x] != ' ' {
				dir = up
			} else if dir != right && x-1 >= 0 && runes[y][x-1] != ' ' {
				dir = left
			} else if dir != left && x+1 < w && runes[y][x+1] != ' ' {
				dir = right
			} else {
				steps++
				return steps, letters
			}
		}
	}
}

func Test1(t *testing.T) {
	util.Debug = false
	var n int
	var s string
	_, s = DoMaze("sample")
	util.AssertEqual(t, "ABCDEF", s)
	_, s = DoMaze("input")
	util.AssertEqual(t, "VEBTPXCHLI", s)
	n, _ = DoMaze("sample")
	util.AssertEqual(t, 38, n)
	n, _ = DoMaze("input")
	util.AssertEqual(t, 18702, n)
}
