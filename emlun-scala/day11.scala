object Day11 extends App {

  val moves: List[String] = (for {
    line <- io.Source.stdin.getLines()
    move <- line.trim.split(raw",")
  } yield move).toList

  def execute(state: (Int, Int), move: String): (Int, Int) = state match {
    case (x, y) => move match {
      case "n"  => (x, y + 2)
      case "ne" => (x + 1, y + 1)
      case "se" => (x + 1, y - 1)
      case "s"  => (x, y - 2)
      case "sw" => (x - 1, y -1)
      case "nw" => (x - 1, y + 1)
    }
  }

  def dist(pos: (Int, Int)): Int = pos match {
    case (x, y) => {
      val ax = Math.abs(x)
      val ay = Math.abs(y)
      val diagonal: Int = Math.min(ax, ay)

      diagonal + (ax - diagonal) + (ay - diagonal) / 2
    }
  }

  def solveA(moves: List[String]): Int = dist(moves.foldLeft((0, 0))(execute))
  def solveB(moves: List[String]): Int =
    moves
      .scanLeft((0, 0))(execute)
      .map(dist)
      .foldLeft(0)(Math.max)

  println(s"A: ${solveA(moves)}")
  println(s"B: ${solveB(moves)}")
}
