object Day04 extends App {
  val passphrases: List[List[String]] = (for {
    line <- io.Source.stdin.getLines
    trimmed = line.trim
  } yield trimmed.split(raw"\s+").toList).toList

  def solveA(passphrases: List[List[String]]): Int =
    passphrases.count({ p => p.toSet.size == p.size })

  def solveB(passphrases: List[List[String]]): Int =
    passphrases.count({ p => p.map(_.sorted).toSet.size == p.size })

  println(s"A: ${solveA(passphrases)}")
  println(s"B: ${solveB(passphrases)}")
}
