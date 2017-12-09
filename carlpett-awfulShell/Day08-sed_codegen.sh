#!/bin/bash
max=0
declare -A vars=()
eval $(cat $1 | sed -r 's/inc/+/; s/dec/-/; s/([a-z]+) ([+-]) ([-0-9]+)/vars[\1]=$((${vars[\1]-0} \2 \3)); if [[ ${vars[\1]-0} -gt $max ]]; then max=${vars[\1]}; fi/; s/^(.+) if ([a-z]+) ([!=<>]+) ([-0-9]+)/if [[ $(echo "${vars[\2]-0} \3 \4" | bc) -eq 1 ]]; then \1; fi;/')
for v in "${!vars[@]}"
do
    echo $v=${vars["$v"]}
done |
sort -rn -t= -k2 | head -n1
echo $max