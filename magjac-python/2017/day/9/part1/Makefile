SHELL=/bin/bash -x

all: test run

debug:
	p9a.py < test.txt

test:
	p9a.py < test.txt | diff - test-scores.txt
	[ "`p9a.py < input.txt`" = "16021" ]

run:
	p9a.py < input.txt
