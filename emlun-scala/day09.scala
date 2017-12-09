object Main extends App {

  val stream = for {
    line <- io.Source.stdin.getLines
    char <- line
  } yield char

  def pairplus(a: (Int, Int), b: (Int, Int)): (Int, Int) = (a, b) match {
    case ((aa, ab), (ba, bb)) => (aa + ba, ab + bb)
  }

  def process(stream: Iterator[Char], result: (Int, Int), level: Int, inGarbage: Boolean, ignoreNext: Boolean): (Int, Int) =
    if (stream.hasNext) {
      val next = stream.next()
      val rest = stream
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
    } else result

  val (a, b): (Int, Int) = process(stream, (0, 0), 0, false, false)

  println(s"A: ${a}")
  println(s"B: ${b}")
}
