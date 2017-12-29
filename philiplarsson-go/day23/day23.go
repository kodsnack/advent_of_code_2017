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

type instruction struct {
	instrType string
	x         string
	y         string
}

func main() {
	checkArgs()
	filedata := getFileData()
	// for i, v := range filedata {
	// 	fmt.Printf("%d:%s\n", i, v)
	// }

	part1(filedata)
	part2(filedata)
}

func part1(filedata []string) {
	instructions := getInstructions(filedata)

	register := make(map[string]int)
	for ch := 'a'; ch <= 'h'; ch++ {
		register[string(ch)] = 0
	}

	var multiplied int
	for i := 0; i < len(instructions); i++ {
		instr := instructions[i]
		i = doInstructionPart1(i, instr, register, &multiplied)
	}
	fmt.Println("Part 1")
	fmt.Println(" Multiplied:", multiplied)
}

func part2(filedata []string) {
	register := make(map[string]int)
	register["b"] = 108400
	register["c"] = 125400
	register["d"] = 0
	register["e"] = 0
	register["f"] = 0
	register["g"] = 2
	register["h"] = 0

	startTime := time.Now()
	for ; register["b"] <= register["c"]; register["b"] += 17 {
		register["f"] = 1
		for register["d"] = 2; register["d"] <= register["b"]; register["d"]++ {
			if register["b"]%register["d"] != 0 {
				// if b is not evenly divisible by d there is no need to check e
				// since d * e == b
				continue
			}
			for register["e"] = 2; register["e"] <= register["b"]; register["e"]++ {
				if register["d"]*register["e"] == register["b"] {
					register["f"] = 0
					// jump out
					register["e"] = register["b"]
					register["d"] = register["b"]
				}
			}
		}
		if register["f"] == 0 {
			register["h"]++
		}
	}

	fmt.Println("Part 2")
	fmt.Printf(" H is: %d (part 2 took %.2f seconds)\n", register["h"], time.Now().Sub(startTime).Seconds())
}

func doInstructionPart1(i int, instr instruction, register map[string]int, multiplied *int) int {
	// set X Y sets register X to the value of Y.
	// sub X Y decreases register X by the value of Y.
	// mul X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
	// jnz X Y jumps with an offset of the value of Y, but only if the value of X is not zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)

	switch instr.instrType {
	case "set":
		if isRegister(instr.y) {
			register[instr.x] = register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] = y
		}
	case "sub":
		if isRegister(instr.y) {
			register[instr.x] -= register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] -= y
		}
	case "mul":
		if isRegister(instr.y) {
			register[instr.x] *= register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] *= y
		}
		(*multiplied)++
	case "jnz":
		var x int
		if isRegister(instr.x) {
			x = register[instr.x]
		} else {
			x = convertToInt(instr.x)
		}
		if x != 0 {
			if isRegister(instr.y) {
				i += register[instr.y]
			} else {
				i += convertToInt(instr.y)
			}
			// since we are incresing i after each loop we subtract once more
			i--
		}
	}
	return i
}

func isRegister(s string) bool {
	_, err := strconv.Atoi(s)
	if err != nil {
		return true
	}

	return false
}

func convertToInt(val string) int {
	valAsInt, err := strconv.Atoi(val)
	if err != nil {
		fmt.Println("Could not convert", val, "to int. ")
		log.Fatal(err)
	}
	return valAsInt
}

func getInstructions(filedata []string) []instruction {
	instructions := make([]instruction, 0)

	for _, line := range filedata {
		chunks := strings.Fields(line)
		instr := instruction{}
		if len(chunks) == 3 {
			instr = instruction{instrType: chunks[0], x: chunks[1], y: chunks[2]}
		} else if len(chunks) == 2 {
			instr = instruction{instrType: chunks[0], x: chunks[1]}
		}
		instructions = append(instructions, instr)
	}
	return instructions
}

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please provide a filename to the puzzle input as first and only argument. ")
		fmt.Println(" Example: go run day23.go puzzle.in")
		os.Exit(1)
	}
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
