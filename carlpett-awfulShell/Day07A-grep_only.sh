#!/bin/bash
cur=$(grep -- '->' $1)
while [[ $? -eq 0 ]]; do
	cur=${cur/ */}
	next=$cur
	cur=$(grep $cur $1 | grep -vE "^$cur")
done
echo $next
