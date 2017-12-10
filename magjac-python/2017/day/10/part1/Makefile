SHELL=/bin/bash -x

all: test run

debug:
	p10a.py 5 < test.txt

test:
	[ "`p10a.py 5 < test.txt`" = 12 ]
	[ "`p10a.py 256 < input.txt`" = 11413 ]

run:
	p10a.py 256 < input.txt
