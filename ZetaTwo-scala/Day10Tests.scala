package com.zetatwo

import org.scalatest.FunSuite

class Day10Tests extends FunSuite {

  test("Day10.Twist") {
    assert(Day10.twist(List(0, 1, 2, 3, 4), List(3)) == List(2, 1, 0, 3, 4))
    assert(Day10.twist(List(0, 1, 2, 3, 4), List(3, 4, 1, 5)) == List(3, 4, 2, 1, 0))
  }

  test("Day10.Twistround") {
    assert(Day10.twistround(List(3, 4, 1, 5), 5) == 12)
  }

  test("Day10.Challenge1") {
    assert(Day10.standardtwist(List(83,0,193,1,254,237,187,40,88,27,2,255,149,29,42,100)) == 20056)
  }

  test("Day10.Twisthash") {
    assert(Day10.twisthash("") == "a2582a3a0e66e6e86e3812dcb672a272")
    assert(Day10.twisthash("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd")
    assert(Day10.twisthash("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d")
    assert(Day10.twisthash("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e")
  }

  test("Day10.Challenge2") {
    assert(Day10.twisthash("83,0,193,1,254,237,187,40,88,27,2,255,149,29,42,100") == "d9a7de4a809c56bf3a9465cb84392c8e")
  }
}
