SHELL=/bin/bash -x

all: test run

debug:
	p18a.py < test.txt

debugv:
	p18a.py -v < test.txt

test:
	[ "`p18a.py < test.txt`" = 4 ]
	[ "`p18a.py < input.txt`" = 3188 ]

run:
	p18a.py < input.txt

runv:
	p18a.py -v < input.txt
