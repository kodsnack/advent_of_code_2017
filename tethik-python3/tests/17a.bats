
@test "17a.py sample 1" {

input=$(cat << EOF
3
EOF
)

output=$(cat << EOF
638
EOF
)

result=$(echo "$input" | python 17a.py)
[[ "$result" == "$output" ]]
}


@test "17a.py sample 2" {

input=$(cat << EOF
349
EOF
)

output=$(cat << EOF
640
EOF
)

result=$(echo "$input" | python 17a.py)
[[ "$result" == "$output" ]]
}

