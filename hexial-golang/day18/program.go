package day18

type Program struct {
	PID             int
	Queue           *Queue
	CPU             *CPU
	operatingSystem *OperatingSystem
	SndCount        int
	Waiting         bool
}

func (p *Program) Other() *Program {
	var o int
	if p.PID == 0 {
		o = 1
	} else {
		o = 0
	}
	return p.operatingSystem.Programs[o]
}

func NewProgram(pid int, filename string, operatingSystem *OperatingSystem) *Program {
	p := new(Program)
	p.PID = pid
	p.CPU = NewCPU(filename, p)
	p.Queue = NewQueue()
	p.operatingSystem = operatingSystem
	p.CPU.StoreReg("p", p.PID)
	return p
}
