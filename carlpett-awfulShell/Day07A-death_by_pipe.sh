#!/bin/bash
cat $1 | \
	tr -dc [:alpha:][:space:] | \
	sed -r 's/ +/\n/g' | \
	grep -vE '^ *$' | \
	sort | \
	uniq -c | \
	grep -E '^ +1 ' | \
	sed -r 's/ +1 //'
