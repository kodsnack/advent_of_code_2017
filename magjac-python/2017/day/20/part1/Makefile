SHELL=/bin/bash -x

all: test run

debug:
	p20a.py < test.txt

debugv:
	p20a.py -v < test.txt

test:
	[ "`p20a.py < test.txt`" = 0 ]
	[ "`p20a.py < input.txt`" = 364 ]

run:
	p20a.py < input.txt

runv:
	p20a.py -v < input.txt
