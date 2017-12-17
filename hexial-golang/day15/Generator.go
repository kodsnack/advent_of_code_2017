package day15

type Generator struct {
	Factor        int64
	PreviousValue int64
	Multiple      int64
}

func (g *Generator) Next() int64 {
	if g.Multiple > 0 {
		for {
			g.PreviousValue = (g.PreviousValue * g.Factor) % 2147483647
			if g.PreviousValue%g.Multiple == 0 {
				return g.PreviousValue
			}
		}
	} else {
		g.PreviousValue = (g.PreviousValue * g.Factor) % 2147483647
		return g.PreviousValue
	}
}

func NewGenerator(factor int64, startingValue int64) *Generator {
	g := new(Generator)
	g.Factor = factor
	g.PreviousValue = startingValue
	return g
}

func NewGeneratorMultiple(factor int64, startingValue int64, multiple int64) *Generator {
	g := new(Generator)
	g.Factor = factor
	g.PreviousValue = startingValue
	g.Multiple = multiple
	return g
}
