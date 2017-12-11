object Main extends App {

  val moves: List[String] = (for {
    line <- io.Source.stdin.getLines
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

  def solveA(moves: List[String]) = dist(moves.foldLeft((0, 0))(execute))

  println(s"A1: ${moves.foldLeft((0, 0))(execute)}")
  println(s"A: ${solveA(moves)}")
}
