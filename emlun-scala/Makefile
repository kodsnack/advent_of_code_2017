PROGRAMS=$(wildcard day*.scala)

default: runall

clean:
	rm *.class

runall: $(foreach day,$(PROGRAMS),$(patsubst day%.scala,run%,$(day)))
timeall: $(foreach day,$(PROGRAMS),$(patsubst day%.scala,time%,$(day)))

run%: day%.scala
	scala $< < day$*.in

Day%.class: day%.scala
	scalac $<

time%: Day%.class
	time scala $(subst .class,,$<) < day$*.in
