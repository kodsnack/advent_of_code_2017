package util

import (
	"bufio"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

func FileAsLineArray(filename string) []string {
	f, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	r := bufio.NewReader(f)
	l := make([]string, 0)
	for {
		if s, err := r.ReadString('\n'); err == nil {
			l = append(l, strings.Split(s, "\n")[0])
		} else {
			return l
		}
	}
}

func FileAsRuneArray(filename string) [][]rune {
	a := make([][]rune, 0)
	for _, s := range FileAsLineArray(filename) {
		a = append(a, []rune(s))
	}
	return a
}

func FileAsString(filename string) string {
	f, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	b, err := ioutil.ReadAll(f)
	if err != nil {
		panic(err)
	}
	return string(b)
}

func FileAsTabbedSingleLineNumbers(filename string) []int {
	return FileAsSeparatedSingleLineNumbers(filename, "\t")
}

func FileAsSeparatedSingleLineNumbers(filename string, sep string) []int {
	l := FileAsLineArray(filename)[0]
	s := strings.Split(l, sep)
	result := make([]int, len(s))
	for i := range s {
		var err error
		result[i], err = strconv.Atoi(s[i])
		if err != nil {
			panic(err)
		}
	}
	return result
}

func FileAsNumberArray(filename string) []int {
	l := make([]int, 0)
	for _, s := range FileAsLineArray(filename) {
		n, err := strconv.Atoi(s)
		if err != nil {
			panic(err)
		}
		l = append(l, n)
	}
	return l
}

func FileAsWordArraySep(filename string, sep string) [][]string {
	l := make([][]string, 0)
	for _, s := range FileAsLineArray(filename) {
		l = append(l, strings.Split(s, sep))
	}
	return l
}

func FileAsWordArray(filename string) [][]string {
	return FileAsWordArraySep(filename, " ")
}

func FileAsWordNumberArray(filename string) [][]int {
	return FileAsWordNumberArraySep(filename, " ")
}

func FileAsWordNumberArraySep(filename string, sep string) [][]int {
	l1 := make([][]int, 0)
	for _, s1 := range FileAsWordArraySep(filename, sep) {
		l2 := make([]int, 0)
		for _, s2 := range s1 {
			n, err := strconv.Atoi(strings.TrimSpace(s2))
			if err != nil {
				panic(err)
			}
			l2 = append(l2, n)
		}
		l1 = append(l1, l2)
	}
	return l1
}
