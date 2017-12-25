package day07

import (
	"AdventOfCode2017/util"
	"fmt"
	"strconv"
	"strings"
)

type Tree struct {
	Nodes []*TreeNode
}

type TreeNode struct {
	Name          string
	Weight        int
	Children      []*TreeNode
	ChildrenNames []string
	Parent        *TreeNode
}

func (this Tree) FindBase() *TreeNode {
	for _, node := range this.Nodes {
		if len(node.Children) > 0 && node.Parent == nil {
			return node
		}
	}
	return nil
}

func (this *TreeNode) DebugInfo() string {
	return fmt.Sprintf("%s (%d) (%d)", this.Name, this.Weight, this.WeightWithChildren())
}

func (this *TreeNode) Balance() int {
	//util.LogInfof("Balance : %s", this.Name)
	for _, child := range this.Children {
		n := child.Balance()
		if n > 0 {
			return n
		}
	}
	var incorrect *TreeNode
	var prev *TreeNode
	var wanted int
	if len(this.Children) > 1 {
		prev = this.Children[0]
		for i := 1; i < len(this.Children); i++ {
			curr := this.Children[i]
			if incorrect == nil && prev.WeightWithChildren() != curr.WeightWithChildren() && i == len(this.Children)-1 {
				incorrect = curr
				wanted = prev.WeightWithChildren()
			} else if incorrect == nil && prev.WeightWithChildren() != curr.WeightWithChildren() {
				incorrect = prev
				wanted = curr.WeightWithChildren()
			} else if incorrect != nil {
				if curr.WeightWithChildren() != prev.WeightWithChildren() {
					if curr.WeightWithChildren() != incorrect.WeightWithChildren() {
						incorrect = curr
						wanted = prev.WeightWithChildren()
					} else {
						incorrect = prev
						wanted = curr.WeightWithChildren()
					}
				}
			}
			prev = curr
			if incorrect != nil {
				util.LogInfof("Balance : %d : prev=%s : curr=%s : incorrect=%s", i, prev.DebugInfo(), curr.DebugInfo(), incorrect.DebugInfo())
			} else {
				//util.LogInfof("Balance : %d : prev=%s : curr=%s", i, prev.DebugInfo(), curr.DebugInfo())
			}
		}
	}
	if incorrect != nil {
		util.LogInfof("************************")
		for _, child := range this.Children {
			util.LogInfof("%s", child.DebugInfo())
		}
		util.LogInfof("------------------------")
		incorrect.Weight -= (incorrect.WeightWithChildren() - wanted)
		util.LogInfof("%s", incorrect.DebugInfo())
		return incorrect.Weight
	}
	return 0
}

func (this *TreeNode) WeightWithChildren() int {
	w := this.Weight
	for _, child := range this.Children {
		w += child.WeightWithChildren()
	}
	return w
}

func (this *TreeNode) WeightOfChildren() int {
	sum := 0
	for _, child := range this.Children {
		sum += child.Weight
	}
	return sum
}

func Load(filename string) Tree {
	var err error
	tree := Tree{}

	//
	// Parse file
	rows := util.FileAsLineArray(filename)
	for _, row := range rows {
		rowItems := strings.Split(row, " ")
		node := new(TreeNode)
		node.Name = rowItems[0]
		node.Weight, err = strconv.Atoi(rowItems[1][1 : len(rowItems[1])-1])
		if err != nil {
			panic(err)
		}
		for i := 3; i < len(rowItems); i++ {
			if strings.HasSuffix(rowItems[i], ",") {
				node.ChildrenNames = append(node.ChildrenNames, rowItems[i][:len(rowItems[i])-1])
			} else {
				node.ChildrenNames = append(node.ChildrenNames, rowItems[i])
			}
		}
		tree.Nodes = append(tree.Nodes, node)
	}

	//
	// Build tree
	for _, node := range tree.Nodes {
		for _, childName := range node.ChildrenNames {
			for _, n := range tree.Nodes {
				if n.Name == childName {
					if n.Parent != nil {
						util.LogPanicf("Didn't except more than one parent")
					}
					node.Children = append(node.Children, n)
					n.Parent = node
				}
			}
		}
	}
	return tree
}
