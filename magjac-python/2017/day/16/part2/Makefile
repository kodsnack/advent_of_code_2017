SHELL=/bin/bash -x

all: test run

debug:
	p16b.py abcde 2 < test.txt

debugv:
	p16b.py abcde 2 -v < test.txt

test:
	[ "`p16b.py abcde 2 < test.txt`" = ceadb ]
	[ "`p16b.py abcdefghijklmnop 1000000000 < input.txt`" = fmpanloehgkdcbji ]

run:
	p16b.py abcdefghijklmnop 1000000000 < input.txt

runv:
	p16b.py -v abcdefghijklmnop 1000000000 < input.txt
