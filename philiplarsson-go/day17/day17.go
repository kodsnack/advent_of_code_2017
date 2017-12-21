package main

import (
	"container/ring"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"time"
)

func main() {
	checkArgs()
	forwardSteps := getForwardStep()
	part1(forwardSteps)
	part2(forwardSteps)
}

func part1(steps int) {
	buffer := ring.New(1)
	buffer.Value = 0
	for i := 1; i <= 2017; i++ {
		buffer = walkForward(buffer, steps, i)
	}

	value := valueAfter(buffer, 2017)
	fmt.Println("Part 1")
	fmt.Println(" Value after 2017 is:", value)

}

// part2 does same as part1 but print percentage and time.
// This means that part2 is very slow...
func part2(steps int) {
	buffer := ring.New(1)
	buffer.Value = 0
	fiftyMillion := int(50 * math.Pow(10, 6))
	onePercent := fiftyMillion / 100
	currentPercentage := onePercent
	lastTime := time.Now()
	for i := 1; i <= fiftyMillion; i++ {
		if i >= currentPercentage {
			timeDiff := time.Now().Sub(lastTime)
			fmt.Printf("%d %% (%.2f seconds)\n", currentPercentage/onePercent, timeDiff.Seconds())
			lastTime = time.Now()
			currentPercentage += onePercent
		}
		buffer = walkForward(buffer, steps, i)
	}
	value := valueAfter(buffer, 0)
	fmt.Println("Part 2")
	fmt.Println(" Value after 0 is:", value)
}

func valueAfter(r *ring.Ring, value int) int {
	for r.Value != value {
		r = r.Next()
	}
	// One more to go to next
	r = r.Next()
	return r.Value.(int)
}

func printRing(r *ring.Ring) {
	steps := 0
	// Go forward to 0
	for r.Value != 0 {
		r = r.Next()
		steps++
	}
	r.Do(func(x interface{}) {
		fmt.Println(x)
	})
	// go back to where we were
	for i := 0; i < steps; i++ {
		r = r.Prev()
	}
}

func walkForward(r *ring.Ring, steps int, i int) *ring.Ring {
	for step := 0; step < steps; step++ {
		r = r.Next()
	}
	r = insertValue(r, i)
	return r
}

func insertValue(r *ring.Ring, i int) *ring.Ring {
	newRing := ring.New(1)
	newRing.Value = i
	r = r.Link(newRing)
	// r.Link will make r point at the value after the new ring.
	// therefore we go back one step
	return r.Prev()

}

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Enter the puzzle input as first and only argument. ")
		fmt.Println(" Example: go run day17.go 3")
		os.Exit(1)
	}
}

func getForwardStep() int {
	arg := os.Args[1]
	steps, err := strconv.Atoi(arg)
	if err != nil {
		fmt.Println("Could not convert", arg, " to int. ")
		log.Fatal(err)
	}
	return steps
}
