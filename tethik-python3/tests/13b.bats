
@test "13b.py sample 1" {

input=$(cat << EOF
0: 3
1: 2
4: 4
6: 4
EOF
)

output=$(cat << EOF
10
EOF
)

result=$(echo "$input" | python 13b.py)
[[ "$result" == "$output" ]]
}

