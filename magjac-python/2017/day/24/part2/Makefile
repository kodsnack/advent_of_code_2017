SHELL=/bin/bash -x

all: test run

debug:
	p24b.py < test.txt

debugv:
	p24b.py -v < test.txt

test:
	[ "`p24b.py < test.txt`" = 19 ]
	[ "`p24b.py < input.txt`" = 1824 ]

run:
	p24b.py < input.txt
