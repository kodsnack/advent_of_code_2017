
@test "14b.py sample 1" {

input=$(cat << EOF
flqrgnkx
EOF
)

output=$(cat << EOF
1242
EOF
)

result=$(echo "$input" | python 14b.py)
[[ "$result" == "$output" ]]
}

