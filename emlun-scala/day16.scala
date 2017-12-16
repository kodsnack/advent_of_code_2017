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

  def danceAll(programs: String, moves: List[Move]): String = moves.foldLeft(programs)(dance)

  def danceTimes(programs: String, moves: List[Move], timesLeft: Int, history: List[String]): String =
    if (timesLeft > 0) {
      val next = danceAll(programs, moves)
      val index = history.indexOf(programs)
      if (index >= 0) {
        val period = index + 1
        if (index == 0) {
          programs
        } else if (timesLeft >= period) {
          println(s"timesLeft: ${timesLeft}, programs: ${programs}, index: ${index}, period: ${period}, history(index): ${history(index)}, history: ${history}")
          danceTimes(programs, moves, timesLeft % period, history)
        } else {
          danceTimes(next, moves, timesLeft - 1, programs +: history)
        }
      }
      else {
        danceTimes(next, moves, timesLeft - 1, programs +: history)
      }
    } else
      programs

  val startPos = "abcdefghijklmnop"
  // val startPos = "abcde"

  println(moves)
  println(moves.foldLeft(startPos)(dance))

  def stream = Iterator.iterate(startPos)(danceAll(_, moves))

  println(1)
  println(stream.drop(1).next())
  println(danceTimes(startPos, moves, 1, Nil))

  println(2)
  println(stream.drop(2).next())
  println(danceTimes(startPos, moves, 2, Nil))

  println(29)
  println(stream.drop(29).next())
  println(danceTimes(startPos, moves, 29, Nil))

  println(30)
  println(stream.drop(30).next())
  println(danceTimes(startPos, moves, 30, Nil))

  println()
  println(31)
  println(stream.drop(31).next())
  println(danceTimes(startPos, moves, 31, Nil))

  println()
  println(57)
  println(stream.drop(57).next())
  println(danceTimes(startPos, moves, 57, Nil))

  println()
  println(58)
  println(stream.drop(58).next())
  println(danceTimes(startPos, moves, 58, Nil))

  println()
  println(59)
  println(stream.drop(59).next())
  println(danceTimes(startPos, moves, 59, Nil))

  println()
  println(60)
  println(stream.drop(60).next())
  println(danceTimes(startPos, moves, 60, Nil))

  println()
  println(1000)
  println(stream.drop(1000).next())
  println(danceTimes(startPos, moves, 1000, Nil))

  println(danceTimes(startPos, moves, 1000000000, Nil))

}
