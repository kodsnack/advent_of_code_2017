package day11

import (
	"AdventOfCode2017/util"
	"math"
	"strings"
)

//
// All creds to this site!!
// https://www.redblobgames.com/grids/hexagons/

type Cube struct {
	x, y, z float64
}

type Hexagon struct {
	// Column
	q int
	// Row
	r int
}

func (h *Hexagon) MoveDir(direction string) {
	switch direction {
	case "n":
		h.Move(-1, 0)
	case "ne":
		h.Move(0, -1)
	case "se":
		h.Move(+1, -1)
	case "s":
		h.Move(+1, 0)
	case "sw":
		h.Move(0, +1)
	case "nw":
		h.Move(-1, +1)
	default:
		util.LogPanicf("Unhandled %s", direction)
	}
	util.LogInfof("Move: %s [q=%d,r=%d]", direction, h.q, h.r)

}

func (h *Hexagon) Move(q, r int) {
	h.q += q
	h.r += r
}

func (h *Hexagon) Distance(other *Hexagon) int {
	a := h.ToCube()
	b := other.ToCube()
	util.LogInfof("a=%v b=%v", a, b)
	return int((math.Abs(a.x-b.x) + math.Abs(a.y-b.y) + math.Abs(a.z-b.z)) / 2)
}

func (h *Hexagon) ToCube() Cube {
	var c Cube
	c.x = float64(h.q)
	c.z = float64(h.r)
	c.y = -c.x - c.z
	return c
}

func NewHexagon(input string) *Hexagon {
	util.LogInfof("*******************************")
	origo := new(Hexagon)
	h := new(Hexagon)
	var max int
	for _, step := range strings.Split(input, ",") {
		h.MoveDir(step)
		d := h.Distance(origo)
		if d > max {
			max = d
		}
	}
	util.LogInfof("Max was: %d", max)
	return h
}
