package main

import (
	"fmt"
	"io/ioutil"
)

func main() {
	var level, score, garbage int
	row, _ := ioutil.ReadFile("input.txt")

	for i := 0; i < len(row); i++ {
		switch row[i] {
		case '{':
			level++

		case '}':
			score += level
			level--

		case '<':
			i++
			for row[i] != '>' {
				if row[i] == '!' {
					i++
				} else {
					garbage++
				}
				i++
			}

		case '!':
			i++
		}
	}

	fmt.Printf("score: %v\n", score)
	fmt.Printf("garbage: %v\n", garbage)
}
