package com.zetatwo

import com.zetatwo.Common._

import scala.annotation.tailrec
import scala.collection.script.Index

object Day09 {

  def main(args: Array[String]): Unit = {
    val input = io.Source.stdin.getLines().toList.map(_.trim).head

    printf("Result 1/2: %s\n", time { parse(input) })
  }

  @tailrec
  def cleanup(input: String): String = {
    input.indexOf("!") match {
      case i if i >= 0 => cleanup(input.substring(0, i) + input.substring(i + 2))
      case _ => input
    }
  }

  def parsegarbage(input: String): (String, Int) = {
    val garbageend = input.indexOf('>')
    (input.substring(garbageend + 1), garbageend - 1)
  }

  def parse(input: String): (Int, Int) = {
    def traverse(remaining: String, level: Int, score: Int, characters: Int): (Int, Int) = {
      if(remaining.isEmpty) return (score, characters)

      remaining.head match {
        case '<' =>
          val (degarbaged, garbagecount) = parsegarbage(remaining)
          traverse(degarbaged, level, score, characters + garbagecount)
        case ',' => traverse(remaining.substring(1), level, score, characters)
        case '{' => traverse(remaining.substring(1), level + 1, score, characters)
        case '}' => traverse(remaining.substring(1), level - 1, score + level, characters)
      }
    }

    traverse(cleanup(input), 0, 0, 0)
  }
}
