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
	fmt.Printf("Turtle now at coordinates (%d, %d) and value at this position is %d\n", t.x, t.y, t.val[t.x+500][t.y+500])
	fmt.Printf("Manhattan Distance from starting point is %d\n", int(math.Abs(float64(t.x))+math.Abs(float64(t.y)))
}
