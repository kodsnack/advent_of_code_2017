package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"regexp"
	"strconv"
	"strings"
)

type node struct {
	name                 string
	weight               int
	children             []string
	parent               string
	totalWeight          int
	childrenTotalWeights []int
}

func main() {
	fmt.Println("Part 1: ", topNode(input("input.txt")))

	fmt.Println("Part 2")
	findUnbalanced(input("input.txt"))
}

func topNode(nodes map[string]*node) string {
	for _, n := range nodes {
		if n.parent == "" {
			return n.name
		}
	}
	panic("couldnt find node without parent")
}

func findUnbalanced(nodes map[string]*node) {

	for _, node := range nodes {
		childrenWeights := node.childrenTotalWeights
		for i := 1; i < len(childrenWeights); i++ {
			if childrenWeights[i] != childrenWeights[0] {
				printNode(node, nodes)
				return
			}
		}
	}

	panic("couldnt find unbalanced noe")
}

func printNode(n *node, nodes map[string]*node) {
	fmt.Println("Node:", n.name)
	fmt.Println("Children:")
	for _, childName := range n.children {
		c := nodes[childName]
		fmt.Println("* ", c.name)
		fmt.Println("  ", c.totalWeight)
		fmt.Println("  ", c.weight)
	}
}

func nodeTotalWeight(nodeName string, nodes map[string]*node) int {
	childrenWeight := 0
	node := nodes[nodeName]
	for _, child := range node.children {
		childrenWeight += nodeTotalWeight(child, nodes)
	}
	node.totalWeight = node.weight + childrenWeight
	return node.totalWeight
}

func input(filename string) map[string]*node {
	nodes := make(map[string]*node)

	// Load nodes from file
	data, _ := ioutil.ReadFile(filename)
	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		re := regexp.MustCompile(`([a-z]+) \((\d+)\)(?: -> )?(.*)?`)
		matches := re.FindAllStringSubmatch(line, -1)

		name := matches[0][1]
		weight, err := strconv.Atoi(matches[0][2])
		if err != nil {
			log.Fatalln(err)
		}
		var children []string
		if matches[0][3] == "" {
			children = make([]string, 0)
		} else {
			children = strings.Split(matches[0][3], ", ")
		}

		//fmt.Printf("name: %s, weight: %d, children: %q\n", name, weight, children)
		nodes[name] = &node{
			name,
			weight,
			children,
			"",
			0,
			nil,
		}
	}

	// Set parent name
	for _, node := range nodes {
		for _, childName := range node.children {
			c := nodes[childName]
			c.parent = node.name
		}
	}

	// Calculate total weights
	topNode := topNode(nodes)
	nodeTotalWeight(topNode, nodes)

	// Collect total weights of all children
	for _, node := range nodes {
		weights := make([]int, 0)
		for _, c := range node.children {
			weights = append(weights, nodes[c].totalWeight)
		}
		node.childrenTotalWeights = weights
	}

	// Print all nodes
	// for _, node := range nodes {
	// 	fmt.Printf("%v\n", node)
	// }
	return nodes
}
