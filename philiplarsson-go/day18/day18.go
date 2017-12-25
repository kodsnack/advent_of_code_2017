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

type instruction struct {
	instrType string
	x         string
	y         string
}

func main() {
	checkArgs()
	filedata := getFileData()
	instructions := getInstructions(filedata)
	// printInstructions(instructions)
	part1(instructions)
	part2(instructions)
}

func checkArgs() {
	if len(os.Args) != 2 {
		fmt.Println("Please enter filename to puzzle input as only name. ")
		fmt.Println(" Example: go run day18.go instructions.in")
		os.Exit(1)
	}
}

func part1(instructions []instruction) {
	register := make(map[string]int)
	var lastSoundPlayed int
	for i := 0; i < len(instructions); i++ {
		instr := instructions[i]
		i = doInstructionPart1(i, instr, register, &lastSoundPlayed)
	}
	fmt.Println("Part 1")
	fmt.Println(" Last sound played is", lastSoundPlayed)
}

// part2 is awful. Run until deadlock
func part2(instructions []instruction) {
	chA := make(chan int, 10000)
	chB := make(chan int, 10000)

	done := make(chan bool, 2)
	go runProgram(0, chA, chB, instructions, done)
	go runProgram(1, chB, chA, instructions, done)

	<-done
	<-done
}

func runProgram(id int, myChannel chan int, otherChannel chan int, instructions []instruction, done chan bool) {
	fmt.Println("starting go routine", id)
	register := make(map[string]int)
	register["p"] = id
	var sent int
	for i := 0; i < len(instructions); i++ {
		instr := instructions[i]
		i = doInstructionPart2(&sent, i, instr, register, myChannel, otherChannel)
		fmt.Println("program ", id, "sent:", sent)
	}
	// fmt.Println("Program", id, "sent", sent, "values. ")
	// fmt.Println("Shutting down go routine", id)
	done <- true
}

func doInstructionPart2(sent *int, i int, instr instruction, register map[string]int, myChannel chan int, otherChannel chan int) int {
	switch instr.instrType {
	case "snd":
		var x int
		if isRegister(instr.x) {
			x = register[instr.x]
		} else {
			x = convertToInt(instr.x)
		}
		*sent++
		otherChannel <- x
	case "set":
		if isRegister(instr.y) {
			register[instr.x] = register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] = y
		}
	case "add":
		if isRegister(instr.y) {
			register[instr.x] += register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] += y
		}
	case "mul":
		if isRegister(instr.y) {
			register[instr.x] *= register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] *= y
		}
	case "mod":
		if isRegister(instr.y) {
			register[instr.x] %= register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] %= y
		}
	case "rcv":
		val, more := <-myChannel
		if more {
			register[instr.x] = val
		} else {
			fmt.Println("Done.")
			i = math.MaxInt32
		}
	case "jgz":
		var x int
		if isRegister(instr.x) {
			x = register[instr.x]
		} else {
			x = convertToInt(instr.x)
		}
		if x > 0 {
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

// lastsoundplayed must be a pointer value since we want to
// change the value if we have a snd instruction
// register must not be a pointer since it is a map which is a
// reference variable
func doInstructionPart1(i int, instr instruction, register map[string]int, lastSoundPlayed *int) int {
	switch instr.instrType {
	case "snd":
		var x int
		if isRegister(instr.x) {
			x = register[instr.x]
		} else {
			x = convertToInt(instr.x)
		}
		*lastSoundPlayed = x
	case "set":
		if isRegister(instr.y) {
			register[instr.x] = register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] = y
		}
	case "add":
		if isRegister(instr.y) {
			register[instr.x] += register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] += y
		}
	case "mul":
		if isRegister(instr.y) {
			register[instr.x] *= register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] *= y
		}
	case "mod":
		if isRegister(instr.y) {
			register[instr.x] %= register[instr.y]
		} else {
			y := convertToInt(instr.y)
			register[instr.x] %= y
		}
	case "rcv":
		var x int
		if isRegister(instr.x) {
			x = register[instr.x]
		} else {
			x = convertToInt(instr.x)
		}

		if x != 0 {
			// We are done
			i = math.MaxInt32
		}
	case "jgz":
		var x int
		if isRegister(instr.x) {
			x = register[instr.x]
		} else {
			x = convertToInt(instr.x)
		}
		if x > 0 {
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

func printInstructions(instructions []instruction) {
	for i, instruction := range instructions {
		fmt.Printf("%d: %s (x:%s, y:%s)\n", i, instruction.instrType, instruction.x, instruction.y)
	}
}
