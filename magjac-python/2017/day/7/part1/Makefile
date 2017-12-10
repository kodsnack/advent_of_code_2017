SHELL=/bin/bash -x

all: test run

debug:
	p7a.py < test.txt

test:
	[ "`p7a.py < test.txt`" = tknk ]
	[ "`p7a.py < input.txt`" = veboyvy ]

run:
	p7a.py < input.txt
