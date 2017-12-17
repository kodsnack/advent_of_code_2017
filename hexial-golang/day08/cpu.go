package day08

import (
	"AdventOfCode2017/util"
	"strconv"
)

type CPU struct {
	Registers    map[string]int
	cs           [][]string
	alltTimeHigh int
}

func (cpu *CPU) execute() {
	for _, l := range cpu.cs {
		//
		// Check
		if len(l) != 7 {
			util.LogPanicf("Expected len 7. %s", l)
		}
		if l[3] != "if" {
			util.LogPanicf("%s is not if", l[3])
		}
		if_reg := l[4]
		if_cond := l[5]
		if_val, err := strconv.Atoi(l[6])
		if err != nil {
			util.LogPanicf("Unable to atoi %s", l[6])
		}
		dst_reg := l[0]
		dst_op := l[1]
		dst_val, err := strconv.Atoi(l[2])
		if err != nil {
			util.LogPanicf("Unable to atoi %s", l[2])
		}
		//
		// IF
		cond := false
		switch if_cond {
		case ">":
			cond = cpu.LoadReg(if_reg) > if_val
		case "<":
			cond = cpu.LoadReg(if_reg) < if_val
		case "==":
			cond = cpu.LoadReg(if_reg) == if_val
		case ">=":
			cond = cpu.LoadReg(if_reg) >= if_val
		case "<=":
			cond = cpu.LoadReg(if_reg) <= if_val
		case "!=":
			cond = cpu.LoadReg(if_reg) != if_val
		default:
			util.LogPanicf("Unhandled %s", if_cond)
		}
		if cond {
			switch dst_op {
			case "inc":
				cpu.StoreReg(dst_reg, cpu.LoadReg(dst_reg)+dst_val)
			case "dec":
				cpu.StoreReg(dst_reg, cpu.LoadReg(dst_reg)-dst_val)
			default:
				util.LogPanicf("Unhandled %s", dst_op)
			}
		}
	}
}

func NewCPU(filename string) *CPU {
	cpu := new(CPU)
	cpu.Registers = make(map[string]int)
	cpu.cs = util.FileAsWordArray(filename)
	cpu.execute()
	return cpu
}

func (cpu *CPU) LoadReg(reg string) int {
	val, ok := cpu.Registers[reg]
	if !ok {
		return 0
	}
	return val
}

func (cpu *CPU) StoreReg(reg string, val int) {
	cpu.Registers[reg] = val
	if val > cpu.alltTimeHigh {
		cpu.alltTimeHigh = val
	}
}

func (cpu *CPU) LargestRegisterValue() int {
	var max int
	for reg := range cpu.Registers {
		if cpu.LoadReg(reg) > max {
			max = cpu.LoadReg(reg)
		}
	}
	return max
}
