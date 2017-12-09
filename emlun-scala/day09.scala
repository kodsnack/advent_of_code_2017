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

  def process(stream: Seq[Char], level: Int, inGarbage: Boolean, ignoreNext: Boolean): Int = stream match {
    case Nil => 0
    case next :: rest =>
      if (inGarbage)
        if (ignoreNext)
          process(rest, level, true, false)
        else
          next match {
            case '!' => process(rest, level, true, true)
            case '>' => process(rest, level, false, false)
            case _   => process(rest, level, true, false)
          }
      else
        next match {
          case '{' => process(rest, level + 1, false, false)
          case '}' => level + process(rest, level - 1, false, false)
          case '<' => process(rest, level, true, false)
          case ',' => process(rest, level, false, false)
        }
  }

  def solveA(stream: Seq[Char]): Int = process(stream, 0, false, false)

  println(s"A: ${solveA(stream.toList)}")
}
