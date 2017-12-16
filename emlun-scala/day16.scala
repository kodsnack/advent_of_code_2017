object Day16 extends App {

  val moves: List[Move] = (for {
    line <- io.Source.stdin.getLines()
    move <- line.trim.split(",")
  } yield parseMove(move)).toList

  sealed trait Move
  case class Spin(num: Int) extends Move
  case class Exchange(a: Int, b: Int) extends Move
  case class Partner(a: String, b: String) extends Move

  def parseMove(move: String): Move = move.splitAt(1) match {
    case ("s", rest) => Spin(rest.toInt)
    case ("x", rest) => rest.split("/") match {
      case Array(a, b) => Exchange(a.toInt, b.toInt)
    }
    case ("p", rest) => rest.split("/") match {
      case Array(a, b) => Partner(a, b)
    }
  }

  def dance(programs: String, move: Move): String = move match {
    case Spin(num) => programs.splitAt(programs.length - num) match {
      case (front, back) => back + front
    }
    case Exchange(a, b) => programs.updated(a, programs(b)).updated(b, programs(a))
    case Partner(a, b) => dance(programs, Exchange(programs.indexOf(a), programs.indexOf(b)))
  }

  println(moves)
  println(moves.foldLeft("abcdefghijklmnop")(dance))
}
