SHELL=/bin/bash -x

all: test run

debug:
	p14b.py flqrgnkx

debugv:
	p14b.py -v flqrgnkx

test:
	[ "`p14b.py flqrgnkx`" = 1242 ]
	[ "`p14b.py hwlqcszp`" = 1018 ]

run:
	p14b.py hwlqcszp
