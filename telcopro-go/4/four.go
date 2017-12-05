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
