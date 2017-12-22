package strmatrice

import "fmt"

// Matrice is a table
type Matrice struct {
	table [][]string
}

// New creates a new matrice
func New(height, width int) Matrice {
	table := make([][]string, height)
	for i := range table {
		table[i] = make([]string, width)
	}
	matrix := Matrice{
		table: table,
	}
	return matrix
}

// ShowSurrounding shows the matrix at a specific x,y coordinate
// distance decides how much in each direction that should be shown.
func (matrix Matrice) ShowSurrounding(x, y, distance int) {
	startX := x - distance
	startY := y - distance
	if startX < 0 {
		startX = 0
	}
	if startY < 0 {
		startY = 0
	}
	endX := x + distance
	endY := y + distance
	if endX > len(matrix.table[0]) {
		endX = len(matrix.table[0])
	}
	if endY > len(matrix.table) {
		endY = len(matrix.table)
	}
	for y1 := startY; y1 < endY; y1++ {
		for x1 := startX; x1 < endX; x1++ {
			if y1 == y &&
				x1 == x {
				fmt.Print("X")
			} else {
				fmt.Print(matrix.Get(x1, y1))
			}
		}
		fmt.Println()
	}
}

// GetTable returns the matrix underlying table
func (matrix Matrice) GetTable() [][]string {
	return matrix.table
}

// FillMatrice reads data from a slice of strings and inputs it
// into the matrice
func (matrix *Matrice) FillMatrice(data []string) {
	for row, line := range data {
		for col, value := range line {
			matrix.Set(col, row, string(value))
		}
	}
}

// Set changes x and y value for the matrice
func (matrix *Matrice) Set(x int, y int, value string) {
	matrix.table[y][x] = value
}

// Get returns the string value at (x,y)
func (matrix Matrice) Get(x, y int) string {
	return matrix.table[y][x]
}

// CountOccurrence counts how many times needle exists in the underlying table
func (matrix Matrice) CountOccurrence(needle string) int {
	var occurrences int
	for _, row := range matrix.table {
		for _, col := range row {
			if col == needle {
				occurrences++
			}
		}
	}
	return occurrences
}
