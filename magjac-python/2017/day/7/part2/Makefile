SHELL=/bin/bash -x

all: test run

debug:
	p7b.py < test.txt

test:
	[ "`p7b.py < test.txt`" = 60 ]
	[ "`p7b.py < input.txt`" = 749 ]

run:
	p7b.py < input.txt
