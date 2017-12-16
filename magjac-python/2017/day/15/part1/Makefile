SHELL=/bin/bash -x

all: test run

debug:
	p15a.py --test

debugv:
	p15a.py -v --test

test:
	[ "`p15a.py --test`" = 1 ]
	[ "`p15a.py`" = 619 ]

run:
	p15a.py
