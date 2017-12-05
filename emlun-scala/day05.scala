object Main extends App {
  val jumps: Array[Int] = (for {
    line <- io.Source.stdin.getLines
  } yield line.trim.toInt).toArray

  def jump(eip: Int, jumps: Array[Int]): (Int, Int) =
    (eip + jumps(eip), jumps(eip) match {
      case i if i >= 3 => jumps(eip) - 1
      case i => jumps(eip) + 1
    })

  def solveA(input: Array[Int]): Int = {
    var eip = 0
    var jumps = input
    var numJumps = 0

    while (eip < jumps.size && eip >= 0) {
      if (numJumps % 100000 == 0) {
        println(numJumps, eip)
      }
      // println(jumps.toList)

      val pair = jump(eip, jumps)
      jumps.update(eip, pair._2)
      eip = pair._1
      numJumps += 1
    }

    numJumps
  }

  // def solveB(input: Array[String]): Int =
    // input.filter({ p => p.map(_.toSet).toSet.size == p.size }).size

  println(s"A: ${solveA(jumps)}")
  // println(s"B: ${solveB(input)}")
}
