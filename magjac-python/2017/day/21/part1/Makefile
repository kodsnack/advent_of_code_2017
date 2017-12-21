SHELL=/bin/bash -x

all: test run

debug:
	p21a.py 2 < test.txt

debugv:
	p21a.py 2 -v < test.txt

test:
	[ "`p21a.py 2 < test.txt`" = 12 ]
	[ "`p21a.py 5 < input.txt`" = 167 ]

run:
	p21a.py 5 < input.txt

runv:
	p21a.py 5 -v < input.txt
