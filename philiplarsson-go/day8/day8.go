package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type Instruction struct {
	Register  string
	Increase  bool
	Amount    int
	Condition string
}

func main() {
	checkUserInput()
	fileData := getFileData()
	instructions := getInstructions(fileData)
	register, maxValueInRegister := runInstructions(instructions)
	largestValue := getLargestValueFrom(register)
	fmt.Println("The largest value is:", largestValue)
	fmt.Println("The largest value ever held in register was:", maxValueInRegister)
}

func checkUserInput() {
	if len(os.Args) < 2 {
		fmt.Println("Please provide filename as argument.")
		os.Exit(1)
	}
}

func getFileData() []string {
	fileName := os.Args[1]
	file, err := os.Open(fileName)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	scanner := bufio.NewScanner(file)
	filedata := make([]string, 0, 10)
	for scanner.Scan() {
		line := scanner.Text()
		filedata = append(filedata, line)
	}
	return filedata
}

func getInstructions(data []string) []Instruction {
	instructions := make([]Instruction, 0, 10)

	for _, line := range data {
		register := getRegisterFromLine(line)
		increase := getIncreaseBoolFromLine(line)
		amount := getAmountFromLine(line)
		condition := getConditionFromLine(line)

		instruction := Instruction{
			Register:  register,
			Increase:  increase,
			Amount:    amount,
			Condition: condition,
		}
		instructions = append(instructions, instruction)
	}

	return instructions
}

func getRegisterFromLine(line string) string {
	chunks := strings.Fields(line)
	return chunks[0]
}

func getIncreaseBoolFromLine(line string) bool {
	chunks := strings.Fields(line)
	return chunks[1] == "inc"
}

func getAmountFromLine(line string) int {
	chunks := strings.Fields(line)
	amount, err := strconv.Atoi(chunks[2])
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return amount
}

func getConditionFromLine(line string) string {
	chunks := strings.Fields(line)
	return strings.Join(chunks[4:len(chunks)], " ")
}

func runInstructions(instructions []Instruction) (map[string]int, int) {
	var register = make(map[string]int)
	var maxValueInRegister = math.MinInt32
	for _, instr := range instructions {
		// if conditionIsTrue(instr.Condition, register) {
		if instr.conditionIsTrue(register) {
			if instr.Increase {
				register[instr.Register] += instr.Amount
			} else {
				register[instr.Register] -= instr.Amount
			}
			// Part 2
			if register[instr.Register] > maxValueInRegister {
				maxValueInRegister = register[instr.Register]
			}
		}
	}
	return register, maxValueInRegister
}

// func conditionIsTrue(condition string, register map[string]int) bool {
func (instr Instruction) conditionIsTrue(register map[string]int) bool {
	chunks := strings.Fields(instr.Condition)
	target := chunks[0]
	operator := chunks[1]
	// amount is at index [2] so we can use getAmountFromLine again
	amount := getAmountFromLine(instr.Condition)

	targetValue := register[target]
	switch operator {
	case "<":
		return targetValue < amount
	case ">":
		return targetValue > amount
	case "<=":
		return targetValue <= amount
	case ">=":
		return targetValue >= amount
	case "!=":
		return targetValue != amount
	case "==":
		return targetValue == amount
	}
	return false
}

func getLargestValueFrom(register map[string]int) int {
	largestValue := math.MinInt32
	for _, val := range register {
		if val > largestValue {
			largestValue = val
		}
	}
	return largestValue
}
