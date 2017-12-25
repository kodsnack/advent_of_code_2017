SHELL=/bin/bash -x

all: test run

debug:
	p22a.py 70 < test.txt

debugv:
	p22a.py 70 -v < test.txt

debug2:
	p22a.py 10000 < test.txt

debug2v:
	p22a.py 10000 -v < test.txt

test:
	[ "`p22a.py 70 < test.txt`" = 41 ]
	[ "`p22a.py 10000 < test.txt`" = 5587 ]
	[ "`p22a.py 10000 < input.txt`" = 5433 ]

run:
	p22a.py 10000 < input.txt

runv:
	p22a.py 10000 -v < input.txt
