SHELL=/bin/bash -x

all: test run

debug:
	p9b.py < test2.txt

test:
	p9b.py < test2.txt | diff - test2-garbage-counts.txt
	[ "`p9b.py < input.txt`" = "7685" ]

run:
	p9b.py < input.txt
