#!/usr/bin/env bats

@test "4a sample 1" {
  result="$(echo aa bb cc dd ee | python 4a.py)"
  [[ "$result" == "1" ]]
}

@test "4a sample 2" {
  result="$(echo aa bb cc dd aa | python 4a.py)"
  [[ "$result" == "0" ]]
}

@test "4a sample 3" {
  result="$(echo aa bb cc dd aaa | python 4a.py)"
  [[ "$result" == "1" ]]
}



@test "4b sample 1" {
  result="$(echo abcde fghij | python 4b.py)"
  [[ "$result" == "1" ]]
}

@test "4b sample 2" {
  result="$(echo abcde xyz ecdab | python 4b.py)"
  [[ "$result" == "0" ]]
}

@test "4b sample 3" {
  result="$(echo a ab abc abd abf abj | python 4b.py)"
  [[ "$result" == "1" ]]
}

@test "4b sample 4" {
  result="$(echo iiii oiii ooii oooi oooo | python 4b.py)"
  [[ "$result" == "1" ]]
}

@test "4b sample 5" {
input=$(cat << EOF
oiii ioii iioi iiio
EOF
)
  result=$(echo "$input" | python 4b.py)
  [[ "$result" == "0" ]]
}
