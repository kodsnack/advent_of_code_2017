#!/bin/bash

filename="$(dirname "$0")/testdata_b.txt"
if [[ $1 ]]; then
	filename=$1
fi

checksumline() {
	local data
	read -r -a data <<< "$1"
	local heads=0
	local tails=0
	for ((i=0;i<${#data[@]};i++)); do
		heads=${data[$i]}
		for ((j=0;j<${#data[@]};j++)); do
			((i==j)) && continue
			tails=${data[$j]}
			if (( (heads%tails) == 0)); then
				echo $((heads/tails))
			fi
		done
	done
}

result=0
while read -r line; do
	result=$(($(checksumline "$line") + result))
done < "$filename"
echo $result
