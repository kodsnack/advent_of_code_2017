package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

func dag3_part1(stepts int) int {
	x := 0.0
	y := 0.0
	turns := 0
	for stepCounter := 0; stepCounter < stepts-1; {

		length := (turns / 2) + 1
		direction := turns % 4
		for cnt := 1; cnt < length; cnt++ {
			if stepCounter == stepts-1 {
				break
			}
			stepCounter++
			if direction == 0 {
				x += 1
			} else if direction == 1 {
				y += 1
			} else if direction == 2 {
				x -= 1
			} else {
				y -= 1
			}
		}
		turns += 1

	}

	return int(math.Abs(x) + math.Abs(y))
}

func main() {

	arg := os.Args[1]

	square, _ := strconv.Atoi(arg)
	fmt.Printf("Svar på dag3 part1: %d.\n", dag3_part1(square))

}
