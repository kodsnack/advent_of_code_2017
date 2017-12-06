object Main extends App {
  val banks: List[Int] = (for {
    line <- io.Source.stdin.getLines
    bank <- line.trim.split(raw"\s+")
  } yield bank.toInt).toList

  def findMax(banks: List[Int]): (Int, Int) = {
    val value = banks.max
    val index = banks.indexOf(value)
    (index, value)
  }

  def redistribute(banks: List[Int], index: Int, blocks: Int): List[Int] =
    if (blocks == 0)
      banks
    else
      redistribute(banks.updated(index, banks(index) + 1), (index + 1) % banks.length, blocks - 1)

  def step(banks: List[Int]): List[Int] = {
    val (i, m) = findMax(banks)
    redistribute(banks.updated(i, 0), (i + 1) % banks.length, m)
  }

  def indexOfFirstRecurrence(history: List[List[Int]], present: List[Int]): Int =
    if (history contains present)
      history.indexOf(present) + 1
    else
      indexOfFirstRecurrence(present +: history, step(present))

  println(s"A: ${banks}")
  println(s"A: ${step(banks)}")
  println(s"A: ${indexOfFirstRecurrence(Nil, banks)}")
}

