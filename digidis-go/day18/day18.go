package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

func main() {
	f, _ := os.Open("input.txt")
	defer f.Close()
	scanner := bufio.NewScanner(f)
	rows := []string{}
	for scanner.Scan() {
		row := scanner.Text()
		rows = append(rows, row)
	}

	fmt.Printf("Part 1: %v\n", run1(rows))

	chan0in := make(chan int, 1000)
	chan1in := make(chan int, 1000)
	sends := make([]int, 2)

	go run2(rows, 0, chan0in, chan1in, &sends[0])
	go run2(rows, 1, chan1in, chan0in, &sends[1])

	for {
		time.Sleep(100 * time.Millisecond)
		if len(chan0in) == 0 && len(chan1in) == 0 {
			// most likely deadlock
			fmt.Printf("Sends %v\n", sends)
			fmt.Printf("Part 2: %v\n", sends[1])
			break
		}
	}
}

func run1(code []string) int {
	var pos, sound int
	registers := make(map[string]int)

	for pos >= 0 && pos < len(code) {
		op := strings.Fields(code[pos])
		switch op[0] {
		case "snd":
			sound = get(registers, op[1])
		case "set":
			registers[op[1]] = get(registers, op[2])
		case "add":
			registers[op[1]] = registers[op[1]] + get(registers, op[2])
		case "mul":
			registers[op[1]] = registers[op[1]] * get(registers, op[2])
		case "mod":
			registers[op[1]] = registers[op[1]] % get(registers, op[2])
		case "rcv":
			if get(registers, op[1]) != 0 {
				return sound
			}
		case "jgz":
			if get(registers, op[1]) > 0 {
				pos += get(registers, op[2])
				continue
			}
		default:
			panic("bad instruciton")
		}
		pos++
	}
	return 0
}

func run2(code []string, id int, in chan int, out chan int, sends *int) {
	pos := 0
	registers := make(map[string]int)
	registers["p"] = id

	for pos >= 0 && pos < len(code) {
		op := strings.Fields(code[pos])
		switch op[0] {
		case "snd":
			out <- get(registers, op[1])
			*sends++
		case "set":
			registers[op[1]] = get(registers, op[2])
		case "add":
			registers[op[1]] = registers[op[1]] + get(registers, op[2])
		case "mul":
			registers[op[1]] = registers[op[1]] * get(registers, op[2])
		case "mod":
			registers[op[1]] = registers[op[1]] % get(registers, op[2])
		case "rcv":
			a := <-in
			registers[op[1]] = a
		case "jgz":
			if get(registers, op[1]) > 0 {
				pos += get(registers, op[2])
				continue
			}
		default:
			panic("bad instruciton")
		}
		pos++
	}
}

func get(registers map[string]int, r string) int {
	i, err := strconv.Atoi(r)
	if err == nil {
		return i
	}
	return registers[r]
}
