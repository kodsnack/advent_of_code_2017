package day13

import (
	"AdventOfCode2017/util"
)

type Layer struct {
	depth int
}

type Firewall struct {
	layers     map[int]*Layer
	highestKey int
}

func (fw *Firewall) Delay() int {
	util.LogInfof("highestKey=%d", fw.highestKey)
	var delay int
	//delay = 21400000000
	delay = 0
	for {
		if delay%100000000 == 0 {
			util.LogInfof("Delay: %d", delay)
		}
		hit := false
		for picosecond := 0; picosecond <= fw.highestKey; picosecond++ {
			if h, _ := fw.Hit(picosecond, delay); h {
				hit = true
				break
			}
		}
		if !hit {
			return delay
		}
		delay++
	}
}

func Steps(depth int) int {
	if depth == 1 {
		return 1
	}
	return 3 + ((depth - 2) * 2)
}

func TestHit(depth int, picosecond int, delay int) bool {
	time := picosecond + delay
	steps := Steps(depth) - 1
	s := picosecond + delay
	var result bool
	if depth == 0 {
		result = false
	} else if time == 0 {
		result = depth > 0
	} else {
		result = s%steps == 0
	}
	//util.LogInfof("time=%d : depth=%d : steps=%d, s=%d : %t", time, depth, steps, s, result)
	return result
}

func (fw *Firewall) Hit(picosecond int, delay int) (bool, int) {
	var depth int
	if layer, ok := fw.layers[picosecond]; ok {
		depth = layer.depth
	}
	if TestHit(depth, picosecond, delay) {
		sev := depth * picosecond
		//util.LogInfof("Hit : sev=%d", sev)
		return true, sev
	}
	return false, 0
}

func (fw *Firewall) Severity() int {
	var severity int
	for picosecond := 0; picosecond <= fw.highestKey; picosecond++ {
		_, s := fw.Hit(picosecond, 0)
		severity += s
		//fw.Move()
	}
	return severity
}

func NewFirewall(filename string) *Firewall {
	fw := new(Firewall)
	fw.layers = make(map[int]*Layer, 0)
	for _, row := range util.FileAsWordNumberArraySep(filename, ":") {
		layer := new(Layer)
		layer.depth = row[1]
		fw.layers[row[0]] = layer
		if fw.highestKey < row[0] {
			fw.highestKey = row[0]
		}
	}
	return fw
}
