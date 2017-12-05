object Main extends App {
  val jumps: List[Int] = (for {
    line <- io.Source.stdin.getLines
  } yield line.trim.toInt).toList

  def jump(eip: Int, jumps: List[Int]): (Int, List[Int]) =
    (eip + jumps(eip), jumps.updated(eip, jumps(eip) + 1))

  def solveA(input: List[Int]): Int = {
    var eip = 0
    var jumps = input
    var numJumps = 0

    while (eip < jumps.size) {
      val pair = jump(eip, jumps)
      eip = pair._1
      jumps = pair._2
      numJumps += 1
    }

    numJumps
  }

  // def solveB(input: List[String]): Int =
    // input.filter({ p => p.map(_.toSet).toSet.size == p.size }).size

  println(s"A: ${solveA(jumps)}")
  // println(s"B: ${solveB(input)}")
}
