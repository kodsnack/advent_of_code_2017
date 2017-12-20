package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	f, _ := os.Open("input.txt")
	defer f.Close()
	scanner := bufio.NewScanner(f)

	var grid [][]byte

	for scanner.Scan() {
		row := scanner.Text()
		grid = append(grid, []byte(row))
	}

	var x, y, dir, steps int

	for k := 0; k < len(grid[0]); k++ {
		if grid[0][k] == '|' {
			x = k
		}
	}

	letters := ""
	steps = 1

	for {
		d := grid[y][x]
		if d == '+' {
			switch dir {
			case 0, 2:
				if grid[y][x-1] == '-' {
					dir = 1
				} else {
					dir = 3
				}
			case 1, 3:
				if grid[y-1][x] == '|' {
					dir = 2
				} else {
					dir = 0
				}
			}
		}
		if d >= 'A' && d <= 'Z' {
			letters = letters + string(grid[y][x])
		}
		switch dir {
		case 0:
			y++
		case 1:
			x--
		case 2:
			y--
		case 3:
			x++
		}
		if grid[y][x] == ' ' {
			break
		}
		steps++
	}
	fmt.Printf("%v\n", letters)
	fmt.Printf("%v steps\n", steps)
}
