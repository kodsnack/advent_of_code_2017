#!/bin/bash

filename="$(dirname "$0")/testdata_b.txt"
if [[ $1 ]] && [[ -f $1 ]]; then
	filename=$1
fi

inarray() { local q=$1 e; shift; (( $# )) && for e; do [[ $q = "$e" ]] && return; done; }

checkline () {
	local words
	read -r -a words <<< "$1"
	declare -a seen
	for word in "${words[@]}"; do
		sorted=$(
		for ((i=0;i<${#word};i++)); do
			echo "${word:$i:1}"
		done | sort | tr -d '\n')
		if inarray "$sorted" "${seen[@]}"; then
			return 1
		fi
		read -r -a seen <<< "${seen[*]} $sorted"
	done
}

result=0
while read -r line; do
	checkline "$line" && result=$((result+1))
done < "$filename"
echo $result
