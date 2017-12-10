package com.zetatwo

import com.zetatwo.Common._
import org.scalatest.FunSuite

class Day06Tests extends FunSuite {
  test("Day06.distribute") {
    assert(Day06.distribute(Vector(0, 2, 7, 0), 2) == Vector(2,4,1,2))
    assert(Day06.distribute(Vector(2, 4, 1, 2), 1) == Vector(3,1,2,3))
    assert(Day06.distribute(Vector(3, 1, 2, 3), 0) == Vector(0,2,3,4))
    assert(Day06.distribute(Vector(0, 2, 3, 4), 3) == Vector(1,3,4,1))
    assert(Day06.distribute(Vector(1, 3, 4, 1), 2) == Vector(2,4,1,2))
  }

  test("Day06.simulate") {
    assert(Day06.simulate(Vector(0, 2, 7, 0)) == 5)
  }

  test("Day06.challenge") {
    assert(Day06.simulate(Vector(4,10,4,1,8,4,9,14,5,1,14,15,0,15,3,5)) == 12841)
  }

  test("Day06.simulate2") {
    assert(Day06.simulate2(Vector(0, 2, 7, 0)) == 4)
  }

  test("Day06.challenge2") {
    assert(Day06.simulate2(Vector(4,10,4,1,8,4,9,14,5,1,14,15,0,15,3,5)) == 8038)
  }
}
