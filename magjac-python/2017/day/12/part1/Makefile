SHELL=/bin/bash -x

all: test run

debug:
	p12a.py < test.txt

test:
	[ "`p12a.py < test.txt`" = 6 ]
	[ "`p12a.py < input.txt`" = 152 ]

run:
	p12a.py < input.txt

