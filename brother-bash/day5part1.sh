#!/bin/bash

filename="$(dirname "$0")/testdata_a.txt"
if [[ $1 ]] && [[ -f $1 ]]; then
	filename=$1
fi

mapfile -t instructions < "$filename"

max=${#instructions[@]}
current=0
count=0
while :; do
	next=$((current+${instructions[$current]}))
	instructions[$current]=$((${instructions[$current]}+1))
	current=$next
	if (( current >= max )); then
		echo $((count+1))
		break
	fi
	count=$((count+1))
done
