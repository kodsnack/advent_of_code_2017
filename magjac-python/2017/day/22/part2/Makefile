SHELL=/bin/bash -x

all: test run

debug:
	p22b.py 100 < test.txt

debugv:
	p22b.py 100 -v < test.txt

debug2:
	p22b.py 10000000 < test.txt

debug2v:
	p22b.py 10000000 -v < test.txt

test:
	[ "`p22b.py 100 < test.txt`" = 26 ]
	[ "`p22b.py 10000000 < test.txt`" = 2511944 ]
	[ "`p22b.py 10000000 < input.txt`" = 2512599 ]

run:
	p22b.py 10000000 < input.txt

runv:
	p22b.py 10000000 -v < input.txt
