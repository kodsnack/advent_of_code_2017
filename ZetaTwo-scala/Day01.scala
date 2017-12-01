package com.zetatwo

object Day01 {
  def main(args: Array[String]): Unit = {
    val input = io.StdIn.readLine()

    printf("Result: %d", sum2(input))
  }

  def sum(input: String): Int = {
    val right: String = input.substring(1) + input.charAt(0)
    val left: String = input
    val pairs: Seq[(Char, Char)] = left zip right
    val pairvalues: Seq[Int] = {
      pairs.map(p => if (p._1 == p._2) Integer.valueOf(p._1.toString).intValue() else 0)
    }

    pairvalues.sum
  }

  def sum2(input: String): Int = {
    val right: String = input.substring(input.length/2) + input.substring(0, input.length/2)
    val left: String = input
    val pairs: Seq[(Char, Char)] = left zip right
    val pairvalues: Seq[Int] = {
      pairs.map(p => if (p._1 == p._2) Integer.valueOf(p._1.toString).intValue() else 0)
    }

    pairvalues.sum
  }

}
