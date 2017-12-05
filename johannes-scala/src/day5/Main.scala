package day5

import io.Source._

object Main {
   def main(args: Array[String]) = {
    val instructions = fromFile("day5.txt").getLines.toArray.map(_.toInt)
    
    println("part 1: " + run(instructions, _ + 1))
    println("part 2: " + run(instructions, i => if (i < 3) i + 1  else i - 1 ))
  }
   
   
  def run(instructions: Array[Int], nextAddr: (Int) => Int): Int = {
    val lines = instructions.clone()
    
    var addr = 0
    var i = 0
    
    while (addr >= 0 && addr < lines.length) {
      val na = lines(addr) 
      lines(addr) = nextAddr(lines(addr))
      addr += na
      i += 1
    }
    return i
  }
}