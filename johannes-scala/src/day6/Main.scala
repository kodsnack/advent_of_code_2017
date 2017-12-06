package day6

import io.Source._

object Main {
  
  def main(args: Array[String]): Unit = {
    partOne
  }
  
  def partOne() {
    var thing = fromFile("day6.txt").getLines().next.split("\t").map(_.toInt)
    var things = Set[Long]()
    
    var i = 0
    var thingInt: Long = toInt(thing)
    var loopDest: Long = 0
    var done = false

    do {
      if (thingInt == loopDest && i != 0) {
        println("Part 2: " + i)
        done = true
      }
      things = things + thingInt
      thing = redis(thing)
      thingInt = toInt(thing)
      i += 1
      if (loopDest == 0 && things.contains(thingInt)) {
        println("Part 1: " + i)
        loopDest = thingInt
        println("dest = " + loopDest)
        i = 0
      } 
    } while (!done) 
     
    
  }
  
  def redis(thing: Array[Int]): Array[Int] = {
    var max = thing.max
    var i = thing.indexOf(max)
    val ret = thing.clone
    ret(i) = 0
    i+=1
    
    while (max > 0) {
      ret(i % thing.length) += 1
      i += 1
      max -= 1
    }
    return ret
  }
  
  def toInt(thing: Array[Int]): Long = {
    thing.reduce(_ * 100 + _)
  }
}