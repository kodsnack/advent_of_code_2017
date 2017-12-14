#!/bin/bash

source "$(dirname "$0")/../functions.sh"

filename="$(dirname "$0")/testdata_a.txt"
if [[ $1 ]]; then
	if ! [[ -f $1 ]]; then
		echo "Invalid input file. Using test data."
	else
		filename=$1
	fi
fi

findtopbank () {
	local banks
	read -r -a banks <<< "$@"
	local topValue=0
	local topPosition=0
	for ((i=0;i<${#banks[@]};i++)); do
		currentValue=${banks[$i]}
		currentPosition=$i
		if (( currentValue > topValue )); then
			topValue=$currentValue
			topPosition=$currentPosition
		fi
	done
	echo "$topPosition"
}

balancebanks () {
	local activeBank
	local banks
	read -r -a banks <<< "$@"
	activeBank=$(findtopbank "${banks[@]}")
	value=${banks[$activeBank]}
	banks[$activeBank]=0
	for ((todistribute=value;todistribute>0;todistribute--)); do
		activeBank=$((activeBank+1))
		if ((activeBank>=${#banks[@]})); then
			activeBank=0
		fi

		banks[$activeBank]=$((${banks[$activeBank]}+1))
	done
	echo "${banks[@]}"
}

read -r -a dataBanks < "$filename"

result=0
declare -a seen
while :; do
	result=$((result+1))
	signature=$(balancebanks "${dataBanks[@]}")
	lazyhash=${signature// /-}
	if inarray "$lazyhash" "${seen[@]}"; then
		break
	fi
	# Store hash and reset banks for new balance try
	read -r -a seen <<< "${seen[*]} $lazyhash"
	read -r -a dataBanks <<< "$signature"
done
echo $result
