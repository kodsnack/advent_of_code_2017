package day7

import io.Source._

object Main2 {
  
  def main(args: Array[String]) = {
    val input = fromFile("day7.txt").getLines().toArray
    
    val (left, right) = input.map(a => {
      val b = a.split("->")
      if (b.length == 1) (b(0).trim, "")
      else (b(0).trim, b(1).trim)
    }).unzip
    
    val rootName = left.find(a => {
      val c = a.split(" ")(0)
      ! right.find(b => b.contains(c)).isDefined
    }).get
    println("part 1: " + rootName)
    
    val root = nodeFromName(rootName, input)
    println("part 2: " + root.part2(0))
  }
  
  def nodeFromName(n: String, input: Array[String]): Node = {
    val line = input.find(a => a.split("->")(0).contains(n.trim)).get
    val s1 = line.split("->")
    val hasChildren = s1.length > 1
    val s2 = s1(0).split(" ")
    new Node(s2(0), s2(1).split("")(1).toInt, 
        if (hasChildren) 
          s1(1).split(", ").map(m => nodeFromName(m, input)).toSet
        else 
          Set[Node]()
      )
  }
  
  class Node(name: String, weight: Int, children: Set[Node]) {
    def isBalanced = {
      children.map(_.totalWeight).count(_ => true) == 1
    }
    
    def totalWeight = {
      weight + children.toArray.map(_.getWeight).sum
    }
    
    def getWeight = weight
    def getName = name
    
    def part2(target: Int): Int = {
      val ub = children.find(!_.isBalanced)
      if (ub.isDefined) {
        println(ub.get.getName + " is unbalanced")
        val target = children.find(_.totalWeight != ub.get.totalWeight).get.totalWeight
        ub.get.part2(target)
      } else {
        println(name + " is problem, target " + target + ", me " + weight + ", total " + totalWeight)
        target + weight - totalWeight
      }
    }
  }
}