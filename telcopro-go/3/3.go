package main

type Turtle struct {
	x, y, dx, dy int
	val          [1000][1000]int
}

func forward(t *Turtle, newVal int) {
	t.x = t.x + t.dx
	t.y = t.y + t.dy
	t.val[t.x+500][t.y+500] = newVal
	return
}

func forwardNoset(t *Turtle) {
	t.x = t.x + t.dx
	t.y = t.y + t.dy
	return
}

func turnLeft(t *Turtle) {
	if t.dx == 1 && t.dy == 0 {
		t.dx, t.dy = 0, 1
	} else if t.dx == 0 && t.dy == 1 {
		t.dx, t.dy = -1, 0
	} else if t.dx == -1 && t.dy == 0 {
		t.dx, t.dy = 0, -1
	} else if t.dx == 0 && t.dy == -1 {
		t.dx, t.dy = 1, 0
	}
}

func lookLeft(t *Turtle) int {
	if t.dx == 1 && t.dy == 0 {
		return t.val[t.x+500][t.y+501]
	} else if t.dx == 0 && t.dy == 1 {
		return t.val[t.x+499][t.y+500]
	} else if t.dx == -1 && t.dy == 0 {
		return t.val[t.x+500][t.y+499]
	} else if t.dx == 0 && t.dy == -1 {
		return t.val[t.x+501][t.y+500]
	} else {
		return 0
	}
}

func sqSum(t *Turtle) int {

	acc := 0

	for a := -1; a <= 1; a++ {
		for b := -1; b <= 1; b++ {
			acc += t.val[t.x+500+a][t.y+500+b]
		}
	}
	return acc
}
