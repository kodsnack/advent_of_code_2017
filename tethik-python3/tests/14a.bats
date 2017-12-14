
@test "14a.py sample 1" {

input=$(cat << EOF
flqrgnkx
EOF
)

output=$(cat << EOF
8108
EOF
)

result=$(echo "$input" | python 14a.py)
[[ "$result" == "$output" ]]
}

