package day13

import (
	"strings"
	"strconv"
)

type Firewall map[int]int

func Part1(input string) int {
	firewall := parseFirewall(input)
	severity := 0

	for depth, ran := range firewall {
		if spotted(depth, ran) {
			severity += depth * ran
		}
	}

	return severity
}

func Part2(input string) int {
	firewall := parseFirewall(input)

	delay := 0

scan:
	for {
		for fDepth, sRange := range firewall {
			if spotted(sRange, fDepth+delay) {
				delay++
				continue scan
			}
		}
		return delay
	}
}

func parseFirewall(input string) (Firewall) {
	fire := make(Firewall)

	for _, row := range strings.Split(input, "\n") {
		split := strings.Split(row, ":")

		depth, err := strconv.Atoi(strings.TrimSpace(split[0]))
		if err != nil {
			panic(err)
		}

		rang, err := strconv.Atoi(strings.TrimSpace(split[1]))
		if err != nil {
			panic(err)
		}

		fire[depth] = rang
	}

	return fire
}

func spotted(sRange, delay int) bool {
	if sRange == 1 {
		return true
	}
	return delay%(2*(sRange-1)) == 0
}
