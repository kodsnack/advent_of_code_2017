
@test "5a.py sample 1" {
input=$(cat << EOF
0
3
0
1
-3
EOF
)
output=$(cat << EOF
5
EOF
)
  result=$(echo "$input" | python 5a.py)
  [[ "$result" == "$output" ]]
}

