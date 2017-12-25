object Day24 extends App {

  val parts: List[Part] = (for {
    line <- io.Source.stdin.getLines()
    Array(a, b) = line.trim.split("/") map { _.toInt }
  } yield Part(a, b)).toList

  case class Part(a: Int, b: Int) {
    def align(prevEnd: Int): Part =
      if (a == prevEnd) this
      else if (b == prevEnd) Part(b, a)
      else ???
  }

  def validContinuations(prefix: List[Part], parts: Set[Part]): Iterator[List[Part]] = {
    val startValue = (prefix.headOption map { _.b } getOrElse 0)
    val starts = parts filter { p => p.a == startValue || p.b == startValue }

    if (starts.isEmpty)
      List(prefix).toIterator
    else
      for {
        start <- starts.toIterator
        result <- validContinuations(start.align(startValue) +: prefix, parts - start)
      } yield result
  }

  def score(bridge: List[Part]): Int = bridge.map(p => p.a + p.b).sum

  def solveA(parts: List[Part]): Int =
    (validContinuations(Nil, parts.toSet) map score).max

  def solveB(parts: List[Part]): Int = {
    val bridge = validContinuations(Nil, parts.toSet) maxBy { b => (b.length, score(b)) }
    score(bridge)
  }

  if (parts.toSet.size != parts.size) {
    println("WARNIG: DUPLICATE PARTS! Result may not be accurate!")
  }

  println(s"A: ${solveA(parts)}")
  println(s"B: ${solveB(parts)}")
}
