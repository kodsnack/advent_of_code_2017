package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
)

func main() {
	checkUserInput()
	fileData := getFileData()
	stream := getStreamData(fileData)
	stream = removeIgnoredCharacters(stream)
	stream, removed := removeGarbage(stream)
	score := calculateScore(stream)
	fmt.Println("Stream score is", score)
	fmt.Println("Removed", removed, "garbage.")
}

func checkUserInput() {
	if len(os.Args) < 2 {
		fmt.Println("Please provide filename as argument.")
		os.Exit(1)
	}
}

func getFileData() []string {
	fileName := os.Args[1]
	file, err := os.Open(fileName)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0)
	for scanner.Scan() {
		line := scanner.Text()
		filedata = append(filedata, line)
	}
	return filedata
}

func getStreamData(filedata []string) []string {
	if len(filedata) > 1 {
		fmt.Println("We assume that all data is in index 0. This seems to not be the case.")
		os.Exit(1)
	}
	stream := make([]string, 0)
	for _, char := range filedata[0] {
		stream = append(stream, string(char))
	}
	return stream
}

func removeIgnoredCharacters(stream []string) []string {
	ignoreFlag := "!"
	for i := 0; i < len(stream); i++ {
		if stream[i] == ignoreFlag {
			// Remove two chars
			stream = append(stream[:i], stream[i+2:]...)
			i -= 2
		}
	}
	return stream
}

func removeGarbage(stream []string) ([]string, int) {
	indexOfFirstGarbage := math.MinInt16
	removedGarbage := 0
	for i := 0; i < len(stream); i++ {
		if stream[i] == "<" && indexOfFirstGarbage == math.MinInt16 {
			indexOfFirstGarbage = i
		}
		if stream[i] == ">" && indexOfFirstGarbage != math.MinInt16 {
			// Remove from indexOfFirstGarbage to i
			stream = append(stream[:indexOfFirstGarbage], stream[i+1:]...)
			removedGarbage += (i - 1) - indexOfFirstGarbage
			i -= i - indexOfFirstGarbage
			indexOfFirstGarbage = math.MinInt16
		}
	}
	return stream, removedGarbage
}

func printStream(stream []string) {
	for _, v := range stream {
		fmt.Print(v)
	}
	fmt.Println()
}

func calculateScore(stream []string) int {
	score := 0
	currentGroupscore := 1
	for _, v := range stream {
		if v == "{" {
			score += currentGroupscore
			currentGroupscore++
		}
		if v == "}" {
			currentGroupscore--
		}
	}
	return score
}
