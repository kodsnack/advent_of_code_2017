PROGRAMS=$(wildcard day*.scala)

default: runall

runall: $(foreach day,$(PROGRAMS),$(patsubst day%.scala,run%,$(day)))

run%: day%.scala
	scala $< < day$*.in
