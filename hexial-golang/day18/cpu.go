package day18

import (
	"AdventOfCode2017/util"
	"fmt"
	"reflect"
	"strconv"
	"strings"
)

type CPU struct {
	Registers map[string]int
	cs        []string
	ip        int
	lastFreq  int
	myAnswer  int
	Running   bool
	Program   *Program
}

func (cpu *CPU) valueOf(s string) int {
	i, err := strconv.Atoi(s)
	if err == nil {
		return i
	}
	return cpu.LoadReg(s)
}

func (cpu *CPU) Prefix() string {
	return fmt.Sprintf("PID[%d]IP[%02d]", cpu.Program.PID, cpu.ip)
}

func (cpu *CPU) InstrSET(i []string) {
	cpu.StoreReg(i[1], cpu.valueOf(i[2]))
	cpu.ip++
}

func (cpu *CPU) InstrADD(i []string) {
	cpu.StoreReg(i[1], cpu.LoadReg(i[1])+cpu.valueOf(i[2]))
	cpu.ip++
}

func (cpu *CPU) InstrMUL(i []string) {
	cpu.StoreReg(i[1], cpu.LoadReg(i[1])*cpu.valueOf(i[2]))
	cpu.ip++
}

func (cpu *CPU) InstrMOD(i []string) {
	cpu.StoreReg(i[1], cpu.LoadReg(i[1])%cpu.valueOf(i[2]))
	cpu.ip++
}

func (cpu *CPU) InstrSND(i []string) {
	if cpu.Program.operatingSystem.Part == 1 {
		cpu.lastFreq = cpu.valueOf(i[1])
	} else {
		util.LogDebugf("%s : Sending %d to %d", cpu.Prefix(), cpu.valueOf(i[1]), cpu.Program.Other().PID)
		cpu.Program.Other().Queue.Push(cpu.valueOf(i[1]))
		cpu.Program.SndCount++
	}
	cpu.ip++
}

func (cpu *CPU) InstrRCV(i []string) {
	if cpu.Program.operatingSystem.Part == 1 {
		if cpu.LoadReg(i[1]) > 0 {
			cpu.myAnswer = cpu.lastFreq
		}
	} else {
		//util.LogDebugf("PID: %d : InstrRCV", cpu.Program.PID)
		done := false
		for !done {
			//util.LogDebugf("%s : Waiting", cpu.Prefix())
			for cpu.Program.Queue.Empty() {
				cpu.Program.Waiting = true
				//util.LogDebugf("%t : %t", cpu.Program.Waiting, cpu.Program.Other().Waiting)
				if cpu.Program.Other().Waiting {
					//
					// Deadlock
					cpu.Stop()
					cpu.Program.Other().CPU.Stop()
				}
				if !cpu.Running {
					return
				}
			}
			cpu.Program.Waiting = false
			v := cpu.Program.Queue.Pop()
			util.LogDebugf("%s : Received : %d", cpu.Prefix(), v)
			cpu.StoreReg(i[1], v)
			done = true
		}
	}
	cpu.ip++
}

func (cpu *CPU) InstrJGZ(i []string) {
	if cpu.valueOf(i[1]) > 0 {
		v := cpu.valueOf(i[2])
		//util.LogInfof("%s : i[2]=%s : v=%d", cpu.Prefix(), i[2], v)
		cpu.ip += v
	} else {
		cpu.ip++
	}
}

func (cpu *CPU) execute() {
	cpu.State()
	for cpu.Running {
		instr := strings.Split(cpu.cs[cpu.ip], " ")
		util.LogDebugf("%s : instruction : %v", cpu.Prefix(), instr)
		inputs := make([]reflect.Value, 1)
		inputs[0] = reflect.ValueOf(instr)
		reflect.ValueOf(cpu).MethodByName(fmt.Sprintf("Instr%s", strings.ToUpper(instr[0]))).Call(inputs)
		if cpu.Program.operatingSystem.Part == 1 && cpu.myAnswer > 0 {
			cpu.Stop()
		}
		if cpu.ip < 0 && cpu.ip >= len(cpu.cs) {
			cpu.Stop()
		}
	}
	cpu.Stop()
	util.LogDebugf("%s : CPU stopped", cpu.Prefix())
	cpu.State()
}

func (cpu *CPU) Stop() {
	//
	// Put IP to end of program to make it stop
	cpu.ip = len(cpu.cs)
	cpu.Running = false
}

func NewCPU(filename string, program *Program) *CPU {
	cpu := new(CPU)
	cpu.Running = true
	cpu.Program = program
	cpu.Registers = make(map[string]int)
	cpu.cs = util.FileAsLineArray(filename)
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
}

func (cpu *CPU) State() {
	if util.Debug {
		util.LogDebugf("%s : **** State ****", cpu.Prefix())
		util.LogDebugf("%s : Registers:", cpu.Prefix())
		for r := range cpu.Registers {
			util.LogDebugf("%s : %s : %d", cpu.Prefix(), r, cpu.Registers[r])
		}
	}
}
