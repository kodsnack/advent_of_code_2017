
@test "24a.py sample 1" {

input=$(cat << EOF
0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10
EOF
)

output=$(cat << EOF
31
EOF
)

result=$(echo "$input" | python 24a.py)
[[ "$result" == "$output" ]]
}

