SHELL=/bin/bash -x

all: test run

debug:
	p16a.py abcde < test.txt

debugv:
	p16a.py abcde -v < test.txt

test:
	[ "`p16a.py abcde < test.txt`" = baedc ]
	[ "`p16a.py abcdefghijklmnop < input.txt`" = glnacbhedpfjkiom ]

run:
	p16a.py abcdefghijklmnop < input.txt

