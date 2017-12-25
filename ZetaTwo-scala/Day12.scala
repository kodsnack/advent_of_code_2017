package com.zetatwo

import com.zetatwo.Common._
import scala.annotation.tailrec

object Day12 {

  def main(args: Array[String]): Unit = {
    val input = io.Source.stdin.getLines().toList.map(_.trim)

    printf("Result 1: %s\n", time { process(input) })
    printf("Result 2: %s\n", time { countgroups(input) })
  }

  def parseline(input: String): (Int, Seq[Int]) = {
    val parts = input.split(" <-> ", 2)
    (parts.head.toInt, parts.tail.head.split(", ").map(_.toInt))
  }

  def unionprograms(inputs: Seq[String]): UnionFind = {
    inputs
      .map(parseline)
      // For every line, union the head with every connection
      .foldLeft(FUnionFind.create(inputs.length))((state, line) => {
        val (idx, connections) = line
        connections.foldLeft(state)((state, connection) => state.union(idx, connection))
      })
  }

  def process(inputs: Seq[String]): Int = inputs.indices.count(unionprograms(inputs).connected(0, _))

  def countgroups(inputs: Seq[String]): Int = {
    val unions = unionprograms(inputs)
    @tailrec
    def group(programs: List[Int], numgroups: Int): Int = {
      programs match {
        case head :: tail => group(tail.filter(!unions.connected(head, _)), numgroups + 1)
        case _ => numgroups
      }
    }
    group(inputs.indices.toList, 0)
  }
}
