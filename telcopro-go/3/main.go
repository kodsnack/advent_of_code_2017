package main

import "fmt"
import "math"

func main() {

	t := Turtle{}
	t.x = 0
	t.y = 0
	t.dx = 1
	t.dy = 0
	t.val[500][500] = 1

	for i := 2; i <= 325489; i++ {
		forward(&t, i)
		if lookLeft(&t) == 0 {
			turnLeft(&t)
		}
	}
	fmt.Printf("A: Turtle now at coordinates (%d, %d) and value at this position is %d\n", t.x, t.y, t.val[t.x+500][t.y+500])
	fmt.Printf("A: Manhattan Distance from starting point is %d\n", int(math.Abs(float64(t.x))+math.Abs(float64(t.y))))

	t2 := Turtle{}
	t2.x = 0
	t2.y = 0
	t2.dx = 1
	t2.dy = 0
	t2.val[500][500] = 1

	for t2.val[t2.x+500][t2.y+500] < 325489 {
		forwardNoset(&t2)
		t2.val[t2.x+500][t2.y+500] = sqSum(&t2)
		if lookLeft(&t2) == 0 {
			turnLeft(&t2)
		}
	}

	fmt.Printf("B: Turtle now at coordinates (%d, %d) and value at this position is %d\n", t2.x, t2.y, t2.val[t2.x+500][t2.y+500])

}
