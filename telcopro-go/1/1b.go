package main

import "strconv"

func match1b() int {

	var i, j, acc int = 0, 0, 0

	for i = 0; i < inputLen; i++ {
		j = (i + inputLen/2) % inputLen
		if input[i] == input[j] {
			val, _ := strconv.Atoi(string(input[i]))
			acc += val
		}
	}
	return (acc)
}
