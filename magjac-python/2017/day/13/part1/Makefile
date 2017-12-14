SHELL=/bin/bash -x

all: test run

debug:
	p13a.py < test.txt

debugv:
	p13a.py -v < test.txt

test:
	[ "`p13a.py < test.txt`" = 24 ]
	[ "`p13a.py < input.txt`" = 1580 ]

run:
	p13a.py < input.txt
