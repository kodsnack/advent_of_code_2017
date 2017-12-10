package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"strings"
)

//////////////////////////////
////////// Typedefs //////////
//////////////////////////////

const inc = "inc"
const dec = "dec"

type operation string

type step struct {
	target  string
	change  operation
	par     int
	source  string
	cond    string
	operand int
}

/////////////////////////////
////////// Globals //////////
//////////////////////////////

var prg []step
var regs map[string]int

///////////////////////////////
////////// Functions //////////
///////////////////////////////

func parseRow(r string) step {

	var s step
	sArray := strings.Split(r, " ")
	s.target = sArray[0]
	s.change = operation(sArray[1])
	s.par, _ = strconv.Atoi(sArray[2])
	s.source = sArray[4]
	s.cond = sArray[5]
	s.operand, _ = strconv.Atoi(sArray[6])
	return s
}

func readProgramFromFile(f string) {
	file, err := os.Open(f)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	// Read all steps program and register map
	for scanner.Scan() {
		s := parseRow(scanner.Text())
		prg = append(prg, s)
	}
}

func setSign(change operation, operand int) int {
	switch change {
	case inc:
		return operand
	case dec:
		return -operand
	default:
		log.Fatal("Unknown change type in operation")
	}
	//Will never happen
	return 0
}

func execute(s step) {
	switch s.cond {
	case "!=":
		if regs[s.source] != s.operand {
			regs[s.target] += setSign(s.change, s.par)
		}
	case ">":
		if regs[s.source] > s.operand {
			regs[s.target] += setSign(s.change, s.par)
		}
	case ">=":
		if regs[s.source] >= s.operand {
			regs[s.target] += setSign(s.change, s.par)
		}
	case "<":
		if regs[s.source] < s.operand {
			regs[s.target] += setSign(s.change, s.par)
		}
	case "<=":
		if regs[s.source] <= s.operand {
			regs[s.target] += setSign(s.change, s.par)
		}
	case "==":
		if regs[s.source] == s.operand {
			regs[s.target] += setSign(s.change, s.par)
		}
	default:
		log.Fatal("Unknown condition in operation")
	}
}

func main() {
	var max = int(math.MinInt32)
	var maxReg = ""
	var globalMax = int(math.MinInt32)
	var globalMaxReg = ""

	readProgramFromFile("input.txt")
	regs = make(map[string]int) // Reset all registers
	for _, s := range prg {
		execute(s)
		for register, value := range regs {
			if globalMax < value {
				globalMax = value
				globalMaxReg = register
			}
		}
	}

	// Find final maxumum
	for register, value := range regs {
		if max < value {
			max = value
			maxReg = register
		}
	}
	fmt.Println("Maximum is stored in register", maxReg, "which holds value", max)
	fmt.Println("Maximum stored in a register during execution was in", globalMaxReg, "which held value", globalMax)
}
