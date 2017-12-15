object Day06 extends App {
  val banks: List[Int] = (for {
    line <- io.Source.stdin.getLines
    bank <- line.trim.split(raw"\s+")
  } yield bank.toInt).toList

  def findMax(banks: List[Int]): (Int, Int) = {
    val value = banks.max
    (banks.indexOf(value), value)
  }

  def redistribute(banks: List[Int], index: Int, blocks: Int): List[Int] =
    if (blocks == 0)
      banks
    else
      redistribute(
        banks.updated(index, banks(index) + 1),
        (index + 1) % banks.length,
        blocks - 1
      )

  def step(banks: List[Int]): List[Int] = {
    val (i, m) = findMax(banks)
    redistribute(
      banks.updated(i, 0),
      (i + 1) % banks.length,
      m
    )
  }

  def solve(history: List[List[Int]], present: List[Int]): (Int, Int) =
    if (history contains present)
      (history.size, history.indexOf(present) + 1)
    else
      solve(present +: history, step(present))

  val (a, b): (Int, Int) = solve(Nil, banks)

  println(s"A: ${a}")
  println(s"B: ${b}")
}
