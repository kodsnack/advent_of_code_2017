package main

import (
	"strings"
)

func check(s string) bool {
	w := strings.Fields(s)
	wc := make(map[string]int)
	for _, e := range w {
		wc[e]++
		if wc[e] > 1 {
			return false
		}
	}
	return true
}

func checkAnagramLine(s string) bool {
	w := strings.Fields(s)

	for i := 0; i < len(w); i++ {
		for j := i + 1; j < len(w); j++ {
			if checkAnagram(w[i], w[j]) {
				return false
			}
		}
	}
	return true
}

func checkAnagram(s1 string, s2 string) bool {

	l1, l2 := len(s1), len(s2)

	if l1 != l2 {
		return false
	}
	for i := 0; i < l1; i++ {
		if strings.IndexByte(s2, s1[i]) == -1 {
			return false
		}
	}
	return true
}
