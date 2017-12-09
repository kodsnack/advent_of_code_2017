package main

type Node struct {
	name     string
	weight   int
	children []*Node
}

func add(parent *Node, n *Node) {
	parent.children = append(parent.children, n)
}
