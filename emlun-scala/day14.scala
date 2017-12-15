object Day14 extends App {

  val keystring: String = io.Source.stdin.getLines().mkString("\n").trim

  def round(lengths: Vector[Int], numbers: Vector[Int] = (0 to 255).toVector, pos: Int = 0, skip: Int = 0): Vector[Int] = lengths match {
    case Vector() => numbers
    case _ => {
      val length = lengths.head
      val restLengths = lengths.tail
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

  def hash(bytes: Vector[Int]): Vector[Int] = {
    val padded = bytes ++ Vector(17, 31, 73, 47, 23)
    val bytesForAllRounds: Vector[Int] = (1 to 64).toVector flatMap { i => padded }
    val sparseHash: Vector[Int] = round(bytesForAllRounds)
    val denseHash: Vector[Int] = sparseHash
      .grouped(16)
      .map { block =>
        block.reduce({ _ ^ _ })
      }
      .toVector

    denseHash
  }

  def solveA(keystring: String) = {
    val hashInputs = (0 to 127) map { keystring + "-" + _ }
    val hashes = hashInputs map { _.getBytes("UTF-8").toVector.map(_.toInt) } map hash
    val numBits = hashes.map({ h => h.map({ x => f"${Integer.toBinaryString(x)}%8s".count(_ == '1') }).sum }).sum
    numBits
  }

  def solveB(keystring: String) = {
    val hashInputs = (0 to 127) map { keystring + "-" + _ }
    val hashes: Vector[Vector[Int]] = hashInputs.toVector map { _.getBytes("UTF-8").toVector.map(_.toInt) } map hash
    val bitgrid: Vector[Vector[Int]] = hashes map { h =>
      h flatMap { x =>
        f"${Integer.toBinaryString(x)}%8s" map {
          case '1' => 0
          case _  => -1
        }
      }
    }
    val bitlist: Vector[Int] = bitgrid.flatten

    def crtoi(c: Int, r: Int): Int = c + r * 128
    def itocr(i: Int): (Int, Int) = (i % 128, i / 128)

    def getNeighbors(i: Int): List[Int] =
      itocr(i) match {
        case (c, r) => (
          List((c - 1, r), (c + 1, r), (c, r - 1), (c, r + 1))
            filter { case (cc, rr) => cc >= 0 && cc < 128 && rr >= 0 && rr < 128 }
            map { case (c, r) => crtoi(c, r) }
        )
      }

    def nameNeighbors(bitlist: Vector[Int], i: Int, name: Int): Vector[Int] =
      getNeighbors(i)
        .filter({ n => bitlist(n) == 0 })
        .foldLeft(bitlist) { (resultBitlist, neighbor: Int) =>
          nameNeighbors(resultBitlist.updated(neighbor, name), neighbor, name)
        }

    def nameRegions(bitlist: Vector[Int], nextName: Int): Vector[Int] = {
      val zeroIndex = bitlist.indexOf(0)
      if (zeroIndex >= 0)
        nameRegions(
          nameNeighbors(bitlist.updated(zeroIndex, nextName), zeroIndex, nextName),
          nextName + 1
        )
      else
        bitlist
    }

    nameRegions(bitlist, 1).max
  }

  println(s"A: ${solveA(keystring)}")
  println(s"B: ${solveB(keystring)}")
}
