SHELL=/bin/bash -x

all: test run

debug:
	p20b.py < test.txt

debugv:
	p20b.py -v < test.txt

test:
	[ "`p20b.py < test.txt`" = 1 ]
	[ "`p20b.py < input.txt`" = 420 ]

run:
	p20b.py < input.txt

runv:
	p20b.py -v < input.txt
