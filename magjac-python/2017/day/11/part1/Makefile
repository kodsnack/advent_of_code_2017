SHELL=/bin/bash -x

all: test run

debug:
	p11a.py < test.txt

test:
	p11a.py < test.txt | diff - test-distances.txt
	[ "`p11a.py < input.txt`" = 834 ]

run:
	p11a.py < input.txt
