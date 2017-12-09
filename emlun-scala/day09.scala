object Main extends App {

  val stream: Seq[Char] = (for {
    line <- io.Source.stdin.getLines
    char <- line
  } yield char).toSeq

  case class State(level: Int, ignoreNext: Boolean, inGarbage: Boolean)

  def foldNext(state: State, next: Char): State =
    if (state.inGarbage)
      if (state.ignoreNext)
        state.copy(ignoreNext = false)
      else
        next match {
          case '!' => state.copy(ignoreNext = true)
          case '>' => state.copy(inGarbage = false)
          case _   => state
        }
    else
      next match {
        case '{' => state.copy(level = state.level + 1)
        case '}' => state.copy(level = state.level - 1)
        case '<' => state.copy(inGarbage = true)
      }

  def pairplus(a: (Int, Int), b: (Int, Int)): (Int, Int) = (a, b) match {
    case ((aa, ab), (ba, bb)) => (aa + ba, ab + bb)
  }

  def process(stream: Seq[Char], result: (Int, Int), level: Int, inGarbage: Boolean, ignoreNext: Boolean): (Int, Int) = stream match {
    case Nil => result
    case next :: rest =>
      if (inGarbage)
        if (ignoreNext)
          process(rest, result, level, true, false)
        else
          next match {
            case '!' => process(rest, result, level, true, true)
            case '>' => process(rest, result, level, false, false)
            case _   => process(rest, pairplus((0, 1), result), level, true, false)
          }
      else
        next match {
          case '{' => process(rest, result, level + 1, false, false)
          case '}' => process(rest, pairplus((level, 0), result), level - 1, false, false)
          case '<' => process(rest, result, level, true, false)
          case ',' => process(rest, result, level, false, false)
        }
  }

  def solveA(stream: Seq[Char]): Int = process(stream, (0, 0), 0, false, false)._1
  def solveB(stream: Seq[Char]): Int = process(stream, (0, 0), 0, false, false)._2

  println(s"A: ${solveA(stream.toList)}")
  println(s"B: ${solveB(stream.toList)}")
}
