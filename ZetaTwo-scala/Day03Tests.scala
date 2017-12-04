package com.zetatwo

import org.scalatest.FunSuite

class Day03Tests extends FunSuite {
  test("Day03.layerparams") {
    assert(Day03.layerparams(1) == (1, 1))
    assert(Day03.layerparams(8) == (3, 2))
    assert(Day03.layerparams(23) == (5, 10))
  }

  test("Day03.sidedistance") {
    assert(Day03.sidedistance(0, 3) == 2)
    assert(Day03.sidedistance(1, 3) == 1)
    assert(Day03.sidedistance(2, 5) == 2)
  }

  test("Day03.distance") {
    assert(Day03.distance(1) == 0)
    assert(Day03.distance(12) == 3)
    assert(Day03.distance(23) == 2)
    assert(Day03.distance(1024) == 31)
  }

  test("Day03.challenge") {
    assert(Day03.distance(312051) == 430)
  }

  test("Day03.nextval") {
    assert(Day03.nextval((1,0), Map((0,0) -> 1)) == 1)
    assert(Day03.nextval((1,1), Map((0,0) -> 1, (1,0) -> 1)) == 2)
  }

  test("Day03.nextsidelength") {
    assert(Day03.nextsidelength((0,0), 1) == 1)
    assert(Day03.nextsidelength((1,0), 1) == 3)
    assert(Day03.nextsidelength((1,1), 3) == 3)
    assert(Day03.nextsidelength((1,-1), 3) == 3)
    assert(Day03.nextsidelength((2,-1), 3) == 5)
  }

  test("Day03.nextcoord") {
    assert(Day03.nextcoord((1,0), 3) == (1,1))
    assert(Day03.nextcoord((-2,0), 5) == (-2,-1))
  }

  test("Day03.sums") {
    assert(Day03.sums(4) == 5)
    assert(Day03.sums(22) == 23)
    assert(Day03.sums(746) == 747)
    assert(Day03.sums(805) == 806)
  }

  test("Day03.challenge2") {
    assert(Day03.sums(312051) == 312453)
  }
}
