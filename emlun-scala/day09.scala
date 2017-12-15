import scala.language.implicitConversions

object Day09 extends App {

  val stream = for {
    line <- io.Source.stdin.getLines
    char <- line
  } yield char

  implicit def pairToPairOps(a: (Int, Int)) = new PairOps(a)
  class PairOps(a: (Int, Int)) {
    def +(b: (Int, Int)) = (a, b) match {
      case ((aa, ab), (ba, bb)) => (aa + ba, ab + bb)
    }
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
            case _   => process(rest, result + (0, 1), level, true, false)
          }
      else
        next match {
          case '{' => process(rest, result, level + 1, false, false)
          case '}' => process(rest, result + (level, 0), level - 1, false, false)
          case '<' => process(rest, result, level, true, false)
          case ',' => process(rest, result, level, false, false)
        }
    } else result

  val (a, b): (Int, Int) = process(stream, (0, 0), 0, false, false)

  println(s"A: ${a}")
  println(s"B: ${b}")
}
