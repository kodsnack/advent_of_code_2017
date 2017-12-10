package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {

	file, _ := os.Open("input")
	defer file.Close()

	fs := bufio.NewScanner(file)
	fs.Scan()

	counter := 0
	groups := 1
	score := 1
	garbage := false
	canceled := false
	chars := strings.Split(fs.Text(), "")

	for _, v := range chars {
		if v == "!" && !canceled {
			canceled = true
			continue
		} else if canceled {
			canceled = false
			continue
		}

		if v == ">" {
			garbage = false
		}

		if v == "<" {
			garbage = true
		}
		if v == "!" {
			canceled = true
		}

		if v == "}" && !garbage {
			groups--
		}
		if counter > 0 && v == "{" && !garbage {
			groups++
			score += groups

		}

		counter++
	}
	fmt.Printf("Score: %d.\n", score)
}
