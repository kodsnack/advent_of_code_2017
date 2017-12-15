SHELL=/bin/bash -x

all: test run

debug:
	p14a.py flqrgnkx

debugv:
	p14a.py -v flqrgnkx

test:
	[ "`p14a.py flqrgnkx`" = 8108 ]
	[ "`p14a.py hwlqcszp`" = 8304 ]

run:
	p14a.py hwlqcszp
