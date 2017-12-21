package day17

import (
	"log"
)

func Part1(moveSteps int, iters int) int {
	buffer := []int{0}
	pos := 0


	for i := 1; i <= iters; i++ {
		pos = (pos+moveSteps)%i + 1

		//buffer = append(buffer[:pos], append([]int{i}, buffer[pos:]...)...)

		//buffer = append(, 0)
		//copy(s[i+1:], s[i:])
		//s[i] = x
		//log.Printf("%d: pos:%d buffer:%+v", i, pos, buffer)

		/*buffer = append(buffer, 0)
		copy(buffer[pos+1:], buffer[pos:])
		buffer[pos] = i*/

		buffer = append(buffer, 0)
		copy(buffer[pos+1:], buffer[pos:])
		buffer[pos] = i


	}

	return buffer[pos+1]
}


func Part2(moveSteps int) int {
	pos := 0
	var res int
	for i := 1; i <= 50000000; i++ {
		pos = (pos+moveSteps)%i + 1

		if pos == 1 {
			log.Println(i)
			res = i
		}

	}

	return res

}
