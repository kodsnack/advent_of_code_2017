#!/bin/bash

filename="$(dirname "$0")/testdata_a.txt"
if [[ $1 ]]; then
	filename=$1
fi

checksumline() {
	local data
	read -r -a data <<< "$1"
	local largest=0
	local smallest=${data[0]}
	for i in "${data[@]}"; do
		if (( i >= largest)); then
			largest=$i
		fi
		if (( i <= smallest )); then
			smallest=$i
		fi
	done
	echo $((largest-smallest))
}

result=0
while read -r line; do
	result=$(($(checksumline "$line") + result))
done < "$filename"
echo $result
