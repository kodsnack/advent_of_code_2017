#!/bin/bash

data=1212     # 6
data=1221     # 0
data=123425   # 4
data=123123   # 12
data=12131415 # 4

data=$1

# Split string per char to array.
mapfile -t splitted < <(for ((i=0;i<${#data};i++)); do echo "${data:$i:1}"; done)

result=0
nbrofelements=${#splitted[@]}
lookahead=$((nbrofelements/2))
for ((i=0;i<nbrofelements;i++)); do
	this=${splitted[$i]}
	nextindex=$((i+lookahead))
	next=${splitted[$nextindex]}
	# Reconsider when outside of the length
	if (( nextindex >= nbrofelements )); then
		left=$((nextindex-nbrofelements))
		next=${splitted[$((0+left))]}
	fi
	if [[ $this == "$next" ]]; then
		result=$((result+this))
	fi
done
echo "$result"
