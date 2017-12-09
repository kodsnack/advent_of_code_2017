package day7

import io.Source._

object Main {
  def main(args: Array[String]) = {
    var nodes = Set[Node]()
    
    val input = fromFile("day7.txt").getLines().foreach(line => {
      val s1 = line.split("->")
      val hasChildren = s1.length > 1
      val s2 = s1(0).split(" ")
      nodes = nodes + new Node(s2(0), s2(1).split("")(1).toInt, if (hasChildren) s1(1).split(", ") else Array[String]())
    })
    
    nodes.foreach{println}
    val _nodes = nodes.toSet
    
    _nodes.foreach(n => nodes = n.getChildren(nodes))
    
    println("part 1: ")
    val head = nodes.head
    println(head.updateWeight)
    
    head.printTree(0)
    
    
    //println(head.part2)
  }


  class Node(name: String, weight: Int, children: Array[String]) {
    
    def getName = name
    def getWeight = weight
    
    var childNodes = Set[Node]()
    
    var totalWeight = 0
    
    override def toString() = {
      name + "(" + weight + ", " + totalWeight + ") -> " + children.length + " children"
    }
    
    def printTree(depth: Int): Unit = {
      val spacing = (for (i <- 0 to depth) yield "  ").reduce(_+_)
      println(spacing + this)
      childNodes.foreach(_.printTree(depth + 1))
    }
    
    def part2: Int = {
      var done = false
      val childWeights = childNodes.map(_.totalWeight)
      println("children weigh " + childWeights.map(_ + ", "))
      childWeights.foreach(i => {
        if (childNodes.count(_.totalWeight == i) == 1) {
          println("found 1 weighing " + i + " at " + name)
          val bad = childNodes.find(_.totalWeight == i)
          val target = childWeights.find(_ != bad.get.totalWeight).get
          println("others weigh " + target)
          return target - bad.get.totalWeight + bad.get.getWeight
        }
      })
      childNodes.foreach(n => {
        val i = n.part2
        if (i != -1) return i
      })
      return -1
    }
    
    def getChildren(_nodes: Set[Node]): Set[Node] = {
      var nodes = _nodes
      children.foreach(n => {
        val c = nodes.find(_.getName == n.trim).get
        nodes = nodes - c
        childNodes = childNodes + c
      })
      return nodes
    }
    
    def updateWeight: Int = {
      val weights = childNodes.toArray.map(_.updateWeight)
      totalWeight = weights.sum + weight
      return totalWeight
    }
  }
}