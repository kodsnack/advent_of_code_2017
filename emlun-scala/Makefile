PROGRAMS=$(wildcard day*.scala)

default: runall

clean:
	rm *.class

runall: $(foreach day,$(PROGRAMS),$(patsubst day%.scala,run%,$(day)))

run%: day%.scala
	scala $< < day$*.in
