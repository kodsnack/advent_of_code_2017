package com.zetatwo

import com.zetatwo.Common._

import scala.annotation.tailrec

object Day11 {

  def main(args: Array[String]): Unit = {
    val input = io.Source.stdin.getLines().toList.map(_.trim).head

    printf("Result 1: %s\n", time { walkdist(input.split(",").toList) })
    printf("Result 2: %s\n", time { maxwalk(input.split(",").toList) })
  }

  def step(current: (Int, Int), direction: String): (Int, Int) = {
    val (x, y) = current
    direction match {
      case "nw" => (x - 1, y + 1)
      case "n"  => (x    , y + 1)
      case "ne" => (x + 1, y    )
      case "se" => (x + 1, y - 1)
      case "s"  => (x    , y - 1)
      case "sw" => (x - 1, y    )
      case _    => current
    }
  }

  def maxstep(curmax: ((Int, Int), (Int, Int)), direction: String): ((Int, Int), (Int, Int)) = {
    val (current, max) = curmax
    val next = step(current, direction)
    val newmax = List(max, next).maxBy(distfromorigo)
    (next, newmax)
  }

  def walk(input: Seq[String], current: (Int, Int)): (Int, Int) = {
    input.foldLeft(current)(step)
  }

  def dist(p1: (Int, Int), p2: (Int, Int)): Int = {
    val (x1, y1) = p1
    val z1 = 0 - x1 - y1
    val (x2, y2) = p2
    val z2 = 0 - x2 - y2
    List(x2 - x1, y2 - y1, z2 - z1).map(math.abs).max
  }

  def distfromorigo(p: (Int, Int)): Int = dist(p, (0,0))

  def walkdist(input: Seq[String]): Int = {
    distfromorigo(walk(input, (0, 0)))
  }

  def maxwalk(input: Seq[String]): Int = {
    val (last, max) = input.foldLeft(((0,0), (0,0)))(maxstep)
    distfromorigo(max)
  }
}
