
@test "6b.py sample 1" {

input=$(cat << EOF
0 2 7 0
EOF
)

output=$(cat << EOF
4
EOF
)

result=$(echo "$input" | python 6b.py)
[[ "$result" == "$output" ]]
}

