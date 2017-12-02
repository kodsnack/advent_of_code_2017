object Main extends App {
  val diffs = (for {
    line <- io.Source.stdin.getLines
  } yield {
    val numbers = (for {
      number <- line.trim.split("\t")
    } yield number.toInt).toList

    val quotients = (for {
      as: List[Int] <- numbers.tails
      if as.length >= 2
      bs: List[Int] = as.tail
      a = as.head
      b <- bs
      if a % b == 0 || b % a == 0
    } yield {
      if (a > b)
        a / b
      else
        b / a
    }).toList

    quotients.head
  }).toList.sum

  println(diffs)

}
