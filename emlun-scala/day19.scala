import scala.language.implicitConversions

object Day19 extends App {

  implicit def pairToPairOps(a: (Int, Int)) = new PairOps(a)
  class PairOps(a: (Int, Int)) {
    def +(b: (Int, Int)) = (a, b) match {
      case ((aa, ab), (ba, bb)) => (aa + ba, ab + bb)
    }
    def unary_-(): (Int, Int) = a match {
      case (aa, ab) => (-aa, -ab)
    }
  }

  case class State(pos: (Int, Int), dir: (Int, Int), collected: List[Char])

  def step(map: Vector[Vector[Char]])(state: Option[State]): Option[State] = state flatMap { state =>
    val (nextX, nextY) = (state.pos + state.dir)

    def turn: Option[State] =
      (List((0, 1), (0, -1), (1, 0), (-1, 0)).filter({ _ != -state.dir }))
        .find({ d =>
          val (candX, candY) = state.pos + d
          map(candY)(candX) != ' '
        })
        .map({ nextDir =>
          state.copy(pos = state.pos + nextDir, dir = nextDir)
        })

    if (nextX < 0 || nextY < 0 || nextX >= map(0).length || nextY >= map(0).length)
      turn
    else
      map(nextY)(nextX) match {
        case '|' | '-' | '+' => Some(state.copy(pos = (nextX, nextY)))
        case ' ' => turn
        case a => Some(state.copy(pos = (nextX, nextY), collected = state.collected :+ a))
      }
  }

  def solveA(map: Vector[Vector[Char]]): String = {
    val startPos: (Int, Int) = (map(0).indexOf('|'), 0)
    val startDir: (Int, Int) = (0, 1)
    val startState = State(startPos, startDir, Nil)

    Iterator.iterate[Option[State]](Some(startState))(step(map))
      .takeWhile { _.isDefined }
      .toIterable
      .last
      .get
      .collected
      .mkString("")
  }

  def solveB(map: Vector[Vector[Char]]): Int = {
    val startPos: (Int, Int) = (map(0).indexOf('|'), 0)
    val startDir: (Int, Int) = (0, 1)
    val startState = State(startPos, startDir, Nil)

    Iterator.iterate[Option[State]](Some(startState))(step(map))
      .takeWhile { _.isDefined }
      .length
  }

  val map: Vector[Vector[Char]] =
    io.Source.stdin.getLines()
      .map(_.toVector)
      .toVector

  println(s"A: ${solveA(map)}")
  println(s"B: ${solveB(map)}")
}
