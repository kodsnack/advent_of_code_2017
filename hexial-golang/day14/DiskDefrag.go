package day14

import (
	"AdventOfCode2017/day10"
	"AdventOfCode2017/util"
	"encoding/hex"
	"fmt"
)

func getBit(b byte, bit uint) int {
	return int(b >> bit & 1)
}

func calcByte(b byte) (int, string) {
	sum := 0
	for i := 0; i < 8; i++ {
		sum += getBit(b, uint(i))
	}
	s := ""
	for i := 7; i >= 0; i-- {
		if getBit(b, uint(i)) == 1 {
			s += "#"
		} else {
			s += "."
		}
	}
	return sum, s
}

type DiskDefrag struct {
	key       string
	maxRegion int
	regions   [128][128]int
	usage     [128][128]rune
	used      int
}

func NewDiskDefrag(key string) *DiskDefrag {
	dd := new(DiskDefrag)
	dd.key = key
	dd.Build()
	return dd
}

func (dd *DiskDefrag) GetAbove(y, x int) int {
	if y > 0 {
		return dd.regions[y-1][x]
	}
	return 0
}

func (dd *DiskDefrag) CalcRegions() int {
	for y := 0; y < len(dd.regions); y++ {
		for x := 0; x < len(dd.regions[y]); x++ {
			if dd.usage[y][x] == '#' && dd.regions[y][x] == 0 {
				dd.maxRegion++
				//util.LogInfof("*************************************")
				dd._fill(y, x, dd.maxRegion)
			}
		}
	}
	//dd.Debug(128)
	return dd.maxRegion
}

func (dd *DiskDefrag) _fill(y, x, r int) {
	if y >= 0 && y < len(dd.regions) && x >= 0 && x < len(dd.regions[y]) {
		if dd.regions[y][x] != 0 && dd.regions[y][x] != r {
			util.LogPanicf("This should not happen: y=%d x=%d", y, x)
		}
		if dd.usage[y][x] == '#' && dd.regions[y][x] == 0 {
			//util.LogInfof("_fill(%d,%d,%d)", y, x, r)
			dd.regions[y][x] = r
			dd._fill(y-1, x, r)
			dd._fill(y+1, x, r)
			dd._fill(y, x-1, r)
			dd._fill(y, x+1, r)
		}
	}
}

func (dd *DiskDefrag) Build() {
	for y := 0; y < len(dd.usage); y++ {
		str := day10.NewKnotHashPartTwo(fmt.Sprintf("%s-%d", dd.key, y), 256).DenseHash
		val, err := hex.DecodeString(str)
		if err != nil {
			panic(err)
		}
		x := 0
		for _, b := range val {
			u, s := calcByte(b)
			for _, b1 := range []byte(s) {
				dd.usage[y][x] = rune(b1)
				x++
			}
			dd.used += u
		}
	}
}

func (dd *DiskDefrag) Debug(size int) {
	for y := 0; y < size; y++ {
		str := ""
		for x := 0; x < size; x++ {
			str += fmt.Sprintf("[ %c]", dd.usage[y][x])
		}
		util.LogInfof("%s", str)
	}
	util.LogInfof("-----------------")
	for y := 0; y < size; y++ {
		str := ""
		for x := 0; x < size; x++ {
			if dd.regions[y][x] == 0 {
				str += fmt.Sprintf("[  ]")
			} else {
				str += fmt.Sprintf("[%02d]", dd.regions[y][x])
			}
		}
		util.LogInfof("%s", str)
	}
}
