package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func containString(m []string, w string) bool {

	for _, v := range m {

		if strings.ToLower(v) == strings.ToLower(w) {
			return true
		}
	}

	return false

}

func containDubblicateString(m []string) bool {

	wordCount := make(map[string]int)
	for _, v := range m {

		wordCount[strings.ToLower(v)]++
		if wordCount[strings.ToLower(v)] > 1 {
			return true
		}
	}

	return false

}

func main() {

	file, _ := os.Open("input")
	defer file.Close()

	nrValidPassphrases := 0

	fileScanner := bufio.NewScanner(file)
	for fileScanner.Scan() {

		w := strings.Fields(fileScanner.Text())
		if !containDubblicateString(w) {
			nrValidPassphrases++
		}

	}

	fmt.Println(nrValidPassphrases)

}
