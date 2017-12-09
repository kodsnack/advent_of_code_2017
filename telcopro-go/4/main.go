package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {

	var aGood, aBad, bGood, bBad int = 0, 0, 0, 0

	file, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		res := check(scanner.Text())
		if res == true {
			aGood++
		} else {
			aBad++
		}
		res = checkAnagramLine(scanner.Text())
		if res == true {
			bGood++
		} else {
			bBad++
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	fmt.Println("A:In total there were", aGood, "good passwords and", aBad, "bad ones")
	fmt.Println("B:In total there were", bGood, "good passwords and", bBad, "bad ones")
}
