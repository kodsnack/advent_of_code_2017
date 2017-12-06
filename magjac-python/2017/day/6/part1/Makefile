SHELL=/bin/bash -x

all: test run

debug:
	p6a.py -v < test.txt

test:
	[ "`p6a.py < test.txt`" = "5" ]

run:
	p6a.py < input.txt
