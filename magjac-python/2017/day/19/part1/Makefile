SHELL=/bin/bash -x

all: test run

debug:
	p19a.py < test.txt

debugv:
	p19a.py -v < test.txt

test:
	[ "`p19a.py < test.txt`" = ABCDEF ]
	[ "`p19a.py < input.txt`" = NDWHOYRUEA ]

run:
	p19a.py < input.txt

runv:
	p19a.py -v < input.txt
