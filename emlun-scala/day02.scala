object Day02 extends App {
  val lineChecksums = for {
    line <- io.Source.stdin.getLines
  } yield {
    val numbers = line
      .trim
      .split(raw"\s+")
      .map(_.toInt)
      .toList

    val quotients = for {
      as: List[Int] <- numbers.tails
      if as.length >= 2
      a = as.head
      b <- as.tail
      if a % b == 0 || b % a == 0
    } yield Math.max(a / b, b / a)

    (numbers.max - numbers.min, quotients.toSeq.head)
  }

  val (a, b) = lineChecksums.toSeq.unzip
  println(s"A: ${a.sum}")
  println(s"B: ${b.sum}")
}
