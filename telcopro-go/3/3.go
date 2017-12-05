package main

import "fmt"

const debug = 0

type Turtle struct {
	x, y, dx, dy int
	val          [1000][1000]int
}

func forward(t *Turtle, newVal int) {
	t.x = t.x + t.dx
	t.y = t.y + t.dy
	if debug == 2 {
		fmt.Printf("Moving forward to coordinates (%d, %d) and setting value to %d\n", t.x, t.y, newVal)
	}
	t.val[t.x+500][t.y+500] = newVal
	return
}

func turnLeft(t *Turtle) {

	if t.dx == 1 && t.dy == 0 {
		if debug == 1 {
			fmt.Println("Heading was east, new heading north")
		}
		t.dx, t.dy = 0, 1
	} else if t.dx == 0 && t.dy == 1 {
		if debug == 1 {
			fmt.Println("Heading was north, new heading west")
		}
		t.dx, t.dy = -1, 0
	} else if t.dx == -1 && t.dy == 0 {
		if debug == 1 {
			fmt.Println("Heading was west, new heading south")
		}
		t.dx, t.dy = 0, -1
	} else if t.dx == 0 && t.dy == -1 {
		if debug == 1 {
			fmt.Println("Heading was south, new heading east")
		}
		t.dx, t.dy = 1, 0
	}
}

func lookLeft(t *Turtle) int {
	if t.dx == 1 && t.dy == 0 {
		if debug == 1 {
			fmt.Printf("Heading was east, peeking north and finding %d\n", t.val[t.x+500][t.y+501])
		}
		return t.val[t.x+500][t.y+501]
	} else if t.dx == 0 && t.dy == 1 {
		if debug == 1 {
			fmt.Printf("Heading was north, peeking west and finding %d\n", t.val[t.x+499][t.y+500])
		}
		return t.val[t.x+499][t.y+500]
	} else if t.dx == -1 && t.dy == 0 {
		if debug == 1 {
			fmt.Printf("Heading was west, peeking south and finding %d\n", t.val[t.x+500][t.y+499])
		}
		return t.val[t.x+500][t.y+499]
	} else if t.dx == 0 && t.dy == -1 {
		if debug == 1 {
			fmt.Printf("Heading was south, peeking east and finding %d\n", t.val[t.x+501][t.y+500])
		}
		return t.val[t.x+501][t.y+500]
	} else {
		return 0
	}
}
