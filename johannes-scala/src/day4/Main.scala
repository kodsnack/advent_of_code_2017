package day4

import io.Source._

object Main {
  def main(args: Array[String]) = {
    val lines = fromFile("day4.txt").getLines.toArray
    
    println("part 1: " + lines.count(l => {
      val words = l.split(" ")
      words.diff(words.distinct).length == 0
    }))
    
    println("part 2: " + lines.count(l => {
      val words = l.split(" ")
      val set = words.toSet
      
      val b1 = set.count(_ => true) == words.length // finns dupes
      
      val b2 = set.subsets(2).count(s => {
        val array = s.toArray
        isAnagram(array(0), array(1))
      }) == 0
      
      b1 && b2
    }))
  }
  
  def isAnagram(s1: String, s2: String): Boolean = {
    var l1 = s1.toList
    var l2 = s2.toList
    
    return l1.sorted.equals(l2.sorted)
  }
}