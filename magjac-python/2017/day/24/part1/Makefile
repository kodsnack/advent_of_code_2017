SHELL=/bin/bash -x

all: test run

debug:
	p24a.py < test.txt

debugv:
	p24a.py -v < test.txt

test:
	[ "`p24a.py < test.txt`" = 31 ]
	[ "`p24a.py < input.txt`" = 1906 ]

run:
	p24a.py < input.txt
