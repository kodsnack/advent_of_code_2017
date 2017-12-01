object Main extends App {

  val digits: List[Int] = (for {
    line <- io.Source.stdin.getLines
    digit <- line.trim
  } yield ("" + digit).toInt).toList

  val s = (digits :+ digits.head).sliding(2).foldLeft(0) { (sum, nextPair) =>
    nextPair match {
      case List(a, b) if a == b => sum + a
      case _ => sum
    }
  }

  println(s)
}
