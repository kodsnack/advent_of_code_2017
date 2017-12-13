SHELL=/bin/bash -x

all: test run

debug:
	p11b.py < test.txt

test:
	[ "`p11b.py < input.txt`" = 1569 ]

run:
	p11b.py < input.txt
