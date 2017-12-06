#!/usr/bin/env bats

@test "1a sample 1" {
  result="$(echo 1122 | emojicode 1️.emojib)"
  [[ "$result" == *"1st answer: 3"* ]]
  [[ "$result" == *"2nd answer: 0"* ]]
}

@test "1a sample 2" {
  result="$(echo 1111 | emojicode 1️.emojib)"
  [[ "$result" == *"1st answer: 4"* ]]
  [[ "$result" == *"2nd answer: 4"* ]]
}

@test "1a sample 3" {
  result="$(echo 1234 | emojicode 1️.emojib)"
  [[ "$result" == *"1st answer: 0"* ]]
  [[ "$result" == *"2nd answer: 0"* ]]
}

@test "1a sample 4" {
  result="$(echo 91212129 | emojicode 1️.emojib)"
  [[ "$result" == *"1st answer: 9"* ]]
  [[ "$result" == *"2nd answer: 6"* ]]
}


@test "1b sample 1" {
  result="$(echo 1212 | emojicode 1️.emojib)"
  [[ "$result" == *"2nd answer: 6"* ]]
}

@test "1b sample 2" {
  result="$(echo 1221 | emojicode 1️.emojib)"
  [[ "$result" == *"2nd answer: 0"* ]]
}

@test "1b sample 3" {
  result="$(echo 123425 | emojicode 1️.emojib)"
  [[ "$result" == *"2nd answer: 4"* ]]
}

@test "1b sample 4" {
  result="$(echo 123123 | emojicode 1️.emojib)"
  [[ "$result" == *"2nd answer: 12"* ]]
}

@test "1b sample 5" {
  result="$(echo 12131415 | emojicode 1️.emojib)"
  [[ "$result" == *"2nd answer: 4"* ]]
}