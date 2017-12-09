package day9

type stackItem struct {
	children []*stackItem
	parent   *stackItem
}

func Part(stream string, part int) int {
	index := -1

	root := stackItem{}
	stack := &root

	inGarbage := false

	garbageCounter := 0

	for {
		index++
		if index >= len(stream) {
			break
		}

		char := stream[index]

		// Skip next char
		if char == '!' {
			index++
			continue
		}

		if !inGarbage && char == '<' {
			inGarbage = true
			continue
		}

		if inGarbage && char == '>' {
			inGarbage = false
			continue
		}

		if inGarbage {
			garbageCounter++
			continue
		}

		// push the stack
		if !inGarbage && char == '{' {
			next := &stackItem{
				parent: stack,
			}
			stack.children = append(stack.children, next)
			stack = next
			continue
		}

		// pop the stack
		if !inGarbage && char == '}' {
			stack = stack.parent
			continue
		}
	}

	if part == 1 {
		return summer(&root, 0)
	}

	return garbageCounter
}

func summer(stack *stackItem, level int) int {
	sum := level
	for _, c := range stack.children {
		sum += summer(c, level+1)
	}
	return sum
}
