#!/bin/bash

data=1122     # 3
data=1111     # 4
data=1234     # 0
data=91212129 # 9

data=$1

# Split string per char to array.
mapfile -t splitted < <(for ((i=0;i<${#data};i++)); do echo "${data:$i:1}"; done)

result=0
for ((i=0;i<${#splitted[@]};i++)); do
	this=${splitted[$i]}
	next=${splitted[$((i+1))]}
	# Wrap around for the last element.
	if (( $((i+1)) == ${#splitted[@]} )); then
		next=${splitted[0]}
	fi
	if [[ $this == "$next" ]]; then
		result=$((result+this))
	fi
done
echo "Sum: $result"
