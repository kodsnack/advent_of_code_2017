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
    case _ => ???
  }

  def dance(programs: String, move: Move): String = move match {
    case Spin(num) => programs.splitAt(programs.length - num) match {
      case (front, back) => back + front
    }
    case Exchange(a, b) => programs.updated(a, programs(b)).updated(b, programs(a))
    case Partner(a, b) => dance(programs, Exchange(programs.indexOf(a), programs.indexOf(b)))
  }

  def danceAll(programs: String, moves: List[Move]): String = moves.foldLeft(programs)(dance)

  def danceTimes(programs: String, moves: List[Move], timesLeft: Int, history: List[String]): String = {
    val repeatIndex = history.indexOf(programs)
    val period = repeatIndex + 1

    if (timesLeft <= 0 || repeatIndex == 0)
      programs
    else if (repeatIndex > 0 && timesLeft >= period)
      danceTimes(programs, moves, timesLeft % period, history)
    else
      danceTimes(danceAll(programs, moves), moves, timesLeft - 1, programs +: history)
  }

  val startPos = "abcdefghijklmnop"

  def solveA(moves: List[Move]): String = danceAll(startPos, moves)
  def solveB(moves: List[Move]): String = danceTimes(startPos, moves, 1000000000, Nil)

  println(s"A: ${solveA(moves)}")
  println(s"B: ${solveB(moves)}")
}
