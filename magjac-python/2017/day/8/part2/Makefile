SHELL=/bin/bash -x

all: test run

debug:
	p8b.py < test.txt

test:
	[ "`p8b.py < test.txt`" = 10 ]
	[ "`p8b.py < input.txt`" = 6582 ]

run:
	p8b.py < input.txt
