object Main extends App {
  val digits: List[Int] = (for {
    line <- io.Source.stdin.getLines
    digit <- line.trim
  } yield ("" + digit).toInt).toList

  def solve(lookahead: Int): Int = (for {
    i <- 0 until digits.length
    j = (i + lookahead) % digits.length
    if digits(i) == digits(j)
  } yield digits(i)).sum

  println(s"A: ${solve(1)}")
  println(s"B: ${solve(digits.length / 2)}")
}
