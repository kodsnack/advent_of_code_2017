
@test "12b.py sample 1" {

input=$(cat << EOF
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
EOF
)

output=$(cat << EOF
2
EOF
)

result=$(echo "$input" | python 12b.py)
[[ "$result" == "$output" ]]
}

