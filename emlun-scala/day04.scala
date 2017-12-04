object Main extends App {

  val words: List[List[String]] = (for {
    line <- io.Source.stdin.getLines
    trimmed = line.trim
  } yield trimmed.split(raw"\s+").toList).toList

  def isValid(passphrase: List[String]): Boolean =
    passphrase.map(_.toSet).toSet.size == passphrase.size

  val numValid = words.filter(isValid).size

  println(numValid)

  // println(s"A: ${dist(input)}")
  // println(s"B: ${solveB(input)}")
}
