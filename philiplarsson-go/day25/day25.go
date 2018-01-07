package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
	"time"
)

type state struct {
	stateName string
	zeroRule  rule
	oneRule   rule
}

type rule struct {
	writeValue    int
	moveDirection string
	continueState string
}

type tape struct {
	size  int
	index int
	arr   []int
}

func init() {
	if len(os.Args) != 2 {
		fmt.Println("Please enter a filename to a file that contais the puzzle input as the first argument. ")
		fmt.Println(" Example: go run day25.go puzzle.in")
		os.Exit(1)
	}
}

func main() {
	filedata := getFileData()
	startState := getStartState(filedata)
	nbrOfSteps := getNbrOfSteps(filedata)

	states := getStates(filedata)
	part1(states, startState, nbrOfSteps)
}

func part1(states map[string]state, startState string, nbrOfSteps int) {
	tape := createTape()
	currentStateLetter := startState
	startTime := time.Now()

	for i := 0; i < nbrOfSteps; i++ {
		currentState := states[currentStateLetter]
		if tape.getValueAtIndex() == 0 {
			// zero rule
			tape.writeValue(currentState.zeroRule.writeValue)
			if currentState.zeroRule.moveDirection == "right" {
				tape.moveRight()
			} else {
				tape.moveLeft()
			}
			currentStateLetter = currentState.zeroRule.continueState
		} else {
			// one rule
			tape.writeValue(currentState.oneRule.writeValue)
			if currentState.oneRule.moveDirection == "right" {
				tape.moveRight()
			} else {
				tape.moveLeft()
			}
			currentStateLetter = currentState.oneRule.continueState
		}
	}

	var checksum int
	for _, v := range tape.arr {
		checksum += v
	}
	fmt.Printf("Checksum is: %d (took %.2f seconds).\n", checksum, time.Now().Sub(startTime).Seconds())
}

func createTape() tape {
	arr := make([]int, 4)
	return tape{
		size:  4,
		index: 1,
		arr:   arr,
	}
}

func (t *tape) moveRight() {
	t.index++
	t.checkIfWithinRange()
}

func (t *tape) moveLeft() {
	t.index--
	t.checkIfWithinRange()
}

func (t tape) getValueAtIndex() int {
	return t.arr[t.index]
}

func (t *tape) checkIfWithinRange() {
	// if we are below 0 or above max size, double size and move all to middle
	if t.index < 0 {
		oldValues := make([]int, t.size)
		for i, val := range t.arr {
			oldValues[i] = val
		}
		t.arr = make([]int, t.size*2)
		newSize := t.size * 2
		var i int
		for k := (newSize / 4); k < ((newSize / 4) + t.size); k++ {
			t.arr[k] = oldValues[i]
			i++
		}
		t.index = (newSize / 4) - 1
		t.size = newSize

	} else if t.index >= t.size {
		oldValues := make([]int, t.size)
		for i, val := range t.arr {
			oldValues[i] = val
		}
		t.arr = make([]int, t.size*2)
		newSize := t.size * 2
		var i int
		for k := newSize / 4; k < ((newSize / 4) + t.size); k++ {
			t.arr[k] = oldValues[i]
			i++
		}
		t.index = newSize - (newSize / 4)
		t.size = newSize
	}
}

func (t *tape) writeValue(value int) {
	t.arr[t.index] = value
}

func (t tape) print() {
	for _, val := range t.arr {
		fmt.Printf(" [%d] ", val)
	}
	fmt.Println("\n  Index:", t.index)
	fmt.Println("  Size:\t", t.size)
}

func getStates(data []string) map[string]state {
	states := make(map[string]state)
	startline := 3
	for i := startline; i < len(data); i += 10 {
		firstLine := data[i]
		stateName := firstLine[len(firstLine)-2 : len(firstLine)-1]
		zeroRule := createRule(i+2, data)
		oneRule := createRule(i+6, data)
		newState := state{
			stateName: stateName,
			zeroRule:  zeroRule,
			oneRule:   oneRule,
		}
		states[stateName] = newState
	}
	return states
}

func createRule(i int, data []string) rule {
	writeValueLine := data[i]
	writeValue, err := strconv.Atoi(writeValueLine[len(writeValueLine)-2 : len(writeValueLine)-1])
	if err != nil {
		fmt.Println("Could not convert", data[i], "to int. ")
		log.Fatal(err)
	}
	moveDirectionLine := data[i+1]
	var moveDirection string
	if strings.Contains(moveDirectionLine, "right") {
		moveDirection = "right"
	} else {
		moveDirection = "left"
	}

	continueStateLine := data[i+2]
	continueState := continueStateLine[len(continueStateLine)-2 : len(continueStateLine)-1]
	return rule{
		writeValue:    writeValue,
		moveDirection: moveDirection,
		continueState: continueState,
	}
}
func getStartState(filedata []string) string {
	firstLine := filedata[0]
	return firstLine[len(firstLine)-2 : len(firstLine)-1]
}

func getNbrOfSteps(filedata []string) int {
	secondLine := filedata[1]
	chunks := strings.Split(secondLine, " ")
	steps, err := strconv.Atoi(chunks[5])
	if err != nil {
		log.Fatal(err)
	}
	return steps
}

func getFileData() []string {
	filename := os.Args[1]
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0)
	for scanner.Scan() {
		line := scanner.Text()
		filedata = append(filedata, line)
	}
	return filedata
}
