
@test "13a.py sample 1" {

input=$(cat << EOF
0: 3
1: 2
4: 4
6: 4
EOF
)

output=$(cat << EOF
24
EOF
)

result=$(echo "$input" | python 13a.py)
[[ "$result" == "$output" ]]
}

