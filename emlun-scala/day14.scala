object Main extends App {

  val keystring: String = io.Source.stdin.getLines().mkString("\n").trim

  def round(lengths: List[Int], numbers: List[Int] = (0 to 255).toList, pos: Int = 0, skip: Int = 0): List[Int] = lengths match {
    case Nil => numbers
    case length :: restLengths => {
      val nextNumbers = (numbers ++ numbers).splitAt(pos) match {
        case (newHead, back) => back.splitAt(length) match {
          case (front, newTail) => {
            val wrapLength =
              if (pos + length >= numbers.size)
                (pos + length) % numbers.size
              else 0
            val selection = front.reverse

            (selection.drop(length - wrapLength).take(wrapLength)
              ++ newHead.drop(wrapLength)
              ++ selection.take(length - wrapLength)
              ++ newTail
              ) take numbers.size
          }
        }
      }

      val nextPos = (pos + length + skip) % numbers.size
      val nextSkip = skip + 1

      round(restLengths, nextNumbers, nextPos, nextSkip)
    }
  }

  def hash(bytes: Seq[Int]): List[Int] = {
    val padded = bytes ++ List(17, 31, 73, 47, 23)
    val bytesForAllRounds: List[Int] = (1 to 64).toList flatMap { i => padded }
    val sparseHash: List[Int] = round(bytesForAllRounds)
    val denseHash: List[Int] = sparseHash
      .grouped(16)
      .map { block =>
        block.reduce({ _ ^ _ })
      }
      .toList

    denseHash
  }

  def solveA(keystring: String) = {
    val hashInputs = (0 to 127) map { keystring + "-" + _ }
    val hashes = hashInputs map { _.getBytes("UTF-8").toList.map(_.toInt) } map hash
    val numBits = hashes.map({ h => h.map({ x => f"${Integer.toBinaryString(x)}%8s".count(_ == '1') }).sum }).sum
    numBits
  }

  println(s"A: ${solveA(keystring)}")
}
