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

func weight(n *node) int {

	w := 0
	for _, name := range (*n).children {
		w += nodeMap[name].weight
	}
	return (*n).weight + w
}

func main() {

	nodeMap = make(map[string]*node)

	file, err := os.Open("input1.txt")
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

	// Add up total weight for each node's subnodes (includes node's weight)
	for _, n := range nodeMap {
		n.weightOfBranch = weight(n)
	}

	// Print all unbalanced nodes
	for name, n := range nodeMap {

		if len(n.children) > 1 { // More than 1 child - could be unbalanced
			unbalanced := false
			first := nodeMap[n.children[0]].weightOfBranch
			for i := 1; i < len(n.children); i++ {
				if nodeMap[n.children[i]].weightOfBranch != first {
					unbalanced = true
				}
			}
			if unbalanced {
				fmt.Printf("Unbalanced branch. Node %s had children ", name)
				for i := 0; i < len(n.children); i++ {
					fmt.Printf("(%s: %d) ", n.children[i], nodeMap[n.children[i]].weightOfBranch)
				}
				fmt.Println()
			}
		}
		//fmt.Println(name, " has total weight ", n.weightOfBranch)
	}

	fmt.Println(nodeMap["ahnofa"])
	//rootEntry := nodeMap["ahnofa"]

}
