SHELL=/bin/bash -x

all: test run

debug:
	p6b.py -v < test.txt

test:
	[ "`p6b.py < test.txt`" = 4 ]

run:
	p6b.py < input.txt
