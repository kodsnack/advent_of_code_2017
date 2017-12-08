package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

type condition struct {
	variableName string
	comparator   string
	value        int
}

func (c condition) evaluate(m memory) bool {
	value := m.get(c.variableName)
	switch c.comparator {
	case "==":
		return value == c.value
	case ">":
		return value > c.value
	case "<":
		return value < c.value
	case ">=":
		return value >= c.value
	case "<=":
		return value <= c.value
	case "!=":
		return value != c.value
	default:
		log.Fatalln("Invalid comparator:", c.comparator)
	}
	return false
}

type instruction struct {
	variableName string
	increment    int
	condition    condition
}

type memory map[string]int

var highestMemoryValue int

func (m memory) get(variableName string) int {
	value, ok := m[variableName]
	if ok {
		return value
	}
	m.set(variableName, 0)
	return 0
}

func (m memory) set(variableName string, value int) {
	if len(m) == 0 || value > highestMemoryValue {
		highestMemoryValue = value
	}

	m[variableName] = value
}

func (m memory) increment(variableName string, increment int) {
	curr := m.get(variableName)
	m.set(variableName, curr+increment)
}

func execute(instructions []instruction) map[string]int {
	memory := make(memory)
	for _, instruction := range instructions {
		if instruction.condition.evaluate(memory) {
			memory.increment(instruction.variableName, instruction.increment)
		}
	}
	return memory
}

func highestVariableValue(m memory) int {
	firstValue := true
	max := 0
	for _, value := range m {
		if firstValue {
			max = value
			firstValue = false
			continue
		}

		if value > max {
			max = value
		}
	}
	return max
}

func main() {
	fmt.Println("Part 1:", highestVariableValue(execute(input("input.txt"))))
	fmt.Println("Part 2:", highestMemoryValue)
}

func input(filename string) []instruction {
	//b inc 5 if a > 1
	//0  1  2  3 4 5 6
	instructions := make([]instruction, 0)

	data, _ := ioutil.ReadFile(filename)
	lines := strings.Split(string(data), "\n")

	for _, line := range lines {
		parts := strings.Fields(line)
		increment, err := strconv.Atoi(parts[2])
		if err != nil {
			log.Fatalln("Coudln't convert to int:", parts[2])
		}
		if parts[1] == "dec" {
			increment *= -1
		}

		conditionValue, err := strconv.Atoi(parts[6])
		if err != nil {
			log.Fatalln("Coudln't convert to int:", parts[6])
		}
		instructions = append(instructions, instruction{
			variableName: parts[0],
			increment:    increment,
			condition: condition{
				variableName: parts[4],
				comparator:   parts[5],
				value:        conditionValue,
			},
		})

	}
	return instructions
}
