object Day05 extends App {
  val jumps: List[Int] = io.Source.stdin.getLines().map(_.trim.toInt).toList

  def editA(offset: Int): Int = offset + 1

  def editB(offset: Int): Int =
    if (offset >= 3)
      offset - 1
    else
      offset + 1

  case class State(eip: Int, jumps: Map[Int, Int]) {
    def isHalted: Boolean = eip >= jumps.size || eip < 0
  }

  def step(edit: Int => Int)(state: State): State = state match {
    case State(eip, jumps) => state.copy(
      eip = eip + jumps(eip),
      jumps = jumps.updated(eip, edit(jumps(eip))),
    )
  }

  def solve(input: List[Int], edit: Int => Int): Int = {
    val jumps: Map[Int, Int] = input.zipWithIndex.map({ case (a, b) => (b, a) }).toMap
    Iterator.iterate(State(0, jumps))(step(edit)) indexWhere { _.isHalted }
  }

  println(s"A: ${solve(jumps, editA)}")
  println(s"B: ${solve(jumps, editB)}")
}
