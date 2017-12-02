object Main extends App {
  val diffs = (for {
    line <- io.Source.stdin.getLines
  } yield {
    val numbers = (for {
      number <- line.trim.split("\t")
    } yield number.toInt).toList

    numbers.max - numbers.min
  }).toList.sum

  println(diffs)

}
