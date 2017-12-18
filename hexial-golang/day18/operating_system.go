package day18

import (
	"time"
)

type OperatingSystem struct {
	Programs []*Program
	Part     int
}

func NewOperatingSystem(filename string, instances int) *OperatingSystem {
	operatingSystem := new(OperatingSystem)
	operatingSystem.Programs = make([]*Program, instances)
	for i := 0; i < instances; i++ {
		operatingSystem.Programs[i] = NewProgram(i, filename, operatingSystem)
	}
	return operatingSystem
}

func (operatingSystem *OperatingSystem) PartOne() int {
	operatingSystem.Part = 1
	operatingSystem.Programs[0].CPU.execute()
	return operatingSystem.Programs[0].CPU.myAnswer
}

func (operatingSystem *OperatingSystem) PartTwo() int {
	operatingSystem.Part = 2
	p0 := operatingSystem.Programs[0]
	p1 := operatingSystem.Programs[1]
	go p0.CPU.execute()
	go p1.CPU.execute()
	for p0.CPU.Running && p1.CPU.Running {
		time.Sleep(time.Second)
	}
	return p1.SndCount
}
