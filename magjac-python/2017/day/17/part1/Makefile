SHELL=/bin/bash -x

all: test run

debug0:
	p17a.py 3 10

debug:
	p17a.py 3 2018

test:
	[ "`p17a.py 3 10`" = 5 ]
	[ "`p17a.py 3 2018`" = 638 ]
	[ "`p17a.py 304 2018`" = 1173 ]

run:
	p17a.py 304 2018
