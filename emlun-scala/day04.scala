object Main extends App {
  val passphrases: List[List[String]] = (for {
    line <- io.Source.stdin.getLines
    trimmed = line.trim
  } yield trimmed.split(raw"\s+").toList).toList

  def solveA(passphrases: List[List[String]]): Int =
    passphrases.filter({ p => p.toSet.size == p.size }).size

  def solveB(passphrases: List[List[String]]): Int =
    passphrases.filter({ p => p.map(_.toSet).toSet.size == p.size }).size

  println(s"A: ${solveA(passphrases)}")
  println(s"B: ${solveB(passphrases)}")
}
