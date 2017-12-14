SHELL=/bin/bash -x

all: test run

debug:
	p13b.py < test.txt

debugv:
	p13b.py -v < test.txt

debug-slow:
	p13b-slow.py < test.txt

debug-slowv:
	p13b-slow.py -v < test.txt

test:
	[ "`p13b.py < test.txt`" = 10 ]
	[ "`p13b.py < input.txt`" = 3943252 ]

test-slow:
	[ "`p13b.py 3943251 < input.txt`" = 3943252 ]

run:
	p13b.py < input.txt

runv:
	p13b.py -v < input.txt

run-slow:
	p13b-slow.py 3943251 < input.txt
