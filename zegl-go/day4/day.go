package day4

import (
	"strings"
	"os"
	"bufio"
	"log"
	"io"
	"sort"
)

func Part1(filename string, part int) int {
	count := 0

	file, err := os.Open(filename)
	defer file.Close()

	if err != nil {
		panic(err)
	}

	reader := bufio.NewReader(file)

	seen := make(map[string]struct{})

	var line string
	for {
		line, err = reader.ReadString('\n')

		if _, ok := seen[line]; ok {
			panic("duplicate")
		}
		seen[line] = struct{}{}

		if err == io.EOF {
			break
		}

		if err != nil {
			log.Println(err)
			continue
		}

		line = strings.TrimSpace(line)

		if len(line) == 0 {
			continue
		}

		if part == 1 && isValid(line) {
			count++
		}

		if part == 2 && isValidPart2(line) {
			count++
		}
	}

	return count
}

func isValid(pass string) bool {
	seen := make(map[string]struct{})

	for _, word := range strings.Split(pass, " ") {
		if _, ok := seen[word]; ok {
			return false
		}

		seen[word] = struct{}{}
	}

	return true
}

func isValidPart2(pass string) bool {
	seen := make(map[string]struct{})

	for _, word := range strings.Split(pass, " ") {
		chars := strings.Split(word, "")
		sort.Strings(chars)
		sorted := strings.Join(chars, "")

		if _, ok := seen[sorted]; ok {
			return false
		}

		seen[sorted] = struct{}{}
	}

	return true
}
