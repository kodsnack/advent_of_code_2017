package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type node struct {
	rel     []int
	visited bool
}

func readConnectionsFromFile(f string, n map[int]*node) {
	file, err := os.Open(f)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		row := scanner.Text()
		row = strings.Replace(row, "<->", ",", -1)
		row = strings.Replace(row, " ", "", -1)
		numStrings := strings.Split(row, ",")
		var nums []int
		for i := range numStrings {
			num, _ := strconv.Atoi(numStrings[i])
			nums = append(nums, num)
		}
		n[nums[0]] = &node{nums[1:], false}
	}
}

func findNodesFromStartingPoint(n map[int]*node, start int, acc *[]int) {
	if !n[start].visited {
		n[start].visited = true
		*acc = append(*acc, start)
	}
	for _, v := range n[start].rel {
		if n[v].visited {
			continue
		}
		n[v].visited = true
		*acc = append(*acc, v)
		if len(n[v].rel) == 0 {
			continue
		} else {
			findNodesFromStartingPoint(n, v, acc)
		}
	}

}

func main() {
	var nodeMap map[int]*node
	nodeMap = make(map[int]*node)
	readConnectionsFromFile("input.txt", nodeMap)
	resultList := []int{}
	groups := 0
	for k, v := range nodeMap {
		if !v.visited {
			resultList = []int{}
			findNodesFromStartingPoint(nodeMap, k, &resultList)
			fmt.Println("Group starting with", k, " has length", len(resultList), " :", resultList)
			groups++
		}
	}
	fmt.Println("In total, there were", groups, "groups.")
}
