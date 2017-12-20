package com.zetatwo

import scala.annotation.tailrec

// Taken from: http://blog.xebia.com/the-union-find-algorithm-in-scala-a-purely-functional-implementation/

trait UnionFind {
  def connected(t1: Int, t2: Int): Boolean

  def union(t1: Int, t2: Int): UnionFind
}

class IUnionFind(val size: Int) extends UnionFind {

  private case class Node(var parent: Option[Int], var treeSize: Int)

  private val nodes = Array.fill[Node](size)(Node(None, 1))

  def union(t1: Int, t2: Int): IUnionFind = {
    if (t1 == t2) return this

    val root1 = root(t1)
    val root2 = root(t2)
    if (root1 == root2) return this

    val node1 = nodes(root1)
    val node2 = nodes(root2)

    if (node1.treeSize < node2.treeSize) {
      node1.parent = Some(t2)
      node2.treeSize += node1.treeSize
    } else {
      node2.parent = Some(t1)
      node1.treeSize += node2.treeSize
    }
    this
  }

  def connected(t1: Int, t2: Int): Boolean = t1 == t2 || root(t1) == root(t2)

  @tailrec
  private def root(t: Int): Int = nodes(t).parent match {
    case None => t
    case Some(p) => root(p)
  }
}

case class FNode(parent: Option[Int], treeSize: Int)

object FUnionFind {
  def create(size: Int): FUnionFind = {
    val nodes = Vector.fill(size)(FNode(None, 1))
    new FUnionFind(nodes)
  }
}

class FUnionFind(nodes: Vector[FNode]) extends UnionFind {

  def union(t1: Int, t2: Int): FUnionFind = {
    if (t1 == t2) return this

    val root1 = root(t1)
    val root2 = root(t2)
    if (root1 == root2) return this

    val node1 = nodes(root1)
    val node2 = nodes(root2)
    val newTreeSize = node1.treeSize + node2.treeSize

    val (newNode1, newNode2) =
      if (node1.treeSize < node2.treeSize) {
        val newNode1 = FNode(Some(t2), newTreeSize)
        val newNode2 = FNode(node2.parent, newTreeSize)

        (newNode1, newNode2)
      } else {
        val newNode2 = FNode(Some(t1), newTreeSize)
        val newNode1 = FNode(node1.parent, newTreeSize)

        (newNode1, newNode2)
      }
    val newNodes = nodes.updated(root1, newNode1).updated(root2, newNode2)
    new FUnionFind(newNodes)
  }

  def connected(t1: Int, t2: Int): Boolean = t1 == t2 || root(t1) == root(t2)

  @tailrec
  private def root(t: Int): Int = nodes(t).parent match {
    case None => t
    case Some(p) => root(p)
  }
}
