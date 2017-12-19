SHELL=/bin/bash -x

all: test run

debug:
	p19b.py < test.txt

debugv:
	p19b.py -v < test.txt

test:
	[ "`p19b.py < test.txt`" = 38 ]
	[ "`p19b.py < input.txt`" = 17540 ]

run:
	p19b.py < input.txt

runv:
	p19b.py -v < input.txt
