PROGRAMS=$(wildcard day*.hs)

default: runall

runall: $(foreach day,$(PROGRAMS),$(patsubst day%.hs,run%,$(day)))

day%: day%.hs
	ghc --make $<

run%: day%
	./$< < $<.in
