
@test "15a.py sample 1" {

input=$(cat << EOF
Generator A starts with 65
Generator B starts with 8921
EOF
)

output=$(cat << EOF
588
EOF
)

result=$(echo "$input" | python 15a.py)
[[ "$result" == "$output" ]]
}

