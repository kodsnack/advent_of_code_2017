package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func DayOne(s []string) int {

	result := 0

	for i, v := range s {
		if i > 0 && s[i-1] == v {
			i, _ := strconv.Atoi(v)
			result += i
		}
	}

	if s[0] == s[len(s)-1] {
		i, _ := strconv.Atoi(s[0])
		result += i
	}
	return result
}

func main() {

	file, _ := os.Open("input")
	defer file.Close()
	fileScanner := bufio.NewScanner(file)
	fileScanner.Scan()
	s := strings.Split(fileScanner.Text(), "")

	fmt.Println(DayOne(s))

}
