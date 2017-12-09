package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Node struct {
	Weight   int
	Name     string
	Children []*Node
	Parent   *Node
}

func main() {
	checkUserInput()
	rawData := getFileData()
	nodes := getNodesFromFile(rawData)
	parentNode := getParentNode(nodes)
	if os.Args[1] == "1" {
		fmt.Println("Parent node is:", parentNode.Name)
	} else if os.Args[1] == "2" {
		// part 2
		node := parentNode
		var lastNode *Node
		var correctWeight int
		for node.Children != nil {
			node = getNodeWithFaultyWeight(node)
			if node == lastNode {
				break
			}
			lastNode = node
			fmt.Println()
		}
		correctWeight = getCorrectWeightFor(*node)
		deltaWeight := getChildrenWeight(*node) - correctWeight
		fmt.Println("Correct weight is:", node.Weight-deltaWeight)
	} else if os.Args[1] == "3" {
		for _, v := range nodes {
			printNode(v)
			fmt.Println()
		}
	} else {
		fmt.Println("Enter 1 or 2 as part")
		os.Exit(1)
	}

}

func checkUserInput() {
	if len(os.Args) < 3 {
		fmt.Println("Please provide part (1 or 2) and filename as arguments. ")
		os.Exit(1)
	}
}

func getFileData() []string {
	filename := os.Args[2]
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	scanner := bufio.NewScanner(file)
	fileLines := make([]string, 0, 10)
	for scanner.Scan() {
		line := scanner.Text()
		fileLines = append(fileLines, line)
	}
	return fileLines
}

func getNodesFromFile(filedata []string) map[string]*Node {
	var nodes = make(map[string]*Node)
	for _, line := range filedata {
		nodeName := getNodeName(line)
		nodeWeight := getNodeWeight(line)
		var children []*Node
		if strings.Contains(line, "->") {
			children = getChildren(line, nodes)
		}
		var node *Node
		if val, ok := nodes[nodeName]; ok {
			// node already exists. Update that node
			node = val
			node.Weight = nodeWeight
			node.Children = children
		} else {
			// create new node
			newNode := Node{
				Name:     nodeName,
				Weight:   nodeWeight,
				Children: children,
				Parent:   nil,
			}
			node = &newNode
		}
		for _, child := range children {
			// for all children, add parent
			child.Parent = node
			nodes[child.Name] = child
		}
		nodes[node.Name] = node
	}
	return nodes
}

func getNodeName(line string) string {
	chunks := strings.Fields(line)
	return chunks[0]
}

func getNodeWeight(line string) int {
	chunks := strings.Fields(line)
	chunk := chunks[1]
	weight, err := strconv.Atoi(chunk[1 : len(chunk)-1])
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return weight
}

func getChildChunks(line string) []string {
	chunks := strings.Fields(line)
	var childChunks = make([]string, 0, 1)
	// children are the 4:th and upwards
	for i := 3; i < len(chunks); i++ {
		chunks[i] = strings.TrimSuffix(chunks[i], ",")
		childChunks = append(childChunks, chunks[i])
	}
	return childChunks
}

func getChildren(line string, nodes map[string]*Node) []*Node {
	childChunks := getChildChunks(line)
	children := make([]*Node, 0, 5)
	for _, childName := range childChunks {
		if val, ok := nodes[childName]; ok {
			// child exists
			children = append(children, val)
		} else {
			child := Node{Name: childName}
			children = append(children, &child)
		}
	}
	return children
}

func printNode(node *Node) {
	fmt.Println("Name:", node.Name)
	fmt.Println("Weight:", node.Weight)
	if node.Parent != nil {
		fmt.Println("Parent:", node.Parent.Name)
	} else {
		fmt.Println("No parent...")
	}

	if node.Children != nil {
		fmt.Println("Children:")
		for _, v := range node.Children {
			fmt.Println(" ", v.Name)
		}
		fmt.Println("Children weight:", getChildrenWeight(*node))
	} else {
		fmt.Println("No Children... ")
	}
}

func getParentNode(nodes map[string]*Node) *Node {
	var nodeParents = make(map[string]int)
	var node *Node
	for _, currentNode := range nodes {
		for currentNode.Parent != nil {
			currentNode = currentNode.Parent
		}
		node = currentNode
		nodeParents[currentNode.Name]++
	}
	if len(nodeParents) != 1 {
		fmt.Println("Found more than one parent. Something is wrong!")
		os.Exit(1)
	}
	return node
}

func getNodeWithFaultyWeight(node *Node) *Node {
	var faultyNode *Node
	if node.Children != nil {
		weightCount := make(map[int]int)
		mapWeights := make(map[int]*Node)
		for _, child := range node.Children {
			weight := getChildrenWeight(*child)
			weightCount[weight]++
			mapWeights[weight] = child
		}

		for key, val := range weightCount {
			if len(weightCount) > 1 {
				if val == 1 {
					// we have the faulty one
					faultyNode = mapWeights[key]
					return getNodeWithFaultyWeight(faultyNode)
				}
			} else {
				// Rest is correct
				return node
			}
		}
	}
	return node
}

func getChildrenWeight(node Node) int {
	var weights int
	if node.Children != nil {
		for _, child := range node.Children {
			weights += getChildrenWeight(*child)
		}
	}
	// no more childs
	return node.Weight + weights
}

func getCorrectWeightFor(node Node) int {
	var weight int
	weights := make(map[int]int)
	for _, child := range node.Parent.Children {
		currWeight := getChildrenWeight(*child)
		weights[currWeight] += 1
	}

	for key, val := range weights {
		if val > 1 {
			return key
		}
	}
	return weight
}
