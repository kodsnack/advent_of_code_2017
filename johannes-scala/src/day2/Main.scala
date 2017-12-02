package day2

import java.io._
import io.Source._

object Main {
   def main (args: Array[String]) = {
     val lines = fromFile("day2.txt").getLines.toArray
     val vals = lines.map(_.split("\t").map(_.toInt)) // 2D-array av ints
     
     println("part one: " + vals.map(v => v.max - v.min).sum)
     
     println("part two: " + vals.map(line => {
       val combs = line.toSet.subsets(2).map(_.toArray) // alla kombinationer av 2 element i raden, som array
       val divs = combs.flatMap(c => Array(c(0).toDouble / c(1), c(1).toDouble / c(0))) // alla mojliga divisioner
       val evens = divs.filter(_ % 1 == 0) // alla jämna divisioner
       evens.sum 
     }).sum.toInt)
   }
}