package com.zetatwo
import Common._

import scala.annotation.tailrec

object Day05 {
  def main(args: Array[String]): Unit = {
    val lines: Seq[String] = io.Source.stdin.getLines.toList

    printf("Result 1: %d\n", time { simulate(lines.map(l => l.toInt).toVector) })
    printf("Result 2: %d\n", time { simulate2(lines.map(l => l.toInt).toVector) })
  }

  def simulate(program: Vector[Int]): Int = {
    @tailrec
    def step(program: Vector[Int], pc: Int, steps: Int): Int = {
      if (!(program.indices contains pc)) {
        steps
      } else {
        step(program.updated(pc, program(pc) + 1), pc + program(pc), steps + 1)
      }
    }
    step(program, 0, 0)
  }

  def simulate2(program: Vector[Int]): Int = {
    @tailrec
    def step(program: Vector[Int], pc: Int, steps: Int): Int = {
      if (!(program.indices contains pc)) {
        steps
      } else if (program(pc) >= 3) {
        step(program.updated(pc, program(pc) - 1), pc + program(pc), steps + 1)
      } else {
        step(program.updated(pc, program(pc) + 1), pc + program(pc), steps + 1)
      }
    }
    step(program, 0, 0)
  }
}
