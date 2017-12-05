object Main extends App {
  val jumps: List[Int] = io.Source.stdin.getLines().map(_.trim.toInt).toList

  def editA(offset: Int): Int = offset + 1

  def editB(offset: Int): Int =
    if (offset >= 3)
      offset - 1
    else
      offset + 1

  def solve(input: Seq[Int], edit: Int => Int): Int = {
    var eip = 0
    var jumps = input.toArray
    var numJumps = 0

    while (eip < jumps.size && eip >= 0) {
      val (e, j) = (eip + jumps(eip), edit(jumps(eip)))
      jumps.update(eip, j)
      eip = e
      numJumps += 1
    }

    numJumps
  }

  println(s"A: ${solve(jumps, editA)}")
  println(s"B: ${solve(jumps, editB)}")
}
