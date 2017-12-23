package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	part1, _ := run(parse("input.txt"))
	fmt.Printf("Part 1: %v\n", part1)

	// new asm code using mod and jb
	_, part2 := run(parse("input2.txt"))
	fmt.Printf("Part 2: %v\n", part2)
}

func parse(file string) (code [][]string) {
	data, _ := ioutil.ReadFile(file)
	rows := strings.Split(string(data), "\n")
	for _, r := range rows {
		code = append(code, strings.Fields(r))
	}
	return
}

var registers map[string]int

func run(code [][]string) (int, int) {
	registers = make(map[string]int)
	var pos, mul int
	for pos >= 0 && pos < len(code) {
		op := code[pos]
		switch op[0] {
		case "set":
			registers[op[1]] = get(op[2])
		case "sub":
			registers[op[1]] -= get(op[2])
		case "mod":
			registers[op[1]] %= get(op[2])
		case "mul":
			registers[op[1]] *= get(op[2])
			mul++
		case "jnz":
			if get(op[1]) != 0 {
				pos += get(op[2])
				continue
			}
		case "jb":
			if get(op[1]) < 0 {
				pos += get(op[2])
				continue
			}
		default:
			panic("bad instruciton")
		}
		pos++
	}
	return mul, registers["h"]
}

func get(r string) int {
	if r[0] > '9' {
		return registers[r]
	}
	i, _ := strconv.Atoi(r)
	return i
}
