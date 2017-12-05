package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {

	var good, bad int = 0, 0

	file, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		res := check(scanner.Text())
		if res == true {
			good++
		} else {
			bad++
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	fmt.Println("In total there were", good, "good passwords and", bad, "bad ones")
}
