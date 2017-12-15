object Day01 extends App {
  val digits: List[Int] = (for {
    line <- io.Source.stdin.getLines
    digit <- line.trim
  } yield digit.toString.toInt).toList

  def solve(lookahead: Int): Int = {
    val (front, back) = digits.splitAt(lookahead)
    digits.zip(back ++ front).flatMap({
      case (a, b) if a == b => Some(a)
      case _ => None
    }).sum
  }

  println(s"A: ${solve(1)}")
  println(s"B: ${solve(digits.length / 2)}")
}
