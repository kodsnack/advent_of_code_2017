SHELL=/bin/bash -x

all: test run

debug:
	p21b.py 2 < test.txt

debugv:
	p21b.py 2 -v < test.txt

test:
	[ "`p21b.py 2 < test.txt`" = 12 ]
	[ "`p21b.py 18 < input.txt`" = 2425195 ]

run:
	p21b.py 18 < input.txt

runv:
	p21b.py 18 -v < input.txt
