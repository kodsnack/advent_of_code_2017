
@test "5b.py sample 1" {

input=$(cat << EOF
0
3
0
1
-3
EOF
)

output=$(cat << EOF
10
EOF
)

result=$(echo "$input" | python 5b.py)
[[ "$result" == "$output" ]]
}

