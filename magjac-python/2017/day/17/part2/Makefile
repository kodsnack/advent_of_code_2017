SHELL=/bin/bash -x

all: test run

debug0:
	p17b.py 3 10

debug:
	p17b.py 3 2018

test:
	[ "`p17b.py 3 10`" = 9 ]
	[ "`p17b.py 3 2018`" = 1226 ]
	[ "`p17b.py 304 50000000`" = 1930815 ]

run:
	p17b.py 304 50000000
