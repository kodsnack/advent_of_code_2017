
@test "6a.py sample 1" {

input=$(cat << EOF
0 2 7 0
EOF
)

output=$(cat << EOF
5
EOF
)

result=$(echo "$input" | python 6a.py)
[[ "$result" == "$output" ]]
}

