#!/usr/bin/env bats

@test "2a sample 1" {
  result="$(cat tests/data/2a-sample.txt | python 2a.py)"
  [[ "$result" == "18" ]]
}

@test "2b sample 1" {
  result="$(cat tests/data/2b-sample.txt | python 2b.py)"
  [[ "$result" == "9" ]]
}
