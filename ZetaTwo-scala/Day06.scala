package com.zetatwo

import com.zetatwo.Common._

import scala.annotation.tailrec

object Day06 {
  val WHITESPACE = raw"\s+"

  def main(args: Array[String]): Unit = {
    val input: String = io.Source.stdin.getLines().toList.head

    printf("Result 1: %d\n", time { simulate(input.split(WHITESPACE).map(d => d.toInt).toVector) })
    printf("Result 2: %d\n", time { simulate2(input.split(WHITESPACE).map(d => d.toInt).toVector) })
  }

  def distribute(state: Vector[Int], position: Int): Vector[Int] = {
    @tailrec
    def dodistribute(state: Vector[Int], left: Int, position: Int): Vector[Int] = {
      if (left == 0) {
        state
      } else {
        dodistribute(state.updated(position, state(position) + 1), left - 1, (position + 1) % state.length)
      }
    }

    dodistribute(state.updated(position, 0), state(position), (position + 1) % state.length)
  }

  def simulate(state: Vector[Int]): Int = {
    @tailrec
    def step(program: Vector[Int], seen: Set[Vector[Int]], iterations: Int): Int = {
      if (seen contains program) {
        iterations
      } else {
        step(distribute(program, program.zipWithIndex.maxBy(_._1)._2), seen + program, iterations + 1)
      }
    }

    step(state, Set.empty, 0)
  }

  def simulate2(state: Vector[Int]): Int = {
    @tailrec
    def step(program: Vector[Int], seen: Map[Vector[Int], Int], iterations: Int): Int = {
      if (seen contains program) {
        iterations - seen(program)
      } else {
        step(distribute(program, program.zipWithIndex.maxBy(_._1)._2), seen.updated(program, iterations), iterations + 1)
      }
    }

    step(state, Map.empty, 0)
  }
}
