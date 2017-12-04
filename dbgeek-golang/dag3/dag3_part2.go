package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

type (
	position struct {
		x int
		y int
	}
	square struct {
		xSteps           float64
		ySteps           float64
		totalInNeighbors int
	}
	neighbors [8]position
	grid      map[position]square
)

var seen map[position]bool

func (s square) getSteps() int {

	return int(math.Abs(s.xSteps) + math.Abs(s.ySteps))
}

func NewGrid(nrSquare int) grid {

	var n grid
	n = make(grid)
	p := position{x: 0, y: 0}
	s := square{xSteps: 0.0, ySteps: 0.0}
	n[position{x: 0, y: 0}] = square{xSteps: 0.0, ySteps: 0.0, totalInNeighbors: 1}
	turns := 0

	for stepCounter := 0; stepCounter < nrSquare-1; {
		length := (turns / 2) + 1
		direction := turns % 4

		for cnt := 1; cnt < length; cnt++ {
			if stepCounter == nrSquare-1 {
				break
			}
			stepCounter++
			if direction == 0 {
				p.x++
				s.xSteps++
			} else if direction == 1 {
				p.y++
				s.ySteps++
			} else if direction == 2 {
				p.x--
				s.xSteps--
			} else {
				p.y--
				s.ySteps--
			}
			sumNeigbortsStep := 0
			for _, v := range p.getNeighbors() {
				if val, ok := n[v]; ok {
					sumNeigbortsStep += val.totalInNeighbors
				}
			}

			s.totalInNeighbors = sumNeigbortsStep
			n[p] = s
		}
		turns += 1
	}
	return n

}

func (g grid) GetPosAfteNrSteps(steps int) position {
	p := position{x: 0, y: 0}
	turns := 0

	for stepCounter := 0; stepCounter < steps-1; {
		length := (turns / 2) + 1
		direction := turns % 4

		for cnt := 1; cnt < length; cnt++ {
			if stepCounter == steps-1 {
				break
			}
			stepCounter++
			if direction == 0 {
				p.x++
			} else if direction == 1 {
				p.y++
			} else if direction == 2 {
				p.x--
			} else {
				p.y--
			}
		}
		turns += 1
	}
	return p

}

func (p position) getNeighbors() neighbors {
	var n neighbors

	p.x--
	p.y--
	turn := 0
	steps := 0
	for i := 0; i < 4; i++ {
		direction := turn % 4
		for x := 0; x < 2; x++ {
			if direction == 0 {
				p.x++
			} else if direction == 1 {
				p.y++
			} else if direction == 2 {
				p.x--
			} else {
				p.y--
			}
			n[steps] = p
			steps++
		}
		turn++
	}

	return n
}

func main() {

	arg := os.Args[1]

	puzzelInput, _ := strconv.Atoi(arg)
	n := NewGrid(1024)
	stepts := 0
	for i := 0; n[n.GetPosAfteNrSteps(i)].totalInNeighbors < puzzelInput; i++ {
		stepts = i
	}

	fmt.Printf("Svar på dag 3 part2: %d.\n", n[n.GetPosAfteNrSteps(stepts+1)].totalInNeighbors)

}
