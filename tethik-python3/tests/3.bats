#!/usr/bin/env bats

@test "3a sample 1" {
  result="$(echo 1 | python 3a.py)"
  [[ "$result" == "0" ]]
}


@test "3a sample 2" {
  result="$(echo 12 | python 3a.py)"
  [[ "$result" == "3" ]]
}


@test "3a sample 3" {
  result="$(echo 23 | python 3a.py)"
  [[ "$result" == "2" ]]
}

@test "3a sample 4" {
  result="$(echo 1024 | python 3a.py)"
  [[ "$result" == "31" ]]
}


@test "3b sample 1" {
  result="$(echo 141 | python 3b.py)"
  [[ "$result" == "142" ]]
}
