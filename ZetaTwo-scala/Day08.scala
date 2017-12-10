package com.zetatwo

import com.zetatwo.Common._

object Day08 {

  def main(args: Array[String]): Unit = {
    val input: Seq[String] = io.Source.stdin.getLines().toList.map(_.trim)

    printf("Result 1/2: %s\n", time { run(input) })
  }

  case class Statement(register: String, amount: Int, left: String, condition: String, right: Int)

  def parse(input: Seq[String]): Seq[Statement] = {
    def parseline(line: String): Option[Statement] = {
      val StatementPattern = raw"([a-z]+) (inc|dec) (-?[0-9]+) if ([a-z]+|-?[0-9]+) (<|>|<=|>=|==|!=) ([a-z]+|-?[0-9]+)".r
      line match {
        case StatementPattern(dst, "inc", amount, left, cond, right) => Some(Statement(dst, amount.toInt, left, cond, right.toInt))
        case StatementPattern(dst, "dec", amount, left, cond, right) => Some(Statement(dst, -amount.toInt, left, cond, right.toInt))
        case _ => None
      }
    }

    input.flatMap(parseline)
  }

  def run(input: Seq[String]): (Int, Int) = {
    type ProgramState = Map[String, (Int, Int)]

    def evalcond(state: ProgramState, stmt: Statement): Boolean = {
      val (curval, _) = state.getOrElse(stmt.left, (0, 0))
      stmt.condition match {
        case "==" => curval == stmt.right
        case "!=" => curval != stmt.right
        case ">" =>  curval >  stmt.right
        case "<" =>  curval <  stmt.right
        case "<=" => curval <= stmt.right
        case ">=" => curval >= stmt.right
      }
    }

    def calculate(state: ProgramState, stmt: Statement): ProgramState = {
      if(evalcond(state, stmt)) {
        val (curval, maxval) = state.getOrElse(stmt.register, (0, 0))
        val newval = curval + stmt.amount
        val newregister = (newval, Math.max(maxval, newval))
        state.updated(stmt.register, newregister)
      } else {
        state
      }
    }

    val program = parse(input)
    val endstate = program.foldLeft(Map.empty[String, (Int, Int)])(calculate)
    (endstate.values.map(_._1).max, endstate.values.map(_._2).max)
  }
}
