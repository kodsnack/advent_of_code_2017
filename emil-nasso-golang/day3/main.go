package main

import "fmt"

type position struct {
	x int
	y int
}

func main() {
	fmt.Println("Part 1:", part1(265149))
	fmt.Println("Part 2:", part2(265149))
}

func part2(input int) int {
	numbers := make(map[position]int)
	current := position{0, 0}
	direction := position{1, 0}
	numbers[current] = 1

	var value int
	for {
		nextPosition := position{current.x + direction.x, current.y + direction.y}
		value = calculateValueForPosition(nextPosition, numbers)
		//fmt.Println(nextPosition, value)
		numbers[nextPosition] = value
		leftDirection := turnLeft(direction)
		leftPosition := position{nextPosition.x + leftDirection.x, nextPosition.y + leftDirection.y}
		if _, ok := numbers[leftPosition]; ok == false {
			direction = leftDirection
		}
		current = nextPosition
		if value > input {
			break
		}
	}

	return value
}

func turnLeft(direction position) position {
	if direction.x == 0 && direction.y == 1 {
		return position{-1, 0}
	} else if direction.x == -1 && direction.y == 0 {
		return position{0, -1}
	} else if direction.x == 0 && direction.y == -1 {
		return position{1, 0}
	} else if direction.x == 1 && direction.y == 0 {
		return position{0, 1}
	} else {
		panic("Unknown direction")
	}
}

func calculateValueForPosition(p position, numbers map[position]int) int {
	sum := 0

	diffs := []int{-1, 0, 1}

	for _, x := range diffs {
		for _, y := range diffs {
			if x == 0 && y == 0 {
				continue
			}
			if val, ok := numbers[position{x: p.x + x, y: p.y + y}]; ok {
				sum += val
			}
		}
	}
	return sum
}

func part1(input int) int {
	if input <= 1 {
		return 0
	}

	radius := 1
	diameter := 1
	var area int
	for {
		if (diameter+2)*(diameter+2) > input {
			break
		}
		radius++
		diameter += 2
		area = diameter * diameter
	}

	if input == area {
		return radius
	}

	outerRingSideLength := diameter + 1
	outerRingPosition := input - area
	sideMidPoint := outerRingSideLength / 2
	for {
		if outerRingPosition <= outerRingSideLength {
			break
		}
		outerRingPosition -= outerRingSideLength
	}

	midPointDistance := sideMidPoint - outerRingPosition
	if midPointDistance < 0 {
		midPointDistance *= -1
	}
	return midPointDistance + radius
}
