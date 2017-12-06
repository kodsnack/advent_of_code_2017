all: squeeze shebang test run

debug:
	p4a.sed test.txt
	p4a.sed input.txt

test:
	[ "`p4a.sed test.txt`" = 2 ]
	[ "`p4a.sed input.txt`" = 477 ]

run:
	p4a.sed input.txt

squeeze:
	@sed '/^$$/d;/^#/d' p4a-commented.sed | tr '\n' ';' | sed 's/;$$//' > p4a-squeezed.sed

shebang:
	echo "#!/bin/sed -Enf" | cat - p4a-squeezed.sed > p4a.sed
	echo "" >> p4a.sed
	chmod +x p4a.sed
