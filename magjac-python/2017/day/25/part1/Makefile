SHELL=/bin/bash -x

all: test run

debug:
	p25a.py < test.txt

debugv:
	p25a.py -v < test.txt

test:
	[ "`p25a.py < test.txt`" = 3 ]
	[ "`p25a.py < input.txt`" = 2870 ]

run:
	p25a.py < input.txt
