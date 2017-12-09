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
	weight         int
	weightOfBranch int
	children       []string
}

var nodeMap map[string]*node

func parseRow(s string) (string, int, []string) {
	var m []string
	words := strings.Split(s, " ")
	r := words[0]
	var l []string
	w, _ := strconv.Atoi(words[1][1 : len(words[1])-1])
	if len(words) > 3 {
		l = words[3:]
		for _, s := range l {
			t := strings.Replace(s, ",", "", -1)
			m = append(m, t)
		}
	}
	return r, w, m
}

func stringInArray(s string, a []string) bool {
	for _, s2 := range a {
		if s == s2 {
			return true
		}
	}
	return false
}

func findParent(name string) string {
	for k, v := range nodeMap {
		if stringInArray(name, v.children) {
			return k
		}
	}
	return ""
}

func findRoot() string {

	for k := range nodeMap {
		if findParent(k) == "" {
			return k
		}
	}
	return "error!"
}

func setWeights(startName string) int {
	if len(nodeMap[startName].children) == 0 {
		nodeMap[startName].weightOfBranch = nodeMap[startName].weight
		return nodeMap[startName].weight
	} else {
		w := nodeMap[startName].weight
		for _, n := range nodeMap[startName].children {
			w += setWeights(n)
		}
		nodeMap[startName].weightOfBranch = w
		return w
	}
}

func printTree(name string) {
	printNode(name)
	if len(nodeMap[name].children) > 0 {
		for i := 0; i < len(nodeMap[name].children); i++ {
			printTree(nodeMap[name].children[i])
		}
	}
}

func printNode(name string) {

	fmt.Printf("Node '%s' weight %d, total weight %d and has ", name, nodeMap[name].weight, nodeMap[name].weightOfBranch)
	if len(nodeMap[name].children) == 0 {
		fmt.Printf("no children.\n")
	} else {
		fmt.Printf("%d children:\n", len(nodeMap[name].children))
		for i := 0; i < len(nodeMap[name].children); i++ {
			fmt.Printf("  '%s', weight %d, total weight %d\n", nodeMap[name].children[i], nodeMap[nodeMap[name].children[i]].weight, nodeMap[nodeMap[name].children[i]].weightOfBranch)
		}
		fmt.Println()
	}
}

func printUnbalanced() {
	for s := range nodeMap {
		if len(nodeMap[s].children) > 1 {
			for i := 1; i < len(nodeMap[s].children); i++ {
				if nodeMap[nodeMap[s].children[i-1]].weightOfBranch != nodeMap[nodeMap[s].children[i]].weightOfBranch {
					fmt.Printf("Unbalanced node:\n")
					printNode(s)
				}
			}
		}
	}
}

func main() {

	nodeMap = make(map[string]*node)

	file, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	// Read all nodes into array
	for scanner.Scan() {
		n, w, c := parseRow(scanner.Text())
		nodeMap[n] = &node{w, 0, c}
	}

	root := findRoot()
	fmt.Printf("The root node is %s\n", root)
	setWeights(root)
	printUnbalanced()
}
