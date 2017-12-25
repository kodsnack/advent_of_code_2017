package matricepoint

import matrice "github.com/philiplarsson/strmatrice"

// Point is a point in a matrice
type Point struct {
	matrix matrice.Matrice
	x      int
	y      int
}

const up string = "up"
const right string = "right"
const down string = "down"
const left string = "left"

// New creates new point
func New(matrix matrice.Matrice) Point {
	newPoint := Point{
		matrix: matrix,
		x:      0,
		y:      0,
	}
	return newPoint
}

// MoveInDirection moves point in specified direction
func (p *Point) MoveInDirection(direction string) {
	switch direction {
	case down:
		p.MoveDown()
	case right:
		p.MoveRight()
	case up:
		p.MoveUp()
	case left:
		p.MoveLeft()
	}
}

// GetValue returns the value that is under point
func (p Point) GetValue() string {
	return p.matrix.Get(p.x, p.y)
}

// Set changes the position of the point
func (p *Point) Set(x, y int) {
	p.x = x
	p.y = y
}

func (p Point) GetX() int {
	return p.x
}

func (p Point) GetY() int {
	return p.y
}

// CheckDown returns the value below the points current position.
func (p Point) CheckDown() string {
	return p.matrix.Get(p.x, p.y+1)
}

// CheckUp returns the value above the points current position.
func (p Point) CheckUp() string {
	return p.matrix.Get(p.x, p.y-1)
}

func (p Point) CheckRight() string {
	return p.matrix.Get(p.x+1, p.y)
}

func (p Point) CheckLeft() string {
	return p.matrix.Get(p.x-1, p.y)
}

func (p *Point) MoveDown() {
	p.y++
}

func (p *Point) MoveUp() {
	p.y--
}

func (p *Point) MoveRight() {
	p.x++
}

func (p *Point) MoveLeft() {
	p.x--
}
