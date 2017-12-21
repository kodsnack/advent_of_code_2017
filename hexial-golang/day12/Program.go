package day12

type Program struct {
	ID    int
	Pipes []*Program
}

func (p *Program) AddPipe(child *Program) {
	p.Pipes = append(p.Pipes, child)
}

func (p *Program) Group() map[int]*Program {
	group := make(map[int]*Program, 0)
	p._group(group)
	//
	//
	return group
}

func (p *Program) _group(g map[int]*Program) {
	if _, ok := g[p.ID]; !ok {
		g[p.ID] = p
		for _, c := range p.Pipes {
			c._group(g)
		}
	}
}
