package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
)

func main() {
	data, _ := ioutil.ReadFile("input.txt")
	stream, garbageCount := input(string(data))
	fmt.Println("Part 1:", score(stream))
	fmt.Println("Part 2:", garbageCount)
}

func input(s string) (cleanedStream string, garbageCount int) {
	var buffer bytes.Buffer
	var char string
	insideGarbage := false
	i := 0
	for i < len(s) {
		char = string(s[i])

		switch char {
		case "!":
			i += 2
			continue
		case "<":
			if insideGarbage == true {
				garbageCount++
			}
			insideGarbage = true
			i++
			continue
		case ">":
			insideGarbage = false
			i++
			continue
		}

		if insideGarbage {
			garbageCount++
		} else {
			buffer.WriteString(char)
		}

		i++
	}
	s = buffer.String()

	return s, garbageCount
}

func score(s string) int {
	score := 0
	depth := 0
	for _, char := range s {
		switch string(char) {
		case "{":
			depth++
			break
		case "}":
			score += depth
			depth--
			break
		}
	}
	return score
}
