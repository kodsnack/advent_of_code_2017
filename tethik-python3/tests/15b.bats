
@test "15b.py sample 1" {

input=$(cat << EOF
Generator A starts with 65
Generator B starts with 8921
EOF
)

output=$(cat << EOF
309
EOF
)

result=$(echo "$input" | python 15b.py)
[[ "$result" == "$output" ]]
}

