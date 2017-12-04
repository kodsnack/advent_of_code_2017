package com.zetatwo

object Day02 {
  def main(args: Array[String]): Unit = {
    val lines: Seq[String] = io.Source.stdin.getLines.toList

    printf("Result 1: %d", linesums(lines))
    printf("Result 2: %d", linesums2(lines))
  }

  def numberlines(lines: Seq[String]): Seq[Seq[Int]] = {
    lines.map(l => l.split("\\s+").toSeq.map(c => Integer.valueOf(c).intValue))
  }

  def linesums(lines: Seq[String]): Int = {
    val numbers = numberlines(lines)
    val linediffs: Seq[Int] = numbers.map(l => l.max - l.min)
    linediffs.sum
  }

  def linesums2(lines: Seq[String]): Int = {
    val numbers = numberlines(lines)
    val linedivs = numbers.map(l => {
      (for {
        x <- l.toStream
        y <- l.toStream
        if x > y && x % y == 0
      } yield x/y).head
    })
    linedivs.sum
  }

}
