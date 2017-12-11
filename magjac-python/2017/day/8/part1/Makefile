SHELL=/bin/bash -x

all: test run

debug:
	p8a.py < test.txt

test:
	[ "`p8a.py < test.txt`" = 1 ]
	[ "`p8a.py < input.txt`" = 4448 ]

run:
	p8a.py < input.txt
