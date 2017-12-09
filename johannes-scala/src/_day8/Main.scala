package _day8

import io.Source._
import scala.collection.mutable.HashMap

object Main {
  
  def main(args: Array[String]) {
    val registers = new HashMap[String, Int]
    val instructions = fromFile("day8.txt").getLines().map(new Instruction(_)).toArray
    var max = 0
    var currentMax = 0
    println(instructions.length + " instructions")
    instructions.foreach(i => {
      i.execute(registers)
      currentMax = registers.map(_._2).max
      if (currentMax > max) max = currentMax
    })
    println("")
    println("part 1: " + currentMax)
    println("part 2: " + max)
  }
  
  class Instruction(i: String) {
    val w = i.split(" ")
    val target = w(0)
    val op = w(1)
    val value = w(2).toInt
    val condition = new Condition(w.slice(4, 8))
    
    def execute(regs: HashMap[String, Int]) {
      val r = if (regs.contains(target)) regs(target) else { regs.put(target, 0); 0 }
      if (condition.check(regs)) {
        op match {
          case "inc" => regs(target) = r + value
          case "dec" => regs(target) = r - value
        }
      }
    }
  }
  
  class Condition(i: Array[String]) {
    val target = i(0)
    val op = i(1)
    val value = i(2).toInt
    
    def check(regs: HashMap[String, Int]): Boolean = {
      val r = if (regs.contains(target)) regs(target) else {regs.put(target, 0); 0 }
      op match {
        case ">" => r > value
        case "<" => r < value
        case "==" => r == value
        case "<=" => r <= value
        case ">=" => r >= value
        case "!=" => r != value
      }
    }
  }
}