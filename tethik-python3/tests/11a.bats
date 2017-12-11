
@test "11a.py sample 1" {

input=$(cat << EOF
ne,ne,ne
EOF
)

output=$(cat << EOF
3
EOF
)

result=$(echo "$input" | python 11a.py)
[[ "$result" == "$output" ]]
}


@test "11a.py sample 2" {

input=$(cat << EOF
ne,ne,sw,sw
EOF
)

output=$(cat << EOF
0
EOF
)

result=$(echo "$input" | python 11a.py)
[[ "$result" == "$output" ]]
}


@test "11a.py sample 3" {

input=$(cat << EOF
ne,ne,s,s
EOF
)

output=$(cat << EOF
2
EOF
)

result=$(echo "$input" | python 11a.py)
[[ "$result" == "$output" ]]
}


@test "11a.py sample 4" {

input=$(cat << EOF
se,sw,se,sw,sw
EOF
)

output=$(cat << EOF
3
EOF
)

result=$(echo "$input" | python 11a.py)
[[ "$result" == "$output" ]]
}

