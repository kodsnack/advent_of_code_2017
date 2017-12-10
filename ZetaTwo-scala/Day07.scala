package com.zetatwo

import com.zetatwo.Common._

import scala.annotation.tailrec

object Day07 {

  def main(args: Array[String]): Unit = {
    val input: Seq[String] = io.Source.stdin.getLines().toList.map(_.trim)

    printf("Result 1: %s\n", time { findRoot(input) })
    printf("Result 2: %d\n", time { findImbalance(input) })
  }

  case class Node(name: String, weight: Int, children: Seq[String])

  def parse(input: Seq[String]): Seq[Node] = {
    def parseline(line: String): Option[Node] = {
      val InnerNode = raw"([a-z]+) \(([0-9]+)\)(?: -> ([a-z, ]+))".r
      val LeafNode = raw"([a-z]+) \(([0-9]+)\)".r
      line match {
        case InnerNode(name, weight, children) => Some(Node(name, weight.toInt, children.split(", ")))
        case LeafNode(name, weight) => Some(Node(name, weight.toInt, List.empty))
        case _ => None
      }
    }

    input.flatMap(parseline)
  }

  def findRoot(input: Seq[String]): String = {
    val tree = parse(input)
    val leaves = tree.map(_.children.toSet).reduce(_ ++ _)
    val inner = tree.map(_.name).toSet
    (inner diff leaves).head
  }

  def findImbalance(input: Seq[String]): Int = {

    def findWeight(nodemap: Map[String, (Int, Seq[String])], node: String): Either[Int, Int] = {
      //type Imbalance = Left[Int, Int]
      //type Weight = Right[Int, Int]

      nodemap(node) match {
        case (currentweight, children) if children.isEmpty => Right(currentweight) // Leaf node, report weight
        case (currentweight, children) =>
          sequence(children.map(findWeight(nodemap, _))) match {
            case Left(imbalance) => Left(imbalance) // Imbalance found, pass it upwards
            case Right(weights) if weights.distinct.length == 1 => Right(currentweight + weights.length * weights.head) // All are same, compute total weight
            case Right(weights) => // Mismatch found, pass proposed weight upwards
              val weightgroups = (children zip weights)
                .groupBy({case (_, weight) => weight})
                .toList
                .sortBy({ case (count, _) => count})
              val diffname = weightgroups
                .map({ case (_, weightgroup) => weightgroup.head._1})
                .reverse
                .head
              Left(nodemap(diffname)._1 + (weightgroups.head._1 - weightgroups.tail.head._1))
          }
      }
    }

    val tree = parse(input)
    val nodemap = tree.map(n => (n.name, (n.weight, n.children))).toMap
    val leaves = tree.map(_.children.toSet).reduce(_ ++ _)
    val inner = tree.map(_.name).toSet
    val root = (inner diff leaves).head

    findWeight(nodemap, root) match {
      case Left(imbalance) => imbalance
    }
  }
}
