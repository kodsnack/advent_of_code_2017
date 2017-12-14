package day12

import (
	"strings"
	"sort"
)

func Part1(input string) int {
	pipes := make(map[string][]string)

	for _, row := range strings.Split(input, "\n") {
		startAndTargets := strings.Split(row, "<->")
		start := strings.TrimSpace(startAndTargets[0])
		targets := strings.Split(strings.TrimSpace(startAndTargets[1]), ", ")
		pipes[start] = targets
	}

	visited := make(map[string]struct{})
	return len(connected(pipes, "0", visited))
}

func Part2(input string) int {
	pipes := make(map[string][]string)

	for _, row := range strings.Split(input, "\n") {
		startAndTargets := strings.Split(row, "<->")
		start := strings.TrimSpace(startAndTargets[0])
		targets := strings.Split(strings.TrimSpace(startAndTargets[1]), ", ")
		pipes[start] = targets
	}

	groups := make(map[string]struct{})

	for pipeStart := range pipes {
		visited := make(map[string]struct{})

		connected := connected(pipes, pipeStart, visited)

		keys := make([]string, 0)
		for key := range connected {
			keys = append(keys, key)
		}
		sort.Strings(keys)
		groups[strings.Join(keys, "-")] = struct{}{}
	}

	return len(groups)
}

func connected(pipes map[string][]string, start string, visited map[string]struct{}) map[string]struct{} {
	for _, node := range pipes[start] {
		if _, ok := visited[node]; ok {
			continue
		}
		visited[node] = struct{}{}

		connected(pipes, node, visited)
	}

	return visited
}
