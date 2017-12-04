package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

func main() {
	checkUserInput()
	lines := getFileData()
	if os.Args[1] == "1" {
		correctPasswords := checkPasswordsForUniqueness(lines)
		fmt.Println(correctPasswords, "passwords are correct. ")
	} else if os.Args[1] == "2" {
		correctPasswords := checkPasswordsForAnagrams(lines)
		fmt.Println(correctPasswords, "passwords are correct")
	} else {
		fmt.Println("Please enter 0 or 1 as part")
		os.Exit(1)
	}
}

func checkUserInput() {
	if len(os.Args) < 3 {
		fmt.Println("Please provide part (1 or 2) and filename as arguments. ")
		fmt.Println(" Example:", "go run day4.go 2 passwords.org")
		os.Exit(1)
	}
}

func getFileData() []string {
	filename := os.Args[2]
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	scanner := bufio.NewScanner(file)
	lines := make([]string, 0, 10)
	for scanner.Scan() {
		line := scanner.Text()
		lines = append(lines, line)
	}

	return lines
}

func checkPasswordsForUniqueness(lines []string) int {
	validPasswords := 0
	for _, pw := range lines {
		if passwordsUnique(pw) {
			validPasswords++
		}
	}
	return validPasswords
}

func passwordsUnique(pw string) bool {
	chunks := strings.Fields(pw)
	m := make(map[string]int)
	for _, chunk := range chunks {
		m[chunk]++
		if m[chunk] > 1 {
			return false
		}
	}
	return true
}

func checkPasswordsForAnagrams(lines []string) int {
	validPasswords := 0
	for _, pw := range lines {
		if passwordAnagramValid(pw) {
			validPasswords++
		}
	}
	return validPasswords
}

func passwordAnagramValid(pw string) bool {
	chunks := strings.Fields(pw)
	m := make(map[string]int)
	for _, chunk := range chunks {
		wordHolder := make([]string, 0, 1)
		for _, c := range chunk {
			wordHolder = append(wordHolder, string(c))
		}
		sort.Strings(wordHolder)
		word := strings.Join(wordHolder, "")
		m[word]++
		if m[word] > 1 {
			return false
		}
	}
	return true
}
