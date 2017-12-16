SHELL=/bin/bash -x

all: test run

debug:
	p15b.py --test

debugv:
	p15b.py -v --test

test:
	[ "`p15b.py --test`" = 309 ]
	[ "`p15b.py`" = 290 ]

run:
	p15b.py
