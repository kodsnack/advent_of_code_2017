package com.zetatwo

import com.zetatwo.Common._
import scala.annotation.tailrec

object Day10 {

  def main(args: Array[String]): Unit = {
    val input = io.Source.stdin.getLines().toList.map(_.trim).head

    printf("Result 1: %s\n", time { standardtwist(input.split(",").map(_.toInt)) })
    printf("Result 2: %s\n", time { twisthash(input) })
  }

  def twist(list: List[Int], lengths: Seq[Int]): List[Int] = {
    @tailrec
    def loop(list: List[Int], lengths: Seq[Int], position: Int, skipsize: Int): List[Int] = {
      if (lengths.isEmpty) {
        return list
      }

      // Cycle current position to start
      val (normleft, normright) = list.splitAt(position).swap
      val normalized = normleft ++ normright

      // Twist left half
      val (twistleft, twistright) = normalized.splitAt(lengths.head)
      val twisted = twistleft.reverse ++ twistright

      // Cycle back in place
      val (denormleft, denormright) = twisted.splitAt(list.length - position).swap
      val denormalized = denormleft ++ denormright

      loop(denormalized, lengths.tail, (position + lengths.head + skipsize) % list.length, skipsize + 1)
    }

    loop(list, lengths, 0, 0)
  }

  def twistround(lengths: Seq[Int], size: Int): Int = {
    twist((0 until size).toList, lengths).take(2).product
  }

  def standardtwist(lengths: Seq[Int]): Int = twistround(lengths, 256)

  def twisthash(input: String): String = {
    val preproc = input.map(_.toInt) ++ List(17, 31, 73, 47, 23)
    val hash = twist((0 until 256).toList, (1 to 64).flatMap(_ => preproc))
    hash
      .grouped(16)              // Groups of 16
      .map(_.fold(0)(_ ^ _))    // Xor all together
      .map(_.formatted("%02x")) // Hex format
      .fold("")(_ + _)          // Concat to string
  }
}
